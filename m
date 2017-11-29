From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Nov 2017 16:46:10 -0200
Subject: [PATCH 02/11] ARM: dts: imx6: Move nodes which have no reg property
 out of bus
In-Reply-To: <1511981179-12660-1-git-send-email-festevam@gmail.com>
References: <1511981179-12660-1-git-send-email-festevam@gmail.com>
Message-ID: <1511981179-12660-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Move tempmon, ldb and pmu nodes from soc node to root node.

The nodes that have been moved do not have any register properties and thus
shouldn't be placed on the bus.

This fixes the following build warnings with W=1:

arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (simple_bus_reg): Node /soc/aips-bus at 2000000/tempmon missing or empty reg/ranges property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (simple_bus_reg): Node /soc/aips-bus at 2000000/ldb missing or empty reg/ranges property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (simple_bus_reg): Node /soc/pmu missing or empty reg/ranges property

Based on a patch from Simon Horman for r8a7795.dtsi.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 136 +++++++++++++++++++++--------------------
 arch/arm/boot/dts/imx6sl.dtsi  |  28 +++++----
 arch/arm/boot/dts/imx6sx.dtsi  |  30 ++++-----
 arch/arm/boot/dts/imx6ul.dtsi  |  32 +++++-----
 4 files changed, 117 insertions(+), 109 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ac4f9ec..a0f6712 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -80,6 +80,75 @@
 		};
 	};
 
+	tempmon: tempmon {
+		compatible = "fsl,imx6q-tempmon";
+		interrupt-parent = <&gpc>;
+		interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,tempmon = <&anatop>;
+		fsl,tempmon-data = <&ocotp>;
+		clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+	};
+
+	ldb: ldb {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,imx6q-ldb", "fsl,imx53-ldb";
+		gpr = <&gpr>;
+		status = "disabled";
+
+		lvds-channel at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			status = "disabled";
+
+			port at 0 {
+				reg = <0>;
+
+				lvds0_mux_0: endpoint {
+					remote-endpoint = <&ipu1_di0_lvds0>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				lvds0_mux_1: endpoint {
+					remote-endpoint = <&ipu1_di1_lvds0>;
+				};
+			};
+		};
+
+		lvds-channel at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			status = "disabled";
+
+			port at 0 {
+				reg = <0>;
+
+				lvds1_mux_0: endpoint {
+					remote-endpoint = <&ipu1_di0_lvds1>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				lvds1_mux_1: endpoint {
+					remote-endpoint = <&ipu1_di1_lvds1>;
+				};
+			};
+		};
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&gpc>;
+		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -224,11 +293,6 @@
 			status = "disabled";
 		};
 
-		pmu {
-			compatible = "arm,cortex-a9-pmu";
-			interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		aips-bus at 2000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
@@ -729,14 +793,6 @@
 				};
 			};
 
-			tempmon: tempmon {
-				compatible = "fsl,imx6q-tempmon";
-				interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
-				fsl,tempmon = <&anatop>;
-				fsl,tempmon-data = <&ocotp>;
-				clocks = <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
-			};
-
 			usbphy1: usbphy at 20c9000 {
 				compatible = "fsl,imx6q-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020c9000 0x1000>;
@@ -841,60 +897,6 @@
 				reg = <0x20e0000 0x4000>;
 			};
 
-			ldb: ldb {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx6q-ldb", "fsl,imx53-ldb";
-				gpr = <&gpr>;
-				status = "disabled";
-
-				lvds-channel at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-					status = "disabled";
-
-					port at 0 {
-						reg = <0>;
-
-						lvds0_mux_0: endpoint {
-							remote-endpoint = <&ipu1_di0_lvds0>;
-						};
-					};
-
-					port at 1 {
-						reg = <1>;
-
-						lvds0_mux_1: endpoint {
-							remote-endpoint = <&ipu1_di1_lvds0>;
-						};
-					};
-				};
-
-				lvds-channel at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-					status = "disabled";
-
-					port at 0 {
-						reg = <0>;
-
-						lvds1_mux_0: endpoint {
-							remote-endpoint = <&ipu1_di0_lvds1>;
-						};
-					};
-
-					port at 1 {
-						reg = <1>;
-
-						lvds1_mux_1: endpoint {
-							remote-endpoint = <&ipu1_di1_lvds1>;
-						};
-					};
-				};
-			};
-
 			dcic1: dcic at 20e4000 {
 				reg = <0x020e4000 0x4000>;
 				interrupts = <0 124 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 3ea1a41..3365182 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -102,6 +102,21 @@
 		};
 	};
 
