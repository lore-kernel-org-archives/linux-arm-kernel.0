From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Oct 2014 21:36:58 +0800
Subject: [PATCH v5 02/18] ACPI / table: Add new function to get table entries
In-Reply-To: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1413553034-20956-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ashwin Chaugule <ashwin.chaugule@linaro.org>

The acpi_table_parse() function has a callback that
passes a pointer to a table_header. Add a new function
which takes this pointer and parses its entries. This
eliminates the need to re-traverse all the tables for
each call. e.g. as in acpi_table_parse_madt() which is
normally called after acpi_table_parse().

Acked-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/tables.c |   67 ++++++++++++++++++++++++++++++++++---------------
 include/linux/acpi.h  |    4 +++
 2 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 6d5a6cd..21ae521 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -192,17 +192,14 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 
 
 int __init
-acpi_table_parse_entries(char *id,
-			     unsigned long table_size,
-			     int entry_id,
-			     acpi_tbl_entry_handler handler,
-			     unsigned int max_entries)
+acpi_parse_entries(unsigned long table_size,
+		acpi_tbl_entry_handler handler,
+		struct acpi_table_header *table_header,
+		int entry_id, unsigned int max_entries)
 {
-	struct acpi_table_header *table_header = NULL;
 	struct acpi_subtable_header *entry;
-	unsigned int count = 0;
+	int count = 0;
 	unsigned long table_end;
-	acpi_size tbl_size;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -210,13 +207,11 @@ acpi_table_parse_entries(char *id,
 	if (!handler)
 		return -EINVAL;
 
-	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-		acpi_get_table_with_size(id, acpi_apic_instance, &table_header, &tbl_size);
-	else
-		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
+	if (!table_size)
+		return -EINVAL;
 
 	if (!table_header) {
-		pr_warn("%4.4s not present\n", id);
+		pr_warn("Table header not present\n");
 		return -ENODEV;
 	}
 
@@ -232,30 +227,62 @@ acpi_table_parse_entries(char *id,
 		if (entry->type == entry_id
 		    && (!max_entries || count++ < max_entries))
 			if (handler(entry, table_end))
-				goto err;
+				return -EINVAL;
 
 		/*
 		 * If entry->length is 0, break from this loop to avoid
 		 * infinite loop.
 		 */
 		if (entry->length == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
-			goto err;
+			pr_err("[0x%02x] Invalid zero length\n", entry_id);
+			return -EINVAL;
 		}
 
 		entry = (struct acpi_subtable_header *)
 		    ((unsigned long)entry + entry->length);
 	}
+
 	if (max_entries && count > max_entries) {
 		pr_warn("[%4.4s:0x%02x] ignored %i entries of %i found\n",
-			id, entry_id, count - max_entries, count);
+			table_header->signature, entry_id, count - max_entries,
+			count);
 	}
 
-	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 	return count;
-err:
+}
+
+int __init
+acpi_table_parse_entries(char *id,
+			 unsigned long table_size,
+			 int entry_id,
+			 acpi_tbl_entry_handler handler,
+			 unsigned int max_entries)
+{
+	struct acpi_table_header *table_header = NULL;
+	acpi_size tbl_size;
+	int count;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	if (!handler)
+		return -EINVAL;
+
+	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
+		acpi_get_table_with_size(id, acpi_apic_instance, &table_header, &tbl_size);
+	else
+		acpi_get_table_with_size(id, 0, &table_header, &tbl_size);
+
+	if (!table_header) {
+		pr_warn("%4.4s not present\n", id);
+		return -ENODEV;
+	}
+
+	count = acpi_parse_entries(table_size, handler, table_header,
+			entry_id, max_entries);
+
 	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
-	return -EINVAL;
+	return count;
 }
 
 int __init
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 807cbc4..36d5012 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -123,6 +123,10 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
+int __init acpi_parse_entries(unsigned long table_size,
+			      acpi_tbl_entry_handler handler,
+			      struct acpi_table_header *table_header,
+			      int entry_id, unsigned int max_entries);
 int __init acpi_table_parse_entries(char *id, unsigned long table_size,
 				    int entry_id,
 				    acpi_tbl_entry_handler handler,
-- 
1.7.9.5
