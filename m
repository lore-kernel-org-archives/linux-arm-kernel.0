From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 24 Oct 2014 14:39:41 +0200
Subject: [PATCH 3/6] efi: split off remapping code from efi_config_init()
In-Reply-To: <1414154384-15385-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1414154384-15385-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1414154384-15385-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split of the remapping code from efi_config_init() so that the caller
can perform its own remapping. This is necessary to correctly handle
virtually remapped UEFI memory regions under kexec, as efi.systab will
have been updated to a virtual address.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 49 +++++++++++++++++++++++++++++-----------------
 include/linux/efi.h        |  2 ++
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 9035c1b74d58..0de77db4fb88 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -293,9 +293,10 @@ static __init int match_config_table(efi_guid_t *guid,
 	return 0;
 }
 
-int __init efi_config_init(efi_config_table_type_t *arch_tables)
+int __init efi_config_parse_tables(void *config_tables, int count,
+				   efi_config_table_type_t *arch_tables)
 {
-	void *config_tables, *tablep;
+	void *tablep;
 	int i, sz;
 
 	if (efi_enabled(EFI_64BIT))
@@ -303,19 +304,9 @@ int __init efi_config_init(efi_config_table_type_t *arch_tables)
 	else
 		sz = sizeof(efi_config_table_32_t);
 
-	/*
-	 * Let's see what config tables the firmware passed to us.
-	 */
-	config_tables = early_memremap(efi.systab->tables,
-				       efi.systab->nr_tables * sz);
-	if (config_tables == NULL) {
-		pr_err("Could not map Configuration table!\n");
-		return -ENOMEM;
-	}
-
 	tablep = config_tables;
 	pr_info("");
-	for (i = 0; i < efi.systab->nr_tables; i++) {
+	for (i = 0; i < count; i++) {
 		efi_guid_t guid;
 		unsigned long table;
 
@@ -328,8 +319,6 @@ int __init efi_config_init(efi_config_table_type_t *arch_tables)
 			if (table64 >> 32) {
 				pr_cont("\n");
 				pr_err("Table located above 4GB, disabling EFI.\n");
-				early_memunmap(config_tables,
-					       efi.systab->nr_tables * sz);
 				return -EINVAL;
 			}
 #endif
@@ -344,13 +333,37 @@ int __init efi_config_init(efi_config_table_type_t *arch_tables)
 		tablep += sz;
 	}
 	pr_cont("\n");
-	early_memunmap(config_tables, efi.systab->nr_tables * sz);
-
 	set_bit(EFI_CONFIG_TABLES, &efi.flags);
-
 	return 0;
 }
 
+int __init efi_config_init(efi_config_table_type_t *arch_tables)
+{
+	void *config_tables;
+	int sz, ret;
+
+	if (efi_enabled(EFI_64BIT))
+		sz = sizeof(efi_config_table_64_t);
+	else
+		sz = sizeof(efi_config_table_32_t);
+
+	/*
+	 * Let's see what config tables the firmware passed to us.
+	 */
+	config_tables = early_memremap(efi.systab->tables,
+				       efi.systab->nr_tables * sz);
+	if (config_tables == NULL) {
+		pr_err("Could not map Configuration table!\n");
+		return -ENOMEM;
+	}
+
+	ret = efi_config_parse_tables(config_tables, efi.systab->nr_tables,
+				      arch_tables);
+
+	early_memunmap(config_tables, efi.systab->nr_tables * sz);
+	return ret;
+}
+
 #ifdef CONFIG_EFI_VARS_MODULE
 static int __init efi_load_efivars(void)
 {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 27d69388ded0..abd3e91964a6 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -875,6 +875,8 @@ static inline efi_status_t efi_query_variable_store(u32 attributes, unsigned lon
 #endif
 extern void __iomem *efi_lookup_mapped_addr(u64 phys_addr);
 extern int efi_config_init(efi_config_table_type_t *arch_tables);
+extern int efi_config_parse_tables(void *config_tables, int count,
+				   efi_config_table_type_t *arch_tables);
 extern u64 efi_get_iobase (void);
 extern u32 efi_mem_type (unsigned long phys_addr);
 extern u64 efi_mem_attributes (unsigned long phys_addr);
-- 
1.8.3.2
