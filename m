From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 2 Aug 2012 23:01:52 +0800
Subject: [PATCH 2/2] ARM: dts: imx53-ard: add regulators for lan9220
In-Reply-To: <1343919712-6240-1-git-send-email-shawn.guo@linaro.org>
References: <1343919712-6240-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1343919712-6240-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit c7e963f (net/smsc911x: Add regulator support), the lan9220
device tree probe fails on imx53-ard board, because the commit makes
VDD33A and VDDVARIO supplies mandatory for the driver.

Add a fixed dummy 3V3 supplying lan9220 to fix the regression.

Cc: stable at vger.kernel.org
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-ard.dts |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
index 5b8eafc..fa95f4a 100644
--- a/arch/arm/boot/dts/imx53-ard.dts
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -66,10 +66,30 @@
 			interrupt-parent = <&gpio2>;
 			interrupts = <31>;
 			reg-io-width = <4>;
+			/*
+			 * VDD33A and VDDVARIO of LAN9220 are supplied by
+			 * SW4_3V3 of LTC3589.  Before the regulator driver
+			 * for this PMIC is available, we use a fixed dummy
+			 * 3V3 regulator to get LAN9220 driver probing work.
+			 */
+			vdd33a-supply = <&reg_3p3v>;
+			vddvario-supply = <&reg_3p3v>;
 			smsc,irq-push-pull;
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
-- 
1.7.5.4
