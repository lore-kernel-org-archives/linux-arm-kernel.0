From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 21 Nov 2012 15:06:29 +0100
Subject: [PATCH v3 3/7] usb: chipidea: usbmisc: fix a potential race condition
In-Reply-To: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1353506793-8354-4-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

This fixes a potential race condition where the ci13xxx_imx glue code
could be fast enough to call one of the usbmisc_ops before he got a
valid value on the static usbmisc pointer. To fix that we first set
usbmisc, then call usbmisc_set_ops().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes since v1:
* split previous patch into two seperate.

 drivers/usb/chipidea/usbmisc_imx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 552c63f..9145e04 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -116,14 +116,14 @@ static int __devinit usbmisc_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	usbmisc = data;
 	ret = usbmisc_set_ops(&imx6q_usbmisc_ops);
 	if (ret) {
+		usbmisc = NULL;
 		clk_disable_unprepare(data->clk);
 		return ret;
 	}
 
-	usbmisc = data;
-
 	return 0;
 }
 
-- 
1.7.10.4
