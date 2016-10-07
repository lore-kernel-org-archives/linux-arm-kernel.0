From: panand@redhat.com (Pratyush Anand)
Date: Fri, 7 Oct 2016 22:08:43 +0530
Subject: [PATCH 2/3] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <1474643941-109020-2-git-send-email-labath@google.com>
References: <1474643941-109020-1-git-send-email-labath@google.com>
 <1474643941-109020-2-git-send-email-labath@google.com>
Message-ID: <CAHB_GupyUp_s4nWq-QVnEoCZvmkrXyCcxs-XpH3x0Yugkknpzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 8:49 PM, Pavel Labath
<test.tberghammer@gmail.com> wrote:
> Arm64 hardware does not always report a watchpoint hit address that
> matches one of the watchpoints set. It can also report an address
> "near" the watchpoint if a single instruction access both watched and
> unwatched addresses. There is no straight-forward way, short of
> disassembling the offending instruction, to map that address back to
> the watchpoint.
>
> Previously, when the hardware reported a watchpoint hit on an address
> that did not match our watchpoint (this happens in case of instructions
> which access large chunks of memory such as "stp") the process would
> enter a loop where we would be continually resuming it (because we did
> not recognise that watchpoint hit) and it would keep hitting the
> watchpoint again and again. The tracing process would never get
> notified of the watchpoint hit.
>
> This commit fixes the problem by looking at the watchpoints near the
> address reported by the hardware. If the address does not exactly match
> one of the watchpoints we have set, it attributes the hit to the
> nearest watchpoint we have.  This heuristic is a bit dodgy, but I don't
> think we can do much more, given the hardware limitations.

IIUC, then you see an issue when an address watched is not the base
address accessed by the instruction. For example, if an address 'a+8'
is watched and an instruction accesses instruction from  a to a +16. I
tried to reproduce the issue with mustang using your test-case in
patch3 (after couple of syntax modifcations for resolving compilation
issue with gcc). All the test case did pass with existing code in
v4.8. I noticed that, watchpoint exception is generated if any of the
sub-location accessed from a single instruction is watched, provided
watchdpoint watches either a byte, half word, word or double word
from the base.

So, either I must be missing something or the problem is not related
to all arm64 platform.

However, I did notice that it does not work if we watch an address
which is at some offset from address programmed. For example, it works
when byte_mask is 0x3, but it does not work if byte_mask if 0x2 (which
is supported by hardware).

I do have some patches to resolve that.

https://github.com/pratyushanand/linux/commits/perf/upstream_arm64_devel

I will send them for review comment after some testing.

~Pratyush

