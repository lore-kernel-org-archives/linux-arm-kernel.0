From: gsi@denx.de (Gerhard Sittig)
Date: Tue,  6 Aug 2013 22:43:56 +0200
Subject: [PATCH v4 16/31] dts: mpc512x: add clock related device tree specs
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <1375821851-31609-17-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this addresses the clock driver aka provider's side of clocks
- prepare for future '<&clks ID>' phandle references for device tree
  based clock lookup in client drivers
- introduce a 'clocks' subtree with an 'osc' node for the crystal
  or oscillator SoC input (fixed frequency)
- provide default values with 33MHz oscillator frequency in the
  common include (the 66MHz IPS bus already was there), add
  override values for the ifm AC14xx board which deviates from
  the reference design (25MHz xtal, 80MHz IPS bus)

Reviewed-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/boot/dts/ac14xx.dts   |    7 +++++++
 arch/powerpc/boot/dts/mpc5121.dtsi |   15 ++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index a543c40..a1b8837 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -139,7 +139,14 @@
 		};
 	};
 
+	clocks {
+		osc {
+			clock-frequency = <25000000>;
+		};
+	};
+
 	soc at 80000000 {
+		bus-frequency = <80000000>;	/* 80 MHz ips bus */
 
 		clock at f00 {
 			compatible = "fsl,mpc5121rev2-clock", "fsl,mpc5121-clock";
diff --git a/arch/powerpc/boot/dts/mpc5121.dtsi b/arch/powerpc/boot/dts/mpc5121.dtsi
index bd14c00..8f4cba0 100644
--- a/arch/powerpc/boot/dts/mpc5121.dtsi
+++ b/arch/powerpc/boot/dts/mpc5121.dtsi
@@ -9,6 +9,8 @@
  * option) any later version.
  */
 
+#include <dt-bindings/clock/mpc512x-clock.h>
+
 /dts-v1/;
 
 / {
@@ -73,6 +75,16 @@
 		ranges = <0x0 0x0 0xfc000000 0x04000000>;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		osc {
+			compatible = "fsl,mpc512x-osc", "fixed-clock";
+			clock-frequency = <33000000>;
+		};
+	};
+
 	soc at 80000000 {
 		compatible = "fsl,mpc5121-immr";
 		#address-cells = <1>;
@@ -118,9 +130,10 @@
 		};
 
 		/* Clock control */
-		clock at f00 {
+		clks: clock at f00 {
 			compatible = "fsl,mpc5121-clock";
 			reg = <0xf00 0x100>;
+			#clock-cells = <1>;
 		};
 
 		/* Power Management Controller */
-- 
1.7.10.4