+	tempmon: tempmon {
+		compatible = "fsl,imx6q-tempmon";
+		interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gpc>;
+		fsl,tempmon = <&anatop>;
+		fsl,tempmon-data = <&ocotp>;
+		clocks = <&clks IMX6SL_CLK_PLL3_USB_OTG>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&gpc>;
+		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -125,11 +140,6 @@
 			arm,data-latency = <4 2 3>;
 		};
 
-		pmu {
-			compatible = "arm,cortex-a9-pmu";
-			interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		aips1: aips-bus at 2000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
@@ -615,14 +625,6 @@
 				};
 			};
 
-			tempmon: tempmon {
-				compatible = "fsl,imx6q-tempmon";
-				interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>;
-				fsl,tempmon = <&anatop>;
-				fsl,tempmon-data = <&ocotp>;
-				clocks = <&clks IMX6SL_CLK_PLL3_USB_OTG>;
-			};
-
 			usbphy1: usbphy at 20c9000 {
 				compatible = "fsl,imx6sl-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020c9000 0x1000>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 40c6738c..4500380 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -141,6 +141,22 @@
 		};
 	};
 
+	tempmon: tempmon {
+		compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
+		interrupt-parent = <&gpc>;
+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,tempmon = <&anatop>;
+		nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+		nvmem-cell-names = "calib", "temp_grade";
+		clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&gpc>;
+		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -148,11 +164,6 @@
 		interrupt-parent = <&gpc>;
 		ranges;
 
-		pmu {
-			compatible = "arm,cortex-a9-pmu";
-			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		ocram: sram at 900000 {
 			compatible = "mmio-sram";
 			reg = <0x00900000 0x20000>;
@@ -671,15 +682,6 @@
 				};
 			};
 
-			tempmon: tempmon {
-				compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
-				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-				fsl,tempmon = <&anatop>;
-				nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
-				nvmem-cell-names = "calib", "temp_grade";
-				clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
-			};
-
 			usbphy1: usbphy at 20c9000 {
 				compatible = "fsl,imx6sx-usbphy", "fsl,imx23-usbphy";
 				reg = <0x020c9000 0x1000>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index e0b4a46..0e931fd 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -136,6 +136,23 @@
 		clock-output-names = "ipp_di1";
 	};
 
+	tempmon: tempmon {
+		compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
+		interrupt-parent = <&gpc>;
+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		fsl,tempmon = <&anatop>;
+		nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+		nvmem-cell-names = "calib", "temp_grade";
+		clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupt-parent = <&gpc>;
+		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -143,12 +160,6 @@
 		interrupt-parent = <&gpc>;
 		ranges;
 
-		pmu {
-			compatible = "arm,cortex-a7-pmu";
-			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
 		ocram: sram at 900000 {
 			compatible = "mmio-sram";
 			reg = <0x00900000 0x20000>;
@@ -599,15 +610,6 @@
 				fsl,anatop = <&anatop>;
 			};
 
-			tempmon: tempmon {
-				compatible = "fsl,imx6ul-tempmon", "fsl,imx6sx-tempmon";
-				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
-				fsl,tempmon = <&anatop>;
-				nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
-				nvmem-cell-names = "calib", "temp_grade";
-				clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
-			};
-
 			snvs: snvs at 20cc000 {
 				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
 				reg = <0x020cc000 0x4000>;
-- 
2.7.4
