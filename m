From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Wed, 1 Apr 2015 17:17:34 +0530
Subject: [RESEND PATCH 4/8] layerscape/ftm: Add compatible string for FTM0 be
 used as alarm timer.
In-Reply-To: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1427888858-29636-5-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Only FTM0 can be used as an alarm timer, so add a "fsl,ftm-alarm"
compatible string to describe FTM0 alarm mode.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 .../devicetree/bindings/timer/fsl,ftm-timer.txt    |   46 ++++++++++++++------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
index aa8c402..a372ed7 100644
--- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
+++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.txt
@@ -2,12 +2,18 @@ Freescale FlexTimer Module (FTM) Timer
 
 Required properties:
 
-- compatible : should be "fsl,ftm-timer"
+- compatible : should be "fsl,ftm-timer" & "fsl,ftm-alarm".
+  (a) "fsl,ftm-timer", for FlexTimer compatible as normal timer.
+  (b) "fsl,ftm-alarm", for FlexTimer compatible when FTM0 as an ALARM timer.
+
 - reg : Specifies base physical address and size of the register sets for the
   clock event device and clock source device.
+
 - interrupts : Should be the clock event device interrupt.
+
 - clocks : The clocks provided by the SoC to drive the timer, must contain an
   entry for each entry in clock-names.
+
 - clock-names : Must include the following entries:
   o "ftm-evt"
   o "ftm-src"
@@ -16,16 +22,28 @@ Required properties:
 - big-endian: One boolean property, the big endian mode will be in use if it is
   present, or the little endian mode will be in use for all the device registers.
 
-Example:
-ftm: ftm at 400b8000 {
-	compatible = "fsl,ftm-timer";
-	reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
-	interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
-	clock-names = "ftm-evt", "ftm-src",
-		"ftm-evt-counter-en", "ftm-src-counter-en";
-	clocks = <&clks VF610_CLK_FTM2>,
-		<&clks VF610_CLK_FTM3>,
-		<&clks VF610_CLK_FTM2_EXT_FIX_EN>,
-		<&clks VF610_CLK_FTM3_EXT_FIX_EN>;
-	big-endian;
-};
+Example 1: In this example, The FlexTimer module (FTM) is a two-to-eight,
+	   channel timer that supports input capture, output compare, and
+	   the generation of PWM signals to control electric motor and power
+	   management applications.
+
+	ftm: ftm at 400b8000 {
+		compatible = "fsl,ftm-timer";
+		reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
+		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "ftm-evt", "ftm-src",
+			"ftm-evt-counter-en", "ftm-src-counter-en";
+		clocks = <&clks VF610_CLK_FTM2>,
+			<&clks VF610_CLK_FTM3>,
+			<&clks VF610_CLK_FTM2_EXT_FIX_EN>,
+			<&clks VF610_CLK_FTM3_EXT_FIX_EN>;
+		big-endian;
+	};
+
+Example 2: In this example, FTM0 only be used as an alarm timer.
+
+	ftm0: ftm0 at 2800000 {
+		compatible = "fsl,ftm-alarm";
+		reg = <0x0 0x2800000 0x0 0x10000>;
+		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.7.9.5
