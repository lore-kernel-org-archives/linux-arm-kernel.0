From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu,  3 Aug 2017 16:09:09 +0800
Subject: [PATCH v3 1/5] phy: rockchip-inno-usb2: add companion grf quirk
In-Reply-To: <1501747753-6983-1-git-send-email-frank.wang@rock-chips.com>
References: <1501747753-6983-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1501747753-6983-2-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The registers of usb-phy are distributed in grf and usbgrf on some
Rockchip SoCs (e.g RV1108), this patch add a quirk to support this
companion grf design.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 112 +++++++++++++++++---------
 1 file changed, 74 insertions(+), 38 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 626883d..23a0652 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -202,6 +202,7 @@ struct rockchip_usb2phy_port {
 /**
  * struct rockchip_usb2phy: usb2.0 phy driver data.
  * @grf: General Register Files regmap.
+ * @usbgrf: USB General Register Files regmap.
  * @clk: clock struct of phy input clk.
  * @clk480m: clock struct of phy output clk.
  * @clk_hw: clock struct of phy output clk management.
@@ -216,6 +217,7 @@ struct rockchip_usb2phy_port {
 struct rockchip_usb2phy {
 	struct device	*dev;
 	struct regmap	*grf;
+	struct regmap	*usbgrf;
 	struct clk	*clk;
 	struct clk	*clk480m;
 	struct clk_hw	clk480m_hw;
@@ -225,9 +227,15 @@ struct rockchip_usb2phy {
 	struct extcon_dev	*edev;
 	const struct rockchip_usb2phy_cfg	*phy_cfg;
 	struct rockchip_usb2phy_port	ports[USB2PHY_NUM_PORTS];
+	unsigned int	companion_grf_quirk:1;
 };
 
-static inline int property_enable(struct rockchip_usb2phy *rphy,
+static inline struct regmap *get_reg_base(struct rockchip_usb2phy *rphy)
+{
+	return rphy->companion_grf_quirk ? rphy->usbgrf : rphy->grf;
+}
+
+static inline int property_enable(struct regmap *base,
 				  const struct usb2phy_reg *reg, bool en)
 {
 	unsigned int val, mask, tmp;
@@ -236,17 +244,17 @@ static inline int property_enable(struct rockchip_usb2phy *rphy,
 	mask = GENMASK(reg->bitend, reg->bitstart);
 	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
 
-	return regmap_write(rphy->grf, reg->offset, val);
+	return regmap_write(base, reg->offset, val);
 }
 
-static inline bool property_enabled(struct rockchip_usb2phy *rphy,
+static inline bool property_enabled(struct regmap *base,
 				    const struct usb2phy_reg *reg)
 {
 	int ret;
 	unsigned int tmp, orig;
 	unsigned int mask = GENMASK(reg->bitend, reg->bitstart);
 
-	ret = regmap_read(rphy->grf, reg->offset, &orig);
+	ret = regmap_read(base, reg->offset, &orig);
 	if (ret)
 		return false;
 
@@ -258,11 +266,12 @@ static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
 {
 	struct rockchip_usb2phy *rphy =
 		container_of(hw, struct rockchip_usb2phy, clk480m_hw);
+	struct regmap *base = get_reg_base(rphy);
 	int ret;
 
 	/* turn on 480m clk output if it is off */
-	if (!property_enabled(rphy, &rphy->phy_cfg->clkout_ctl)) {
-		ret = property_enable(rphy, &rphy->phy_cfg->clkout_ctl, true);
+	if (!property_enabled(base, &rphy->phy_cfg->clkout_ctl)) {
+		ret = property_enable(base, &rphy->phy_cfg->clkout_ctl, true);
 		if (ret)
 			return ret;
 
@@ -277,17 +286,19 @@ static void rockchip_usb2phy_clk480m_unprepare(struct clk_hw *hw)
 {
 	struct rockchip_usb2phy *rphy =
 		container_of(hw, struct rockchip_usb2phy, clk480m_hw);
+	struct regmap *base = get_reg_base(rphy);
 
 	/* turn off 480m clk output */
-	property_enable(rphy, &rphy->phy_cfg->clkout_ctl, false);
+	property_enable(base, &rphy->phy_cfg->clkout_ctl, false);
 }
 
 static int rockchip_usb2phy_clk480m_prepared(struct clk_hw *hw)
 {
 	struct rockchip_usb2phy *rphy =
 		container_of(hw, struct rockchip_usb2phy, clk480m_hw);
+	struct regmap *base = get_reg_base(rphy);
 
-	return property_enabled(rphy, &rphy->phy_cfg->clkout_ctl);
+	return property_enabled(base, &rphy->phy_cfg->clkout_ctl);
 }
 
 static unsigned long
@@ -409,13 +420,13 @@ static int rockchip_usb2phy_init(struct phy *phy)
 		if (rport->mode != USB_DR_MODE_HOST &&
 		    rport->mode != USB_DR_MODE_UNKNOWN) {
 			/* clear bvalid status and enable bvalid detect irq */
-			ret = property_enable(rphy,
+			ret = property_enable(rphy->grf,
 					      &rport->port_cfg->bvalid_det_clr,
 					      true);
 			if (ret)
 				goto out;
 
-			ret = property_enable(rphy,
+			ret = property_enable(rphy->grf,
 					      &rport->port_cfg->bvalid_det_en,
 					      true);
 			if (ret)
@@ -429,11 +440,13 @@ static int rockchip_usb2phy_init(struct phy *phy)
 		}
 	} else if (rport->port_id == USB2PHY_PORT_HOST) {
 		/* clear linestate and enable linestate detect irq */
-		ret = property_enable(rphy, &rport->port_cfg->ls_det_clr, true);
+		ret = property_enable(rphy->grf,
+				      &rport->port_cfg->ls_det_clr, true);
 		if (ret)
 			goto out;
 
-		ret = property_enable(rphy, &rport->port_cfg->ls_det_en, true);
+		ret = property_enable(rphy->grf,
+				      &rport->port_cfg->ls_det_en, true);
 		if (ret)
 			goto out;
 
@@ -449,6 +462,7 @@ static int rockchip_usb2phy_power_on(struct phy *phy)
 {
 	struct rockchip_usb2phy_port *rport = phy_get_drvdata(phy);
 	struct rockchip_usb2phy *rphy = dev_get_drvdata(phy->dev.parent);
+	struct regmap *base = get_reg_base(rphy);
 	int ret;
 
 	dev_dbg(&rport->phy->dev, "port power on\n");
@@ -460,7 +474,7 @@ static int rockchip_usb2phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
-	ret = property_enable(rphy, &rport->port_cfg->phy_sus, false);
+	ret = property_enable(base, &rport->port_cfg->phy_sus, false);
 	if (ret)
 		return ret;
 
@@ -475,6 +489,7 @@ static int rockchip_usb2phy_power_off(struct phy *phy)
 {
 	struct rockchip_usb2phy_port *rport = phy_get_drvdata(phy);
 	struct rockchip_usb2phy *rphy = dev_get_drvdata(phy->dev.parent);
+	struct regmap *base = get_reg_base(rphy);
 	int ret;
 
 	dev_dbg(&rport->phy->dev, "port power off\n");
@@ -482,7 +497,7 @@ static int rockchip_usb2phy_power_off(struct phy *phy)
 	if (rport->suspended)
 		return 0;
 
-	ret = property_enable(rphy, &rport->port_cfg->phy_sus, true);
+	ret = property_enable(base, &rport->port_cfg->phy_sus, true);
 	if (ret)
 		return ret;
 
@@ -526,11 +541,11 @@ static void rockchip_usb2phy_otg_sm_work(struct work_struct *work)
 	bool vbus_attach, sch_work, notify_charger;
 
 	if (rport->utmi_avalid)
-		vbus_attach =
-			property_enabled(rphy, &rport->port_cfg->utmi_avalid);
+		vbus_attach = property_enabled(rphy->grf,
+					       &rport->port_cfg->utmi_avalid);
 	else
-		vbus_attach =
-			property_enabled(rphy, &rport->port_cfg->utmi_bvalid);
+		vbus_attach = property_enabled(rphy->grf,
+					       &rport->port_cfg->utmi_bvalid);
 
 	sch_work = false;
 	notify_charger = false;
@@ -650,22 +665,28 @@ static const char *chg_to_string(enum power_supply_type chg_type)
 static void rockchip_chg_enable_dcd(struct rockchip_usb2phy *rphy,
 				    bool en)
 {
-	property_enable(rphy, &rphy->phy_cfg->chg_det.rdm_pdwn_en, en);
-	property_enable(rphy, &rphy->phy_cfg->chg_det.idp_src_en, en);
+	struct regmap *base = get_reg_base(rphy);
+
+	property_enable(base, &rphy->phy_cfg->chg_det.rdm_pdwn_en, en);
+	property_enable(base, &rphy->phy_cfg->chg_det.idp_src_en, en);
 }
 
 static void rockchip_chg_enable_primary_det(struct rockchip_usb2phy *rphy,
 					    bool en)
 {
-	property_enable(rphy, &rphy->phy_cfg->chg_det.vdp_src_en, en);
-	property_enable(rphy, &rphy->phy_cfg->chg_det.idm_sink_en, en);
+	struct regmap *base = get_reg_base(rphy);
+
+	property_enable(base, &rphy->phy_cfg->chg_det.vdp_src_en, en);
+	property_enable(base, &rphy->phy_cfg->chg_det.idm_sink_en, en);
 }
 
 static void rockchip_chg_enable_secondary_det(struct rockchip_usb2phy *rphy,
 					      bool en)
 {
-	property_enable(rphy, &rphy->phy_cfg->chg_det.vdm_src_en, en);
-	property_enable(rphy, &rphy->phy_cfg->chg_det.idp_sink_en, en);
+	struct regmap *base = get_reg_base(rphy);
+
+	property_enable(base, &rphy->phy_cfg->chg_det.vdm_src_en, en);
+	property_enable(base, &rphy->phy_cfg->chg_det.idp_sink_en, en);
 }
 
 #define CHG_DCD_POLL_TIME	(100 * HZ / 1000)
@@ -677,6 +698,7 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 	struct rockchip_usb2phy_port *rport =
 		container_of(work, struct rockchip_usb2phy_port, chg_work.work);
 	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
+	struct regmap *base = get_reg_base(rphy);
 	bool is_dcd, tmout, vout;
 	unsigned long delay;
 
@@ -687,7 +709,7 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		if (!rport->suspended)
 			rockchip_usb2phy_power_off(rport->phy);
 		/* put the controller in non-driving mode */
-		property_enable(rphy, &rphy->phy_cfg->chg_det.opmode, false);
+		property_enable(base, &rphy->phy_cfg->chg_det.opmode, false);
 		/* Start DCD processing stage 1 */
 		rockchip_chg_enable_dcd(rphy, true);
 		rphy->chg_state = USB_CHG_STATE_WAIT_FOR_DCD;
@@ -696,7 +718,8 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		break;
 	case USB_CHG_STATE_WAIT_FOR_DCD:
 		/* get data contact detection status */
-		is_dcd = property_enabled(rphy, &rphy->phy_cfg->chg_det.dp_det);
+		is_dcd = property_enabled(rphy->grf,
+					  &rphy->phy_cfg->chg_det.dp_det);
 		tmout = ++rphy->dcd_retries == CHG_DCD_MAX_RETRIES;
 		/* stage 2 */
 		if (is_dcd || tmout) {
@@ -713,7 +736,8 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		}
 		break;
 	case USB_CHG_STATE_DCD_DONE:
-		vout = property_enabled(rphy, &rphy->phy_cfg->chg_det.cp_det);
+		vout = property_enabled(rphy->grf,
+					&rphy->phy_cfg->chg_det.cp_det);
 		rockchip_chg_enable_primary_det(rphy, false);
 		if (vout) {
 			/* Voltage Source on DM, Probe on DP  */
@@ -734,7 +758,8 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		}
 		break;
 	case USB_CHG_STATE_PRIMARY_DONE:
-		vout = property_enabled(rphy, &rphy->phy_cfg->chg_det.dcp_det);
+		vout = property_enabled(rphy->grf,
+					&rphy->phy_cfg->chg_det.dcp_det);
 		/* Turn off voltage source */
 		rockchip_chg_enable_secondary_det(rphy, false);
 		if (vout)
@@ -748,7 +773,7 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		/* fall through */
 	case USB_CHG_STATE_DETECTED:
 		/* put the controller in normal mode */
-		property_enable(rphy, &rphy->phy_cfg->chg_det.opmode, true);
+		property_enable(base, &rphy->phy_cfg->chg_det.opmode, true);
 		rockchip_usb2phy_otg_sm_work(&rport->otg_sm_work.work);
 		dev_info(&rport->phy->dev, "charger = %s\n",
 			 chg_to_string(rphy->chg_type));
@@ -790,8 +815,7 @@ static void rockchip_usb2phy_sm_work(struct work_struct *work)
 	if (ret < 0)
 		goto next_schedule;
 
-	ret = regmap_read(rphy->grf, rport->port_cfg->utmi_hstdet.offset,
-			  &uhd);
+	ret = regmap_read(rphy->grf, rport->port_cfg->utmi_hstdet.offset, &uhd);
 	if (ret < 0)
 		goto next_schedule;
 
@@ -845,8 +869,8 @@ static void rockchip_usb2phy_sm_work(struct work_struct *work)
 		 * activate the linestate detection to get the next device
 		 * plug-in irq.
 		 */
-		property_enable(rphy, &rport->port_cfg->ls_det_clr, true);
-		property_enable(rphy, &rport->port_cfg->ls_det_en, true);
+		property_enable(rphy->grf, &rport->port_cfg->ls_det_clr, true);
+		property_enable(rphy->grf, &rport->port_cfg->ls_det_en, true);
 
 		/*
 		 * we don't need to rearm the delayed work when the phy port
@@ -869,14 +893,14 @@ static irqreturn_t rockchip_usb2phy_linestate_irq(int irq, void *data)
 	struct rockchip_usb2phy_port *rport = data;
 	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
 
-	if (!property_enabled(rphy, &rport->port_cfg->ls_det_st))
+	if (!property_enabled(rphy->grf, &rport->port_cfg->ls_det_st))
 		return IRQ_NONE;
 
 	mutex_lock(&rport->mutex);
 
 	/* disable linestate detect irq and clear its status */
-	property_enable(rphy, &rport->port_cfg->ls_det_en, false);
-	property_enable(rphy, &rport->port_cfg->ls_det_clr, true);
+	property_enable(rphy->grf, &rport->port_cfg->ls_det_en, false);
+	property_enable(rphy->grf, &rport->port_cfg->ls_det_clr, true);
 
 	mutex_unlock(&rport->mutex);
 
@@ -896,13 +920,13 @@ static irqreturn_t rockchip_usb2phy_bvalid_irq(int irq, void *data)
 	struct rockchip_usb2phy_port *rport = data;
 	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
 
-	if (!property_enabled(rphy, &rport->port_cfg->bvalid_det_st))
+	if (!property_enabled(rphy->grf, &rport->port_cfg->bvalid_det_st))
 		return IRQ_NONE;
 
 	mutex_lock(&rport->mutex);
 
 	/* clear bvalid detect irq pending status */
-	property_enable(rphy, &rport->port_cfg->bvalid_det_clr, true);
+	property_enable(rphy->grf, &rport->port_cfg->bvalid_det_clr, true);
 
 	mutex_unlock(&rport->mutex);
 
@@ -1045,6 +1069,18 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	if (IS_ERR(rphy->grf))
 		return PTR_ERR(rphy->grf);
 
+	rphy->companion_grf_quirk =
+		device_property_read_bool(dev, "rockchip,companion_grf_quirk");
+	if (rphy->companion_grf_quirk) {
+		rphy->usbgrf =
+			syscon_regmap_lookup_by_phandle(dev->of_node,
+							"rockchip,usbgrf");
+		if (IS_ERR(rphy->usbgrf))
+			return PTR_ERR(rphy->usbgrf);
+	} else {
+		rphy->usbgrf = NULL;
+	}
+
 	if (of_property_read_u32(np, "reg", &reg)) {
 		dev_err(dev, "the reg property is not assigned in %s node\n",
 			np->name);
-- 
2.0.0
