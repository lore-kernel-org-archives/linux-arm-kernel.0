From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 1 May 2015 15:43:29 +0800
Subject: [PATCH 6/7] ARM: dts: mt8135: enable basic SMP bringup for mt8135
In-Reply-To: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1430466210-22963-7-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add arch timer node to enable arch-timer support. MT8135 firmware
doesn't correctly setup arch-timer frequency and CNTVOFF, add
properties to workaround this.

This also set cpu enable-method to enable SMP.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 arch/arm/boot/dts/mt8135.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
index 612bd22..eb5e06f 100644
--- a/arch/arm/boot/dts/mt8135.dtsi
+++ b/arch/arm/boot/dts/mt8135.dtsi
@@ -46,6 +46,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "mediatek,mt81xx-tz-smp";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -103,6 +104,21 @@
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
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.8.1.1.dirty
