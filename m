From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:24 +0800
Subject: [PATCH v3 25/62] acpi/table: Introduce acpi_get_entry to get
 specified entry
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-26-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

When constructing MADT table for Dom0, it needs to create GICC subtable
according to the dom0_max_vcpus. This function could be used for get the
specified entry.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/drivers/acpi/tables.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 xen/include/xen/acpi.h    |  4 ++++
 2 files changed, 49 insertions(+)

diff --git a/xen/drivers/acpi/tables.c b/xen/drivers/acpi/tables.c
index 2fba206..3ba8bad 100644
--- a/xen/drivers/acpi/tables.c
+++ b/xen/drivers/acpi/tables.c
@@ -221,6 +221,51 @@ void __init acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
+struct acpi_subtable_header * __init
+acpi_get_entry(char *id, unsigned long table_size,
+	       struct acpi_table_header *table_header, int entry_id,
+	       unsigned int entry_index)
+{
+	struct acpi_subtable_header *entry;
+	unsigned int count = 0;
+	unsigned long table_end;
+
+	if ( !table_size )
+		return NULL;
+
+	if ( !table_header )
+	{
+		printk("Table header not present\n");
+		return NULL;
+	}
+
+	table_end = (unsigned long)table_header + table_header->length;
+
+	/* Parse all entries looking for a match. */
+	entry = (struct acpi_subtable_header *)
+	    ((unsigned long)table_header + table_size);
+
+	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
+	       table_end) {
+		if (entry->length < sizeof(*entry)) {
+			printk(KERN_ERR PREFIX "[%4.4s:%#x] Invalid length\n",
+			       id, entry_id);
+			return NULL;
+		}
+
+		if (entry->type == entry_id) {
+			if (count == entry_index)
+				return entry;
+			count++;
+		}
+
+		entry = (struct acpi_subtable_header *)
+		    ((unsigned long)entry + entry->length);
+	}
+
+	return NULL;
+}
+
 int __init
 acpi_parse_entries(char *id,
 		      unsigned long table_size,
diff --git a/xen/include/xen/acpi.h b/xen/include/xen/acpi.h
index 23f8261..3339374 100644
--- a/xen/include/xen/acpi.h
+++ b/xen/include/xen/acpi.h
@@ -72,6 +72,10 @@ int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_table_handler handler);
 int acpi_table_parse_entries(char *id, unsigned long table_size,
 	int entry_id, acpi_table_entry_handler handler, unsigned int max_entries);
+struct acpi_subtable_header *
+acpi_get_entry(char *id, unsigned long table_size,
+	       struct acpi_table_header *table_header, int entry_id,
+	       unsigned int entry_index);
 int acpi_parse_entries(char *id, unsigned long table_size,
 	acpi_table_entry_handler handler, struct acpi_table_header *table_header,
 	int entry_id, unsigned int max_entries);
-- 
2.1.0
