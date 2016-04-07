From: huawei.libin@huawei.com (Li Bin)
Date: Thu, 7 Apr 2016 19:34:37 +0800
Subject: [PATCH 2/2] arm64: Fix watchpoint recursion when single-step is
 wrongly triggered in irq
In-Reply-To: <20160404051714.GH28435@dhcppc0.redhat.com>
References: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
 <1458549470-124791-2-git-send-email-hekuang@huawei.com>
 <20160321102423.GB15150@dhcppc6.redhat.com> <56FD1BD1.7070101@huawei.com>
 <20160404051714.GH28435@dhcppc0.redhat.com>
Message-ID: <570645CD.6030400@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

on 2016/4/4 13:17, Pratyush Anand wrote:
> Hi Li,
> 
> On 31/03/2016:08:45:05 PM, Li Bin wrote:
>> Hi Pratyush,
>>
>> on 2016/3/21 18:24, Pratyush Anand wrote:
>>> On 21/03/2016:08:37:50 AM, He Kuang wrote:
>>>> On arm64, watchpoint handler enables single-step to bypass the next
>>>> instruction for not recursive enter. If an irq is triggered right
>>>> after the watchpoint, a single-step will be wrongly triggered in irq
>>>> handler, which causes the watchpoint address not stepped over and
>>>> system hang.
>>>
>>> Does patch [1] resolves this issue as well? I hope it should. Patch[1] has still
>>> not been sent for review. Your test result will be helpful.
>>>
>>> ~Pratyush
>>>
>>> [1] https://github.com/pratyushanand/linux/commit/7623c8099ac22eaa00e7e0f52430f7a4bd154652
>>
>> This patch did not consider that, when excetpion return, the singlestep flag
>> should be restored, otherwise the right singlestep will not triggered.
>> Right?
> 
> Yes, you are right, and there are other problems as well. Will Deacon pointed
> out [1] that kernel debugging is per-cpu rather than per-task. So, I did thought
> of a per-cpu implementation by introducing a new element "flags" in struct
> pt_regs. But even with that I see issues. For example:
> - While executing single step instruction, we get a data abort
> - In the kernel_entry of data abort we disable single stepping based on "flags"
>   bit field
> - While handling data abort we receive anther interrupt, so we are again in
>   kernel_entry (for el1_irq). Single stepping will be disabled again (although
>   it does not matter).
> 
> Now the issue is that, what condition should be verified in kernel_exit for
> enabling single step again? In the above scenario, kernel_exit for el1_irq
> should not enable single stepping, but how to prevent that elegantly?

The condition for kernel_entry to disable the single step is that MDSCR_EL1.SS
has been set. And only when the corresponding kernel_entry has disabled the single
step, the kernel_exit should enable it, but the kernel_exit of single-step exception
should be handled specially, that when disable single step in single-step exception
handler, flag of pt_regs stored in stack should be cleard to prevent to be re-enabled
by kernel_exit.

Thanks,
Li Bin

---
 arch/arm64/include/asm/assembler.h      |   11 +++++++++++
 arch/arm64/include/asm/debug-monitors.h |    2 +-
 arch/arm64/include/asm/ptrace.h         |    2 ++
 arch/arm64/kernel/asm-offsets.c         |    1 +
 arch/arm64/kernel/debug-monitors.c      |    3 ++-
 arch/arm64/kernel/entry.S               |   18 ++++++++++++++++++
 arch/arm64/kernel/hw_breakpoint.c       |    2 +-
 arch/arm64/kernel/kgdb.c                |    2 +-
 8 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 70f7b9e..56a4335 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -60,6 +60,17 @@
 	msr	daifclr, #8
 	.endm

+	.macro	disable_step, orig
+	bic \orig, \orig, #1
+	msr	mdscr_el1, \orig
+	.endm
+
+	.macro	enable_step, orig
+	disable_dbg
+	orr \orig, \orig, #1
+	msr	mdscr_el1, \orig
+	.endm
+
 	.macro	disable_step_tsk, flgs, tmp
 	tbz	\flgs, #TIF_SINGLESTEP, 9990f
 	mrs	\tmp, mdscr_el1
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 2fcb9b7..50f114c 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -115,7 +115,7 @@ void user_rewind_single_step(struct task_struct *task);
 void user_fastforward_single_step(struct task_struct *task);

 void kernel_enable_single_step(struct pt_regs *regs);
-void kernel_disable_single_step(void);
+void kernel_disable_single_step(struct pt_regs *regs);
 int kernel_active_single_step(void);

 #ifdef CONFIG_HAVE_HW_BREAKPOINT
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index a307eb6..da00cd8 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -113,6 +113,8 @@ struct pt_regs {
 			u64 sp;
 			u64 pc;
 			u64 pstate;
+			u64 flags;
+			u64 padding;
 		};
 	};
 	u64 orig_x0;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 3ae6b31..7936ba9 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -56,6 +56,7 @@ int main(void)
   DEFINE(S_COMPAT_SP,		offsetof(struct pt_regs, compat_sp));
 #endif
   DEFINE(S_PSTATE,		offsetof(struct pt_regs, pstate));
+  DEFINE(S_FLAGS,		offsetof(struct pt_regs, flags));
   DEFINE(S_PC,			offsetof(struct pt_regs, pc));
   DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index c45f296..9d2bdbf 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -403,9 +403,10 @@ void kernel_enable_single_step(struct pt_regs *regs)
 	enable_debug_monitors(DBG_ACTIVE_EL1);
 }

-void kernel_disable_single_step(void)
+void kernel_disable_single_step(struct pt_regs *regs)
 {
 	WARN_ON(!irqs_disabled());
+	regs->flags = 0;
 	mdscr_write(mdscr_read() & ~DBG_MDSCR_SS);
 	disable_debug_monitors(DBG_ACTIVE_EL1);
 }
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 12e8d2b..753bef2 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -87,6 +87,15 @@
 	stp	x26, x27, [sp, #16 * 13]
 	stp	x28, x29, [sp, #16 * 14]

+	.if \el == 1
+	mrs     x19, mdscr_el1
+	and     x20, x19, #1
+	str     x20, [sp, #S_FLAGS]
+	tbz     x20, #0, 1f
+	disable_step x19
+1:
+	.endif
+
 	.if	\el == 0
 	mrs	x21, sp_el0
 	mov	tsk, sp
@@ -154,6 +163,15 @@ alternative_endif
 	.endif
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
+
+	.if	\el == 1
+	ldr	x19, [sp, #S_FLAGS]
+	tbz	x19, #0, 1f
+	mrs	x19, mdscr_el1
+	enable_step	x19
+1:
+	.endif
+
 	ldp	x0, x1, [sp, #16 * 0]
 	ldp	x2, x3, [sp, #16 * 1]
 	ldp	x4, x5, [sp, #16 * 2]
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index b45c95d..6afbb80 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -802,7 +802,7 @@ int reinstall_suspended_bps(struct pt_regs *regs)
 			toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL0, 1);

 		if (*kernel_step != ARM_KERNEL_STEP_SUSPEND) {
-			kernel_disable_single_step();
+			kernel_disable_single_step(regs);
 			handled_exception = 1;
 		} else {
 			handled_exception = 0;
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index b67531a..f92c5fb 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -183,7 +183,7 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 * Received continue command, disable single step
 		 */
 		if (kernel_active_single_step())
-			kernel_disable_single_step();
+			kernel_disable_single_step(linux_regs);

 		err = 0;
 		break;
-- 
1.7.1

> 
> [1] http://www.spinics.net/lists/arm-kernel/msg491844.html
> 
> .
> 
