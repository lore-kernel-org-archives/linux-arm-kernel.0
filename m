From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Thu, 19 May 2016 19:15:13 +0300
Subject: [PATCH v2 2/5] ACPI: table upgrade: refactor function definitions
In-Reply-To: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
References: <1463674518-22477-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1463674518-22477-3-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refer initrd_start, initrd_end directly from drivers/acpi/tables.c.
This allows to use the table upgrade feature in architectures
other than x86.  Also this simplifies header files.

The patch renames acpi_table_initrd_init() to acpi_table_upgrade()
(what reflects the purpose of the function) and removes the unneeded
wraps early_acpi_table_init() and early_initrd_acpi_init().

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/x86/kernel/setup.c |  9 +--------
 drivers/acpi/tables.c   | 14 ++++----------
 include/linux/acpi.h    |  8 ++++++--
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c4e7b39..aac91be 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -399,10 +399,6 @@ static void __init reserve_initrd(void)
 	memblock_free(ramdisk_image, ramdisk_end - ramdisk_image);
 }
 
-static void __init early_initrd_acpi_init(void)
-{
-	early_acpi_table_init((void *)initrd_start, initrd_end - initrd_start);
-}
 #else
 static void __init early_reserve_initrd(void)
 {
@@ -410,9 +406,6 @@ static void __init early_reserve_initrd(void)
 static void __init reserve_initrd(void)
 {
 }
-static void __init early_initrd_acpi_init(void)
-{
-}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 static void __init parse_setup_data(void)
@@ -1146,7 +1139,7 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_initrd();
 
-	early_initrd_acpi_init();
+	acpi_table_upgrade();
 
 	vsmp_init();
 
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f829e6a..b05df13 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -34,6 +34,7 @@
 #include <linux/bootmem.h>
 #include <linux/earlycpio.h>
 #include <linux/memblock.h>
+#include <linux/initrd.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -481,8 +482,10 @@ static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
 
 #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
 
-static void __init acpi_table_initrd_init(void *data, size_t size)
+void __init acpi_table_upgrade(void)
 {
+	void *data = (void *)initrd_start;
+	size_t size = initrd_end - initrd_start;
 	int sig, no, table_nr = 0, total_offset = 0;
 	long offset = 0;
 	struct acpi_table_header *table;
@@ -696,10 +699,6 @@ next_table:
 	}
 }
 #else
-static void __init acpi_table_initrd_init(void *data, size_t size)
-{
-}
-
 static acpi_status
 acpi_table_initrd_override(struct acpi_table_header *existing_table,
 			   acpi_physical_address *address,
@@ -742,11 +741,6 @@ acpi_os_table_override(struct acpi_table_header *existing_table,
 	return AE_OK;
 }
 
-void __init early_acpi_table_init(void *data, size_t size)
-{
-	acpi_table_initrd_init(data, size);
-}
-
 /*
  * acpi_table_init()
  *
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 288fac5..ef2ad26 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -208,7 +208,6 @@ void acpi_boot_table_init (void);
 int acpi_mps_check (void);
 int acpi_numa_init (void);
 
-void early_acpi_table_init(void *data, size_t size);
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
 int __init acpi_parse_entries(char *id, unsigned long table_size,
@@ -588,7 +587,6 @@ static inline const char *acpi_dev_name(struct acpi_device *adev)
 	return NULL;
 }
 
-static inline void early_acpi_table_init(void *data, size_t size) { }
 static inline void acpi_early_init(void) { }
 static inline void acpi_subsystem_init(void) { }
 
@@ -997,4 +995,10 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 #define acpi_probe_device_table(t)	({ int __r = 0; __r;})
 #endif
 
+#ifdef CONFIG_ACPI_TABLE_UPGRADE
+void acpi_table_upgrade(void);
+#else
+static inline void acpi_table_upgrade(void) { }
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.8.2
