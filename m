From: marex@denx.de (Marek Vasut)
Date: Tue, 24 Apr 2012 05:18:37 +0200
Subject: [PATCH 05/11] MXS: Modify the ci13xxx_udc to avoid adding UDC
In-Reply-To: <1335237523-9053-1-git-send-email-marex@denx.de>
References: <1335099567-21056-1-git-send-email-marex@denx.de>
 <1335237523-9053-1-git-send-email-marex@denx.de>
Message-ID: <1335237523-9053-6-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the i.MX platform, we are adding the UDC ourselves from the PHY driver. This
patch adds a flag into the ci13xxx_udc that avoids adding the UDC if set.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Lin Tony-B19295 <B19295@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Tony Lin <tony.lin@freescale.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/usb/gadget/ci13xxx_udc.c |   12 ++++++++----
 drivers/usb/gadget/ci13xxx_udc.h |    1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/ci13xxx_udc.c b/drivers/usb/gadget/ci13xxx_udc.c
index 243ef1a..94f8b19 100644
--- a/drivers/usb/gadget/ci13xxx_udc.c
+++ b/drivers/usb/gadget/ci13xxx_udc.c
@@ -2935,9 +2935,11 @@ static int udc_probe(struct ci13xxx_udc_driver *driver, struct device *dev,
 			goto remove_dbg;
 	}
 
-	retval = usb_add_gadget_udc(dev, &udc->gadget);
-	if (retval)
-		goto remove_trans;
+	if (!(udc->udc_driver->flags & CI13XXX_DONT_REGISTER_GADGET)) {
+		retval = usb_add_gadget_udc(dev, &udc->gadget);
+		if (retval)
+			goto remove_trans;
+	}
 
 	pm_runtime_no_callbacks(&udc->gadget.dev);
 	pm_runtime_enable(&udc->gadget.dev);
@@ -2980,7 +2982,9 @@ static void udc_remove(void)
 		err("EINVAL");
 		return;
 	}
-	usb_del_gadget_udc(&udc->gadget);
+
+	if (!(udc->udc_driver->flags & CI13XXX_DONT_REGISTER_GADGET))
+		usb_del_gadget_udc(&udc->gadget);
 
 	if (udc->transceiver) {
 		otg_set_peripheral(udc->transceiver->otg, &udc->gadget);
diff --git a/drivers/usb/gadget/ci13xxx_udc.h b/drivers/usb/gadget/ci13xxx_udc.h
index 0d31af5..9f2efa2 100644
--- a/drivers/usb/gadget/ci13xxx_udc.h
+++ b/drivers/usb/gadget/ci13xxx_udc.h
@@ -108,6 +108,7 @@ struct ci13xxx_udc_driver {
 #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
 #define CI13XXX_PULLUP_ON_VBUS		BIT(2)
 #define CI13XXX_DISABLE_STREAMING	BIT(3)
+#define CI13XXX_DONT_REGISTER_GADGET	BIT(4)
 
 #define CI13XXX_CONTROLLER_RESET_EVENT		0
 #define CI13XXX_CONTROLLER_STOPPED_EVENT	1
-- 
1.7.10
