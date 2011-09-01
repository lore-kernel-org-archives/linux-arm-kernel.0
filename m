From: robherring2@gmail.com (Rob Herring)
Date: Wed, 31 Aug 2011 20:44:01 -0500
Subject: [PATCH v2 2/7] ARM: highbank: add devicetree source
In-Reply-To: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
Message-ID: <1314841446-11006-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This adds the devicetree source and documentation for the Calxeda highbank
platform.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
Changes in v2:
 - Change gic interrupt-cell size to 2 and update entries to high level
   triggered.
   
 Documentation/devicetree/bindings/arm/calxeda.txt |    8 +
 arch/arm/boot/dts/highbank.dts                    |  224 +++++++++++++++++++++
 2 files changed, 232 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
 create mode 100644 arch/arm/boot/dts/highbank.dts

diff --git a/Documentation/devicetree/bindings/arm/calxeda.txt b/Documentation/devicetree/bindings/arm/calxeda.txt
new file mode 100644
index 0000000..4755caa
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/calxeda.txt
@@ -0,0 +1,8 @@
+Calxeda Highbank Platforms Device Tree Bindings
+-----------------------------------------------
+
+Boards with Calxeda Cortex-A9 based Highbank SOC shall have the following
+properties.
+
+Required root node properties:
+    - compatible = "calxeda,highbank";
diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
new file mode 100644
index 0000000..40fe013
--- /dev/null
+++ b/arch/arm/boot/dts/highbank.dts
@@ -0,0 +1,224 @@
+/*
+ * Copyright 2011 Calxeda, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/dts-v1/;
+
+/* First 4KB has pen for secondary cores. */
+/memreserve/ 0x00000000 0x0001000;
+
+/ {
+	model = "Calxeda Highbank";
+	compatible = "calxeda,highbank";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 2 {
+			compatible = "arm,cortex-a9";
+			reg = <2>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 3 {
+			compatible = "arm,cortex-a9";
+			reg = <3>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x00000000 0xff900000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyAMA0";
+	};
+
+	intc: interrupt-controller at fff11000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <2>;
+		#size-cells = <0>;
+		#address-cells = <1>;
+		interrupt-controller;
+		reg = <0xfff11000 0x1000>,
+		      <0xfff10100 0x100>;
+		      
+		gicppi0: gic-ppi at 0 {
+			compatible = "arm,cortex-a9-gic-ppi";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <0>;
+		};
+		gicppi1: gic-ppi at 1 {
+			compatible = "arm,cortex-a9-gic-ppi";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <1>;
+		};
+		gicppi2: gic-ppi at 2 {
+			compatible = "arm,cortex-a9-gic-ppi";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <2>;
+		};
+		gicppi3: gic-ppi at 3 {
+			compatible = "arm,cortex-a9-gic-ppi";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <3>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		ranges;
+
+		timer at fff10600 {
+			compatible = "arm,smp-twd";
+			reg = <0xfff10600 0x20>;
+			interrupt-parent = <&gicppi0>;
+			interrupts = <29>;
+		};
+
+		watchdog at fff10620 {
+			compatible = "arm,cortex-a9-wdt";
+			reg = <0xfff10620 0x20>;
+			interrupt-parent = <&gicppi0>;
+			interrupts = <30>;
+		};
+
+		L2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0xfff12000 0x1000>;
+			interrupts = <102 4>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		pmu {
+			compatible = "arm,cortex-a9-pmu";
+			interrupts = <108 4 107 4 106 4 105 4>;
+		};
+
+		sata at ffe08000 {
+			compatible = "calxeda,hb-ahci";
+			reg = <0xffe08000 0x10000>;
+			interrupts = <115 4>;
+		};
+
+		sdhci at ffe0e000 {
+			compatible = "calxeda,hb-sdhci";
+			reg = <0xffe0e000 0x1000>;
+			interrupts = <122 4>;
+		};
+
+		ipc at fff20000 {
+			compatible = "arm,pl320", "arm,primecell";
+			reg = <0xfff20000 0x1000>;
+			interrupts = <39 4>;
+		};
+
+		gpioe: gpio at fff30000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0xfff30000 0x1000>;
+			interrupts = <46 4>;
+		};
+
+		gpiof: gpio at fff31000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0xfff31000 0x1000>;
+			interrupts = <47 4>;
+		};
+
+		gpiog: gpio at fff32000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0xfff32000 0x1000>;
+			interrupts = <48 4>;
+		};
+
+		gpioh: gpio at fff33000 {
+			#gpio-cells = <2>;
+			compatible = "arm,pl061", "arm,primecell";
+			gpio-controller;
+			reg = <0xfff33000 0x1000>;
+			interrupts = <49 4>;
+		};
+
+		timer {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0xfff34000 0x1000>;
+			interrupts = <50 4>;
+		};
+
+		rtc at fff35000 {
+			compatible = "arm,pl031", "arm,primecell";
+			reg = <0xfff35000 0x1000>;
+			interrupts = <51 4>;
+		};
+
+		serial at fff36000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xfff36000 0x1000>;
+			interrupts = <52 4>;
+		};
+
+		smic at fff3a000 {
+			compatible = "ipmi-smic";
+			device_type = "ipmi";
+			reg = <0xfff3a000 0x1000>;
+			interrupts = <56 4>;
+			reg-size = <4>;
+			reg-spacing = <4>;
+		};
+
+		sregs at fff3c000 {
+			compatible = "calxeda,hb-sregs";
+			reg = <0xfff3c000 0x1000>;
+		};
+
+		dma at fff3d000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0xfff3d000 0x1000>;
+			interrupts = <124 4>;
+		};
+	};
+};
-- 
1.7.4.1
