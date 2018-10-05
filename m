From: david.hernandezsanchez@st.com (David HERNANDEZ SANCHEZ)
Date: Fri, 5 Oct 2018 10:08:45 +0000
Subject: [PATCH 1/3] dt-bindings: stm32-thermal: add binding documentation
In-Reply-To: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
References: <1538734081-26585-1-git-send-email-david.hernandezsanchez@st.com>
Message-ID: <1538734081-26585-2-git-send-email-david.hernandezsanchez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add thermal binding documentation for STM32 DTS sensor

Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>

diff --git a/Documentation/devicetree/bindings/thermal/stm32-thermal.txt b/Documentation/devicetree/bindings/thermal/stm32-thermal.txt
new file mode 100644
index 0000000..8c0d5a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/stm32-thermal.txt
@@ -0,0 +1,61 @@
+Binding for Thermal Sensor for STMicroelectronics STM32 series of SoCs.
+
+On STM32 SoCs, the Digital Temperature Sensor (DTS) is in charge of managing an
+analog block which delivers a frequency depending on the internal SoC's
+temperature. By using a reference frequency, DTS is able to provide a sample
+number which can be translated into a temperature by the user.
+
+DTS provides interrupt notification mechanism by threshold. This mechanism
+offers two temperature trip points: passive and critical. The first is intended
+for passive cooling notification while the second is used for over-temperature
+reset.
+
+Required parameters:
+-------------------
+
+compatible: 	Should be "st,stm32-thermal"
+reg: 		This should be the physical base address and length of the
+		sensor's registers.
+clocks: 	Phandle of the clock used by the thermal sensor.
+		  See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+clock-names: 	Should be "pclk" for register access clock and reference clock.
+		  See: Documentation/devicetree/bindings/resource-names.txt
+#thermal-sensor-cells: Should be 0. See ./thermal.txt for a description.
+interrupts:	Standard way to define interrupt number.
+
+Example:
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu_alert1: cpu-alert1 {
+					temperature = <85000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				cpu-crit: cpu-crit {
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
+	thermal: thermal at 50028000 {
+		compatible = "st,stm32-thermal";
+		reg = <0x50028000 0x100>;
+		clocks = <&rcc TMPSENS>;
+		clock-names = "pclk";
+		#thermal-sensor-cells = <0>;
+		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+	};
--
2.7.4
