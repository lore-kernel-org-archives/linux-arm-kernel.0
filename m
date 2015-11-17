From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:22 +0800
Subject: [PATCH v3 23/62] acpi/table: Introduce acpi_parse_entries
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-24-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Parth Dixit <parth.dixit@linaro.org>

Add new function acpi_parse_entries which takes acpi table as argument.
This will avoid fetching table everytime in acpi_table_parse_entries.
This function will be used in acpi_gicv2_init within another patch.

Signed-off-by: Naresh Bhat <Naresh.Bhat@linaro.org>
Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/drivers/acpi/tables.c | 53 ++++++++++++++++++++++++++++++++++-------------
 xen/include/xen/acpi.h    |  3 +++
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/xen/drivers/acpi/tables.c b/xen/drivers/acpi/tables.c
index 6573175..2fba206 100644
--- a/xen/drivers/acpi/tables.c
+++ b/xen/drivers/acpi/tables.c
@@ -221,29 +221,27 @@ void __init acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
-
 int __init
-acpi_table_parse_entries(char *id,
-			     unsigned long table_size,
-			     int entry_id,
-			     acpi_table_entry_handler handler,
-			     unsigned int max_entries)
+acpi_parse_entries(char *id,
+		      unsigned long table_size,
+		      acpi_table_entry_handler handler,
+		      struct acpi_table_header *table_header,
+		      int entry_id,
+		      unsigned int max_entries)
 {
-	struct acpi_table_header *table_header = NULL;
 	struct acpi_subtable_header *entry;
 	unsigned int count = 0;
 	unsigned long table_end;
 
-	if (!handler)
+	if ( !handler )
 		return -EINVAL;
 
-	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-		acpi_get_table(id, acpi_apic_instance, &table_header);
-	else
-		acpi_get_table(id, 0, &table_header);
+	if ( !table_size )
+		return -EINVAL;
 
-	if (!table_header) {
-		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
+	if ( !table_header )
+	{
+		printk("Table header not present\n");
 		return -ENODEV;
 	}
 
@@ -279,6 +277,33 @@ acpi_table_parse_entries(char *id,
 	}
 
 	return count;
+
+}
+
+int __init
+acpi_table_parse_entries(char *id,
+			     unsigned long table_size,
+			     int entry_id,
+			     acpi_table_entry_handler handler,
+			     unsigned int max_entries)
+{
+	struct acpi_table_header *table_header = NULL;
+
+	if (!handler)
+		return -EINVAL;
+
+	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
+		acpi_get_table(id, acpi_apic_instance, &table_header);
+	else
+		acpi_get_table(id, 0, &table_header);
+
+	if (!table_header) {
+		printk(KERN_WARNING PREFIX "%4.4s not present\n", id);
+		return -ENODEV;
+	}
+
+	return acpi_parse_entries(id, table_size, handler, table_header,
+				  entry_id, max_entries);
 }
 
 int __init
diff --git a/xen/include/xen/acpi.h b/xen/include/xen/acpi.h
index 723ece8..23f8261 100644
--- a/xen/include/xen/acpi.h
+++ b/xen/include/xen/acpi.h
@@ -72,6 +72,9 @@ int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_table_handler handler);
 int acpi_table_parse_entries(char *id, unsigned long table_size,
 	int entry_id, acpi_table_entry_handler handler, unsigned int max_entries);
+int acpi_parse_entries(char *id, unsigned long table_size,
+	acpi_table_entry_handler handler, struct acpi_table_header *table_header,
+	int entry_id, unsigned int max_entries);
 int acpi_table_parse_madt(enum acpi_madt_type id, acpi_table_entry_handler handler, unsigned int max_entries);
 int acpi_table_parse_srat(int id, acpi_madt_entry_handler handler,
 	unsigned int max_entries);
-- 
2.1.0
