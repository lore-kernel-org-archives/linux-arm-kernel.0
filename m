From: yi.li@linaro.org (Yi Li)
Date: Tue,  3 Jun 2014 23:57:13 +0800
Subject: [PATCH] ARM64:DMI: Add smbios/dmi support on arm64
Message-ID: <1401811033-16478-1-git-send-email-yi.li@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add smbios/dmi support on arm64 system, it depends on
EFI boot.

Signed-off-by: Yi Li <yi.li@linaro.org>
---

Changes since v1:
  -Followed Ard Biesheuvel's suggestion to rebase the patch on
   Matt Fleming's arm64-efi branch.

 arch/arm64/Kconfig           |   10 ++++++++++
 arch/arm64/include/asm/dmi.h |   28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c    |    2 ++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/include/asm/dmi.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6c71f12..13ee261 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -294,6 +294,16 @@ config EFI
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.
 
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
index 0000000..f2198bf
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
+/* Use efi mappings for DMI */
+#define dmi_early_remap(x, l)	efi_lookup_mapped_addr(x)
+#define dmi_early_unmap(x, l)
+#define dmi_remap(x, l)			efi_lookup_mapped_addr(x)
+#define dmi_unmap(x)
+#define dmi_alloc(l)			kzalloc(l, GFP_ATOMIC)
+
+#endif
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 0a14aaf..7622561 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -42,6 +42,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
 #include <linux/efi.h>
+#include <linux/dmi.h>
 
 #include <asm/fixmap.h>
 #include <asm/cputype.h>
@@ -400,6 +401,7 @@ static int __init arm64_device_init(void)
 {
 	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	dmi_scan_machine();
 	return 0;
 }
 arch_initcall(arm64_device_init);
-- 
1.7.9.5
