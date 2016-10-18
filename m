From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 18 Oct 2016 17:04:06 +0100
Subject: [PATCH v6 08/16] drivers: acpi: iort: add node match function
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Message-ID: <20161018160414.1228-9-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device drivers (eg ARM SMMU) need to know if a specific component
is part of the IORT table, so that kernel data structures are not
initialized at initcalls time if the respective component is not
part of the IORT table.

To this end, this patch adds a trivial function that allows detecting
if a given IORT node type is present or not in the ACPI table, providing
an ACPI IORT equivalent for of_find_matching_node().

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/arm64/iort.c | 15 +++++++++++++++
 include/linux/acpi_iort.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 75ff7fa..1433de3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -227,6 +227,21 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
 	return NULL;
 }
 
+static acpi_status
+iort_match_type_callback(struct acpi_iort_node *node, void *context)
+{
+	return AE_OK;
+}
+
+bool iort_node_match(u8 type)
+{
+	struct acpi_iort_node *node;
+
+	node = iort_scan_node(type, iort_match_type_callback, NULL);
+
+	return node != NULL;
+}
+
 static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 					    void *context)
 {
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index d16fdda..17bb078 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -28,10 +28,12 @@ void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
+bool iort_node_match(u8 type);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 #else
 static inline void acpi_iort_init(void) { }
+static inline bool iort_node_match(u8 type) { return false; }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
 static inline struct irq_domain *iort_get_device_domain(struct device *dev,
-- 
2.10.0
