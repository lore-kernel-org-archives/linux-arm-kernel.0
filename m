From: robh@kernel.org (Rob Herring)
Date: Thu, 24 May 2018 12:50:22 -0500
Subject: [PATCH v2 6/8] iommu: Stop deferring probe at end of initcalls
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Message-ID: <20180524175024.19874-7-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IOMMU subsystem has its own mechanism to not defer probe if driver
support is missing. Now that the driver core supports stopping deferring
probe if drivers aren't built-in (and probed), use the driver core
support so the IOMMU specific support can be removed.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu at lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c36a8b7656a..2aac8387717c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -133,7 +133,7 @@ static int of_iommu_xlate(struct device *dev,
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
 	if (!ops)
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_init_done(dev, true);
 
 	return ops->of_xlate(dev, iommu_spec);
 }
-- 
2.17.0
