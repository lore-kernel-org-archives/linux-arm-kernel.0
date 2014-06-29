From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 29 Jun 2014 20:32:22 +0200
Subject: [PATCH 2/4] dts: add devicetree bindings for pxa27x clocks
In-Reply-To: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
References: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1404066744-13416-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clock tree description for the PXA27x based boards.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi            | 134 ++++++++++++++++++++++++++++++-
 include/dt-bindings/clock/pxa2xx-clock.h |  45 +++++++++++
 2 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/pxa2xx-clock.h

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index a705469..badaa71 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -1,5 +1,6 @@
 /* The pxa3xx skeleton simply augments the 2xx version */
-/include/ "pxa2xx.dtsi"
+#include "pxa2xx.dtsi"
+#include "dt-bindings/clock/pxa2xx-clock.h"
 
 / {
 	model = "Marvell PXA27x familiy SoC";
@@ -35,4 +36,135 @@
 			#pwm-cells = <1>;
 		};
 	};
+
+	clocks {
+	       /*
+		* The muxing of external clocks/internal dividers for osc* clock
+		* sources has been hidden under the carpet by now.
+		*/
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		osc13mhz:osc13mhz {
+			compatible = "fixed-clock";
+			 #clock-cells = <0>;
+			clock-frequency = <13000000>;
+		};
+
+		osc32_768khz:osc32_768khz {
+			compatible = "fixed-clock";
+			 #clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+
+		pll_312mhz:pll_312mhz {
+			compatible = "fixed-factor-clock";
+			 #clock-cells = <0>;
+			clocks = <&osc13mhz>;
+			clock-div = <1>;
+			clock-mult = <24>;
+		};
+
+		clk_48mhz:clk_48mhz {
+			compatible = "fixed-factor-clock";
+			 #clock-cells = <0>;
+			clocks = <&pll_312mhz>;
+			clock-div = <13>;
+			clock-mult = <2>;
+		};
+
+		clk_32_842mhz:clk_32_842mhz {
+			compatible = "fixed-factor-clock";
+			 #clock-cells = <0>;
+			clocks = <&pll_312mhz>;
+			clock-div = <19>;
+			clock-mult = <2>;
+		};
+
+		clk_19_5mhz:clk_19_5mhz {
+			compatible = "fixed-factor-clock";
+			 #clock-cells = <0>;
+			clocks = <&pll_312mhz>;
+			clock-div = <32>;
+			clock-mult = <2>;
+		};
+
+		clk_14_857mhz:clk_14_857mhz {
+			compatible = "fixed-factor-clock";
+			 #clock-cells = <0>;
+			clocks = <&pll_312mhz>;
+			clock-div = <42>;
+			clock-mult = <2>;
+		};
+
+		clk_14_682mhz:clk_14_682mhz {
+			compatible = "fixed-factor-clock";
+			 #clock-cells = <0>;
+			clocks = <&pll_312mhz>;
+			clock-div = <51>;
+			clock-mult = <2>;
+		};
+
+		clk_13mhz:clk_13mhz {
+			compatible = "fixed-factor-clock";
+			 #clock-cells = <0>;
+			clocks = <&osc13mhz>;
+			clock-div = <1>;
+			clock-mult = <1>;
+		};
+
+		clk_dummy:clk_dummy {
+			compatible = "fixed-clock";
+			 #clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		clk_ostimer:clk_ostimer {
+			compatible = "fixed-factor-clock";
+			 #clock-cells = <0>;
+			clocks = <&osc13mhz>;
+			clock-div = <4>;
+			clock-mult = <1>;
+		};
+
+		pxa27x_sysclks:pxa27x_sysclks {
+			compatible = "marvell,pxa270-core-clocks";
+			#clock-cells = <1>;
+			clocks = <&osc13mhz>;
+			clock-output-names = "run mode", "half-turbo mode",
+				"turbo mode", "cpu core", "system bus", "memory", "lcd";
+		};
+
+		pxa2xx_clks: pxa2xx_clks at 41300004 {
+			compatible = "marvell,pxa-clocks";
+			reg = <0x41300004 0x4>;
+			clocks =
+				<&clk_13mhz>, <&clk_13mhz>, <&clk_dummy>, <&clk_13mhz>,
+				<&clk_13mhz>, <&clk_14_857mhz>, <&clk_14_857mhz>, <&clk_14_857mhz>,
+				<&clk_14_682mhz>, <&clk_ostimer>, <&clk_48mhz>, <&clk_48mhz>,
+				<&clk_19_5mhz>, <&clk_48mhz>, <&clk_32_842mhz>, <&clk_13mhz>,
+				<&pxa27x_sysclks 6>, <&clk_48mhz>, <&clk_48mhz>, <&osc32_768khz>,
+				<&clk_dummy>, <&clk_19_5mhz>, <&pxa27x_sysclks 4>, <&clk_13mhz>,
+				<&pxa27x_sysclks 6>, <&clk_dummy>;
+			#clock-cells = <1>;
+			clock-output-names =
+				"pwm 0,2", "pwm 1,3", "ac97", "ssp2",
+				"ssp3,hwuart", "stuart", "ffuart", "btuart",
+				"i2s", "nssp,ostimer", "usb host,assp", "usb udc",
+				"mmc", "ficp", "i2c", "pwri2c",
+				"lcd", "msl", "usim", "keypad",
+				 "im", "memstk", "memc", "ssp1",
+				 "camera", "ac97conf";
+			clock-indices = <
+				CKEN_PWM0 CKEN_PWM1 CKEN_AC97 CKEN_SSP2
+				CKEN_SSP3 CKEN_STUART CKEN_FFUART CKEN_BTUART
+				CKEN_I2S CKEN_OSTIMER CKEN_USBHOST CKEN_USB
+				CKEN_MMC CKEN_FICP CKEN_I2C CKEN_PWRI2C
+				CKEN_LCD CKEN_MSL CKEN_USIM CKEN_KEYPAD
+				CKEN_IM CKEN_MEMSTK 65 CKEN_SSP1
+				CKEN_CAMERA CKEN_AC97CONF >;
+		};
+	};
+
 };
