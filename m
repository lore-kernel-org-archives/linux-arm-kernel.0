From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 26 Aug 2016 19:12:49 +0800
Subject: [PATCH 1/3] ARM: dts: imx7: support SMP boot up
In-Reply-To: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1472209971-32469-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds GPC module, i.MX7 has a different
design of GPC module from i.MX6, so we call it GPCV2,
booting up secondary CPUs needs to access GPCV2
to enable secondary CPUs' power.

Also, adds "arm,cpu-registers-not-fw-configured"
property, interrupt parent and clock rate to
arch timer.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index bb7102c..e920436 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -299,10 +299,13 @@
 
 		timer {
 			compatible = "arm,armv7-timer";
+			arm,cpu-registers-not-fw-configured;
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			interrupt-parent = <&intc>;
+			clock-frequency = <8000000>;
 		};
 
 		aips1: aips-bus at 30000000 {
@@ -312,6 +315,11 @@
 			reg = <0x30000000 0x400000>;
 			ranges;
 
+			gpc: gpc at 303a0000 {
+				compatible = "fsl,imx7d-gpc";
+				reg = <0x303a0000 0x10000>;
+			};
+
 			gpio1: gpio at 30200000 {
 				compatible = "fsl,imx7d-gpio", "fsl,imx35-gpio";
 				reg = <0x30200000 0x10000>;
-- 
1.9.1
