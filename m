From: labath@google.com (Pavel Labath)
Date: Fri, 16 Sep 2016 11:07:39 +0100
Subject: [PATCH] arm64: hw_breakpoint: Handle inexact watchpoint addresses
In-Reply-To: <20160916085825.GL3380@arm.com>
References: <1473689244-147136-1-git-send-email-labath@google.com>
 <20160916085825.GL3380@arm.com>
Message-ID: <CAJt8pk8Hj+PhcA=knXbRqakSJhP4XiQR+1uhm0U4LNfxW8PUhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

thank you for the review. I will be a bit busy in the next few weeks,
so I don't think I'll be able to submit a revised version of the patch
that quickly. Until then, here I my responses.

On 16 September 2016 at 09:58, Will Deacon <will.deacon@arm.com> wrote:
> Hi Pavel,
>
> On Mon, Sep 12, 2016 at 03:07:24PM +0100, Pavel Labath wrote:
>> Arm64 hardware does not always report a watchpoint hit address that
>> matches one of the watchpoints set. It can also report an address
>> "near" the watchpoint if a single instruction access both watched and
>> unwatched addresses. There is no straight-forward way, short of
>> disassembling the offending instruction, to map that address back to
>> the watchpoint.
>>
>> Previously, when the hardware reported a watchpoint hit on an address
>> that did not match our watchpoint (this happens in case of instructions
>> which access large chunks of memory such as "stp") the process would
>> enter a loop where we would be continually resuming it (because we did
>> not recognise that watchpoint hit) and it would keep hitting the
>> watchpoint again and again. The tracing process would never get
>> notified of the watchpoint hit.
>>
>> This commit fixes the problem by looking at the watchpoints near the
>> address reported by the hardware. If the address does not exactly match
>> one of the watchpoints we have set, it attributes the hit to the
>> nearest watchpoint we have.  This heuristic is a bit dodgy, but I don't
>> think we can do much more, given the hardware limitations.
>> I include a kernel selftest which triggers this code.
>
> Thanks for the patch. Comments inline.
>
>> Signed-off-by: Pavel Labath <labath@google.com>
>> ---
>>  arch/arm64/kernel/hw_breakpoint.c                  | 104 +++++++---
>>  tools/testing/selftests/breakpoints/Makefile       |   5 +-
>>  .../selftests/breakpoints/breakpoint_test-arm.c    | 217 +++++++++++++++++++++
>>  3 files changed, 298 insertions(+), 28 deletions(-)
>>  create mode 100644 tools/testing/selftests/breakpoints/breakpoint_test-arm.c
>
> Could you split the test out into a separate patch please?
Sure thing.

