From: eric.auger@linaro.org (Eric Auger)
Date: Tue,  1 Mar 2016 18:27:41 +0000
Subject: [RFC v5 01/17] iommu: Add DOMAIN_ATTR_MSI_MAPPING attribute
In-Reply-To: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
References: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1456856877-4817-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new DOMAIN_ATTR_MSI_MAPPING domain attribute. If supported,
this means the MSI addresses need to be mapped in the IOMMU.

x86 IOMMUs typically don't expose the attribute since on x86, MSI write
transaction addresses always are within the 1MB PA region [FEE0_0000h -
FEF0_000h] window which directly targets the APIC configuration space and
hence bypass the sMMU. On ARM and PowerPC however MSI transactions are
conveyed through the IOMMU.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v4 -> v5:
- introduce the user in the next patch

RFC v1 -> v1:
- the data field is not used
- for this attribute domain_get_attr simply returns 0 if the MSI_MAPPING
  capability if needed or <0 if not.
- removed struct iommu_domain_msi_maps
---
 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a5c539f..a4fe04a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -112,6 +112,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
+	DOMAIN_ATTR_MSI_MAPPING, /* Require MSIs mapping in iommu */
 	DOMAIN_ATTR_MAX,
 };
 
-- 
1.9.1
