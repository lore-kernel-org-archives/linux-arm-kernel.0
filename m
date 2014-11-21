From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 21 Nov 2014 11:41:41 +0100
Subject: [PATCH] ARM: tegra: colibri t30: fix on-module ethernet
Message-ID: <b1cdc96ce8bb15059d7eea282f6586a826bee124.1416566157.git.marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like Ethernet only ever worked if U-Boot properly brought it up
as both the reset as well as the VBUS lines were not actively handled
in-kernel.
This patch fixes this by just pulling up the reset GPIO and properly
enabling VBUS via a GPIO enabled fixed regulator VBUS supply.

Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
---
Don't know whether this one could still make it into the current RC
cycle as it is clearly a bug fix.

 arch/arm/boot/dts/tegra30-colibri.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c4ed1be..ddbdb77 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -167,6 +167,22 @@
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
+
+			/* LAN_RESET# */
+			pex_l0_prsnt_n_pdd0 {
+				nvidia,pins = "pex_l0_prsnt_n_pdd0";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* LAN_V_BUS */
+			pex_l0_clkreq_n_pdd2 {
+				nvidia,pins = "pex_l0_clkreq_n_pdd2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
 		};
 	};
 
@@ -345,6 +361,7 @@
 	usb-phy at 7d004000 {
 		status = "okay";
 		nvidia,is-wired = <1>;
+		vbus-supply = <&lan_vbus_reg>;
 	};
 
 	clocks {
@@ -382,5 +399,17 @@
 			regulator-max-microvolt = <5000000>;
 			regulator-always-on;
 		};
+
+		/* LAN_V_BUS */
+		lan_vbus_reg: regulator at 102 {
+			compatible = "regulator-fixed";
+			reg = <102>;
+			regulator-name = "lan_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio TEGRA_GPIO(DD, 2) GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			vin-supply = <&charge_pump_5v0_reg>;
+		};
 	};
 };
-- 
1.9.3
