From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 27 Apr 2015 15:19:12 +0200
Subject: [PATCH 3/4] ARM: at91/dt: sama5d3 xplained: add fixed regulator for
 vmmc0
In-Reply-To: <1430140753-19998-1-git-send-email-ludovic.desroches@atmel.com>
References: <1430140753-19998-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1430140753-19998-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add fixed regulator for vmmc0 and attach the vmmc for it to the mmc0
node on the SAM5D3 Xplained board. This will remove the following
warning from the kernel:

atmel_mci f0000000.mmc: No vmmc regulator found

Note, atmel_defconfig will need fixed regulator support enabled if this
is to be used properly.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[use a fixed regulator instead of gpio one]
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 61922b3..581986a 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -35,6 +35,7 @@
 		apb {
 			mmc0: mmc at f0000000 {
 				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_dat4_7 &pinctrl_mmc0_cd>;
+				vmmc-supply = <&vcc_mmc0_reg>;
 				vqmmc-supply = <&vcc_3v3_reg>;
 				status = "okay";
 				slot at 0 {
@@ -296,6 +297,14 @@
 		};
 	};
 
+	vcc_mmc0_reg: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
+		regulator-name = "mmc0-card-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 
-- 
2.2.0
