From: david.wu@rock-chips.com (David Wu)
Date: Thu, 10 Aug 2017 22:01:08 +0800
Subject: [PATCH v5 09/11] ARM: dts: rk3228-evb: Enable the integrated PHY for
 gmac
In-Reply-To: <1502373410-2423-1-git-send-email-david.wu@rock-chips.com>
References: <1502373410-2423-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1502373668-2767-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the integrated PHY for rk3228 evb board
by default.
To use the external 1000M PHY on evb board, need to make
some switch of evb board to be on.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
changes in v5:
 - Use phy-is-integrated property via PHY node.
 - Move the PHY clock and reset control to PHY node.

 arch/arm/boot/dts/rk3228-evb.dts | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
index 5883433..456ddf7 100644
--- a/arch/arm/boot/dts/rk3228-evb.dts
+++ b/arch/arm/boot/dts/rk3228-evb.dts
@@ -50,6 +50,16 @@
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
 	};
+
+	vcc_phy: vcc-phy-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		regulator-name = "vcc_phy";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &emmc {
@@ -60,6 +70,30 @@
 	status = "okay";
 };
 
+&gmac {
+	assigned-clocks = <&cru SCLK_MAC_SRC>;
+	assigned-clock-rates = <50000000>;
+	clock_in_out = "output";
+	phy-supply = <&vcc_phy>;
+	phy-mode = "rmii";
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy at 0 {
+			compatible = "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			clocks = <&cru SCLK_MAC_PHY>;
+			resets = <&cru SRST_MACPHY>;
+			phy-is-integrated;
+		};
+	};
+};
+
 &tsadc {
 	status = "okay";
 
-- 
1.9.1
