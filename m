From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 12:55:32 +0100
Subject: [PATCH 1/6] usb: chipidea: usbmisc: unset global varibale usbmisc on
 driver remove
In-Reply-To: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352894137-2050-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

While there fix a potential race condition, first set usbmisc, then call
usbmisc_set_ops().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/chipidea/usbmisc_imx6q.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx6q.c b/drivers/usb/chipidea/usbmisc_imx6q.c
index 416e3fc..edc0edd 100644
--- a/drivers/usb/chipidea/usbmisc_imx6q.c
+++ b/drivers/usb/chipidea/usbmisc_imx6q.c
@@ -116,14 +116,14 @@ static int __devinit usbmisc_imx6q_probe(struct platform_device *pdev)
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
 
@@ -131,6 +131,7 @@ static int __devexit usbmisc_imx6q_remove(struct platform_device *pdev)
 {
 	usbmisc_unset_ops(&imx6q_usbmisc_ops);
 	clk_disable_unprepare(usbmisc->clk);
+	usbmisc = NULL;
 	return 0;
 }
 
-- 
1.7.10.4
