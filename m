From: sainswapna@gmail.com (Swapna Nannapaneni)
Date: Thu, 26 Mar 2015 08:52:51 -0400
Subject: [PATCH 02/16] iommu: Introduce iommu domain types
In-Reply-To: <1427373799-18662-3-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
 <1427373799-18662-3-git-send-email-joro@8bytes.org>
Message-ID: <20150326125251.5005382.96732.4883@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X

Sent?from?my?BlackBerry?10?smartphone?on?the?TELUS?network.
? Original Message ?
From: Joerg Roedel
Sentuv: Thursday, March 26, 2015 8:51 AM
To: iommu at lists.linux-foundation.org
Cc: Will Deacon; Kukjin Kim; David Woodhouse; Heiko Stuebner; Hiroshi Doyu; Stephen Warren; Thierry Reding; Alexandre Courbot; Alex Williamson; Arnd Bergmann; Yingjoe Chen; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org; linux-rockchip at lists.infradead.org; linux-tegra at vger.kernel.org; Joerg Roedel; jroedel at suse.de
Subject: [PATCH 02/16] iommu: Introduce iommu domain types

From: Joerg Roedel <jroedel@suse.de>

This allows to handle domains differently based on their
type in the future. An IOMMU driver can implement certain
optimizations for DMA-API domains for example.

The domain types can be extended later and some of the
existing domain attributes can be migrated to become domain
flags.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
drivers/iommu/iommu.c | 5 +++--
include/linux/iommu.h | 27 ++++++++++++++++++++++++++-
2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 11de262..4920605 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -909,14 +909,15 @@ struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
ops = bus->iommu_ops;

if (ops->domain_alloc)
-	 domain = ops->domain_alloc();
+	 domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
else
domain = kzalloc(sizeof(*domain), GFP_KERNEL);

if (!domain)
return NULL;

-	domain->ops = bus->iommu_ops;
+	domain->ops = bus->iommu_ops;
+	domain->type = IOMMU_DOMAIN_UNMANAGED;

if (ops->domain_init && domain->ops->domain_init(domain))
goto out_free;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 69d1d12..72d03fe 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -51,7 +51,32 @@ struct iommu_domain_geometry {
bool force_aperture; /* DMA only allowed in mappable range? */
};

+/* Domain feature flags */
+#define __IOMMU_DOMAIN_PAGING	(1U << 0) /* Support for iommu_map/unmap */
+#define __IOMMU_DOMAIN_DMA_API	(1U << 1) /* Domain for use in DMA-API
+	 implementation */
+#define __IOMMU_DOMAIN_PT	(1U << 2) /* Domain is identity mapped */
+
+/*
+ * This are the possible domain-types
+ *
+ *	IOMMU_DOMAIN_BLOCKED	- All DMA is blocked, can be used to isolate
+ *	 devices
+ *	IOMMU_DOMAIN_IDENTITY	- DMA addresses are system physical addresses
+ *	IOMMU_DOMAIN_UNMANAGED	- DMA mappings managed by IOMMU-API user, used
+ *	 for VMs
+ *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
+ *	 This flag allows IOMMU drivers to implement
+ *	 certain optimizations for these domains
+ */
+#define IOMMU_DOMAIN_BLOCKED	(0U)
+#define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
+#define IOMMU_DOMAIN_UNMANAGED (__IOMMU_DOMAIN_PAGING)
+#define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
+	 __IOMMU_DOMAIN_DMA_API)
+
struct iommu_domain {
+	unsigned type;
const struct iommu_ops *ops;
void *priv;
iommu_fault_handler_t handler;
@@ -117,7 +142,7 @@ struct iommu_ops {
void (*domain_destroy)(struct iommu_domain *domain);

/* Domain allocation and freeing by the iommu driver */
-	struct iommu_domain *(*domain_alloc)(void);
+	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
void (*domain_free)(struct iommu_domain *);

int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@http://vger.kernel.org/majordomo-info.html
