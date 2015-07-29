From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 29 Jul 2015 18:08:57 +0800
Subject: [PATCH v4 08/10] ACPI: GIC: Add ACPI helper functions to query
 irq-domain tokens for for GIC MSI and ITS
In-Reply-To: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1438164539-29256-9-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch introduces acpi_gic_get_msi_token(), which returns irq-domain
token that can be used to look up MSI doamin of a device.
In both GIC MSI and ITS cases, the base_address specified in the GIC MSI
or GIC ITS structure is used as a token for MSI domain.

In addition, this patch also provides low-level helper functions to parse
and query GIC MSI structure and GIC ITS from MADT. Once parsed, it keeps
a copy of the structure for use in subsequent queries to avoid having
to map and parse MADT multiple times.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Makefile   |   1 +
 drivers/acpi/acpi_gic.c | 234 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_gic.h |  23 +++++
 include/linux/acpi.h    |   1 +
 4 files changed, 259 insertions(+)
 create mode 100644 drivers/acpi/acpi_gic.c
 create mode 100644 include/acpi/acpi_gic.h

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8321430..def54b9 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -54,6 +54,7 @@ acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
+acpi-$(CONFIG_ARM_GIC_ACPI)	+= acpi_gic.o
 
 # These are (potentially) separate modules
 
