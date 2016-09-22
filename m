From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 22 Sep 2016 14:19:01 +0300
Subject: [PATCH v2 3/3] musb: sunxi: Force session end on babble errors in
 host-mode
In-Reply-To: <20160922111901.15337-1-hdegoede@redhat.com>
References: <20160922111901.15337-1-hdegoede@redhat.com>
Message-ID: <20160922111901.15337-3-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sunxi musb has a bug where sometimes it will generate a babble
error on device disconnect instead of a disconnect irq. When this
happens the musb-controller switches from host mode to device mode
(it clears MUSB_DEVCTL_SESSION and sets MUSB_DEVCTL_BDEVICE) and
gets stuck in this state.

Clearing this requires reporting Vbus low for 200 or more ms, but
on some devices Vbus is simply always high (host-only mode, no Vbus
control).

This commit adds a sunxi_musb_recover() callback which makes
sunxi_musb_work call phy_set_mode with the current mode, which
will force end the current session.

This fixes the musb controller getting stuck in this state on systems
without Vbus control; and also fixes the need to unplug the usb-b ->
usb-a cable to get out of this state on systems with Vbus control.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Use musb_platform_recover callback instead of using DYI code in the
 interrupt handler
-Call phy_set_mode with the current mode instead of adding a new custom
 sunxi phy callback
---
 drivers/usb/musb/sunxi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 82eba92..d0be0ea 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -380,6 +380,20 @@ static int sunxi_musb_set_mode(struct musb *musb, u8 mode)
 	return 0;
 }
 
+static int sunxi_musb_recover(struct musb *musb)
+{
+	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
+
+	/*
+	 * Schedule a phy_set_mode with the current glue->phy_mode value,
+	 * this will force end the current session.
+	 */
+	set_bit(SUNXI_MUSB_FL_PHY_MODE_PEND, &glue->flags);
+	schedule_work(&glue->work);
+
+	return 0;
+}
+
 /*
  * sunxi musb register layout
  * 0x00 - 0x17	fifo regs, 1 long per fifo
@@ -608,6 +622,7 @@ static const struct musb_platform_ops sunxi_musb_ops = {
 	.dma_init	= sunxi_musb_dma_controller_create,
 	.dma_exit	= sunxi_musb_dma_controller_destroy,
 	.set_mode	= sunxi_musb_set_mode,
+	.recover	= sunxi_musb_recover,
 	.set_vbus	= sunxi_musb_set_vbus,
 	.pre_root_reset_end = sunxi_musb_pre_root_reset_end,
 	.post_root_reset_end = sunxi_musb_post_root_reset_end,
-- 
2.9.3
