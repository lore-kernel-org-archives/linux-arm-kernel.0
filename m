From: scott.shu@mediatek.com (Scott Shu)
Date: Tue, 4 Aug 2015 21:54:24 +0800
Subject: [PATCH v3 8/8] ARM: dts: mt6580: enable basic SMP bringup for MT6580
In-Reply-To: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
References: <1438696464-59858-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1438696464-59858-9-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add arch timer node to enable arch-timer support. MT6580 firmware
doesn't correctly setup arch-timer frequency and CNTVOFF, add
properties to workaround this.

This set cpu enable-method to enable SMP.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm/boot/dts/mt6580.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/mt6580.dtsi b/arch/arm/boot/dts/mt6580.dtsi
index 40957d3..70531b2 100644
--- a/arch/arm/boot/dts/mt6580.dtsi
+++ b/arch/arm/boot/dts/mt6580.dtsi
@@ -25,26 +25,31 @@
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
@@ -67,6 +72,21 @@
 		#clock-cells = <0>;
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <13000000>;
+		arm,cpu-registers-not-fw-configured;
+	};
+
 	scpsys: scpsys at 10006000 {
 		#power-domain-cells = <1>;
 		compatible = "mediatek,mt6580-scpsys";
-- 
1.7.9.5
