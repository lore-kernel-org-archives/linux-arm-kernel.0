From: will.deacon@arm.com (Will Deacon)
Date: Thu,  8 Dec 2011 19:03:19 +0000
Subject: [PATCH v8 2/4] ARM: reset: implement soft_restart for jumping to a
 physical address
In-Reply-To: <1323371001-4036-1-git-send-email-will.deacon@arm.com>
References: <1323371001-4036-1-git-send-email-will.deacon@arm.com>
Message-ID: <1323371001-4036-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tools such as kexec and CPU hotplug require a way to reset the processor
and branch to some code in physical space. This requires various bits of
jiggery pokery with the caches and MMU which, when it goes wrong, tends
to lock up the system.

This patch fleshes out the soft_restart implementation so that it
branches to the reset code using the identity mapping. This requires us
to change to a temporary stack, held within the kernel image as a static
array, to avoid conflicting with the new view of memory.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/process.c |   50 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index eeb3e16..423bb20 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -92,17 +92,23 @@ static int __init hlt_setup(char *__unused)
 __setup("nohlt", nohlt_setup);
 __setup("hlt", hlt_setup);
 
-void soft_restart(unsigned long addr)
+extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
+typedef void (*phys_reset_t)(unsigned long);
+
+/*
+ * A temporary stack to use for CPU reset. This is static so that we
+ * don't clobber it with the identity mapping. When running with this
+ * stack, any references to the current task *will not work* so you
+ * should really do as little as possible before jumping to your reset
+ * code.
+ */
+static u64 soft_restart_stack[16];
+
+static void __soft_restart(void *addr)
 {
-	/* Disable interrupts first */
-	local_irq_disable();
-	local_fiq_disable();
+	phys_reset_t phys_reset;
 
-	/*
-	 * Tell the mm system that we are going to reboot -
-	 * we may need it to insert some 1:1 mappings so that
-	 * soft boot works.
-	 */
+	/* Take out a flat memory mapping. */
 	setup_mm_for_reboot();
 
 	/* Clean and invalidate caches */
@@ -114,7 +120,31 @@ void soft_restart(unsigned long addr)
 	/* Push out any further dirty data, and ensure cache is empty */
 	flush_cache_all();
 
-	cpu_reset(addr);
+	/* Switch to the identity mapping. */
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset((unsigned long)addr);
+
+	/* Should never get here. */
+	BUG();
+}
+
+void soft_restart(unsigned long addr)
+{
+	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
+
+	/* Disable interrupts first */
+	local_irq_disable();
+	local_fiq_disable();
+
+	/* Disable the L2 if we're the last man standing. */
+	if (num_online_cpus() == 1)
+		outer_disable();
+
+	/* Change to the new stack and continue with the reset. */
+	call_with_stack(__soft_restart, (void *)addr, (void *)stack);
+
+	/* Should never get here. */
+	BUG();
 }
 
 void arm_machine_restart(char mode, const char *cmd)
-- 
1.7.4.1
