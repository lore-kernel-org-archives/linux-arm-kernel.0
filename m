From: david.wu@rock-chips.com (David Wu)
Date: Wed,  2 Aug 2017 14:24:57 +0800
Subject: [PATCH v3 10/11] ARM64: dts: rockchip: Add gmac2phy node support for
 rk3328
In-Reply-To: <1501654546-17292-1-git-send-email-david.wu@rock-chips.com>
References: <1501654546-17292-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1501655097-21054-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gmac2phy controller of rk3328 is connected to internal phy
directly inside, add the node for the internal phy support.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 0be96ce..51c8c66 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -63,6 +63,8 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		ethernet0 = &gmac2io;
+		ethernet1 = &gmac2phy;
 	};
 
 	cpus {
@@ -424,6 +426,29 @@
 		status = "disabled";
 	};
 
+	gmac2phy: eth at ff550000 {
+		compatible = "rockchip,rk3328-gmac";
+		reg = <0x0 0xff550000 0x0 0x10000>;
+		rockchip,grf = <&grf>;
+		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+		clocks = <&cru SCLK_MAC2PHY_SRC>, <&cru SCLK_MAC2PHY_RXTX>,
+			 <&cru SCLK_MAC2PHY_RXTX>, <&cru SCLK_MAC2PHY_REF>,
+			 <&cru ACLK_MAC2PHY>, <&cru PCLK_MAC2PHY>,
+			 <&cru SCLK_MAC2PHY_OUT>;
+		clock-names = "stmmaceth", "mac_clk_rx",
+			      "mac_clk_tx", "clk_mac_ref",
+			      "aclk_mac", "pclk_mac",
+			      "clk_macphy";
+		resets = <&cru SRST_GMAC2PHY_A>, <&cru SRST_MACPHY>;
+		reset-names = "stmmaceth", "mac-phy";
+		phy-mode = "rmii";
+		phy-is-internal;
+		pinctrl-names = "default";
+		pinctrl-0 = <&fephyled_rxm1 &fephyled_linkm1>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller at ff811000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
1.9.1
