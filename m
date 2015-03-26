From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 17:38:25 +0000
Subject: [PATCH 3/3] ARM: at91/dt: sama5d3 add gpio regulator for vmmc0
In-Reply-To: <1427391505-29129-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427391505-29129-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427391505-29129-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add gpio regulator for vmmc0 and attach the vmmc for it to the mmc0
node on the SAM5D3 Xplained board. This will remove the following
warning from the kernel:

atmel_mci f0000000.mmc: No vmmc regulator found

Note, atmel_defconfig will need gpio regulator support enabled if this
is to be used properly.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Ian Campbell <ijc+devicetree@hellion.org.uk>
CC: Kumar Gala <galak@codeaurora.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
CC: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 1eb150d..6b6ad5c 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -36,6 +36,7 @@
 			mmc0: mmc at f0000000 {
 				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_dat4_7 &pinctrl_mmc0_cd>;
 				status = "okay";
+				vmmc-supply = <&vcc_mmc0_reg>;
 				vqmmc-supply = <&vcc_3v3_reg>;
 				slot at 0 {
 					reg = <0>;
@@ -285,6 +286,14 @@
 		};
 	};
 
+	vcc_mmc0_reg: regulator at 1 {
+		compatible = "regualtor-gpio";
+		gpio = <&pioE 2 GPIO_ACTIVE_LOW>;
+		regulator-name = "mmc0-card-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 
-- 
2.1.4