>
> Signed-off-by: Pavel Labath <labath@google.com>
> ---
>  arch/arm64/kernel/hw_breakpoint.c | 98 +++++++++++++++++++++++++--------------
>  1 file changed, 64 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 14562ae..3ce27ea 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -664,49 +664,63 @@ unlock:
>  }
>  NOKPROBE_SYMBOL(breakpoint_handler);
>
> +/*
> + * Arm64 hardware does not always report a watchpoint hit address that matches
> + * one of the watchpoints set. It can also report an address "near" the
> + * watchpoint if a single instruction access both watched and unwatched
> + * addresses. There is no straight-forward way, short of disassembling the
> + * offending instruction, to map that address back to the watchpoint. This
> + * function computes the distance of the memory access from the watchpoint as a
> + * heuristic for the likelyhood that a given access triggered the watchpoint.
> + *
> + * See Section D2.10.5 "Determining the memory location that caused a Watchpoint
> + * exception" of ARMv8 Architecture Reference Manual for details.
> + *
> + * The function returns the distance of the address from the bytes watched by
> + * the watchpoint. In case of an exact match, it returns 0.
> + */
> +static u64 get_distance_from_watchpoint(unsigned long addr, int i,
> +                                       struct arch_hw_breakpoint *info)
> +{
> +       u64 wp_low, wp_high;
> +       int first_bit;
> +
> +       first_bit = ffs(info->ctrl.len);
> +       if (first_bit == 0)
> +               return -1;
> +
> +       wp_low = info->address + first_bit - 1;
> +       wp_high = info->address + fls(info->ctrl.len) - 1;
> +       if (addr < wp_low)
> +               return wp_low - addr;
> +       else if (addr > wp_high)
> +               return addr - wp_high;
> +       else
> +               return 0;
> +
> +}
> +
>  static int watchpoint_handler(unsigned long addr, unsigned int esr,
>                               struct pt_regs *regs)
>  {
> -       int i, step = 0, *kernel_step, access;
> -       u32 ctrl_reg;
> -       u64 val, alignment_mask;
> +       int i, step = 0, *kernel_step, access, closest_match = 0;
> +       u64 min_dist = -1, dist;
>         struct perf_event *wp, **slots;
>         struct debug_info *debug_info;
>         struct arch_hw_breakpoint *info;
> -       struct arch_hw_breakpoint_ctrl ctrl;
>
>         slots = this_cpu_ptr(wp_on_reg);
>         debug_info = &current->thread.debug;
>
> +       /*
> +        * Find all watchpoints that match the reported address. If no exact
> +        * match is found. Attribute the hit to the closest watchpoint.
> +        */
> +       rcu_read_lock();
>         for (i = 0; i < core_num_wrps; ++i) {
> -               rcu_read_lock();
> -
>                 wp = slots[i];
> -
>                 if (wp == NULL)
> -                       goto unlock;
> -
> -               info = counter_arch_bp(wp);
> -               /* AArch32 watchpoints are either 4 or 8 bytes aligned. */
> -               if (is_compat_task()) {
> -                       if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
> -                               alignment_mask = 0x7;
> -                       else
> -                               alignment_mask = 0x3;
> -               } else {
> -                       alignment_mask = 0x7;
> -               }
> -
> -               /* Check if the watchpoint value matches. */
> -               val = read_wb_reg(AARCH64_DBG_REG_WVR, i);
> -               if (val != (addr & ~alignment_mask))
> -                       goto unlock;
> -
> -               /* Possible match, check the byte address select to confirm. */
> -               ctrl_reg = read_wb_reg(AARCH64_DBG_REG_WCR, i);
> -               decode_ctrl_reg(ctrl_reg, &ctrl);
> -               if (!((1 << (addr & alignment_mask)) & ctrl.len))
> -                       goto unlock;
> +                       continue;
>
>                 /*
>                  * Check that the access type matches.
> @@ -715,7 +729,18 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
>                 access = (esr & AARCH64_ESR_ACCESS_MASK) ? HW_BREAKPOINT_W :
>                          HW_BREAKPOINT_R;
>                 if (!(access & hw_breakpoint_type(wp)))
> -                       goto unlock;
> +                       continue;
> +
> +               info = counter_arch_bp(wp);
> +
> +               dist = get_distance_from_watchpoint(addr, i, info);
> +               if (dist < min_dist) {
> +                       min_dist = dist;
> +                       closest_match = i;
> +               }
> +               /* Is this an exact match? */
> +               if (dist != 0)
> +                       continue;
>
>                 info->trigger = addr;
>                 perf_bp_event(wp, regs);
> @@ -723,10 +748,15 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
>                 /* Do we need to handle the stepping? */
>                 if (is_default_overflow_handler(wp))
>                         step = 1;
> -
> -unlock:
> -               rcu_read_unlock();
>         }
> +       if (min_dist > 0 && min_dist != -1) {
> +               /* No exact match found. */
> +               wp = slots[closest_match];
> +               info = counter_arch_bp(wp);
> +               info->trigger = addr;
> +               perf_bp_event(wp, regs);
> +       }
> +       rcu_read_unlock();
>
>         if (!step)
>                 return 0;
> --
> 2.8.0.rc3.226.g39d4020
>
