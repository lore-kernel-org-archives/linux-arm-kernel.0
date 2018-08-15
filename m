From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Wed, 15 Aug 2018 11:59:33 +0200
Subject: [PATCH 3/4] phy: rockchip-inno-usb2: allow to force the B-Device
 Session Valid bit.
In-Reply-To: <20180815095934.11205-1-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
Message-ID: <20180815095934.11205-4-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OTG disconnection event is generated after the presence/abscense of
an ID connection, but some platforms doesn't have the ID pin connected, so
the event is not generated. In such case, for detecting the disconnection
event, we can get the cable state from an extcon driver. We need, though,
to force to set the B-Device Session Valid bit on the PHY to have the
device respond to setup address. Otherwise, the following error is
shown:

    usb 2-2: Device not responding to setup address.
    usb 2-2: device not accepting address 14, error -71
    usb usb2-port2: unable to enumerate USB device

The patch allows to tell the PHY to force the B-Device Session Valid bit
when the OTG role is device and clear that bit if the OTG role is host.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index e1ef3e34163c..e7337c60ff9d 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -125,6 +125,7 @@ struct rockchip_chg_det_reg {
  * @bvalid_det_en: vbus valid rise detection enable register.
  * @bvalid_det_st: vbus valid rise detection status register.
  * @bvalid_det_clr: vbus valid rise detection clear register.
+ * @bvalid_session: force B-device session valid register.
  * @ls_det_en: linestate detection enable register.
  * @ls_det_st: linestate detection state register.
  * @ls_det_clr: linestate detection clear register.
@@ -138,6 +139,7 @@ struct rockchip_usb2phy_port_cfg {
 	struct usb2phy_reg	bvalid_det_en;
 	struct usb2phy_reg	bvalid_det_st;
 	struct usb2phy_reg	bvalid_det_clr;
+	struct usb2phy_reg	bvalid_session;
 	struct usb2phy_reg	ls_det_en;
 	struct usb2phy_reg	ls_det_st;
 	struct usb2phy_reg	ls_det_clr;
@@ -172,6 +174,7 @@ struct rockchip_usb2phy_cfg {
  *	true	- use avalid to get vbus status
  *	false	- use bvalid to get vbus status
  * @vbus_attached: otg device vbus status.
+ * @force_bvalid: force the control of the B-device session valid bit.
  * @bvalid_irq: IRQ number assigned for vbus valid rise detection.
  * @ls_irq: IRQ number assigned for linestate detection.
  * @otg_mux_irq: IRQ number which multiplex otg-id/otg-bvalid/linestate
@@ -191,6 +194,7 @@ struct rockchip_usb2phy_port {
 	bool		suspended;
 	bool		utmi_avalid;
 	bool		vbus_attached;
+	bool		force_bvalid;
 	int		bvalid_irq;
 	int		ls_irq;
 	int		otg_mux_irq;
@@ -561,6 +565,13 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 	switch (rport->state) {
 	case OTG_STATE_UNDEFINED:
 		rport->state = OTG_STATE_B_IDLE;
+		if (rport->force_bvalid) {
+			property_enable(rphy->grf,
+					&rport->port_cfg->bvalid_session,
+					true);
+			dev_dbg(&rport->phy->dev,
+				"set the B-Device Session Valid\n");
+		}
 		if (!vbus_attach)
 			rockchip_usb2phy_power_off(rport->phy);
 		/* fall through */
@@ -568,6 +579,14 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) > 0) {
 			dev_dbg(&rport->phy->dev, "usb otg host connect\n");
 			rport->state = OTG_STATE_A_HOST;
+			/* When leaving device mode force end the session */
+			if (rport->force_bvalid) {
+				property_enable(rphy->grf,
+					&rport->port_cfg->bvalid_session,
+					false);
+				dev_dbg(&rport->phy->dev,
+					"clear the B-Device Session Valid\n");
+			}
 			rockchip_usb2phy_power_on(rport->phy);
 			return;
 		} else if (vbus_attach) {
@@ -642,6 +661,14 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 		if (extcon_get_state(rphy->edev, EXTCON_USB_HOST) == 0) {
 			dev_dbg(&rport->phy->dev, "usb otg host disconnect\n");
 			rport->state = OTG_STATE_B_IDLE;
+			/* When leaving host mode force start the session */
+			if (rport->force_bvalid) {
+				property_enable(rphy->grf,
+					&rport->port_cfg->bvalid_session,
+					true);
+				dev_dbg(&rport->phy->dev,
+					"set the B-Device Session Valid\n");
+			}
 			rockchip_usb2phy_power_off(rport->phy);
 		}
 		break;
@@ -1024,6 +1051,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
 	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
 
+	rport->force_bvalid = false;
+	if (of_device_is_compatible(rphy->dev->of_node,
+				    "rockchip,rk3399-usb2phy"))
+		rport->force_bvalid = of_property_read_bool(child_np,
+						"rockchip,force-bvalid");
+
 	rport->utmi_avalid =
 		of_property_read_bool(child_np, "rockchip,utmi-avalid");
 
@@ -1349,6 +1382,7 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 				.bvalid_det_en	= { 0xe3c0, 3, 3, 0, 1 },
 				.bvalid_det_st	= { 0xe3e0, 3, 3, 0, 1 },
 				.bvalid_det_clr	= { 0xe3d0, 3, 3, 0, 1 },
+				.bvalid_session = { 0x4498, 4, 4, 0, 1 },
 				.utmi_avalid	= { 0xe2ac, 7, 7, 0, 1 },
 				.utmi_bvalid	= { 0xe2ac, 12, 12, 0, 1 },
 			},
@@ -1384,6 +1418,7 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 				.bvalid_det_en  = { 0xe3c0, 8, 8, 0, 1 },
 				.bvalid_det_st  = { 0xe3e0, 8, 8, 0, 1 },
 				.bvalid_det_clr = { 0xe3d0, 8, 8, 0, 1 },
+				.bvalid_session = { 0x4518, 4, 4, 0, 1 },
 				.utmi_avalid	= { 0xe2ac, 10, 10, 0, 1 },
 				.utmi_bvalid    = { 0xe2ac, 16, 16, 0, 1 },
 			},
-- 
2.18.0