diff --git a/drivers/acpi/acpi_gic.c b/drivers/acpi/acpi_gic.c
new file mode 100644
index 0000000..11ee4eb
--- /dev/null
+++ b/drivers/acpi/acpi_gic.c
@@ -0,0 +1,234 @@
+/*
+ * File: acpi_gic.c
+ *
+ * ACPI helper functions for ARM GIC
+ *
+ * Copyright (C) 2015 Advanced Micro Devices, Inc.
+ * Authors: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+
+/*
+ * GIC MSI Frame data structures
+ */
+struct gic_msi_frame_handle {
+	struct list_head list;
+	struct acpi_madt_generic_msi_frame frame;
+};
+
+static LIST_HEAD(msi_frame_list);
+
+static int acpi_num_msi;
+
+/*
+ * GIC ITS data structures
+ */
+struct gic_its_handle {
+	struct list_head list;
+	struct acpi_madt_generic_translator trans;
+};
+
+static LIST_HEAD(its_list);
+
+static int acpi_num_its;
+
+/*
+ * GIC MSI Frame parsing stuff
+ */
+inline int acpi_gic_get_num_msi_frame(void)
+{
+	return acpi_num_msi;
+}
+
+static int __init
+acpi_parse_madt_msi(struct acpi_subtable_header *header,
+		    const unsigned long end)
+{
+	struct gic_msi_frame_handle *h;
+	struct acpi_madt_generic_msi_frame *frame;
+
+	frame = (struct acpi_madt_generic_msi_frame *)header;
+	if (BAD_MADT_ENTRY(frame, end))
+		return -EINVAL;
+
+	h = kzalloc(sizeof(struct gic_msi_frame_handle *), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+
+	/** Note:
+	 * We make a copy of this structure since this code is called
+	 * prior to acpi_early_init(), which sets the acpi_gbl_permanent_mmap.
+	 * Therefore, we could not keep just the pointer sincce the memory
+	 * could be unmapped.
+	 */
+	memcpy(&h->frame, frame, sizeof(struct acpi_madt_generic_msi_frame));
+
+	list_add(&h->list, &msi_frame_list);
+
+	return 0;
+}
+
+int __init acpi_gic_msi_init(struct acpi_table_header *table)
+{
+	int ret = 0;
+
+	if (acpi_num_msi > 0)
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
+	acpi_num_msi = ret;
+	return 0;
+}
+
+int acpi_gic_get_msi_frame(int index, struct acpi_madt_generic_msi_frame **p)
+{
+	int i = 0;
+	struct gic_msi_frame_handle *m;
+
+	if (index >= acpi_num_msi)
+		return -EINVAL;
+
+	list_for_each_entry(m, &msi_frame_list, list) {
+		if (i == index)
+			break;
+		i++;
+	}
+
+	if (i == acpi_num_msi)
+		return -EINVAL;
+
+	*p = &(m->frame);
+	return  0;
+}
+
+/*
+ * GIC ITS parsing stuff
+ */
+inline int acpi_gic_get_num_its(void)
+{
+	return acpi_num_its;
+}
+
+static int __init
+acpi_parse_madt_its(struct acpi_subtable_header *header,
+		    const unsigned long end)
+{
+	struct gic_its_handle *h;
+	struct acpi_madt_generic_translator *trans;
+
+	trans = (struct acpi_madt_generic_translator *)header;
+	if (BAD_MADT_ENTRY(trans, end))
+		return -EINVAL;
+
+	h = kzalloc(sizeof(struct gic_its_handle *), GFP_KERNEL);
+	if (!h)
+		return -ENOMEM;
+
+	memcpy(&h->trans, trans, sizeof(struct acpi_madt_generic_translator));
+
+	list_add(&h->list, &its_list);
+
+	return 0;
+}
+
+int __init acpi_gic_madt_gic_its_init(struct acpi_table_header *table)
+{
+	int ret = 0;
+
+	if (acpi_num_its > 0)
+		return ret;
+
+	ret = acpi_parse_entries(ACPI_SIG_MADT,
+				 sizeof(struct acpi_table_madt),
+				 acpi_parse_madt_its, table,
+				 ACPI_MADT_TYPE_GENERIC_TRANSLATOR, 0);
+	if (ret == 0) {
+		pr_debug("No valid ACPI GIC ITS exist\n");
+		return ret;
+	}
+
+	acpi_num_its = ret;
+	return 0;
+}
+
+int acpi_gic_get_its(int index, struct acpi_madt_generic_translator **p)
+{
+	int i = 0;
+	struct gic_its_handle *m;
+
+	if (index >= acpi_num_its)
+		return -EINVAL;
+
+	list_for_each_entry(m, &its_list, list) {
+		if (i == index)
+			break;
+		i++;
+	}
+
+	if (i == acpi_num_its)
+		return -EINVAL;
+
+	*p = &(m->trans);
+	return  0;
+}
+
+static void *acpi_gic_msi_token(struct device *dev)
+{
+	int err;
+	struct acpi_madt_generic_msi_frame *msi;
+
+	/**
+	* Since ACPI 5.1 currently does not define
+	* a way to associate MSI frame ID to a device,
+	* we can only support single MSI frame (index 0)
+	* at the moment.
+	*/
+	err = acpi_gic_get_msi_frame(0, &msi);
+	if (err)
+		return NULL;
+
+	return (void *) msi->base_address;
+}
+
+static void *acpi_gic_its_token(struct device *dev)
+{
+	int err;
+	struct acpi_madt_generic_translator *trans;
+	int its_id = 0;
+
+	/**
+	 * TODO: We need a way to retrieve GIC ITS ID from
+	 * struct device pointer (in this case, the device
+	 * would be the PCI host controller.
+	 *
+	 * This would be done by the IORT-related code.
+	 *
+	 * its_id = get_its_id(dev);
+	 */
+
+	err = acpi_gic_get_its(its_id, &trans);
+	if (err)
+		return NULL;
+
+	return (void *) trans->base_address;
+}
+
+void *acpi_gic_get_msi_token(struct device *dev)
+{
+	void *token = acpi_gic_msi_token(dev);
+
+	if (!token)
+		token = acpi_gic_its_token(dev);
+
+	return token;
+}
diff --git a/include/acpi/acpi_gic.h b/include/acpi/acpi_gic.h
new file mode 100644
index 0000000..34fa475
--- /dev/null
+++ b/include/acpi/acpi_gic.h
@@ -0,0 +1,23 @@
+/*
+ *  include/acpi/acpi_gic.h
+ *
+ * Copyright (C) 2015 Advanced Micro Devices, Inc.
+ * Authors: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
+ */
+
+#ifndef __ACPI_GIC_H__
+#define __ACPI_GIC_H__
+
+#ifdef CONFIG_ACPI
+int acpi_gic_get_num_msi_frame(void);
+int acpi_gic_msi_init(struct acpi_table_header *table);
+int acpi_gic_get_msi_frame(int index, struct acpi_madt_generic_msi_frame **p);
+
+int acpi_gic_get_num_its(void);
+int acpi_gic_its_init(struct acpi_table_header *table);
+int acpi_gic_get_its(int index, struct acpi_madt_generic_translator **p);
+
+void *acpi_gic_get_msi_token(struct device *dev);
+#endif
+
+#endif /*__ACPI_GIC_H__*/
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 04dd0bb..5d58b61 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -44,6 +44,7 @@
 
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/acpi_gic.h>
 #include <acpi/acpi_numa.h>
 #include <acpi/acpi_io.h>
 #include <asm/acpi.h>
-- 
1.9.1
