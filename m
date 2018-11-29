From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Nov 2018 07:27:59 -0200
Subject: [RFC] ARM: dts: imx7d-nitrogen7: Use mmc-pwrseq to activate the Wifi
 clock
Message-ID: <1543483679-1100-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to turn on the Wifi clock the correct location for describing
the CLKO2 clock is via a mmc-pwrseq handle, so do it accordingly.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Hi Gary/Troy,

I don't have access to this board, but I was working on something similar
for imx7d-pico-pi and needed to add mmc-pwrseq in order to turn on
the 32kHz clock:
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/616048.html

Is the 32kHz clock still needed for the Wifi chip used in the latest
version of nitrogen7?

What do you think about this patch?

Thanks

 arch/arm/boot/dts/imx7d-nitrogen7.dts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index 4fb7e84..9ba9084 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -87,13 +87,17 @@
 		compatible = "regulator-fixed";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
-		clock-names = "slow";
 		regulator-name = "reg_wlan";
 		startup-delay-us = <70000>;
 		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	usdhc2_pwrseq: usdhc2_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
+		clock-names = "slow";
+	};
 };
 
 &adc1 {
@@ -376,6 +380,7 @@
 	bus-width = <4>;
 	non-removable;
 	vmmc-supply = <&reg_wlan>;
+	mmc-pwrseq = <&usdhc2_pwrseq>;
 	cap-power-off-card;
 	keep-power-in-suspend;
 	status = "okay";
-- 
2.7.4
