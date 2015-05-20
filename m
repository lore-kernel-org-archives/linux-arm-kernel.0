From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Thu, 21 May 2015 02:52:41 +0800
Subject: [PATCH v2 2/2] ARM: dts: imx7d: added arch timer and gpc
In-Reply-To: <1432147961-3547-1-git-send-email-Frank.Li@freescale.com>
References: <1432147961-3547-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1432147961-3547-2-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

add cortex a7 arch timer and gpc to enable smp
uboot need clear virtual timer offset.
if not, need add "arm,cpu-registers-not-fw-configured"
in arch timer section to boot up.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index c42cf8d..0ccae67 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -74,6 +74,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "fsl,imx7d-smp";
 
 		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a7";
@@ -121,6 +122,15 @@
 		clock-output-names = "osc";
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupt-parent = <&intc>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -320,6 +330,12 @@
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc at 303a0000 {
+				compatible = "fsl,imx7d-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			};
 		};
 
 		aips3: aips-bus at 30800000 {
-- 
1.9.1
