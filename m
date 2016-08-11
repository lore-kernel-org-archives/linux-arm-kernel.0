From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 11 Aug 2016 15:54:03 +0800
Subject: [PATCH] drm/bridge: dw-hdmi: fix hdmi display lost
Message-ID: <1470902043-23384-1-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hdmi->disabled maybe not match to the real hardware status.

->dw_hdmi_bridge_enable()
  hdmi->disabled = false;
-->dw_hdmi_update_power()
   if (hdmi->rxsense)
       force = DRM_FORCE_ON;
   else
       force = DRM_FORCE_OFF;

hdmi->rxsense maybe false on bridge enable path, then hdmi->disabled
is false, but actually hardware is power off, they are not match.

So on dw_hdmi_irq, judge the hardware status with hdmi->disabled is wrong.
This bug would cause display lost, unplug/plug can't recovery display.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Liu Ying <gnuiyl@gmail.com>

Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/bridge/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
index 77ab473..a4fcb47 100644
--- a/drivers/gpu/drm/bridge/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -1563,7 +1563,7 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 	if (intr_stat &
 	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
 		mutex_lock(&hdmi->mutex);
-		if (!hdmi->disabled && !hdmi->force) {
+		if (!hdmi->bridge_is_on && !hdmi->force) {
 			/*
 			 * If the RX sense status indicates we're disconnected,
 			 * clear the software rxsense status.
-- 
1.9.1
