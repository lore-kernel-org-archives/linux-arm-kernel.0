From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 28 Aug 2015 17:59:42 +0200
Subject: [PATCH 07/11] arm: tegra: colibri_t30: activate stmpe811 touch
 controller
In-Reply-To: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <1440777586-19545-8-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Activate STMPE811 touch controller as found on Colibri T30 modules.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index fba3d2a..5f8ec5c 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -320,6 +320,46 @@
 			};
 		};
 
+		/* STMPE811 touch screen controller */
+		stmpe811 at 41 {
+			compatible = "st,stmpe811";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x41>;
+			interrupts = <TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;
+			interrupt-parent = <&gpio>;
+			interrupt-controller;
+			id = <0>;
+			blocks = <0x5>;
+			irq-trigger = <0x1>;
+
+			stmpe_touchscreen {
+				compatible = "st,stmpe-ts";
+				reg = <0>;
+				/* 3.25 MHz ADC clock speed */
+				st,adc-freq = <1>;
+				/* 8 sample average control */
+				st,ave-ctrl = <3>;
+				/* 7 length fractional part in z */
+				st,fraction-z = <7>;
+				/*
+				 * 50 mA typical 80 mA max touchscreen drivers
+				 * current limit value
+				 */
+				st,i-drive = <1>;
+				/* 12-bit ADC */
+				st,mod-12b = <1>;
+				/* internal ADC reference */
+				st,ref-sel = <0>;
+				/* ADC converstion time: 80 clocks */
+				st,sample-time = <4>;
+				/* 1 ms panel driver settling time */
+				st,settling = <3>;
+				/* 5 ms touch detect interrupt delay */
+				st,touch-det-delay = <5>;
+			};
+		};
+
 		/*
 		 * LM95245 temperature sensor
 		 * Note: OVERT_N directly connected to PMIC PWRDN
-- 
2.4.3
