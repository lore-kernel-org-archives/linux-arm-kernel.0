From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2011 18:23:18 +0100
Subject: [PATCH v3 7/9] ARM: reset: add reset functionality for jumping to a
	physical address
In-Reply-To: <1308158600-7169-1-git-send-email-will.deacon@arm.com>
References: <1308158600-7169-1-git-send-email-will.deacon@arm.com>
Message-ID: <1308158600-7169-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tools such as kexec and CPU hotplug require a way to reset the processor
and branch to some code in physical space. This requires various bits of
jiggery pokery with the caches and MMU which, when it goes wrong, tends
to lock up the system.

This patch implements a new function, arm_machine_reset, for
consolidating this code in one place where it can be used by multiple
subsystems.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/system.h |    1 +
 arch/arm/kernel/process.c     |   64 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 832888d..cd2a3cd 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -108,6 +108,7 @@ extern int cpu_architecture(void);
 extern void cpu_init(void);
 
 void arm_machine_restart(char mode, const char *cmd);
+void arm_machine_reset(unsigned long reset_code_phys);
 extern void (*arm_pm_restart)(char str, const char *cmd);
 
 #define UDBG_UNDEFINED	(1 << 0)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 8bd9d94..fe99ed3 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -90,12 +90,10 @@ static int __init hlt_setup(char *__unused)
 __setup("nohlt", nohlt_setup);
 __setup("hlt", hlt_setup);
 
-void arm_machine_restart(char mode, const char *cmd)
-{
-	/* Disable interrupts first */
-	local_irq_disable();
-	local_fiq_disable();
+extern void switch_stack(void (*fn)(void *), void *arg, void *sp);
 
+static void prepare_for_reboot(char mode)
+{
 	/*
 	 * Tell the mm system that we are going to reboot -
 	 * we may need it to insert some 1:1 mappings so that
@@ -103,14 +101,20 @@ void arm_machine_restart(char mode, const char *cmd)
 	 */
 	setup_mm_for_reboot(mode);
 
-	/* Clean and invalidate caches */
-	flush_cache_all();
-
 	/* Turn off caching */
 	cpu_proc_fin();
 
 	/* Push out any further dirty data, and ensure cache is empty */
 	flush_cache_all();
+}
+
+void arm_machine_restart(char mode, const char *cmd)
+{
+	/* Disable interrupts first */
+	local_irq_disable();
+	local_fiq_disable();
+
+	prepare_for_reboot(mode);
 
 	/*
 	 * Now call the architecture specific reboot code.
@@ -126,6 +130,50 @@ void arm_machine_restart(char mode, const char *cmd)
 	while (1);
 }
 
+typedef void (*phys_reset_t)(unsigned long);
+void __arm_machine_reset(void *reset_code_phys)
+{
+	phys_reset_t phys_reset;
+
+	prepare_for_reboot(MODE_REMAP_KERNEL);
+
+	/* Switch to the identity mapping. */
+	phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
+	phys_reset((unsigned long)reset_code_phys);
+
+	/* Should never get here. */
+	BUG();
+}
+
+void arm_machine_reset(unsigned long reset_code_phys)
+{
+	phys_addr_t cpu_reset_end_phys;
+	void *cpu_reset_end, *new_stack = (void *)RESERVE_STACK_PAGE;
+
+	cpu_reset_end = (void *)PAGE_ALIGN((unsigned long)cpu_reset);
+	cpu_reset_end_phys = virt_to_phys(cpu_reset_end);
+
+	/* Check that we can safely identity map the reset code. */
+	BUG_ON(cpu_reset_end_phys > TASK_SIZE &&
+	       cpu_reset_end_phys <= RESERVE_STACK_PAGE);
+
+	/* Check that the reserve stack page is valid memory. */
+	BUG_ON(!pfn_valid(__phys_to_pfn(virt_to_phys(new_stack - 1))));
+
+	/* Disable interrupts first. */
+	local_irq_disable();
+	local_fiq_disable();
+
+	/* Disable the L2. */
+	outer_disable();
+
+	/* Change to the new stack and continue with the reset. */
+	switch_stack(__arm_machine_reset, (void *)reset_code_phys, new_stack);
+
+	/* Should never get here. */
+	BUG();
+}
+
 /*
  * Function pointers to optional machine specific functions
  */
-- 
1.7.0.4
