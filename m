From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Feb 2011 10:37:38 +0000
Subject: [PATCH 1/2] ARM: Introduce THREAD_NOTIFY_COPY for copy_thread() hooks
In-Reply-To: <20110214103528.5796.99616.stgit@e102109-lin.cambridge.arm.com>
References: <20110214103528.5796.99616.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20110214103738.5796.44268.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds THREAD_NOTIFY_COPY for colling registered handlers
during the copy_thread() function call. It also changes the VFP handler
to use a switch statement rather than if..else and ignore this event.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/thread_notify.h |    1 +
 arch/arm/kernel/process.c            |    2 ++
 arch/arm/vfp/vfpmodule.c             |   22 +++++++++++++++-------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/thread_notify.h b/arch/arm/include/asm/thread_notify.h
index c4391ba..1dc9806 100644
--- a/arch/arm/include/asm/thread_notify.h
+++ b/arch/arm/include/asm/thread_notify.h
@@ -43,6 +43,7 @@ static inline void thread_notify(unsigned long rc, struct thread_info *thread)
 #define THREAD_NOTIFY_FLUSH	0
 #define THREAD_NOTIFY_EXIT	1
 #define THREAD_NOTIFY_SWITCH	2
+#define THREAD_NOTIFY_COPY	3
 
 #endif
 #endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 94bbedb..5e1e541 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -372,6 +372,8 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	if (clone_flags & CLONE_SETTLS)
 		thread->tp_value = regs->ARM_r3;
 
+	thread_notify(THREAD_NOTIFY_COPY, thread);
+
 	return 0;
 }
 
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 0797cb5..5153135 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -104,12 +104,17 @@ static void vfp_thread_exit(struct thread_info *thread)
 static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 {
 	struct thread_info *thread = v;
+	u32 fpexc;
+#ifdef CONFIG_SMP
+	unsigned int cpu;
+#endif
 
-	if (likely(cmd == THREAD_NOTIFY_SWITCH)) {
-		u32 fpexc = fmrx(FPEXC);
+	switch (cmd) {
+	case THREAD_NOTIFY_SWITCH:
+		fpexc = fmrx(FPEXC);
 
 #ifdef CONFIG_SMP
-		unsigned int cpu = thread->cpu;
+		cpu = thread->cpu;
 
 		/*
 		 * On SMP, if VFP is enabled, save the old state in
@@ -134,13 +139,16 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
 		 * old state.
 		 */
 		fmxr(FPEXC, fpexc & ~FPEXC_EN);
-		return NOTIFY_DONE;
-	}
+		break;
 
-	if (cmd == THREAD_NOTIFY_FLUSH)
+	case THREAD_NOTIFY_FLUSH:
 		vfp_thread_flush(thread);
-	else
+		break;
+
+	case THREAD_NOTIFY_EXIT:
 		vfp_thread_exit(thread);
+		break;
+	}
 
 	return NOTIFY_DONE;
 }
