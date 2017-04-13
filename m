From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 13 Apr 2017 06:32:40 -0700
Subject: [PATCH 6/8] ARM: dts: imx7d-sdb: Add GPIO expander node
In-Reply-To: <20170413133242.5068-1-andrew.smirnov@gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
Message-ID: <20170413133242.5068-7-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for U38, a 74LV595PW serial-in shift register that acts as a
GPIO expander on the board.

Cc: yurovsky at gmail.com
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 5be01a1..e0ff276 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -52,6 +52,30 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
+	spi4 {
+		compatible = "spi-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_spi1>;
+		status = "okay";
+		gpio-sck = <&gpio1 13 0>;
+		gpio-mosi = <&gpio1 9 0>;
+		cs-gpios = <&gpio1 12 0>;
+		num-chipselects = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio_spi: gpio_spi at 0 {
+			compatible = "fairchild,74hc595";
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0>;
+			registers-number = <1>;
+			 /* Enable PERI_3V3, SENSOR_RST_B and HDMI_RST*/
+			registers-default = /bits/ 8 <0x74>;
+			spi-max-frequency = <100000>;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -642,5 +666,13 @@
 		fsl,pins = <
 			MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT		0x110b0
 		>;
+
+		pinctrl_spi1: spi1grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO09__GPIO1_IO9	0x59
+				MX7D_PAD_GPIO1_IO12__GPIO1_IO12	0x59
+				MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x59
+			>;
+		};
 	};
 };
-- 
2.9.3
