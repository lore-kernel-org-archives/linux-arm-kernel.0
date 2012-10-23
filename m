From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 23 Oct 2012 14:08:36 +0200
Subject: [PATCH] Revert "spi/pl022: enable runtime PM"
Message-ID: <1350994116-9127-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This reverts commit 2fb30d1147c599f5657e8c62c862f9a0f58d9d99.

This patch introduced runtime PM issues and is not needed at all.
Thus we should revert it.

Conflicts:

	drivers/spi/spi-pl022.c

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---

This patch is based on linux next as of 2012-10-23.
Latest patch for spi-pl022 driver was this one:

spi/pl022: add IDLE state pin management

---
 drivers/spi/spi-pl022.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 0205d47..1361868 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2192,9 +2192,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
 	       adev->res.start, pl022->virtbase);
 
-	pm_runtime_enable(dev);
-	pm_runtime_resume(dev);
-
 	pl022->clk = devm_clk_get(&adev->dev, NULL);
 	if (IS_ERR(pl022->clk)) {
 		status = PTR_ERR(pl022->clk);
@@ -2298,7 +2295,6 @@ pl022_remove(struct amba_device *adev)
 
 	clk_disable(pl022->clk);
 	clk_unprepare(pl022->clk);
-	pm_runtime_disable(&adev->dev);
 	amba_release_regions(adev);
 	tasklet_disable(&pl022->pump_transfers);
 	spi_unregister_master(pl022->master);
-- 
1.7.10
