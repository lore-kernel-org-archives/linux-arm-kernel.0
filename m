From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 10 Nov 2014 19:47:01 +0100
Subject: [PATCH v2 1/2] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <1415645222-14909-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1415645222-14909-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1415645222-14909-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
that was passed to the kernel by the bootloader. This allows userland
applications such as kexec to access the raw binary. The blob needs to
be preserved as early as possible by calling preserve_fdt().

The fact that this node does not reside under /sys/firmware/device-tree
is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
communicate just the UEFI and ACPI entry points, but the FDT is never
unflattened and used to configure the system.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/of/fdt.c       | 34 ++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1ffca8b34ea..e9ee3d5f7ea4 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -22,6 +22,7 @@
 #include <linux/libfdt.h>
 #include <linux/debugfs.h>
 #include <linux/serial_core.h>
+#include <linux/sysfs.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -1103,4 +1104,37 @@ static int __init of_flat_dt_debugfs_export_fdt(void)
 module_init(of_flat_dt_debugfs_export_fdt);
 #endif
 
+static u8 *raw_fdt_copy;
+
+void __init preserve_fdt(void)
+{
+	u32 fdt_size;
+
+	fdt_size = fdt_totalsize(initial_boot_params);
+	raw_fdt_copy = memcpy(__va(memblock_alloc(fdt_size, PAGE_SIZE)),
+			      initial_boot_params, fdt_size);
+}
+
+#ifdef CONFIG_SYSFS
+static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buf, loff_t off, size_t count)
+{
+	memcpy(buf, raw_fdt_copy + off, count);
+	return count;
+}
+
+static int __init of_fdt_raw_init(void)
+{
+	static struct bin_attribute of_fdt_raw_attr =
+		__BIN_ATTR(fdt, S_IRUSR, of_fdt_raw_read, NULL, 0);
+
+	if (!raw_fdt_copy)
+		return 0;
+	of_fdt_raw_attr.size = fdt_totalsize(raw_fdt_copy);
+	return sysfs_create_bin_file(firmware_kobj, &of_fdt_raw_attr);
+}
+module_init(of_fdt_raw_init);
+#endif
+
 #endif /* CONFIG_OF_EARLY_FLATTREE */
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 0ff360d5b3b3..7672a26305a5 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -83,6 +83,7 @@ extern const void *of_flat_dt_match_machine(const void *default_match,
 /* Other Prototypes */
 extern void unflatten_device_tree(void);
 extern void unflatten_and_copy_device_tree(void);
+extern void preserve_fdt(void);
 extern void early_init_devtree(void *);
 extern void early_get_first_memblock_info(void *, phys_addr_t *);
 extern u64 fdt_translate_address(const void *blob, int node_offset);
@@ -92,6 +93,7 @@ static inline void early_init_fdt_scan_reserved_mem(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
 static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
+static inline void preserve_fdt(void) {}
 #endif /* CONFIG_OF_FLATTREE */
 
 #endif /* __ASSEMBLY__ */
-- 
1.8.3.2