>
>> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
>> index 26a6bf7..d0ebfe6 100644
>> --- a/arch/arm64/kernel/hw_breakpoint.c
>> +++ b/arch/arm64/kernel/hw_breakpoint.c
>> @@ -661,50 +661,80 @@ unlock:
>>  }
>>  NOKPROBE_SYMBOL(breakpoint_handler);
>>
>> +/*
>> + * Arm64 hardware does not always report a watchpoint hit address that matches
>> + * one of the watchpoints set. It can also report an address "near" the
>> + * watchpoint if a single instruction access both watched and unwatched
>> + * addresses. There is no straight-forward way, short of disassembling the
>> + * offending instruction, to map that address back to the watchpoint. This
>> + * function computes the distance of the memory access from the watchpoint as a
>> + * heuristic for the likelyhood that a given access triggered the watchpoint.
>> + *
>> + * See Section D2.10.5 "Determining the memory location that caused a Watchpoint
>> + * exception" of ARMv8 Architecture Reference Manual for details.
>> + *
>> + * The function returns the distance of the address from the bytes watched by
>> + * the watchpoint. In case of an exact match, it returns 0.
>> + */
>> +static u64 get_distance_from_watchpoint(unsigned long addr, int i,
>> +                                     struct arch_hw_breakpoint *info)
>> +{
>> +     u64 val, alignment_mask, wp_low, wp_high;
>> +     u32 ctrl_reg;
>> +     int first_bit;
>> +     struct arch_hw_breakpoint_ctrl ctrl;
>> +
>> +     /* AArch32 watchpoints are either 4 or 8 bytes aligned. */
>> +     if (is_compat_task()) {
>> +             if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
>> +                     alignment_mask = 0x7;
>> +             else
>> +                     alignment_mask = 0x3;
>> +     } else {
>> +             alignment_mask = 0x7;
>> +     }
>
> We have identical logic elsewhere in this file, so please stick this into
> a get_watchpoint_alignment_mask function.
I presume you mean the code in arch_validate_hwbkpt_settings. I'll put
that up as a separate patch as well, as it does not seem to be a
completely trivial cut'n'paste job.

>
>> +
>> +     val = read_wb_reg(AARCH64_DBG_REG_WVR, i) & ~alignment_mask;
>> +
>> +     ctrl_reg = read_wb_reg(AARCH64_DBG_REG_WCR, i);
>> +     decode_ctrl_reg(ctrl_reg, &ctrl);
>> +     first_bit = ffs(ctrl.len);
>> +     if (first_bit == 0)
>> +             return -1;
>> +     wp_low = val + first_bit - 1;
>> +     wp_high = val + fls(ctrl.len) - 1;
>> +     if (addr < wp_low)
>> +             return wp_low - addr;
>> +     else if (addr > wp_high)
>> +             return addr - wp_high;
>
> Why do you need to read the control register? We already have the length
> in the arch_hw_breakpoint, and that should be sufficient for the check, no?
I did this because the original code (see below) relied on reading the
register instead of struct arch_hw_breakpoint. However, if you believe
that is ok, I can do it that way. It will certainly make this code
less complicated.

>
>>  static int watchpoint_handler(unsigned long addr, unsigned int esr,
>>                             struct pt_regs *regs)
>>  {
>> -     int i, step = 0, *kernel_step, access;
>> -     u32 ctrl_reg;
>> -     u64 val, alignment_mask;
>> +     int i, step = 0, *kernel_step, access, closest_match;
>> +     u64 min_dist = -1, dist;
>>       struct perf_event *wp, **slots;
>>       struct debug_info *debug_info;
>>       struct arch_hw_breakpoint *info;
>> -     struct arch_hw_breakpoint_ctrl ctrl;
>>
>>       slots = this_cpu_ptr(wp_on_reg);
>>       debug_info = &current->thread.debug;
>>
>> +     /*
>> +      * Find all watchpoints that match the reported address. If no exact
>> +      * match is found. Attribute the hit to the closest watchpoint.
>> +      */
>>       for (i = 0; i < core_num_wrps; ++i) {
>>               rcu_read_lock();
>>
>>               wp = slots[i];
>> -
>>               if (wp == NULL)
>>                       goto unlock;
>>
>> -             info = counter_arch_bp(wp);
>> -             /* AArch32 watchpoints are either 4 or 8 bytes aligned. */
>> -             if (is_compat_task()) {
>> -                     if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
>> -                             alignment_mask = 0x7;
>> -                     else
>> -                             alignment_mask = 0x3;
>> -             } else {
>> -                     alignment_mask = 0x7;
>> -             }
>> -
>> -             /* Check if the watchpoint value matches. */
>> -             val = read_wb_reg(AARCH64_DBG_REG_WVR, i);
>> -             if (val != (addr & ~alignment_mask))
>> -                     goto unlock;
>> -
>> -             /* Possible match, check the byte address select to confirm. */
>> -             ctrl_reg = read_wb_reg(AARCH64_DBG_REG_WCR, i);
>> -             decode_ctrl_reg(ctrl_reg, &ctrl);
>> -             if (!((1 << (addr & alignment_mask)) & ctrl.len))
>> -                     goto unlock;
Original code reading the control register.

>> -
>>               /*
>>                * Check that the access type matches.
>>                * 0 => load, otherwise => store
>> @@ -714,6 +744,17 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
>>               if (!(access & hw_breakpoint_type(wp)))
>>                       goto unlock;
>>
>> +             info = counter_arch_bp(wp);
>> +
>> +             dist = get_distance_from_watchpoint(addr, i, info);
>> +             if (dist < min_dist) {
>> +                     min_dist = dist;
>> +                     closest_match = i;
>> +             }
>> +             /* Is this an exact match? */
>> +             if (dist != 0)
>> +                     goto unlock;
>> +
>>               info->trigger = addr;
>>               perf_bp_event(wp, regs);
>>
>> @@ -724,6 +765,15 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
>>  unlock:
>>               rcu_read_unlock();
>>       }
>> +     if (min_dist > 0 && min_dist != -1) {
>> +             /* No exact match found. */
>> +             rcu_read_lock();
>> +             wp = slots[closest_match];
>> +             info = counter_arch_bp(wp);
>> +             info->trigger = addr;
>> +             perf_bp_event(wp, regs);
>> +             rcu_read_unlock();
>
> Hmm, are you sure it's safe to drop and retake the RCU lock here? If the
> event is destroyed before we retake the RCU lock, won't htis go horribly
> wrong? It's probably best to hold the lock outside the loop :(

I am definitely not sure of that. :) It's not even clear to me what
data does this lock protect. Doing the locking outside the loop would
certainly be safer though.

regards,
pavel
