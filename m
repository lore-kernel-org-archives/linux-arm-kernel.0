From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 10 Nov 2014 17:51:45 +0100
Subject: [PATCH] of/fdt: export fdt blob as /sys/firmware/fdt
Message-ID: <1415638305-24463-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
that was passed to the kernel by the bootloader. This allows userland
applications such as kexec to access the raw binary.

The fact that this node does not reside under /sys/firmware/device-tree
is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
communicate just the UEFI and ACPI entry points, but the FDT is never
unflattened and used to configure the system.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Resending with CC LAKML and devicetree at vger.kernel.org added.
Apologies for the noise.

 drivers/of/fdt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1ffca8b34ea..60f9c67dc52a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -22,6 +22,7 @@
 #include <linux/libfdt.h>
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
+#include <linux/sysfs.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1103,4 +1104,23 @@ static int __init of_flat_dt_debugfs_export_fdt(void)
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
+	of_fdt_raw_attr.size = fdt_totalsize(initial_boot_params);
+	return sysfs_create_bin_file(firmware_kobj, &of_fdt_raw_attr);
+}
+module_init(of_fdt_raw_init);
+#endif
+
 #endif /* CONFIG_OF_EARLY_FLATTREE */
-- 
1.8.3.2
