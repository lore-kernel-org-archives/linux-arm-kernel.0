From: david.wu@rock-chips.com (David Wu)
Date: Fri, 23 Jun 2017 13:02:48 +0800
Subject: [PATCH 09/11] ARM: dts: rk3228-evb: Enable the internal phy for gmac
In-Reply-To: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
References: <1498192929-7519-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1498194168-8249-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the internal phy for rk3228 evb board
by default.
To use the external 1000M phy on evb board, need to make
some switch of evb board to be on.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 arch/arm/boot/dts/rk3228-evb.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
index 5883433..c4002da 100644
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
@@ -60,6 +70,16 @@
 	status = "okay";
 };
 
+&gmac {
+	assigned-clocks = <&cru SCLK_MAC_SRC>;
+	assigned-clock-rates = <50000000>;
+	clock_in_out = "output";
+	phy-supply = <&vcc_phy>;
+	phy-mode = "rmii";
+	phy-type = "internal";
+	status = "okay";
+};
+
 &tsadc {
 	status = "okay";
 
-- 
1.9.1
