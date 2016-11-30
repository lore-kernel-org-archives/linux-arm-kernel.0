From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 30 Nov 2016 14:57:35 +0900
Subject: [PATCH 07/12] usb: sunxi: Uses the resource-managed extcon API when
 registering extcon notifier
In-Reply-To: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1480485460-2663-8-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch just uses the resource-managed extcon API when registering
the extcon notifier.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/usb/musb/sunxi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 1408245be18e..4b531551e49d 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -261,14 +261,14 @@ static int sunxi_musb_init(struct musb *musb)
 	writeb(SUNXI_MUSB_VEND0_PIO_MODE, musb->mregs + SUNXI_MUSB_VEND0);
 
 	/* Register notifier before calling phy_init() */
-	ret = extcon_register_notifier(glue->extcon, EXTCON_USB_HOST,
-				       &glue->host_nb);
+	ret = devm_extcon_register_notifier(glue->dev, glue->extcon,
+					EXTCON_USB_HOST, &glue->host_nb);
 	if (ret)
 		goto error_reset_assert;
 
 	ret = phy_init(glue->phy);
 	if (ret)
-		goto error_unregister_notifier;
+		goto error_reset_assert;
 
 	musb->isr = sunxi_musb_interrupt;
 
@@ -277,9 +277,6 @@ static int sunxi_musb_init(struct musb *musb)
 
 	return 0;
 
-error_unregister_notifier:
-	extcon_unregister_notifier(glue->extcon, EXTCON_USB_HOST,
-				   &glue->host_nb);
 error_reset_assert:
 	if (test_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags))
 		reset_control_assert(glue->rst);
@@ -303,9 +300,6 @@ static int sunxi_musb_exit(struct musb *musb)
 
 	phy_exit(glue->phy);
 
-	extcon_unregister_notifier(glue->extcon, EXTCON_USB_HOST,
-				   &glue->host_nb);
-
 	if (test_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags))
 		reset_control_assert(glue->rst);
 
-- 
1.9.1
