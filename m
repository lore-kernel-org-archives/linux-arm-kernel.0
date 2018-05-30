From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Wed, 30 May 2018 10:34:14 -0700
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
Message-ID: <20180530173414.6121-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Workaround introduced for i.MX53 in be9cae2479f48 ("usb: chipidea:
imx: Fix ULPI on imx53") seems to be applicable in case of i.MX51 as
well. Running latest kernel on ZII RDU1 Board (imx51-zii-rdu1.dts)
exhibits a kernel frozen on PORTSC access and applying the workaround
resolves the issue.

Cc: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-usb at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index e431c5aafe35..19f5f5f2a48a 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -291,7 +291,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	pdata.usb_phy = data->phy;
 
-	if (of_device_is_compatible(np, "fsl,imx53-usb") && pdata.usb_phy &&
+	if ((of_device_is_compatible(np, "fsl,imx53-usb") ||
+	     of_device_is_compatible(np, "fsl,imx51-usb")) && pdata.usb_phy &&
 	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
 		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
 		data->override_phy_control = true;
-- 
2.17.0