diff --git a/include/dt-bindings/clock/pxa2xx-clock.h b/include/dt-bindings/clock/pxa2xx-clock.h
new file mode 100644
index 0000000..5ffba58
--- /dev/null
+++ b/include/dt-bindings/clock/pxa2xx-clock.h
@@ -0,0 +1,45 @@
+/*
+ * Inspired by original work from pxa2xx-regs.h by Nicolas Pitre
+ * Copyright (C) 2014 Robert Jarzmik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_PXA2XX_H__
+#define __DT_BINDINGS_CLOCK_PXA2XX_H__
+
+#define CKEN_AC97CONF   (31)    /* AC97 Controller Configuration */
+#define CKEN_CAMERA	(24)	/* Camera Interface Clock Enable */
+#define CKEN_SSP1	(23)	/* SSP1 Unit Clock Enable */
+#define CKEN_MEMC	(22)	/* Memory Controller Clock Enable */
+#define CKEN_MEMSTK	(21)	/* Memory Stick Host Controller */
+#define CKEN_IM		(20)	/* Internal Memory Clock Enable */
+#define CKEN_KEYPAD	(19)	/* Keypad Interface Clock Enable */
+#define CKEN_USIM	(18)	/* USIM Unit Clock Enable */
+#define CKEN_MSL	(17)	/* MSL Unit Clock Enable */
+#define CKEN_LCD	(16)	/* LCD Unit Clock Enable */
+#define CKEN_PWRI2C	(15)	/* PWR I2C Unit Clock Enable */
+#define CKEN_I2C	(14)	/* I2C Unit Clock Enable */
+#define CKEN_FICP	(13)	/* FICP Unit Clock Enable */
+#define CKEN_MMC	(12)	/* MMC Unit Clock Enable */
+#define CKEN_USB	(11)	/* USB Unit Clock Enable */
+#define CKEN_ASSP	(10)	/* ASSP (SSP3) Clock Enable */
+#define CKEN_USBHOST	(10)	/* USB Host Unit Clock Enable */
+#define CKEN_OSTIMER	(9)	/* OS Timer Unit Clock Enable */
+#define CKEN_NSSP	(9)	/* NSSP (SSP2) Clock Enable */
+#define CKEN_I2S	(8)	/* I2S Unit Clock Enable */
+#define CKEN_BTUART	(7)	/* BTUART Unit Clock Enable */
+#define CKEN_FFUART	(6)	/* FFUART Unit Clock Enable */
+#define CKEN_STUART	(5)	/* STUART Unit Clock Enable */
+#define CKEN_HWUART	(4)	/* HWUART Unit Clock Enable */
+#define CKEN_SSP3	(4)	/* SSP3 Unit Clock Enable */
+#define CKEN_SSP	(3)	/* SSP Unit Clock Enable */
+#define CKEN_SSP2	(3)	/* SSP2 Unit Clock Enable */
+#define CKEN_AC97	(2)	/* AC97 Unit Clock Enable */
+#define CKEN_PWM1	(1)	/* PWM1 Clock Enable */
+#define CKEN_PWM0	(0)	/* PWM0 Clock Enable */
+
+#endif
-- 
2.0.0.rc2
