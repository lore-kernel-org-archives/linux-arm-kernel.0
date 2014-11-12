From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 12 Nov 2014 13:28:28 +0100
Subject: [PATCH v4] of/fdt: export fdt blob as /sys/firmware/fdt
Message-ID: <1415795308-14639-1-git-send-email-ard.biesheuvel@linaro.org>
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
v4: use pr_warn() instead of WARN()
v3: keep checksum instead of copying the entire blob, and WARN on mismatch

 drivers/of/Kconfig |  1 +
 drivers/of/fdt.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

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
index d1ffca8b34ea..0004871ebccf 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -9,6 +9,7 @@
  * version 2 as published by the Free Software Foundation.
  */
 
+#include <linux/crc32.h>
 #include <linux/kernel.h>
 #include <linux/initrd.h>
 #include <linux/memblock.h>
@@ -22,10 +23,20 @@
 #include <linux/libfdt.h>
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
+#include <linux/sysfs.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
 
+static u32 of_fdt_crc32;
+
+static u32 of_fdt_get_crc32(void *fdt)
+{
+	static u32 const OF_FDT_CRC32_SEED = 0x04c11db7;
+
+	return crc32_be(OF_FDT_CRC32_SEED, fdt, fdt_totalsize(fdt));
+}
+
 /*
  * of_fdt_limit_memory - limit the number of regions in the /memory node
  * @limit: maximum entries
@@ -1003,6 +1014,8 @@ bool __init early_init_dt_verify(void *params)
 		return false;
 	}
 
+	of_fdt_crc32 = of_fdt_get_crc32(initial_boot_params);
+
 	return true;
 }
 
@@ -1103,4 +1116,28 @@ static int __init of_flat_dt_debugfs_export_fdt(void)
 module_init(of_flat_dt_debugfs_export_fdt);
 #endif
 
+#ifdef CONFIG_SYSFS
+static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buf, loff_t off, size_t count)
+{
+	memcpy(buf, initial_boot_params + off, count);
+	return count;
+}
+
+static int __init of_fdt_raw_init(void)
+{
+	static struct bin_attribute of_fdt_raw_attr =
+		__BIN_ATTR(fdt, S_IRUSR, of_fdt_raw_read, NULL, 0);
+
+	if (of_fdt_crc32 != of_fdt_get_crc32(initial_boot_params)) {
+		pr_warn("fdt: not creating '/sys/firmware/fdt': CRC check failed");
+		return 0;
+	}
+	of_fdt_raw_attr.size = fdt_totalsize(initial_boot_params);
+	return sysfs_create_bin_file(firmware_kobj, &of_fdt_raw_attr);
+}
+late_initcall(of_fdt_raw_init);
+#endif
+
 #endif /* CONFIG_OF_EARLY_FLATTREE */
-- 
1.8.3.2
