From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Wed,  2 Dec 2009 17:13:01 +0100
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
Message-ID: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On various mxc boards, the intial ULPI reads resulted in a timeout
which prevented the transceiver to be identified and thus the ehci
device to be probed.

Initializing the hardware lines connected to the transceiver (through
pdata->init call) before actually enabling clocks and configuring
registers in the devices fixes this problem.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 drivers/usb/host/ehci-mxc.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 35c56f4..689b683 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -162,6 +162,15 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 		goto err_ioremap;
 	}
 
+	/* call platform specific init function */
+	if (pdata->init) {
+		ret = pdata->init(pdev);
+		if (ret) {
+			dev_err(dev, "platform init failed\n");
+			goto err_init;
+		}
+	}
+
 	/* enable clocks */
 	priv->usbclk = clk_get(dev, "usb");
 	if (IS_ERR(priv->usbclk)) {
@@ -192,15 +201,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_init;
 
-	/* call platform specific init function */
-	if (pdata->init) {
-		ret = pdata->init(pdev);
-		if (ret) {
-			dev_err(dev, "platform init failed\n");
-			goto err_init;
-		}
-	}
-
 	/* most platforms need some time to settle changed IO settings */
 	mdelay(10);
 
-- 
1.6.3.3
