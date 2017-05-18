From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 18 May 2017 11:43:01 +0800
Subject: [PATCH 3/4] phy: rockchip-inno-usb2: add one phy comprises with two
 host-ports support
In-Reply-To: <1495078982-2555-1-git-send-email-frank.wang@rock-chips.com>
References: <1495078982-2555-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1495078982-2555-4-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: William Wu <william.wu@rock-chips.com>

At the current rockchip-inno-usb2 phy driver framework, it can
only support usb2-phy which comprises with one otg-port and one
host-port.

However, some Rockchip SoCs' (e.g RK3228, RK3229) usb2-phy comprises
with two host-ports, so we use index of otg id for one host-port
configuration, and make it work the same as otg-port host mode.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 drivers/phy/phy-rockchip-inno-usb2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
index d6e459d..d026b4cf 100644
--- a/drivers/phy/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/phy-rockchip-inno-usb2.c
@@ -406,7 +406,8 @@ static int rockchip_usb2phy_init(struct phy *phy)
 	mutex_lock(&rport->mutex);
 
 	if (rport->port_id == USB2PHY_PORT_OTG) {
-		if (rport->mode != USB_DR_MODE_HOST) {
+		if (rport->mode != USB_DR_MODE_HOST &&
+		    rport->mode != USB_DR_MODE_UNKNOWN) {
 			/* clear bvalid status and enable bvalid detect irq */
 			ret = property_enable(rphy,
 					      &rport->port_cfg->bvalid_det_clr,
@@ -496,7 +497,8 @@ static int rockchip_usb2phy_exit(struct phy *phy)
 	struct rockchip_usb2phy_port *rport = phy_get_drvdata(phy);
 
 	if (rport->port_id == USB2PHY_PORT_OTG &&
-	    rport->mode != USB_DR_MODE_HOST) {
+	    rport->mode != USB_DR_MODE_HOST &&
+	    rport->mode != USB_DR_MODE_UNKNOWN) {
 		cancel_delayed_work_sync(&rport->otg_sm_work);
 		cancel_delayed_work_sync(&rport->chg_work);
 	} else if (rport->port_id == USB2PHY_PORT_HOST)
@@ -973,7 +975,8 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	mutex_init(&rport->mutex);
 
 	rport->mode = of_usb_get_dr_mode_by_phy(child_np, -1);
-	if (rport->mode == USB_DR_MODE_HOST) {
+	if (rport->mode == USB_DR_MODE_HOST ||
+	    rport->mode == USB_DR_MODE_UNKNOWN) {
 		ret = 0;
 		goto out;
 	}
-- 
2.0.0
