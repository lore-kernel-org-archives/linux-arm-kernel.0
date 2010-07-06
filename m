From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue,  6 Jul 2010 03:37:43 +0300
Subject: [PATCH 12/15] wireless: wl1271: take irq info from platform data
In-Reply-To: <1278376666-3509-1-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
Message-ID: <1278376666-3509-13-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ohad Ben-Cohen <ohadb@ti.com>

Remove the hard coded irq information, and instead take
the irq information from the platform-specific data
which is supplied by the board device.

Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
---
 drivers/net/wireless/wl12xx/wl1271_sdio.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/wl12xx/wl1271_sdio.c b/drivers/net/wireless/wl12xx/wl1271_sdio.c
index 96b8fc3..0af0dce 100644
--- a/drivers/net/wireless/wl12xx/wl1271_sdio.c
+++ b/drivers/net/wireless/wl12xx/wl1271_sdio.c
@@ -38,8 +38,6 @@
 #include "wl12xx_80211.h"
 #include "wl1271_io.h"
 
-
-#define RX71_WL1271_IRQ_GPIO		42
 static DECLARE_COMPLETION(wl1271_sdio_ready);
 
 static const struct sdio_device_id wl1271_devices[] = {
@@ -286,8 +284,6 @@ static int wl1271_plat_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
-	wl->irq = gpio_to_irq(RX71_WL1271_IRQ_GPIO);
-
 	wl->set_power = pdata->set_power;
 	if (!wl->set_power) {
 		wl1271_error("set power function missing in platform data");
@@ -295,9 +291,10 @@ static int wl1271_plat_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
+	wl->irq = pdata->irq;
 	if (wl->irq < 0) {
-		ret = wl->irq;
-		wl1271_error("could not get irq!");
+		wl1271_error("irq missing in platform data");
+		ret = -ENODEV;
 		goto out_free;
 	}
 
-- 
1.7.0.4
