From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Jul 2011 22:32:14 -0500
Subject: [RFC PATCH 3/3] ARM: add a default mach/system.h header
In-Reply-To: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
References: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
Message-ID: <1311823934-29553-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds default implementations of arch_idle and arch_reset. Any
platform with a system.h will pickup their version of the functions.

Platforms needing custom idle and reset functions can set pm_idle and
machine_reset, respectively, to custom implementations at boot time.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/mach/system.h |   13 +++++++++++++
 arch/arm/kernel/process.c      |    5 ++++-
 2 files changed, 17 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/include/mach/system.h

diff --git a/arch/arm/include/mach/system.h b/arch/arm/include/mach/system.h
new file mode 100644
index 0000000..9ab0684
--- /dev/null
+++ b/arch/arm/include/mach/system.h
@@ -0,0 +1,13 @@
+#ifndef __MACH_SYSTEM_H
+#define __MACH_SYSTEM_H
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
+
+#endif
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 5e1e541..b3b10bc 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -91,6 +91,9 @@ static int __init hlt_setup(char *__unused)
 __setup("nohlt", nohlt_setup);
 __setup("hlt", hlt_setup);
 
+void (*machine_reset)(char mode, const char *cmd) = arch_reset;
+EXPORT_SYMBOL(machine_reset);
+
 void arm_machine_restart(char mode, const char *cmd)
 {
 	/* Disable interrupts first */
@@ -116,7 +119,7 @@ void arm_machine_restart(char mode, const char *cmd)
 	/*
 	 * Now call the architecture specific reboot code.
 	 */
-	arch_reset(mode, cmd);
+	machine_reset(mode, cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
-- 
1.7.4.1
