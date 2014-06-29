From: a.heider@gmail.com (Andre Heider)
Date: Sun, 29 Jun 2014 18:21:36 +0200
Subject: [PATCH 02/13] uio: uio_pruss: use devm_kzalloc()
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Message-ID: <1404058907-21112-3-git-send-email-a.heider@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace kzalloc() by devm_kzalloc() and remove the kfree() calls.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/uio/uio_pruss.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index c28d6e2..f07545b 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -109,9 +109,7 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
 		gen_pool_free(gdev->sram_pool,
 			      gdev->sram_vaddr,
 			      sram_pool_sz);
-	kfree(gdev->info);
 	clk_put(gdev->pruss_clk);
-	kfree(gdev);
 }
 
 static int pruss_probe(struct platform_device *pdev)
@@ -123,24 +121,19 @@ static int pruss_probe(struct platform_device *pdev)
 	int ret = -ENODEV, cnt = 0, len;
 	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
 
-	gdev = kzalloc(sizeof(struct uio_pruss_dev), GFP_KERNEL);
+	gdev = devm_kzalloc(dev, sizeof(struct uio_pruss_dev), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
 
-	gdev->info = kzalloc(sizeof(*p) * MAX_PRUSS_EVT, GFP_KERNEL);
-	if (!gdev->info) {
-		kfree(gdev);
+	gdev->info = devm_kzalloc(dev, sizeof(*p) * MAX_PRUSS_EVT, GFP_KERNEL);
+	if (!gdev->info)
 		return -ENOMEM;
-	}
 
 	/* Power on PRU in case its not done as part of boot-loader */
 	gdev->pruss_clk = clk_get(dev, "pruss");
 	if (IS_ERR(gdev->pruss_clk)) {
 		dev_err(dev, "Failed to get clock\n");
-		ret = PTR_ERR(gdev->pruss_clk);
-		kfree(gdev->info);
-		kfree(gdev);
-		return ret;
+		return PTR_ERR(gdev->pruss_clk);
 	} else {
 		clk_enable(gdev->pruss_clk);
 	}
-- 
2.0.0
