From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue,  2 Aug 2011 11:29:24 +0200
Subject: [PATCH] spi/pl022: remove function cannot exit
Message-ID: <1312277364-12945-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The remove function in the PL022 driver cannot abort the remove
function any way, so restructure the code so as not to make that
assumption. Remove will now proceed no matter whether it can
stop the transfer queue or not.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index eba88c7..730b4a3 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2267,17 +2267,13 @@ static int __devexit
 pl022_remove(struct amba_device *adev)
 {
 	struct pl022 *pl022 = amba_get_drvdata(adev);
-	int status = 0;
+
 	if (!pl022)
 		return 0;
 
 	/* Remove the queue */
-	status = destroy_queue(pl022);
-	if (status != 0) {
-		dev_err(&adev->dev,
-			"queue remove failed (%d)\n", status);
-		return status;
-	}
+	if (destroy_queue(pl022) != 0)
+		dev_err(&adev->dev, "queue remove failed\n");
 	load_ssp_default_config(pl022);
 	pl022_dma_remove(pl022);
 	free_irq(adev->irq[0], pl022);
@@ -2289,7 +2285,6 @@ pl022_remove(struct amba_device *adev)
 	spi_unregister_master(pl022->master);
 	spi_master_put(pl022->master);
 	amba_set_drvdata(adev, NULL);
-	dev_dbg(&adev->dev, "remove succeeded\n");
 	return 0;
 }
 
-- 
1.7.6
