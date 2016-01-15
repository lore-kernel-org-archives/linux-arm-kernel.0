From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 15 Jan 2016 14:55:26 +0800
Subject: [PATCH v2 13/16] ARM: XEN: Set EFI_PARAVIRT if Xen supports EFI
In-Reply-To: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1452840929-19612-14-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Check if there is "uefi" node in the DT. If so, set EFI_PARAVIRT flag.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm/xen/enlighten.c | 23 +++++++++++++++++++++++
 arch/arm64/kernel/efi.c  |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 5d0fe68..485e117 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -31,6 +31,7 @@
 #include <linux/timekeeping.h>
 #include <linux/timekeeper_internal.h>
 #include <linux/acpi.h>
+#include <linux/efi.h>
 
 #include <linux/mm.h>
 
@@ -248,6 +249,19 @@ static int __init fdt_find_xen_node(unsigned long node, const char *uname,
 	return 0;
 }
 
+static int __init fdt_find_uefi_node(unsigned long node, const char *uname,
+				     int depth, void *data)
+{
+	bool *found = data;
+
+	if (depth != 2 || strcmp(uname, "uefi") != 0)
+		return 0;
+
+	*found = true;
+
+	return 1;
+}
+
 /*
  * see Documentation/devicetree/bindings/arm/xen.txt for the
  * documentation of the Xen Device Tree format.
@@ -255,6 +269,8 @@ static int __init fdt_find_xen_node(unsigned long node, const char *uname,
 #define GRANT_TABLE_PHYSADDR 0
 void __init xen_early_init(void)
 {
+	bool uefi_found = false;
+
 	of_scan_flat_dt(fdt_find_xen_node, NULL);
 	if (!xen_node.found) {
 		pr_debug("No Xen support\n");
@@ -279,6 +295,13 @@ void __init xen_early_init(void)
 
 	if (!console_set_on_cmdline && !xen_initial_domain())
 		add_preferred_console("hvc", 0, NULL);
+
+	if (IS_ENABLED(CONFIG_XEN_EFI)) {
+		/* Check if Xen support UEFI */
+		of_scan_flat_dt(fdt_find_uefi_node, &uefi_found);
+		if (uefi_found)
+			set_bit(EFI_PARAVIRT, &efi.flags);
+	}
 }
 
 static int __init xen_guest_init(void)
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 4eeb171..16c6b72 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -288,6 +288,11 @@ static int __init arm64_enable_runtime_services(void)
 		return 0;
 	}
 
+	if (efi_enabled(EFI_PARAVIRT)) {
+		pr_info("EFI runtime services access via paravirt.\n");
+		return -1;
+	}
+
 	pr_info("Remapping and enabling EFI services.\n");
 
 	mapsize = memmap.map_end - memmap.map;
-- 
2.0.4
