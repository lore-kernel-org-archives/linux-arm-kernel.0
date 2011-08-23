From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:46:50 +0100
Subject: [PATCH v4 6/8] ARM: reset: add reset functionality for jumping to a
	physical address
In-Reply-To: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314136012-20533-7-git-send-email-will.deacon@arm.com>
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
 arch/arm/kernel/process.c     |   71 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

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
index 84228ec..cda91a2 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -39,6 +39,7 @@
 #include <asm/system.h>
 #include <asm/thread_notify.h>
 #include <asm/stacktrace.h>
+#include <asm/pgalloc.h>
 #include <asm/mach/time.h>
 
 #ifdef CONFIG_CC_STACKPROTECTOR
@@ -91,6 +92,8 @@ static int __init hlt_setup(char *__unused)
 __setup("nohlt", nohlt_setup);
 __setup("hlt", hlt_setup);
 
+static char reboot_mode = 'h';
+
 void arm_machine_restart(char mode, const char *cmd)
 {
 	/* Disable interrupts first */
@@ -127,6 +130,72 @@ void arm_machine_restart(char mode, const char *cmd)
 	while (1);
 }
 
+extern void switch_stack(void (*fn)(void *), void *arg, void *sp);
+typedef void (*phys_reset_t)(unsigned long);
+
+struct arm_machine_reset_args {
+	unsigned long reset_code_phys;
+	pgd_t *reboot_tables;
+};
+
+void __arm_machine_reset(void *args)
+{
+	struct arm_machine_reset_args reset_args;
+	unsigned long reset_code_phys;
+	phys_reset_t phys_reset;
+
+	/* Copy our arguments onto the new stack. */
+	memcpy(&reset_args, args, sizeof(reset_args));
+	reset_code_phys = reset_args.reset_code_phys;
+
+	/* Take out a flat memory mapping. */
+	setup_mm_for_reboot(reboot_mode, reset_args.reboot_tables);
+
+	/* Clean and invalidate caches */
+	flush_cache_all();
+
+	/* Turn off caching */
+	cpu_proc_fin();
+
+	/* Push out any further dirty data, and ensure cache is empty */
+	flush_cache_all();
+
+	/* Switch to the identity mapping. */
+	phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
+	phys_reset(reset_code_phys);
+
+	/* Should never get here. */
+	BUG();
+}
+
+void arm_machine_reset(unsigned long reset_code_phys)
+{
+	phys_addr_t cpu_reset_end_phys;
+	void *cpu_reset_end;
+	struct arm_machine_reset_args reset_args;
+
+	cpu_reset_end = (void *)PAGE_ALIGN((unsigned long)cpu_reset);
+	cpu_reset_end_phys = virt_to_phys(cpu_reset_end);
+
+	/* Disable interrupts first. */
+	local_irq_disable();
+	local_fiq_disable();
+
+	/* Disable the L2. */
+	outer_disable();
+
+	/* Populate the reset args. */
+	reset_args.reset_code_phys = reset_code_phys;
+	reset_args.reboot_tables = pgd_alloc(&init_mm);
+
+	/* Change to the new stack and continue with the reset. */
+	switch_stack(__arm_machine_reset, (void *)&reset_args,
+		     (void *)RESERVE_STACK_PAGE);
+
+	/* Should never get here. */
+	BUG();
+}
+
 /*
  * Function pointers to optional machine specific functions
  */
@@ -216,8 +285,6 @@ void cpu_idle(void)
 	}
 }
 
-static char reboot_mode = 'h';
-
 int __init reboot_setup(char *str)
 {
 	reboot_mode = str[0];
-- 
1.7.0.4
