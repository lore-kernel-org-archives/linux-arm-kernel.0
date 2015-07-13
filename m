From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 13 Jul 2015 16:14:22 +0700
Subject: [RFCv2 PATCH 6/8] gic: acpi: Introduce GIC MSI frame handle and
 helper functions
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1436778864-17645-7-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introdues struct gic_msi_frame_handle, which can be used
as a reference to GIC MSI frame in MADT. It also provides helper
functions to help parsing and getting reference to each MSI frame.
This avoids having to map and parse MADT multiple times.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/irqchip/irq-gic-acpi.c       | 78 ++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/arm-gic-acpi.h |  3 ++
 2 files changed, 81 insertions(+)

diff --git a/drivers/irqchip/irq-gic-acpi.c b/drivers/irqchip/irq-gic-acpi.c
index f0772d9..6684a8f 100644
--- a/drivers/irqchip/irq-gic-acpi.c
+++ b/drivers/irqchip/irq-gic-acpi.c
@@ -16,6 +16,15 @@
 #include <linux/irqchip/arm-gic-acpi.h>
 #include <linux/irqchip/arm-gic-v3.h>
 
+struct gic_msi_frame_handle {
+	struct list_head list;
+	struct acpi_madt_generic_msi_frame *frame;
+};
+
+static LIST_HEAD(msi_frame_list);
+
+static int acpi_num_msi_frame;
+
 /* GIC version presented in MADT GIC distributor structure */
 static u8 gic_version __initdata = ACPI_MADT_GIC_VERSION_NONE;
 
@@ -141,6 +150,75 @@ static int __init acpi_gic_version_init(void)
 	return 0;
 }
 
+static int __init
+acpi_parse_madt_msi(struct acpi_subtable_header *header,
+			const unsigned long end)
+{
+	struct gic_msi_frame_handle *ms;
+	struct acpi_madt_generic_msi_frame *frame;
+
+	frame = (struct acpi_madt_generic_msi_frame *)header;
+	if (BAD_MADT_ENTRY(frame, end))
+		return -EINVAL;
+
+	ms = kzalloc(sizeof(struct gic_msi_frame_handle *), GFP_KERNEL);
+	if (!ms)
+		return -ENOMEM;
+
+	ms->frame = frame;
+
+	list_add(&ms->list, &msi_frame_list);
+
+	return 0;
+}
+
+inline int acpi_get_num_msi_frames(void)
+{
+	return acpi_num_msi_frame;
+}
+
+int __init acpi_madt_msi_frame_init(struct acpi_table_header *table)
+{
+	int ret = 0;
+
+	if (acpi_num_msi_frame > 0)
+		return ret;
+
+	ret = acpi_parse_entries(ACPI_SIG_MADT,
+				 sizeof(struct acpi_table_madt),
+				 acpi_parse_madt_msi, table,
+				 ACPI_MADT_TYPE_GENERIC_MSI_FRAME, 0);
+	if (ret == 0) {
+		pr_debug("No valid ACPI GIC MSI FRAME exist\n");
+		return ret;
+	}
+
+	acpi_num_msi_frame = ret;
+	return 0;
+}
+
+int acpi_get_msi_frame(int index, struct acpi_madt_generic_msi_frame **p)
+{
+	int i = 0;
+	struct gic_msi_frame_handle *m;
+
+	if (index >= acpi_num_msi_frame)
+		return -EINVAL;
+
+	list_for_each_entry(m, &msi_frame_list, list) {
+		if (i == index)
+			break;
+		i++;
+	}
+
+	if (i == acpi_num_msi_frame)
+		return -EINVAL;
+
+	*p = m->frame;
+	return  0;
+}
+
+
 /*
  * This special acpi_table_id is the sentinel at the end of the
  * acpi_table_id[] array of all irqchips. It is automatically placed at
diff --git a/include/linux/irqchip/arm-gic-acpi.h b/include/linux/irqchip/arm-gic-acpi.h
index 0d43f515..9fb3577 100644
--- a/include/linux/irqchip/arm-gic-acpi.h
+++ b/include/linux/irqchip/arm-gic-acpi.h
@@ -22,6 +22,9 @@
 #define ACPI_GICV3_DIST_MEM_SIZE	(SZ_64K)
 
 u8 acpi_gic_version(void);
+int acpi_madt_msi_frame_init(struct acpi_table_header *table);
+int acpi_get_msi_frame(int index, struct acpi_madt_generic_msi_frame **p);
+int acpi_get_num_msi_frames(void);
 
 #endif /* CONFIG_ACPI */
 #endif /* ARM_GIC_ACPI_H_ */
-- 
2.1.0
