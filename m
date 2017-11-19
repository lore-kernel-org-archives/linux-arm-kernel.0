From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 19 Nov 2017 18:00:27 +0100
Subject: [PATCH RFC] ARM: dts: bcm283x: Fix probing of bcm2835-i2s
Message-ID: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
the bcm2835-i2s requires a clock as DT property. Unfortunately
the necessary DT change has never been applied. While we are at it
also fix the first PCM register range to cover the PCM_GRAY register.

This patch also fixes the dt-bindings accordlingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 4 ++--
 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt | 9 ++++-----
 arch/arm/boot/dts/bcm283x.dtsi                               | 4 ++--
 3 files changed, 8 insertions(+), 9 deletions(-)

Hi, this is only probe tested with a RPi 1B. I don't have the sound hardware
to test the drivers function.

diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
index baf9b34..b6a8cc0 100644
--- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
+++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
@@ -74,8 +74,8 @@ Example:
 
 bcm2835_i2s: i2s at 7e203000 {
 	compatible = "brcm,bcm2835-i2s";
-	reg = <	0x7e203000 0x20>,
-	      < 0x7e101098 0x02>;
+	reg = <	0x7e203000 0x24>;
+	clocks = <&clocks BCM2835_CLOCK_PCM>;
 
 	dmas = <&dma 2>,
 	       <&dma 3>;
diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
index 65783de..7bb0362 100644
--- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
@@ -2,9 +2,8 @@
 
 Required properties:
 - compatible: "brcm,bcm2835-i2s"
-- reg: A list of base address and size entries:
-	* The first entry should cover the PCM registers
-	* The second entry should cover the PCM clock registers
+- reg: Should contain PCM registers location and length.
+- clocks: the (PCM) clock to use
 - dmas: List of DMA controller phandle and DMA request line ordered pairs.
 - dma-names: Identifier string for each DMA request line in the dmas property.
   These strings correspond 1:1 with the ordered pairs in dmas.
@@ -16,8 +15,8 @@ Example:
 
 bcm2835_i2s: i2s at 7e203000 {
 	compatible = "brcm,bcm2835-i2s";
-	reg = <0x7e203000 0x20>,
-	      <0x7e101098 0x02>;
+	reg = <0x7e203000 0x24>;
+	clocks = <&clocks BCM2835_CLOCK_PCM>;
 
 	dmas = <&dma 2>,
 	       <&dma 3>;
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 431dcfc..01733a9 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -391,8 +391,8 @@
 
 		i2s: i2s at 7e203000 {
 			compatible = "brcm,bcm2835-i2s";
-			reg = <0x7e203000 0x20>,
-			      <0x7e101098 0x02>;
+			reg = <0x7e203000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_PCM>;
 
 			dmas = <&dma 2>,
 			       <&dma 3>;
-- 
2.7.4
