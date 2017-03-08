From: romain.perier@collabora.com (Romain Perier)
Date: Wed,  8 Mar 2017 09:15:24 +0100
Subject: [PATCH RESEND] drm: dw_hdmi: Don't rely on the status of the bridge
 for updating HPD
Message-ID: <20170308081524.7672-1-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the irq handler that monitores changes for HPD anx RX_SENSE
relies on the status of the bridge for updating the status of the HPD.
The update is done only when the bridge is enabled.

However, on Rockchip platforms we have found use cases where it could be
a problem. When HDMI is being used, turning off/on the screen or
unplugging/re-plugging the cable, the following simplified code path
will happen:

- dw_hdmi_irq() will be triggered by an HPD event, as the bridge is on
hdmi->disabled is false, then the handler will update the rxsense flag
accordingly.
- dw_hdmi_update_power() will be invoked with the mode
DRM_FORCE_UNSPECIFIED and rxsense == 1, so dw_hdmi_poweroff() will be
called and the PHY will be desactivated (its pixel clocks and TMDS)

[...]

- dw_hdmi_bridge_disable() will be invoked, the bridge will be marked as
disabled.

- dw_hdmi_irq() will be triggered by an HPD event, as the bridge is
currently disabled the HPD status won't be updated, so hdmi->rxsense
won't be changed. Even if the data part of the PHY is disabled, this
information coming from the HDMI Transmitter is correct and should be
saved.

[...]

- dw_hdmi_bridge_enable() will be invoked, the bridge will be marked as
enabled.
- dw_hdmi_update_power() will be called. As hdmi->force will be equal to
DRM_FORCE_UNSPECIFIED the function will rely on hdmi->rxsense. This
field has not been updated by the irq handler, so it will be false and
DRM_FORCE_ON won't be put to hdmi->force.

Consequently, most of the time dw_hdmi_poweron() won't be called in this
use case, TMDS won't be re-enabled the PHY won't be re-initialized,
resulting in a "Signal not found".

This commit fixes the issue by removing the check for "!hdmi->disabled".
As already explained, even if the PHY is partially disabled, information
coming from HDMI Transmitter about HPD should be saved for a later use.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Note: Due to an email configuration issue, some of my patches were not
received on infradead.org or vger.kernel.org. It is now fixed, so I
resend this patch for this reason.

 drivers/gpu/drm/bridge/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/dw-hdmi.c b/drivers/gpu/drm/bridge/dw-hdmi.c
index 235ce7d..b621fc7 100644
--- a/drivers/gpu/drm/bridge/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/dw-hdmi.c
@@ -1790,7 +1790,7 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 	if (intr_stat &
 	    (HDMI_IH_PHY_STAT0_RX_SENSE | HDMI_IH_PHY_STAT0_HPD)) {
 		mutex_lock(&hdmi->mutex);
-		if (!hdmi->disabled && !hdmi->force) {
+		if (!hdmi->force) {
 			/*
 			 * If the RX sense status indicates we're disconnected,
 			 * clear the software rxsense status.
-- 
2.9.3
