From: yong.wu@mediatek.com (Yong Wu)
Date: Sat, 17 Nov 2018 10:35:41 +0800
Subject: [PATCH v3 14/15] iommu/mediatek: Constify iommu_ops
In-Reply-To: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1542422142-30688-15-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

iommu_ops are not supposed to change at runtime.
Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
const iommu_ops provided by <linux/iommu.h>. So mark the non-const
structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[Yong: Change the title to iommu/mediatek: xx]
---
 drivers/iommu/mtk_iommu.c    | 4 ++--
 drivers/iommu/mtk_iommu_v1.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 63406c5..5775e8f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -119,7 +119,7 @@ struct mtk_iommu_domain {
 	struct iommu_domain		domain;
 };
 
-static struct iommu_ops mtk_iommu_ops;
+static const struct iommu_ops mtk_iommu_ops;
 
 static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
@@ -503,7 +503,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
-static struct iommu_ops mtk_iommu_ops = {
+static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
 	.domain_free	= mtk_iommu_domain_free,
 	.attach_dev	= mtk_iommu_attach_device,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 0e78084..27867b8 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -362,7 +362,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pa;
 }
 
-static struct iommu_ops mtk_iommu_ops;
+static const struct iommu_ops mtk_iommu_ops;
 
 /*
  * MTK generation one iommu HW only support one iommu domain, and all the client
@@ -524,7 +524,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	return 0;
 }
 
-static struct iommu_ops mtk_iommu_ops = {
+static const struct iommu_ops mtk_iommu_ops = {
 	.domain_alloc	= mtk_iommu_domain_alloc,
 	.domain_free	= mtk_iommu_domain_free,
 	.attach_dev	= mtk_iommu_attach_device,
-- 
1.9.1
