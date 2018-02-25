From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 25 Feb 2018 15:10:52 +0100
Subject: [PATCH 1/4] Bluetooth: hci_bcm: Make shutdown and device wake GPIO
 optional
In-Reply-To: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1519567855-26105-2-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the devicetree binding the shutdown and device wake
GPIOs are optional. Since commit 3e81a4ca51a1 ("Bluetooth: hci_bcm:
Mandate presence of shutdown and device wake GPIO") this driver
won't probe anymore on Raspberry Pi 3 and Zero W (no device wake GPIO
connected). So fix this regression by reverting this commit partially.

Cc: Lukas Wunner <lukas@wunner.de>
Fixes: 3e81a4ca51a1 ("Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/bluetooth/hci_bcm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0438a64..f8728eb 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -922,12 +922,14 @@ static int bcm_get_resources(struct bcm_device *dev)
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
 
-	dev->device_wakeup = devm_gpiod_get(dev->dev, "device-wakeup",
-					    GPIOD_OUT_LOW);
+	dev->device_wakeup = devm_gpiod_get_optional(dev->dev,
+						     "device-wakeup",
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
 		return PTR_ERR(dev->device_wakeup);
 
-	dev->shutdown = devm_gpiod_get(dev->dev, "shutdown", GPIOD_OUT_LOW);
+	dev->shutdown = devm_gpiod_get_optional(dev->dev, "shutdown",
+						GPIOD_OUT_LOW);
 	if (IS_ERR(dev->shutdown))
 		return PTR_ERR(dev->shutdown);
 
-- 
2.7.4
