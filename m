From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 22 Oct 2014 16:21:52 +0200
Subject: [PATCH 09/10] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1413987713-30528-10-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yi Li <yi.li@linaro.org>

SMBIOS is important for server hardware vendors. It implements a spec for
providing descriptive information about the platform. Things like serial
numbers, physical layout of the ports, build configuration data, and the like.

Signed-off-by: Yi Li <yi.li@linaro.org>
Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
A short history of this patch:

v4: Moved call to dmi_scan_machine() to separate core_initcall(), so that it is
    called unconditionally, i.e., even if UEFI fails to initialize. Otherwise,
    any drivers that attempt to consult DMI info for quirks handling start
    spewing errors, as Catalin unfortunately found out after merging (and
    subsequently reverting) this patch into arm64 for-next/core for the second
    time.

v3: Moved call to dmi_scan_machine() into arm64_enter_virtual_mode(). This is
    to ensure that it is called early enough, because dmi_scan_machine() needs
    to be called before dmi_id_init(), which itself is invoked using an
    arch_initcall(). DMI depends on UEFI on arm64, so it is legal to only invoke
    dmi_scan_machine() when building with UEFI support. However, calling it from
    arm64_enter_virtual_mode() was a mistake, as it could result in
    dmi_scan_machine() not being called at all, resulting in the issues found
    by Catalin.

v2: Use efi_lookup_mapped_addr() to obtain the virtual address of the SMBIOS
    structure table instead of calling ioremap_cache(). This seemed a good idea
    at the time, as the UEFI memory map covers those regions, so the virtual
    mapping should be known as well. However, this is only true if the firmware
    has requested a virtual remapping for the region by setting the
    EFI_MEMORY_RUNTIME bit, which Tianocore/EDK2 appears to do, but violates
    the UEFI spec. ("In general, UEFI Configuration Tables loaded at boot time
    (e.g., SMBIOS table) can be contained in memory of type
    EfiRuntimeServicesData (recommended and the system firmware must not request
    a virtual mapping), [...]", section 2.3.6, UEFI spec v2.4B). This version
    was merged into the arm64 for-next/core branch and reverted again later per
    our request.
---
 arch/arm64/Kconfig           | 11 +++++++++++
 arch/arm64/include/asm/dmi.h | 31 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/efi.c      | 13 +++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 arch/arm64/include/asm/dmi.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ac9afde76dea..211401e8a1d5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -400,6 +400,17 @@ config EFI
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
index 000000000000..69d37d87b159
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
index 4cec21b1ecdd..0e9da0067ef2 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -11,6 +11,7 @@
  *
  */
 
+#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
@@ -467,3 +468,15 @@ err_unmap:
 	return -1;
 }
 early_initcall(arm64_enter_virtual_mode);
+
+static int __init arm64_dmi_init(void)
+{
+	/*
+	 * On arm64, DMI depends on UEFI, and dmi_scan_machine() needs to
+	 * be called early because dmi_id_init(), which is an arch_initcall
+	 * itself, depends on dmi_scan_machine() having been called already.
+	 */
+	dmi_scan_machine();
+	return 0;
+}
+core_initcall(arm64_dmi_init);
-- 
1.8.3.2
