From: b32955@freescale.com (Huang Shijie)
Date: Fri, 24 May 2013 17:59:20 +0800
Subject: [PATCH v3 2/6] ARM: dts: imx6q{dl}: fix the pin conflict between SPI
 and WEIM
In-Reply-To: <1369389564-13181-1-git-send-email-b32955@freescale.com>
References: <1369389564-13181-1-git-send-email-b32955@freescale.com>
Message-ID: <1369389564-13181-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the imx6q-sabreauto and imx6dl-sabreauto boards,
the pin MX6Q{DL}_PAD_EIM_D19 is used as a GPIO for SPI NOR, but
it is used as a data pin for the WEIM NOR.

In order to fix the conflict, this patch removes the pin from the hog,
and adds a new board-level pinctrl: pinctrl_ecspi1_sabreauto.

The SPI NOR selects this pinctrl_ecspi1_sabreauto when it is enabled.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6dl-sabreauto.dts   |    9 ++++++++-
 arch/arm/boot/dts/imx6q-sabreauto.dts    |    9 ++++++++-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |    2 +-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-sabreauto.dts b/arch/arm/boot/dts/imx6dl-sabreauto.dts
index 60f3038..95da711 100644
--- a/arch/arm/boot/dts/imx6dl-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6dl-sabreauto.dts
@@ -25,7 +25,14 @@
 			fsl,pins = <
 				MX6DL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
 				MX6DL_PAD_SD2_DAT2__GPIO1_IO13  0x80000000
-				MX6DL_PAD_EIM_D19__GPIO3_IO19 	0x80000000
+			>;
+		};
+	};
+
+	ecspi1 {
+		pinctrl_ecspi1_sabreauto: ecspi1-sabreauto {
+			fsl,pins = <
+				MX6DL_PAD_EIM_D19__GPIO3_IO19  0x80000000
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dts b/arch/arm/boot/dts/imx6q-sabreauto.dts
index 9fb3e99..09a7580 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dts
@@ -29,7 +29,14 @@
 			fsl,pins = <
 				MX6Q_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
 				MX6Q_PAD_SD2_DAT2__GPIO1_IO13  0x80000000
-				MX6Q_PAD_EIM_D19__GPIO3_IO19   0x80000000
+			>;
+		};
+	};
+
+	ecspi1 {
+		pinctrl_ecspi1_sabreauto: ecspi1-sabreauto {
+			fsl,pins = <
+				MX6Q_PAD_EIM_D19__GPIO3_IO19  0x80000000
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index d6baa51..a4466e6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -20,7 +20,7 @@
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio3 19 0>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_ecspi1_1>;
+	pinctrl-0 = <&pinctrl_ecspi1_1 &pinctrl_ecspi1_sabreauto>;
 	status = "disabled"; /* pin conflict with WEIM NOR */
 
 	flash: m25p80 at 0 {
-- 
1.7.1
