From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 14 Dec 2017 11:02:42 +0800
Subject: [PATCH v2] ARM64: dts: meson-axg: add ethernet mac controller
Message-ID: <20171214030242.113152-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT info for the stmmac ethernet MAC which found in
the Amlogic's Meson-AXG SoC, also describe the ethernet
pinctrl & clock information here.

This is tested in the S400 dev board which use a RTL8211F PHY,
and the pins connect to the 'eth_rgmii_y_pins' group.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
Changes in v2 since [1]:
 - rebase to kevin's v4.16/dt64 branch
 - add Neil's Reviewed-by
 - move clock info to board.dts instead of in soc.dtsi
 - drop "meson-axg-dwmac" compatible string, since we didn't use this
   we could re-add it later when we really need.
 - note: to make ethernet work properly,it depend on clock & pinctrl[2],
   to compile the DTS, the patch [3] is required.
   the code part will be taken via clock & pinctrl subsystem tree.

[1]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005301.html

[2]
http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005735.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005694.html

[3]
http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005738.html
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 11 ++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 50 ++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 70eca1f8736a..138de3bc7cc8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -20,3 +20,14 @@
 &uart_AO {
 	status = "okay";
 };
+
+&ethmac {
+	status = "okay";
+	clocks = <&clkc CLKID_ETH>,
+		 <&clkc CLKID_FCLK_DIV2>,
+		 <&clkc CLKID_MPLL2>;
+	clock-names = "stmmaceth", "clkin0", "clkin1";
+	phy-mode = "rgmii";
+	pinctrl-0 = <&eth_rgmii_y_pins>;
+	pinctrl-names = "default";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index d356ce74ad89..106234fda765 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/axg-clkc.h>
 
 / {
 	compatible = "amlogic,meson-axg";
@@ -148,6 +149,15 @@
 			#address-cells = <0>;
 		};
 
+		ethmac: ethernet at ff3f0000 {
+			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+			reg = <0x0 0xff3f0000 0x0 0x10000
+				0x0 0xff634540 0x0 0x8>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "macirq";
+			status = "disabled";
+		};
+
 		hiubus: bus at ff63c000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xff63c000 0x0 0x1c00>;
@@ -194,6 +204,46 @@
 					#gpio-cells = <2>;
 					gpio-ranges = <&pinctrl_periphs 0 0 86>;
 				};
+
+				eth_rgmii_x_pins: eth-x-rgmii {
+					mux {
+						groups = "eth_mdio_x",
+						       "eth_mdc_x",
+						       "eth_rgmii_rx_clk_x",
+						       "eth_rx_dv_x",
+						       "eth_rxd0_x",
+						       "eth_rxd1_x",
+						       "eth_rxd2_rgmii",
+						       "eth_rxd3_rgmii",
+						       "eth_rgmii_tx_clk",
+						       "eth_txen_x",
+						       "eth_txd0_x",
+						       "eth_txd1_x",
+						       "eth_txd2_rgmii",
+						       "eth_txd3_rgmii";
+						function = "eth";
+					};
+				};
+
+				eth_rgmii_y_pins: eth-y-rgmii {
+					mux {
+						groups = "eth_mdio_y",
+						       "eth_mdc_y",
+						       "eth_rgmii_rx_clk_y",
+						       "eth_rx_dv_y",
+						       "eth_rxd0_y",
+						       "eth_rxd1_y",
+						       "eth_rxd2_rgmii",
+						       "eth_rxd3_rgmii",
+						       "eth_rgmii_tx_clk",
+						       "eth_txen_y",
+						       "eth_txd0_y",
+						       "eth_txd1_y",
+						       "eth_txd2_rgmii",
+						       "eth_txd3_rgmii";
+						function = "eth";
+					};
+				};
 			};
 		};
 
-- 
2.15.1
