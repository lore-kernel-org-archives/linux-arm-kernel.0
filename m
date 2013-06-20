From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 20 Jun 2013 13:47:25 +0200
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <51C2EA04.4060701@pengutronix.de>
References: <51C2C0B5.8020802@pengutronix.de> <20130620095705.GA18536@arm.com>
 <51C2D5EF.3040803@pengutronix.de> <20130620102856.GC18536@arm.com>
 <20130620111255.GD18536@arm.com> <51C2E917.9000708@pengutronix.de>
 <51C2EA04.4060701@pengutronix.de>
Message-ID: <51C2EBCD.4070206@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2013 01:39 PM, Marc Kleine-Budde wrote:
> On 06/20/2013 01:35 PM, Marc Kleine-Budde wrote:
>> On 06/20/2013 01:12 PM, Catalin Marinas wrote:
>>> On Thu, Jun 20, 2013 at 11:28:56AM +0100, Catalin Marinas wrote:
>>>> We may need to place the preempt disable/enable at a higher level in the
>>>> scheduler. My theory is that we have a context switch from prev to next.
>>>> We get preempted just before finish_arch_post_lock_switch(), so the MMU
>>>> hasn't been switched yet. The new switch during preemption happens to a
>>>> thread with the same next mm, so the scheduler no longer switch_mm() and
>>>> the TIF_SWITCH_MM isn't set for the new thread.
>>>>
>>>> I'll come back with another patch shortly.
>>>
>>> Here's another attempt (as before, only compile-tested):
>>
>> booting kernel from /image
>> zImage: concatenated oftree detected
>> booting Linux kernel with devicetree
>>
>> ...dead...
>>
>> Does every process have a "mm"? Even Kernel threads?

I've added a check for "mm". Boots now and my test runs stable for 3
minutes now.

I'm not sure if we have to check for "mm" in
check_and_switch_context(), too.

Thanks,
Marc
---

>From 306d84d5f0645a86e86d539be0546c4ac758d3d4 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 20 Jun 2013 12:12:55 +0100
Subject: [PATCH] arm: Fix deferred mm switch on VIVT processors

As of commit b9d4d42ad9 (ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
pre-ARMv6 CPUs), the mm switching on VIVT processors is done in the
finish_arch_post_lock_switch() function to avoid whole cache flushing
with interrupts disabled. The need for deferred mm switch is stored as a
thread flag (TIF_SWITCH_MM). However, with preemption enabled, we can
have another thread switch before finish_arch_post_lock_switch(). If the
new thread has the same mm as the previous 'next' thread, the scheduler
will not call switch_mm() and the TIF_SWITCH_MM flag won't be set for
the new thread.

This patch moves the switch pending flag to the mm_context_t structure
since this is specific to the mm rather than thread.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
[mkl: add check for mm]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/include/asm/mmu.h         | 2 ++
 arch/arm/include/asm/mmu_context.h | 8 +++++---
 arch/arm/include/asm/thread_info.h | 1 -
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index e3d5554..d1b4998 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -6,6 +6,8 @@
 typedef struct {
 #ifdef CONFIG_CPU_HAS_ASID
 	atomic64_t	id;
+#else
+	int		switch_pending;
 #endif
 	unsigned int	vmalloc_seq;
 } mm_context_t;
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index a7b85e0..9503a7b 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -47,7 +47,7 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 		 * on non-ASID CPUs, the old mm will remain valid until the
 		 * finish_arch_post_lock_switch() call.
 		 */
-		set_ti_thread_flag(task_thread_info(tsk), TIF_SWITCH_MM);
+		mm->context.switch_pending = 1;
 	else
 		cpu_switch_mm(mm->pgd, mm);
 }
@@ -56,9 +56,11 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 	finish_arch_post_lock_switch
 static inline void finish_arch_post_lock_switch(void)
 {
-	if (test_and_clear_thread_flag(TIF_SWITCH_MM)) {
-		struct mm_struct *mm = current->mm;
+	struct mm_struct *mm = current->mm;
+
+	if (mm && mm->context.switch_pending) {
 		cpu_switch_mm(mm->pgd, mm);
+		mm->context.switch_pending = 0;
 	}
 }
 
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 1995d1a..f00b569 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -156,7 +156,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20
-#define TIF_SWITCH_MM		22	/* deferred switch_mm */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/d76998d0/attachment-0001.sig>
