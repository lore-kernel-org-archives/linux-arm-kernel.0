From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 18:04:56 +0100
Subject: [PATCH 4/6] ARM: reset: add reset functionality for jumping to a
	physical address
In-Reply-To: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
References: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379898-14256-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tools such as kexec and CPU hotplug require a way to reset the processor
and branch to some code in physical space. This requires various bits of
jiggery pokery with the caches and MMU which, when it goes wrong, tends
to lock up the system.

This patch implements a new function, arm_machine_reset, for
consolidating this code in one place where it can be used by multiple
subsystems.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/system.h |    1 +
 arch/arm/kernel/process.c     |   42 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 5 deletions(-)

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
index 5e1e541..0b46e9f 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -91,12 +91,8 @@ static int __init hlt_setup(char *__unused)
 __setup("nohlt", nohlt_setup);
 __setup("hlt", hlt_setup);
 
-void arm_machine_restart(char mode, const char *cmd)
+static void prepare_for_reboot(char mode)
 {
-	/* Disable interrupts first */
-	local_irq_disable();
-	local_fiq_disable();
-
 	/*
 	 * Tell the mm system that we are going to reboot -
 	 * we may need it to insert some 1:1 mappings so that
@@ -112,6 +108,15 @@ void arm_machine_restart(char mode, const char *cmd)
 
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
@@ -127,6 +132,33 @@ void arm_machine_restart(char mode, const char *cmd)
 	while (1);
 }
 
+void arm_machine_reset(unsigned long reset_code_phys)
+{
+	unsigned long cpu_reset_end = PAGE_ALIGN((unsigned long)cpu_reset);
+	/* This is stricter than necessary but better to be safe than sorry. */
+	BUG_ON(virt_to_phys((void *)cpu_reset_end) >= TASK_SIZE);
+
+	/* Disable interrupts first */
+	local_irq_disable();
+	local_fiq_disable();
+
+	/*
+	 * Clean and invalidate L2.
+	 * This is racy, so we must be the last guy left.
+	 */
+	WARN_ON(num_online_cpus() > 1);
+	/* Flush while we still have locking available to us. */
+	outer_flush_all();
+	outer_disable();
+	/* Data destroyed here will only be speculative. */
+	outer_inv_all();
+
+	prepare_for_reboot(0);
+
+	/* Switch to the identity mapping. */
+	((typeof(cpu_reset) *)virt_to_phys((void *)cpu_reset))(reset_code_phys);
+}
+
 /*
  * Function pointers to optional machine specific functions
  */
-- 
1.7.0.4
