From: yi.li@linaro.org (Yi Li)
Date: Sat,  7 Sep 2013 00:02:51 +0800
Subject: [PATCH] ARM:DMI: Add dmi driver support on arm
In-Reply-To: <1378483371-19858-1-git-send-email-yi.li@linaro.org>
References: <1378483371-19858-1-git-send-email-yi.li@linaro.org>
Message-ID: <1378483371-19858-2-git-send-email-yi.li@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: liyi <yi.li@linaro.org>

Add dmi driver support on arm, it depends on efi runtime service
enabled.

Signed-off-by: liyi <yi.li@linaro.org>
---
 arch/arm/Kconfig           |    9 +++++++++
 arch/arm/include/asm/dmi.h |   12 ++++++++++++
 arch/arm/kernel/setup.c    |    7 ++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/dmi.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8daccd..02abb1d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1946,6 +1946,15 @@ config EFI_STUB
 	  executed directly by EFI firmware.
 	  See Documentation/efi-stub.txt for more information.
 
+config DMI
+	default y
+	bool "Enable DMI scanning" if EXPERT
+	---help---
+	  Enabled scanning of DMI to identify machine quirks. Say Y
+	  here unless you have verified that your setup is not
+	  affected by entries in the DMI blacklist. Required by EFI
+	  support.
+
 config SECCOMP
 	bool
 	prompt "Enable seccomp to safely compute untrusted bytecode"
diff --git a/arch/arm/include/asm/dmi.h b/arch/arm/include/asm/dmi.h
new file mode 100644
index 0000000..84baf0e
--- /dev/null
+++ b/arch/arm/include/asm/dmi.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_DMI_H
+#define _ASM_DMI_H 1
+
+#include <linux/slab.h>
+#include <asm/io.h>
+#include <asm/mach/map.h>
+/* Use normal IO mappings for DMI */
+#define dmi_ioremap(x, l) __arm_ioremap((x), (l), MT_MEMORY)
+#define dmi_iounmap(x, l) __arm_iounmap((x))
+#define dmi_alloc(l) kmalloc(l, GFP_ATOMIC)
+
+#endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index a440211..2194554 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -34,13 +34,15 @@
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #endif
+#ifdef CONFIG_DMI
+#include <linux/dmi.h>
+#endif
 
 #include <asm/unified.h>
 #include <asm/cp15.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/elf.h>
-#include <asm/io.h>
 #include <asm/procinfo.h>
 #include <asm/psci.h>
 #include <asm/sections.h>
@@ -1073,3 +1075,6 @@ const struct seq_operations cpuinfo_op = {
 	.stop	= c_stop,
 	.show	= c_show
 };
+#ifdef CONFIG_DMI
+	core_initcall(dmi_scan_machine);
+#endif
-- 
1.7.9.5
