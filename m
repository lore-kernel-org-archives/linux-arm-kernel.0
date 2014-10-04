From: yi.li@linaro.org (Yi Li)
Date: Sat,  4 Oct 2014 23:46:43 +0800
Subject: [PATCHv4] arm64: dmi: Add SMBIOS/DMI support
Message-ID: <1412437603-3394-1-git-send-email-yi.li@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SMBIOS is important for server hardware vendors. It implements a spec for
providing descriptive information about the platform. Things like serial
numbers, physical layout of the ports, build configuration data, and the like.

This has been tested by dmidecode and lshw tools.

Signed-off-by: Yi Li <yi.li@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

As Ard's suggestion, tested the patch on the kernel with/without EFI
support to boot. The bootlog and dmidecode/lshw works fine.
I will send the log with another email.

 arch/arm64/Kconfig           |   11 +++++++++++
 arch/arm64/include/asm/dmi.h |   31 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/efi.c      |   14 ++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 arch/arm64/include/asm/dmi.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd4e81a..c69ab5a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -368,6 +368,17 @@ config EFI
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
+
 endmenu
 
 menu "Userspace binary formats"
diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
new file mode 100644
index 0000000..69d37d8
--- /dev/null
+++ b/arch/arm64/include/asm/dmi.h
@@ -0,0 +1,31 @@
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
+#ifndef __ASM_DMI_H
+#define __ASM_DMI_H
+
+#include <linux/io.h>
+#include <linux/slab.h>
+
+/*
+ * According to section 2.3.6 of the UEFI spec, the firmware should not
+ * request a virtual mapping for configuration tables such as SMBIOS.
+ * This means we have to map them before use.
+ */
+#define dmi_early_remap(x, l)		ioremap_cache(x, l)
+#define dmi_early_unmap(x, l)		iounmap(x)
+#define dmi_remap(x, l)			ioremap_cache(x, l)
+#define dmi_unmap(x)			iounmap(x)
+#define dmi_alloc(l)			kzalloc(l, GFP_KERNEL)
+
+#endif
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 03aaa99..f00617f 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -11,6 +11,7 @@
  *
  */
 
+#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
@@ -479,3 +480,16 @@ err_unmap:
 	return -1;
 }
 early_initcall(arm64_enter_virtual_mode);
+
+static int __init arm64_core_init(void)
+{
+/*
+ * DMI depends on EFI on arm64, and dmi_scan_machine() needs to be
+ * called early because dmi_id_init(), which is an arch_initcall itself,
+ * depends on dmi_scan_machine() having been called already.
+ */
+
+	dmi_scan_machine();
+	return 0;
+}
+core_initcall(arm64_core_init);
-- 
1.7.9.5
