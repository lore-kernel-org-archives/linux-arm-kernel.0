From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 26 Nov 2018 16:45:54 -0200
Subject: [RFC 1/2] ARM: dts: imx6ul: Correct mask for GIC PPI interrupts
Message-ID: <1543257955-8910-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC_CPU_MASK_SIMPLE() macro should take as its argument the actual
number of CPU cores the interrupt controller is wired to.

i.MX6UL contains a single Cortex-A7, hence the second interrupt specifier
cell for Private Peripheral Interrupts should use "GIC_CPU_MASK_SIMPLE(1)".

Tested on a imx6ul-evk.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Hi,

This is based on the following commit:

commit 2acb79e15119512da9b6a49906840e7678cfb618
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Mon May 7 15:19:52 2018 +0200

    ARM: dts: r8a7790: Correct mask for GIC PPI interrupts
    
    R-Car H2 (r8a7790) contains four Cortex-A15 and four Cortex-A7 cores,
    hence the second interrupt specifier cell for Private Peripheral
    Interrupts should use "GIC_CPU_MASK_SIMPLE(8)", to make sure interrupts
    can be delivered to all 8 processor cores.
    
    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

and the confirmation from Liviu Dudau that GIC_CPU_MASK_SIMPLE()
should take the number of cores in the system as the argument:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315298.html

 arch/arm/boot/dts/imx6ul.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index c71d2d6..b8f5ef2 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -108,10 +108,10 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&intc>;
 		status = "disabled";
 	};
-- 
2.7.4
