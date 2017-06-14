From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 14 Jun 2017 17:37:13 +0100
Subject: [PATCH 2/2] ACPI/IORT: Remove iort_node_match()
In-Reply-To: <20170614163713.14574-1-lorenzo.pieralisi@arm.com>
References: <20170614163713.14574-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170614163713.14574-2-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
probing") removed the linker section for IORT entries probing.

Since those IORT entries were the only iort_node_match() interface
users, the iort_node_match() became obsolete and can then be removed.

Remove the ACPI IORT iort_node_match() interface from the kernel.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/iort.c | 15 ---------------
 include/linux/acpi_iort.h |  2 --
 2 files changed, 17 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 797b28d..d048f72 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -234,21 +234,6 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
 	return NULL;
 }
 
-static acpi_status
-iort_match_type_callback(struct acpi_iort_node *node, void *context)
-{
-	return AE_OK;
-}
-
-bool iort_node_match(u8 type)
-{
-	struct acpi_iort_node *node;
-
-	node = iort_scan_node(type, iort_match_type_callback, NULL);
-
-	return node != NULL;
-}
-
 static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
 					    void *context)
 {
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 3ff9ace..8379d40 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -31,7 +31,6 @@ void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
 void acpi_iort_init(void);
-bool iort_node_match(u8 type);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 void acpi_configure_pmsi_domain(struct device *dev);
@@ -41,7 +40,6 @@ void iort_set_dma_mask(struct device *dev);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
 #else
 static inline void acpi_iort_init(void) { }
-static inline bool iort_node_match(u8 type) { return false; }
 static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 { return req_id; }
 static inline struct irq_domain *iort_get_device_domain(struct device *dev,
-- 
2.10.0
