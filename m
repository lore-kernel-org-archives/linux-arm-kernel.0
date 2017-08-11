From: frank.wang@rock-chips.com (Frank Wang)
Date: Fri, 11 Aug 2017 16:07:49 +0800
Subject: [PATCH v4 3/5] phy: rockchip-inno-usb2: add support for otg-mux
 interrupt
In-Reply-To: <1502438871-9482-1-git-send-email-frank.wang@rock-chips.com>
References: <1502438871-9482-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1502438871-9482-4-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The otg-id/otg-bvalid/linestate interrupts are multiplexed together
in otg-port on some Rockchip SoC (e.g RV1108), this patch add support
for it.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 63 +++++++++++++++++++++------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index fb593cc..22b7b02 100644
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
@@ -934,6 +937,17 @@ static irqreturn_t rockchip_usb2phy_bvalid_irq(int irq, void *data)
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
@@ -1010,20 +1024,43 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	rport->utmi_avalid =
 		of_property_read_bool(child_np, "rockchip,utmi-avalid");
 
-	rport->bvalid_irq = of_irq_get_byname(child_np, "otg-bvalid");
-	if (rport->bvalid_irq < 0) {
-		dev_err(rphy->dev, "no vbus valid irq provided\n");
-		ret = rport->bvalid_irq;
-		goto out;
-	}
+	/*
+	 * Some SoCs use one interrupt with otg-id/otg-bvalid/linestate
+	 * interrupts muxed together, so probe the otg-mux interrupt first,
+	 * if not found, then look for the regular interrupts one by one.
+	 */
+	rport->otg_mux_irq = of_irq_get_byname(child_np, "otg-mux");
+	if (rport->otg_mux_irq > 0) {
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
 
-	ret = devm_request_threaded_irq(rphy->dev, rport->bvalid_irq, NULL,
-					rockchip_usb2phy_bvalid_irq,
-					IRQF_ONESHOT,
-					"rockchip_usb2phy_bvalid", rport);
-	if (ret) {
-		dev_err(rphy->dev, "failed to request otg-bvalid irq handle\n");
-		goto out;
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
-- 
2.0.0
