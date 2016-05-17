From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Tue, 17 May 2016 15:06:03 +0300
Subject: [PATCH 3/3] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
In-Reply-To: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1463486765-31827-4-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Masters <jcm@redhat.com>

This patch adds support for ACPI_TABLE_UPGRADE for ARM64

To access initrd image we need to move initialization
of linear mapping a bit earlier.

Signed-off-by: Jon Masters <jcm@redhat.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/arm64/kernel/setup.c |  6 ++++--
 drivers/acpi/Kconfig      |  2 +-
 drivers/acpi/tables.c     | 10 +++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index feab2ee..1d5e24f 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -261,11 +261,13 @@ void __init setup_arch(char **cmdline_p)
 	efi_init();
 	arm64_memblock_init();
 
+	paging_init();
+
+	early_initrd_acpi_init();
+
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
-	paging_init();
-
 	if (acpi_disabled)
 		unflatten_device_tree();
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c204344..ec694c0 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -313,7 +313,7 @@ config ACPI_CUSTOM_DSDT
 
 config ACPI_TABLE_UPGRADE
 	bool "Allow upgrading ACPI tables via initrd"
-	depends on BLK_DEV_INITRD && X86
+	depends on BLK_DEV_INITRD && (X86 || ARM64)
 	default y
 	help
 	  This option provides functionality to upgrade arbitrary ACPI tables
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 82be84a..c35034d8 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -482,6 +482,14 @@ static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
 
 #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
 
+#if defined(CONFIG_X86)
+#define MAX_PHYS_ACPI_TABLES (max_low_pfn_mapped << PAGE_SHIFT)
+#elif defined(CONFIG_ARM64)
+#define MAX_PHYS_ACPI_TABLES PFN_PHYS(max_pfn)
+#else
+#error "MAX_PHYS_ACPI_TABLES is not defiend for this architecture"
+#endif
+
 static void __init acpi_table_initrd_init(void *data, size_t size)
 {
 	int sig, no, table_nr = 0, total_offset = 0;
@@ -541,7 +549,7 @@ static void __init acpi_table_initrd_init(void *data, size_t size)
 		return;
 
 	acpi_tables_addr =
-		memblock_find_in_range(0, max_low_pfn_mapped << PAGE_SHIFT,
+		memblock_find_in_range(0, MAX_PHYS_ACPI_TABLES,
 				       all_tables_size, PAGE_SIZE);
 	if (!acpi_tables_addr) {
 		WARN_ON(1);
-- 
2.8.2
