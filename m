From: yi.li@linaro.org (Yi Li)
Date: Tue, 26 Nov 2013 00:44:25 +0800
Subject: [PATCH 2/3] ARM64:DMI: Add smbios/dmi support on arm64
In-Reply-To: <1385397866-7524-1-git-send-email-yi.li@linaro.org>
References: <1385397866-7524-1-git-send-email-yi.li@linaro.org>
Message-ID: <1385397866-7524-3-git-send-email-yi.li@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add smbios/dmi support on arm64 system, it depends on
EFI boot.

Signed-off-by: Yi Li <yi.li@linaro.org>
---

efi_lookup_mapped_addr() isn't able to translate the address range
which is reported as reserved type from UEFI. Following the UEFI
spec 2.4, it descripts the SMBIOS data should be runtime service
type. So it depends on a UEFI patch to convert reserved type to 
runtime service type for SMBIOS and a linux dmi driver patch that
has been posted for review to x86 and ia64.

 arch/arm64/Kconfig           |   10 ++++++++++
 arch/arm64/include/asm/dmi.h |   28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c    |    2 ++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/include/asm/dmi.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d5aaddf..84204b0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -292,6 +292,16 @@ config EFI_STUB
 	  by EFI firmware without the use of a bootloader.
 	  See Documentation/efi-stub.txt for more information.
 
+config DMI
+	bool "Enable support for SMBIOS (DMI) tables"
+	depends on EFI
+	default y
+	help
+	  This enables SMBIOS/DMI feature for systems.
+
+	  This option is only useful on systems that have UEFI firmware.
+	  However, even with this option, the resultant kernel should
+	  continue to boot on existing non-UEFI platforms.
 endmenu
 
 menu "Userspace binary formats"
diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
new file mode 100644
index 0000000..f6e6004
--- /dev/null
+++ b/arch/arm64/include/asm/dmi.h
@@ -0,0 +1,28 @@
+/*
+ * arch/arm64/include/asm/dmi.h
+ *
+ * Copyright (C) 2013 Linaro Limited.
+ * Written by: Yi Li (yi.li at linaro.org)
+ *
+ * based on arch/ia64/include/asm/dmi.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+
+#ifndef _ASM_DMI_H
+#define _ASM_DMI_H 1
+
+#include <linux/slab.h>
+#include <asm/io.h>
+
+/* Use normal IO mappings for DMI */
+#define dmi_early_remap(x, l)	efi_lookup_mapped_addr(x)
+#define dmi_early_unmap(x, l)
+#define dmi_remap(x, l)			efi_lookup_mapped_addr(x)
+#define dmi_unmap(x)
+#define dmi_alloc(l)			kzalloc(l, GFP_ATOMIC)
+
+#endif
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 1aeaaf5..1480843 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -45,6 +45,7 @@
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #endif
+#include <linux/dmi.h>
 
 #include <asm/fixmap.h>
 #include <asm/cputype.h>
@@ -312,6 +313,7 @@ static int __init arm64_device_init(void)
 {
 	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	dmi_scan_machine();
 	return 0;
 }
 arch_initcall(arm64_device_init);
-- 
1.7.9.5
