From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jul 2014 12:24:14 +0100
Subject: [PATCH] ARM/ARM64: don't enter kgdb when userspace executes a
 kgdb break instruction.
In-Reply-To: <20140730071245.GA8954@mew.web-pass.com>
References: <20140730071245.GA8954@mew.web-pass.com>
Message-ID: <20140730112414.GJ12239@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jul 30, 2014 at 08:12:45AM +0100, Omar Sandoval wrote:
> The kgdb breakpoint hooks (kgdb_brk_fn and kgdb_compiled_brk_fn) should only be
> entered when a kgdb break instruction is executed from the kernel. Otherwise,
> if kgdb is enabled, a userspace program can cause the kernel to drop into the
> debugger by executing either KGDB_BREAKINST or KGDB_COMPILED_BREAK on ARM, or
> brk #KGDB_{DYN,COMPILED}_DGB_BRK_IMM on ARM64.
> 
> Signed-off-by: Omar Sandoval <osandov@osandov.com>
> ---
> The following program reproduces the fixed problem on ARM:
> .globl _start
> _start:
> 	udf	#65006	@ KGDB_BREAKINST
> 
> And on ARM64:
> .globl _start
> _start:
>         brk     #0x400	@ KGDB_DYN_DGB_BRK_IMM
> 
>  arch/arm/kernel/kgdb.c                  | 4 ++++
>  arch/arm64/include/asm/debug-monitors.h | 4 +++-
>  arch/arm64/kernel/debug-monitors.c      | 3 ++-
>  arch/arm64/kernel/kgdb.c                | 4 ++++
>  4 files changed, 13 insertions(+), 2 deletions(-)

Whilst this sounds like a worrying problem, I've failed to reproduce it
on arm64.  Executing a brk instruction with either KGDB_DYN_DGB_BRK_IMM or
KDBG_COMPILED_DBG_BRK_IMM immediates from userspace results in a SIGTRAP being
delivered, assumedly because kgdb_handle_exception simply returns when kgdb
isn't active.

> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 6e9b5b3..e1d27ce 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -105,8 +105,10 @@ void unregister_step_hook(struct step_hook *hook);
>  
>  struct break_hook {
>  	struct list_head node;
> -	u32 esr_val;
>  	u32 esr_mask;
> +	u32 esr_val;
> +	u64 pstate_mask;
> +	u64 pstate_val;

The following (totally untested) diff is simpler for arm64, but again, I'm
not sure we even have a problem here.

On which systems have you managed to reproduce this and how?

Will

--->8

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index a7fb874b595e..fe5b94078d82 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -315,20 +315,20 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 {
        siginfo_t info;
 
-       if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
-               return 0;
+       if (user_mode(regs)) {
+               info = (siginfo_t) {
+                       .si_signo = SIGTRAP,
+                       .si_errno = 0,
+                       .si_code  = TRAP_BRKPT,
+                       .si_addr  = (void __user *)instruction_pointer(regs),
+               };
 
-       if (!user_mode(regs))
+               force_sig_info(SIGTRAP, &info, current);
+       } else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
+               pr_warning("Unexpected kernel BRK exception at EL1\n");
                return -EFAULT;
+       }
 
-       info = (siginfo_t) {
-               .si_signo = SIGTRAP,
-               .si_errno = 0,
-               .si_code  = TRAP_BRKPT,
-               .si_addr  = (void __user *)instruction_pointer(regs),
-       };
-
-       force_sig_info(SIGTRAP, &info, current);
        return 0;
 }
