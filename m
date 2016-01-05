From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  5 Jan 2016 09:59:30 +0100
Subject: [PATCH 2/2] ARM: versatile: fix MMC/SD interrupt assignment
Message-ID: <1451984370-16932-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0976c946a610d06e907335b7a3afa6db046f8e1b
"arm/versatile: Fix versatile irq specifications"
has an off-by-one error on the Versatile AB that has
been regressing the Versatile AB hardware for some time.

However it seems like the interrupt assignments have
never been correct and I have now adjusted them according
to the specification. The masks for the valid interrupts
made it impossible to assign the right SIC interrupt
for the MMCI, so I went in and fixed these to correspond
to the specifications, and added references if anyone
wants to double-check.

Due to the Versatile PB including the Versatile AB
as a base DTS file, we need to override and correct
some values to correspond to the actual changes in the
hardware.

For the Versatile PB I don't think the IRQ line
assignment for MMCI has ever been correct for either of
the two MMCI blocks. It would be nice if someone with the
physical PB board could test this.

Patch tested on the Versatile AB, QEMU for Versatile AB
and QEMU for Versatile PB.

Cc: Rob Herring <robh@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: stable at vger.kernel.org
Fixes: 0976c946a610 ("arm/versatile: Fix versatile irq specifications")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC people: please apply this directly for fixes if
you find it OK.
---
 arch/arm/boot/dts/versatile-ab.dts | 10 +++++++---
 arch/arm/boot/dts/versatile-pb.dts | 20 +++++++++++++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 01f40197ea13..3279bf1a17a1 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -110,7 +110,11 @@
 			interrupt-parent = <&vic>;
 			interrupts = <31>; /* Cascaded to vic */
 			clear-mask = <0xffffffff>;
-			valid-mask = <0xffc203f8>;
+			/*
+			 * Valid interrupt lines mask according to
+			 * table 4-36 page 4-50 of ARM DUI 0225D
+			 */
+			valid-mask = <0x0760031b>;
 		};
 
 		dma at 10130000 {
@@ -266,8 +270,8 @@
 			};
 			mmc at 5000 {
 				compatible = "arm,pl180", "arm,primecell";
-				reg = < 0x5000 0x1000>;
-				interrupts-extended = <&vic 22 &sic 2>;
+				reg = <0x5000 0x1000>;
+				interrupts-extended = <&vic 22 &sic 1>;
 				clocks = <&xtal24mhz>, <&pclk>;
 				clock-names = "mclk", "apb_pclk";
 			};
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index b83137f66034..33a8eb28374e 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -5,6 +5,16 @@
 	compatible = "arm,versatile-pb";
 
 	amba {
+		/* The Versatile PB is using more SIC IRQ lines than the AB */
+		sic: intc at 10003000 {
+			clear-mask = <0xffffffff>;
+			/*
+			 * Valid interrupt lines mask according to
+			 * figure 3-30 page 3-74 of ARM DUI 0224B
+			 */
+			valid-mask = <0x7fe003ff>;
+		};
+
 		gpio2: gpio at 101e6000 {
 			compatible = "arm,pl061", "arm,primecell";
 			reg = <0x101e6000 0x1000>;
@@ -67,6 +77,13 @@
 		};
 
 		fpga {
+			mmc at 5000 {
+				/*
+				 * Overrides the interrupt assignment from
+				 * the Versatile AB board file.
+				 */
+				interrupts-extended = <&sic 22 &sic 23>;
+			};
 			uart at 9000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0x9000 0x1000>;
@@ -86,7 +103,8 @@
 			mmc at b000 {
 				compatible = "arm,pl180", "arm,primecell";
 				reg = <0xb000 0x1000>;
-				interrupts-extended = <&vic 23 &sic 2>;
+				interrupt-parent = <&sic>;
+				interrupts = <1>, <2>;
 				clocks = <&xtal24mhz>, <&pclk>;
 				clock-names = "mclk", "apb_pclk";
 			};
-- 
2.4.3
