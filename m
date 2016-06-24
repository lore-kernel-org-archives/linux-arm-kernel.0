From: zhengsq@rock-chips.com (Shunqian Zheng)
Date: Fri, 24 Jun 2016 10:13:26 +0800
Subject: [PATCH v5 1/8] iommu/rockchip: Fix devm_{request,free}_irq parameter
In-Reply-To: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
References: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
Message-ID: <1466734413-7453-2-git-send-email-zhengsq@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Xue <xxm@rock-chips.com>

Even though the IOMMU shares IRQ with its master, the struct device
passed to {request,free}_irq is supposed to represent the device that is
signalling the interrupt. This patch makes the driver use IOMMU device
instead of master's device to make things clear.

Signed-off-by: Simon Xue <xxm@rock-chips.com>
Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 25b4627..5a9659a 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -807,7 +807,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 
 	iommu->domain = domain;
 
-	ret = devm_request_irq(dev, iommu->irq, rk_iommu_irq,
+	ret = devm_request_irq(iommu->dev, iommu->irq, rk_iommu_irq,
 			       IRQF_SHARED, dev_name(dev), iommu);
 	if (ret)
 		return ret;
@@ -860,7 +860,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
 	}
 	rk_iommu_disable_stall(iommu);
 
-	devm_free_irq(dev, iommu->irq, iommu);
+	devm_free_irq(iommu->dev, iommu->irq, iommu);
 
 	iommu->domain = NULL;
 
-- 
1.9.1
