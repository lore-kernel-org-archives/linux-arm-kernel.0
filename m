From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jun 2018 16:38:10 +0100
Subject: [PATCHv3 00/19] arm64: invoke syscalls with pt_regs
In-Reply-To: <20180618120310.39527-1-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
Message-ID: <20180619153810.mm4yt3pqjagvjo7p@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:02:51PM +0100, Mark Rutland wrote:
> This series reworks arm64's syscall handling to minimize the propagation
> of user-controlled register values into speculated code paths. As with
> x86 [1], a wrapper is generated for each syscall, which extracts the
> argument from a struct pt_regs. During kernel entry from userspace,
> registers are zeroed.
> 
> The arm64 kernel code directly invokes some syscalls which the x86 code
> doesn't, so I've added ksys_* wrappers for these, following the x86
> example. The rest of the series is arm64-specific.
> 
> I've pushed the series out to my arm64/syscall-regs branch [2] on
> kernel.org.
> 
> Since v1 [3]:
> * Rebase atop of arm64 for-next/core (for SSBD conflicts)
> * Move ksys_personality logic into <linux/syscalls.h>
> * Move kcompat_sys_* wrappers to <linux/compat.h>
> * Fix scno bounds check to use unsigned comparison
> * Fix sve_user_reset() call in el0_svc_handler()
> * Add BUILD_BUG() to the !CONFIG_ARM64_SVE stubs
> * Accumulate acked-by / reviewed-by tags
> 
> Since v2 [4]:
> * Rebase to v4.18-rc1
> * Take upper 32 RES0 bits of SCTLR_ELx into account
> * Accumulate acks
> 
> Thanks,
> Mark.
> 
> [1] https://lkml.kernel.org/r/20180330093720.6780-1-linux at dominikbrodowski.net
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
> [3] https://lkml.kernel.org/r/20180514094640.27569-1-mark.rutland at arm.com
> [4] https://lkml.kernel.org/r/20180601112441.37810-1-mark.rutland at arm.com
> 
> Mark Rutland (19):
>   arm64: consistently use unsigned long for thread flags
>   arm64: move SCTLR_EL{1,2} assertions to <asm/sysreg.h>
>   arm64: introduce sysreg_clear_set()
>   arm64: kill config_sctlr_el1()
>   arm64: kill change_cpacr()
>   arm64: move sve_user_{enable,disable} to <asm/fpsimd.h>
>   arm64: remove sigreturn wrappers
>   arm64: convert raw syscall invocation to C
>   arm64: convert syscall trace logic to C
>   arm64: convert native/compat syscall entry to C
>   arm64: don't reload GPRs after apply_ssbd
>   arm64: zero GPRs upon entry from EL0

I realised that along with these two, we also no longer need to reload
the GPRs for entry tracking, so I've added the following to my local
copy of the series.

Mark.

---->8----
>From b47791fe74fce8bb48696ab0cdda48a9bae0e397 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 19 Jun 2018 12:49:54 +0100
Subject: [PATCH] arm64: don't restore GPRs when context tracking

Now that syscalls are invoked with pt_regs, we no longer need to ensure
that the argument regsiters are live in the entry assembly, and it's
fine to not restore them after context_tracking_user_exit() has
corrupted them.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 39440c2ee66d..6b7789d72064 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -41,19 +41,9 @@
  * Context tracking subsystem.  Used to instrument transitions
  * between user and kernel mode.
  */
-	.macro ct_user_exit, syscall = 0
+	.macro ct_user_exit
 #ifdef CONFIG_CONTEXT_TRACKING
 	bl	context_tracking_user_exit
-	.if \syscall == 1
-	/*
-	 * Save/restore needed during syscalls.  Restore syscall arguments from
-	 * the values already saved on stack during kernel_entry.
-	 */
-	ldp	x0, x1, [sp]
-	ldp	x2, x3, [sp, #S_X2]
-	ldp	x4, x5, [sp, #S_X4]
-	ldp	x6, x7, [sp, #S_X6]
-	.endif
 #endif
 	.endm
 
-- 
2.11.0
