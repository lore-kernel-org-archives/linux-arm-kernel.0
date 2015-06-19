From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 18 Jun 2015 17:11:36 -0700
Subject: [PATCH 7/7] ARM: dts: brcmstb: add BCM7445 system PM DT nodes
In-Reply-To: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1434672696-13632-8-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need the aon_pm_l2_intc, aon-ctrl, waketimer, boot SRAM, and
memory_controller descriptions.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/arm/boot/dts/bcm7445.dtsi | 102 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
index 58dcd666257c..5b1aeaf5ac40 100644
--- a/arch/arm/boot/dts/bcm7445.dtsi
+++ b/arch/arm/boot/dts/bcm7445.dtsi
@@ -119,6 +119,30 @@
 			interrupt-names = "hif";
 		};
 
+		aon_pm_l2_intc: interrupt-controller at 410640 {
+			compatible = "brcm,l2-intc";
+			reg = <0x410640 0x30>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupts = <GIC_SPI 0x40 0x0>;
+			interrupt-parent = <&gic>;
+			brcm,irq-can-wake;
+		};
+
+		aon-ctrl at 410000 {
+			compatible = "brcm,brcmstb-aon-ctrl";
+			reg = <0x410000 0x200>, <0x410200 0x400>;
+			reg-names = "aon-ctrl", "aon-sram";
+		};
+
+		waketimer at f0417580 {
+			compatible = "brcm,brcmstb-waketimer";
+			reg = <0x417580 0x14>;
+			interrupt-parent = <&aon_pm_l2_intc>;
+			interrupts = <3>;
+			interrupt-names = "timer";
+		};
+
 		nand: nand at 3e2800 {
 			status = "disabled";
 			#address-cells = <1>;
@@ -169,6 +193,84 @@
 		};
 	};
 
+	memory_controllers {
+		compatible = "simple-bus";
+		ranges = <0x0 0x0 0xf1100000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		memc at 0 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x80000>;
+
+			memc-ddr at 2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x800>;
+			};
+
+			ddr-phy at 6000 {
+				compatible = "brcm,brcmstb-ddr-phy-v240.1";
+				reg = <0x6000 0x21c>;
+				};
+
+			shimphy at 8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy-v1.0";
+				reg = <0x8000 0xe4>;
+			};
+		};
+
+		memc at 1 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x80000 0x80000>;
+
+			memc-ddr at 2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x800>;
+			};
+
+			ddr-phy at 6000 {
+				compatible = "brcm,brcmstb-ddr-phy-v240.1";
+				reg = <0x6000 0x21c>;
+			};
+
+			shimphy at 8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy-v1.0";
+				reg = <0x8000 0xe4>;
+			};
+		};
+
+		memc at 2 {
+			compatible = "brcm,brcmstb-memc", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x100000 0x80000>;
+
+			memc-ddr at 2000 {
+				compatible = "brcm,brcmstb-memc-ddr";
+				reg = <0x2000 0x800>;
+			};
+
+			ddr-phy at 6000 {
+				compatible = "brcm,brcmstb-ddr-phy-v240.1";
+				reg = <0x6000 0x21c>;
+			};
+
+			shimphy at 8000 {
+				compatible = "brcm,brcmstb-ddr-shimphy-v1.0";
+				reg = <0x8000 0xe4>;
+			};
+		};
+	};
+
+	sram at ffe00000 {
+		compatible = "brcm,boot-sram", "mmio-sram";
+		reg = <0x0 0xffe00000 0x0 0x10000>;
+	};
+
 	smpboot {
 		compatible = "brcm,brcmstb-smpboot";
 		syscon-cpu = <&hif_cpubiuctrl 0x88 0x178>;
-- 
1.9.1
