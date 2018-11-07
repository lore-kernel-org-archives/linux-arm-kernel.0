From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  7 Nov 2018 18:12:59 +0800
Subject: [PATCH 06/15] Bluetooth: hci_bcm: Simplify clk_get error handling
In-Reply-To: <20181107101308.7626-1-wens@csie.org>
References: <20181107101308.7626-1-wens@csie.org>
Message-ID: <20181107101308.7626-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver currently checks the clk pointer for an error condition, as
returned by clk_get, before every invocation of the clk consumer API.
This is redundant if the goal is simply to ignore the errors, thereby
making the clk optional. The clk consumer API already checks if the
pointer is NULL or not.

Simplify the code a bit by assigning NULL to the clk pointer if the
error condition is one we want to ignore, which is every error except
deferred probing.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bluetooth/hci_bcm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0a20ad48b511..7f21d9ab5029 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -214,7 +214,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
 	int err;
 
-	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled) {
+	if (powered && !dev->clk_enabled) {
 		err = clk_prepare_enable(dev->clk);
 		if (err)
 			return err;
@@ -228,7 +228,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	if (err)
 		goto err_revert_shutdown;
 
-	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
+	if (!powered && dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
 
 	dev->clk_enabled = powered;
@@ -238,7 +238,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 err_revert_shutdown:
 	dev->set_shutdown(dev, !powered);
 err_clk_disable:
-	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
+	if (powered && !dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
 	return err;
 }
@@ -911,6 +911,10 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (IS_ERR(dev->clk) && PTR_ERR(dev->clk) == -EPROBE_DEFER)
 		return PTR_ERR(dev->clk);
 
+	/* Ignore all other errors as before */
+	if (IS_ERR(dev->clk))
+		dev->clk = NULL;
+
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
-- 
2.19.1
