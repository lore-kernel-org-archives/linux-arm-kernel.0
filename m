From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 27 Nov 2017 20:05:34 +0100
Subject: [PATCH v2] sunxi-rsb: Include OF based modalias in device uevent
Message-ID: <53cb17f5-6077-419a-8e5c-6c80f9dfa9dc@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the OF-based modalias in the uevent sent when registering devices
on the sunxi RSB bus, so that user space has a chance to autoload the
kernel module for the device.

Fixes a regression caused by commit 3f241bfa60bd ("arm64: allwinner: a64:
pine64: Use dcdc1 regulator for mmc0"). When the axp20x-rsb module for
the AXP803 PMIC is built as a module, it is not loaded and the system
ends up with an disfunctional MMC controller.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/bus/sunxi-rsb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 328ca93781cf..1b76d9585902 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -178,6 +178,7 @@ static struct bus_type sunxi_rsb_bus = {
 	.match		= sunxi_rsb_device_match,
 	.probe		= sunxi_rsb_device_probe,
 	.remove		= sunxi_rsb_device_remove,
+	.uevent		= of_device_uevent_modalias,
 };
 
 static void sunxi_rsb_dev_release(struct device *dev)
-- 
2.15.0
