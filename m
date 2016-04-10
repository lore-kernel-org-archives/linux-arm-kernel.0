From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 10 Apr 2016 21:30:00 +0200
Subject: [PATCH 3/3] ARM: dts: add pxa25x .dtsi file
In-Reply-To: <1460316600-15978-1-git-send-email-robert.jarzmik@free.fr>
References: <1460316600-15978-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1460316600-15978-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This file describes pxa25x SoCs. Not all devices are listed yet, only
the subset which was already tested with a lubbock board.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa25x.dtsi | 92 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 arch/arm/boot/dts/pxa25x.dtsi

diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
new file mode 100644
index 000000000000..0d1e012178c4
--- /dev/null
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -0,0 +1,92 @@
+/*
+ * Copyright (C) 2016 Robert Jarzmik <robert.jarzmik@free.fr>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include "pxa2xx.dtsi"
+#include "dt-bindings/clock/pxa-clock.h"
+
+/ {
+	model = "Marvell PXA25x family SoC";
+	compatible = "marvell,pxa250";
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
+		clks: pxa2xx_clks at 41300004 {
+			compatible = "marvell,pxa250-core-clocks";
+			#clock-cells = <1>;
+			status = "okay";
+		};
+
+		/* timer oscillator */
+		clktimer: oscillator {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency  = <3686400>;
+			clock-output-names = "ostimer";
+		};
+	};
+
+	pxabus {
+		pdma: dma-controller at 40000000 {
+			compatible = "marvell,pdma-1.0";
+			reg = <0x40000000 0x10000>;
+			interrupts = <25>;
+			#dma-channels = <16>;
+			#dma-cells = <2>;
+			#dma-requests = <40>;
+			status = "okay";
+		};
+
+		pxairq: interrupt-controller at 40d00000 {
+			marvell,intc-priority;
+			marvell,intc-nr-irqs = <32>;
+		};
+
+		pinctrl: pinctrl at 40e00000 {
+			reg = <0x40e00054 0x20 0x40e0000c 0xc 0x40e0010c 4
+			       0x40f00020 0x10>;
+			compatible = "marvell,pxa25x-pinctrl";
+		};
+
+		gpio: gpio at 40e00000 {
+			compatible = "intel,pxa25x-gpio";
+			gpio-ranges = <&pinctrl 0 0 84>;
+			clocks = <&clks CLK_NONE>;
+		};
+
+		pwm0: pwm at 40b00000 {
+			compatible = "marvell,pxa250-pwm";
+			reg = <0x40b00000 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM0>;
+		};
+
+		pwm1: pwm at 40b00010 {
+			compatible = "marvell,pxa250-pwm";
+			reg = <0x40b00010 0x10>;
+			#pwm-cells = <1>;
+			clocks = <&clks CLK_PWM1>;
+		};
+	};
+
+	timer at 40a00000 {
+		compatible = "marvell,pxa-timer";
+		reg = <0x40a00000 0x20>;
+		interrupts = <26>;
+		clocks = <&clktimer>;
+		status = "okay";
+	};
+};
-- 
2.1.4
