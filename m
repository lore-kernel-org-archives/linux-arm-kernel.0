From: scott.shu@mediatek.com (Scott Shu)
Date: Thu, 18 Jun 2015 11:35:24 +0800
Subject: [PATCH 6/6] ARM: dts: mt6580: enable basic SMP bringup for mt6580
In-Reply-To: <1434598524-43846-1-git-send-email-scott.shu@mediatek.com>
References: <Scott Shu <srv_scott.shu@mediatek.com>
 <1434598524-43846-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1434598524-43846-7-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add arch timer node to enable arch-timer support. MT6580 firmware
doesn't correctly setup arch-timer frequency and CNTVOFF, add
properties to workaround this.

This set cpu enable-method to enable SMP.
---
 arch/arm/boot/dts/mt6580.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
index a974830..a7071b38 100644
--- a/arch/arm/boot/dts/mt6580.dtsi
+++ b/arch/arm/boot/dts/mt6580.dtsi
@@ -23,26 +23,31 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "mediatek,mt6580-smp";
 
 		cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x0>;
+			clock-frequency = <1700000000>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x1>;
+			clock-frequency = <1700000000>;
 		};
 		cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x2>;
+			clock-frequency = <1700000000>;
 		};
 		cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x3>;
+			clock-frequency = <1700000000>;
 		};
 
 	};
@@ -72,6 +77,21 @@
 		};
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <13000000>;
+		arm,cpu-registers-not-fw-configured;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.1.1.dirty
