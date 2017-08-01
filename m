From: frank.wang@rock-chips.com (Frank Wang)
Date: Tue,  1 Aug 2017 16:12:12 +0800
Subject: [PATCH 2/3] phy: rockchip-inno-usb2: add otg mux irq quirk
In-Reply-To: <1501575133-20953-1-git-send-email-frank.wang@rock-chips.com>
References: <1501575133-20953-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1501575133-20953-3-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The otg-id/otg-bvalid/linestate irqs are multiplexed to one irq in
otg-port on some Rockchip SoC (e.g RV1108), this patch add a quirk
to support this mux irq feature.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 .../bindings/phy/phy-rockchip-inno-usb2.txt        |  5 ++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      | 68 +++++++++++++++++-----
 2 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
index ddf868a..d49572b 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
@@ -22,6 +22,8 @@ Optional properties:
 		 register files".
  - rockchip,companion_grf_quirk : when set driver will request
 		 "rockchip,usbgrf" phandle as one companion-grf.
+ - rockchip,otg_mux_irq_quirk: set if otg-id/otg-bvalid/linestate irqs
+		 are multiplexed to one irq in otg-port on some SoCs.
 
 Required nodes : a sub-node is required for each port the phy provides.
 		 The sub-node name is used to identify host or otg port,
@@ -36,6 +38,9 @@ Required properties (port (child) node):
 	* "otg-id" : for the otg id interrupt.
 	* "otg-bvalid" : for the otg vbus interrupt.
 	* "linestate" : for the host/otg linestate interrupt.
+	* "otg-mux" : otg-port interrupt, which multiplex otg-id/otg-bvalid/
+		linestate irqs to one irq. Should specify if
+		rockchip,otg_mux_irq_quirk property is set.
 
 Optional properties:
  - phy-supply : phandle to a regulator that provides power to VBUS.
diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 669e5f6..925919c 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -172,6 +172,8 @@ struct rockchip_usb2phy_cfg {
  * @vbus_attached: otg device vbus status.
  * @bvalid_irq: IRQ number assigned for vbus valid rise detection.
  * @ls_irq: IRQ number assigned for linestate detection.
+ * @otg_mux_irq: IRQ number which multiplex otg-id/otg-bvalid/linestate
+ *		 irqs to one irq in otg-port.
  * @mutex: for register updating in sm_work.
  * @chg_work: charge detect work.
  * @otg_sm_work: OTG state machine work.
@@ -189,6 +191,7 @@ struct rockchip_usb2phy_port {
 	bool		vbus_attached;
 	int		bvalid_irq;
 	int		ls_irq;
+	int		otg_mux_irq;
 	struct mutex	mutex;
 	struct		delayed_work chg_work;
 	struct		delayed_work otg_sm_work;
@@ -228,6 +231,7 @@ struct rockchip_usb2phy {
 	const struct rockchip_usb2phy_cfg	*phy_cfg;
 	struct rockchip_usb2phy_port	ports[USB2PHY_NUM_PORTS];
 	unsigned int	companion_grf_quirk:1;
+	unsigned int	otg_mux_irq_quirk:1;
 };
 
 static inline struct regmap *get_reg_base(struct rockchip_usb2phy *rphy)
@@ -935,6 +939,17 @@ static irqreturn_t rockchip_usb2phy_bvalid_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t rockchip_usb2phy_otg_mux_irq(int irq, void *data)
+{
+	struct rockchip_usb2phy_port *rport = data;
+	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
+
+	if (property_enabled(rphy->grf, &rport->port_cfg->bvalid_det_st))
+		return rockchip_usb2phy_bvalid_irq(irq, data);
+	else
+		return IRQ_NONE;
+}
+
 static int rockchip_usb2phy_host_port_init(struct rockchip_usb2phy *rphy,
 					   struct rockchip_usb2phy_port *rport,
 					   struct device_node *child_np)
@@ -1011,20 +1026,44 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	rport->utmi_avalid =
 		of_property_read_bool(child_np, "rockchip,utmi-avalid");
 
-	rport->bvalid_irq = of_irq_get_byname(child_np, "otg-bvalid");
-	if (rport->bvalid_irq < 0) {
-		dev_err(rphy->dev, "no vbus valid irq provided\n");
-		ret = rport->bvalid_irq;
-		goto out;
-	}
+	if (rphy->otg_mux_irq_quirk) {
+		rport->otg_mux_irq = of_irq_get_byname(child_np, "otg-mux");
+		if (rport->otg_mux_irq < 0) {
+			dev_err(rphy->dev, "no otg-mux irq provided\n");
+			ret = rport->otg_mux_irq;
+			goto out;
+		}
 
-	ret = devm_request_threaded_irq(rphy->dev, rport->bvalid_irq, NULL,
-					rockchip_usb2phy_bvalid_irq,
-					IRQF_ONESHOT,
-					"rockchip_usb2phy_bvalid", rport);
-	if (ret) {
-		dev_err(rphy->dev, "failed to request otg-bvalid irq handle\n");
-		goto out;
+		ret = devm_request_threaded_irq(rphy->dev, rport->otg_mux_irq,
+						NULL,
+						rockchip_usb2phy_otg_mux_irq,
+						IRQF_ONESHOT,
+						"rockchip_usb2phy_otg",
+						rport);
+		if (ret) {
+			dev_err(rphy->dev,
+				"failed to request otg-mux irq handle\n");
+			goto out;
+		}
+	} else {
+		rport->bvalid_irq = of_irq_get_byname(child_np, "otg-bvalid");
+		if (rport->bvalid_irq < 0) {
+			dev_err(rphy->dev, "no vbus valid irq provided\n");
+			ret = rport->bvalid_irq;
+			goto out;
+		}
+
+		ret = devm_request_threaded_irq(rphy->dev, rport->bvalid_irq,
+						NULL,
+						rockchip_usb2phy_bvalid_irq,
+						IRQF_ONESHOT,
+						"rockchip_usb2phy_bvalid",
+						rport);
+		if (ret) {
+			dev_err(rphy->dev,
+				"failed to request otg-bvalid irq handle\n");
+			goto out;
+		}
 	}
 
 	if (!IS_ERR(rphy->edev)) {
@@ -1081,6 +1120,9 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		rphy->usbgrf = NULL;
 	}
 
+	rphy->otg_mux_irq_quirk =
+		device_property_read_bool(dev, "rockchip,otg_mux_irq_quirk");
+
 	if (of_property_read_u32(np, "reg", &reg)) {
 		dev_err(dev, "the reg property is not assigned in %s node\n",
 			np->name);
-- 
2.0.0
