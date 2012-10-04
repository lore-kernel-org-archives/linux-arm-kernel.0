From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 4 Oct 2012 10:04:40 +0200
Subject: [PATCH V2 2/3] Revert "spi/pl022: enable runtime PM"
In-Reply-To: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349337881-15917-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1349337881-15917-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This reverts commit 2fb30d1147c599f5657e8c62c862f9a0f58d9d99.

This patch is reverted due to wrong runtime PM code.

Conflicts:

	drivers/spi/spi-pl022.c

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 5cf0643..a1db91a 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2186,9 +2186,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
 	       adev->res.start, pl022->virtbase);
 
-	pm_runtime_enable(dev);
-	pm_runtime_resume(dev);
-
 	pl022->clk = devm_clk_get(&adev->dev, NULL);
 	if (IS_ERR(pl022->clk)) {
 		status = PTR_ERR(pl022->clk);
@@ -2293,7 +2290,6 @@ pl022_remove(struct amba_device *adev)
 
 	clk_disable(pl022->clk);
 	clk_unprepare(pl022->clk);
-	pm_runtime_disable(&adev->dev);
 	amba_release_regions(adev);
 	tasklet_disable(&pl022->pump_transfers);
 	spi_unregister_master(pl022->master);
-- 
1.7.10
