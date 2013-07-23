From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 23:31:22 -0400
Subject: [PATCH 06/13] ARM: bL_switcher: simplify stack isolation
In-Reply-To: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1374550289-25305-7-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have a dedicated thread for each logical CPU.  That's plenty
of stack space for our needs.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index c2355cafc9..3ff7bfe126 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -54,12 +54,6 @@ static void bL_do_switch(void *_unused)
 {
 	unsigned mpidr, cpuid, clusterid, ob_cluster, ib_cluster;
 
-	/*
-	 * We now have a piece of stack borrowed from the init task's.
-	 * Let's also switch to init_mm right away to match it.
-	 */
-	cpu_switch_mm(init_mm.pgd, &init_mm);
-
 	pr_debug("%s\n", __func__);
 
 	mpidr = read_mpidr();
@@ -94,22 +88,21 @@ static void bL_do_switch(void *_unused)
 }
 
 /*
- * Stack isolation.  To ensure 'current' remains valid, we just borrow
- * a slice of the init/idle task which should be fairly lightly used.
- * The borrowed area starts just above the thread_info structure located
- * at the very bottom of the stack, aligned to a cache line.
+ * Stack isolation.  To ensure 'current' remains valid, we just use another
+ * piece of our thread's stack space which should be fairly lightly used.
+ * The selected area starts just above the thread_info structure located
+ * at the very bottom of the stack, aligned to a cache line, and indexed
+ * with the cluster number.
  */
-#define STACK_SIZE 256
+#define STACK_SIZE 512
 extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
 static int bL_switchpoint(unsigned long _arg)
 {
 	unsigned int mpidr = read_mpidr();
-	unsigned int cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	unsigned int clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
-	unsigned int cpu_index = cpuid + clusterid * MAX_CPUS_PER_CLUSTER;
-	void *stack = &init_thread_info + 1;
+	void *stack = current_thread_info() + 1;
 	stack = PTR_ALIGN(stack, L1_CACHE_BYTES);
-	stack += cpu_index * STACK_SIZE + STACK_SIZE;
+	stack += clusterid * STACK_SIZE + STACK_SIZE;
 	call_with_stack(bL_do_switch, (void *)_arg, stack);
 	BUG();
 }
-- 
1.8.1.2
