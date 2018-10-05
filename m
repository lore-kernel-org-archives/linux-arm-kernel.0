From: david.hernandezsanchez@st.com (David HERNANDEZ SANCHEZ)
Date: Fri, 5 Oct 2018 10:08:46 +0000
Subject: [PATCH 3/3] ARM: dts: stm32: add thermal sensor support on STM32MP157c
In-Reply-To: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
Message-ID: <1538734081-26585-4-git-send-email-david.hernandezsanchez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add configuration on DT for thermal sensor driver

Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 661be94..e90b9f6 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -84,6 +84,31 @@
 		};
 	};

+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&dts>;
+
+			trips {
+				cpu_alert1: cpu-alert1 {
+					temperature = <85000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				cpu-crit {
+					temperature = <120000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -908,6 +933,16 @@
 			status = "disabled";
 		};

+		dts: thermal at 50028000 {
+			compatible = "st,stm32-thermal";
+			reg = <0x50028000 0x100>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc TMPSENS>;
+			clock-names = "pclk";
+			#thermal-sensor-cells = <0>;
+			status = "disabled";
+		};
+
 		cryp1: cryp at 54001000 {
 			compatible = "st,stm32mp1-cryp";
 			reg = <0x54001000 0x400>;
--
2.7.4
