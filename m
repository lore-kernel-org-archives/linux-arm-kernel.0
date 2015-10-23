From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 23 Oct 2015 11:28:08 -0700
Subject: [PATCH 1/4] phy: rockchip-usb: Support the PHY's "port reset"
In-Reply-To: <1445624891-31680-1-git-send-email-dianders@chromium.org>
References: <1445624891-31680-1-git-send-email-dianders@chromium.org>
Message-ID: <1445624891-31680-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'd like to be able to expose the USB PHYs as reset providers.  They
can provide one reset that is named in the TRM as a "port reset".

The name in the TRM is a bit confusing since there's a bit in dwc2's
"hprt0" register that's also called "port reset" and this appears to
reset something different, but it's still interesting to expose this one
so we can actually use it.

The TRM gives a little details about the reset that's in the PHY.  It
says this will "reset the port transmit and receive logic without
disabling the clocks within the PHY."  It goes on to say that the
"transmit and receive finite state machines are reset and the line_state
logic combinatorially reflects the state of the single-ended receivers."

It's expected that will add code to dwc2 in a future patch that will let
dwc2 access this reset.  This reset seems to have the ability to unwedge
the dwc2 "host" port when a remote wakeup happens.  It may have other
redeeming qualities as well.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 .../devicetree/bindings/phy/rockchip-usb-phy.txt   |  6 ++
 drivers/phy/phy-rockchip-usb.c                     | 74 ++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
index 826454a..746c035 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
@@ -21,6 +21,11 @@ required properties:
 Optional Properties:
 - clocks : phandle + clock specifier for the phy clocks
 - clock-names: string, clock name, must be "phyclk"
+- #reset-cells: adding this property allows the phy to be
+  specified as a reset source.  Asserting this reset will
+  assert the PHY's "port reset" bit.  Always set reset-cells
+  to 0.  Each PHY only has one reset to provide so no ID is
+  needed.
 
 Example:
 
@@ -32,6 +37,7 @@ usbphy: phy {
 
 	usbphy0: usb-phy0 {
 		#phy-cells = <0>;
+		#reset-cells = <0>;
 		reg = <0x320>;
 	};
 };
diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index 91d6f34..0e17677 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -25,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/reset-controller.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
 
@@ -36,11 +38,72 @@
 #define SIDDQ_ON		BIT(13)
 #define SIDDQ_OFF		(0 << 13)
 
+#define PORT_RESET_WRITE_ENA	BIT(12 + 16)
+#define PORT_RESET_ON		BIT(12)
+#define PORT_RESET_OFF		(0 << 12)
+
 struct rockchip_usb_phy {
 	unsigned int	reg_offset;
 	struct regmap	*reg_base;
 	struct clk	*clk;
 	struct phy	*phy;
+	struct reset_controller_dev	rcdev;
+};
+
+static int rockchip_usb_phy_port_reset_on(struct reset_controller_dev *rcdev,
+					   unsigned long id)
+{
+	int ret;
+
+	struct rockchip_usb_phy *phy =
+		container_of(rcdev, struct rockchip_usb_phy, rcdev);
+
+	ret = regmap_write(phy->reg_base, phy->reg_offset,
+			   PORT_RESET_WRITE_ENA | PORT_RESET_ON);
+
+	/*
+	 * The TRM says nothing about how long we need to reset for, but
+	 * it seems to work with very little delay.
+	 */
+	udelay(1);
+
+	return ret;
+}
+
+static int rockchip_usb_phy_port_reset_off(struct reset_controller_dev *rcdev,
+					   unsigned long id)
+{
+	int ret;
+
+	struct rockchip_usb_phy *phy =
+		container_of(rcdev, struct rockchip_usb_phy, rcdev);
+
+	ret = regmap_write(phy->reg_base, phy->reg_offset,
+			   PORT_RESET_WRITE_ENA | PORT_RESET_OFF);
+
+	/*
+	 * TRM says we should wait 11 PHYCLOCK cycles after deasserting reset
+	 * but doesn't say what PHYCLOCK is.  Even if it was as slow as 12MHz
+	 * that would only be 917 ns though, so we'll delay 1us which should be
+	 * total overkill but shouldn't hurt.
+	 */
+	udelay(1);
+
+	return ret;
+}
+
+static int rockchip_usb_phy_reset_xlate(struct reset_controller_dev *rcdev,
+				       const struct of_phandle_args *reset_spec)
+{
+	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct reset_control_ops rockchip_usb_phy_port_reset_ops = {
+	.assert		= rockchip_usb_phy_port_reset_on,
+	.deassert	= rockchip_usb_phy_port_reset_off,
 };
 
 static int rockchip_usb_phy_power(struct rockchip_usb_phy *phy,
@@ -135,6 +198,17 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 		err = rockchip_usb_phy_power(rk_phy, 1);
 		if (err)
 			return err;
+
+		rk_phy->rcdev.owner = THIS_MODULE;
+		rk_phy->rcdev.nr_resets = 1;
+		rk_phy->rcdev.ops = &rockchip_usb_phy_port_reset_ops;
+		rk_phy->rcdev.of_node = child;
+		rk_phy->rcdev.of_xlate = rockchip_usb_phy_reset_xlate;
+
+		err = reset_controller_register(&rk_phy->rcdev);
+		if (err)
+			dev_warn(dev, "Register reset failed (%d); skipping\n",
+				 err);
 	}
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-- 
2.6.0.rc2.230.g3dd15c0
