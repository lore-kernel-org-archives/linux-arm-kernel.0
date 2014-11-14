From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 14 Nov 2014 18:05:35 +0100
Subject: [PATCH v5.5] of/fdt: export fdt blob as /sys/firmware/fdt
Message-ID: <1415984735-32388-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
that was passed to the kernel by the bootloader. This allows userland
applications such as kexec to access the raw binary.

The fact that this node does not reside under /sys/firmware/device-tree
is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
communicate just the UEFI and ACPI entry points, but the FDT is never
unflattened and used to configure the system.

A CRC32 checksum is calculated over the entire FDT blob, and verified
at late_initcall time. The sysfs entry is instantiated only if the
checksum is valid, i.e., if the FDT blob has not been modified in the
mean time. Otherwise, a warning is printed.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

v5.5: based on Grant's changes
"""
Actually, I made a couple of changes when I merged it. I removed the
older debugfs interface since it overlaps, and I added tests for
initial_boot_params to make sure it doesn't try to run on an invalid
FDT
"""
but I removed the second fdt_check_header() again in the late init code, as it
would result in a corrupted FDT to be silently ignored. Note that
initial_boot_params can only be set if fdt_check_header() succeeded the first
time, so a failure occurring the second time should produce a warning, and
the CRC check will catch it anyway. The CRC check itself is fixed to use the
API as it is supposed to. I also moved the CRC variable definition inside the
#ifdef OF_EARLY_FLATTREE region.

v4: use pr_warn() instead of WARN()
v3: keep checksum instead of copying the entire blob, and WARN on mismatch

 drivers/of/Kconfig |  1 +
 drivers/of/fdt.c   | 43 +++++++++++++++++++++++++++----------------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 1a13f5b722c5..0348c208343c 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -23,6 +23,7 @@ config OF_FLATTREE
 	bool
 	select DTC
 	select LIBFDT
+	select CRC32
 
 config OF_EARLY_FLATTREE
 	bool
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1ffca8b34ea..2bbda0775f57 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -9,6 +9,7 @@
  * version 2 as published by the Free Software Foundation.
  */
 
+#include <linux/crc32.h>
 #include <linux/kernel.h>
 #include <linux/initrd.h>
 #include <linux/memblock.h>
@@ -22,6 +23,7 @@
 #include <linux/libfdt.h>
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
+#include <linux/sysfs.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -425,6 +427,8 @@ void *initial_boot_params;
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
+static u32 of_fdt_crc32;
+
 /**
  * res_mem_reserve_reg() - reserve all memory described in 'reg' property
  */
@@ -996,6 +1000,8 @@ bool __init early_init_dt_verify(void *params)
 
 	/* Setup flat device-tree pointer */
 	initial_boot_params = params;
+	of_fdt_crc32 = crc32_be(~0, initial_boot_params,
+				fdt_totalsize(initial_boot_params));
 
 	/* check device tree validity */
 	if (fdt_check_header(params)) {
@@ -1080,27 +1086,32 @@ void __init unflatten_and_copy_device_tree(void)
 	unflatten_device_tree();
 }
 
-#if defined(CONFIG_DEBUG_FS) && defined(DEBUG)
-static struct debugfs_blob_wrapper flat_dt_blob;
-
-static int __init of_flat_dt_debugfs_export_fdt(void)
+#ifdef CONFIG_SYSFS
+static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buf, loff_t off, size_t count)
 {
-	struct dentry *d = debugfs_create_dir("device-tree", NULL);
-
-	if (!d)
-		return -ENOENT;
+	memcpy(buf, initial_boot_params + off, count);
+	return count;
+}
 
-	flat_dt_blob.data = initial_boot_params;
-	flat_dt_blob.size = fdt_totalsize(initial_boot_params);
+static int __init of_fdt_raw_init(void)
+{
+	static struct bin_attribute of_fdt_raw_attr =
+		__BIN_ATTR(fdt, S_IRUSR, of_fdt_raw_read, NULL, 0);
 
-	d = debugfs_create_blob("flat-device-tree", S_IFREG | S_IRUSR,
-				d, &flat_dt_blob);
-	if (!d)
-		return -ENOENT;
+	if (!initial_boot_params)
+		return 0;
 
-	return 0;
+	if (of_fdt_crc32 != crc32_be(~0, initial_boot_params,
+				     fdt_totalsize(initial_boot_params))) {
+		pr_warn("fdt: not creating '/sys/firmware/fdt': CRC check failed\n");
+		return 0;
+	}
+	of_fdt_raw_attr.size = fdt_totalsize(initial_boot_params);
+	return sysfs_create_bin_file(firmware_kobj, &of_fdt_raw_attr);
 }
-module_init(of_flat_dt_debugfs_export_fdt);
+late_initcall(of_fdt_raw_init);
 #endif
 
 #endif /* CONFIG_OF_EARLY_FLATTREE */
-- 
1.8.3.2
