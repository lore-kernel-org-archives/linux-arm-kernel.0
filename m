From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 30 Aug 2018 13:31:14 +0300
Subject: [PATCH v1 2/2] irqchip/alpine-msi: Switch to bitmap_zalloc()
In-Reply-To: <20180830103114.60601-1-andriy.shevchenko@linux.intel.com>
References: <20180830103114.60601-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20180830103114.60601-2-andriy.shevchenko@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/irqchip/irq-alpine-msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 23a3b877f7f1..3340324c7a02 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -268,9 +268,7 @@ static int alpine_msix_init(struct device_node *node,
 		goto err_priv;
 	}
 
-	priv->msi_map = kcalloc(BITS_TO_LONGS(priv->num_spis),
-				sizeof(*priv->msi_map),
-				GFP_KERNEL);
+	priv->msi_map = bitmap_zalloc(priv->num_spis, GFP_KERNEL);
 	if (!priv->msi_map) {
 		ret = -ENOMEM;
 		goto err_priv;
@@ -286,7 +284,7 @@ static int alpine_msix_init(struct device_node *node,
 	return 0;
 
 err_map:
-	kfree(priv->msi_map);
+	bitmap_free(priv->msi_map);
 err_priv:
 	kfree(priv);
 	return ret;
-- 
2.18.0
