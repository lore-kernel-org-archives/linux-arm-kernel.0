From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon,  8 May 2017 18:21:17 +0200
Subject: [PATCH 8/8] arm64: dts: hikey: Fix WiFi support
In-Reply-To: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1494260477-25163-9-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The description of the connection between the dwmmc (SDIO) controller and
the Wifi chip, which is attached to the SDIO bus is wrong. Currently the
SDIO card can't be detected and thus the Wifi doesn't work.

Let's fix this by assigning the correct vmmc supply, which is the always on
regulator VDD_3V3 and remove the WLAN enable regulator altogether. Then to
properly deal with the power on/off sequence, add a mmc-pwrseq node to
describe the resources needed to detect the SDIO card.

Except for the WLAN enable GPIO and its corresponding assert/de-assert
delays, the mmc-pwrseq node also contains a handle to a clock provided by
the hi655x pmic. This clock is also needed to be able to turn on the WiFi
chip.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index d4b3879..f72698b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -111,6 +111,15 @@
 		vin-supply = <&reg_sys_5v>;
 	};
 
+	wl1835_pwrseq: wl1835-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		/* WLAN_EN GPIO */
+		reset-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
+		clocks = <&pmic>;
+		clock-names = "ext_clock";
+		power-off-delay-us = <10>;
+	};
+
 	soc {
 		spi0: spi at f7106000 {
 			status = "ok";
@@ -302,11 +311,10 @@
 		};
 
 		dwmmc_2: dwmmc2 at f723f000 {
-			broken-cd;
 			bus-width = <0x4>;
 			non-removable;
-			/* WL_EN */
-			vmmc-supply = <&wlan_en_reg>;
+			vmmc-supply = <&reg_vdd_3v3>;
+			mmc-pwrseq = <&wl1835_pwrseq>;
 
 			#address-cells = <0x1>;
 			#size-cells = <0x0>;
@@ -318,18 +326,6 @@
 				interrupts = <3 IRQ_TYPE_EDGE_RISING>;
 			};
 		};
-
-		wlan_en_reg: regulator at 1 {
-			compatible = "regulator-fixed";
-			regulator-name = "wlan-en-regulator";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			/* WLAN_EN GPIO */
-			gpio = <&gpio0 5 0>;
-			/* WLAN card specific delay */
-			startup-delay-us = <70000>;
-			enable-active-high;
-		};
 	};
 
 	leds {
-- 
2.7.4
