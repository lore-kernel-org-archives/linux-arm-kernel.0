From: rjui@broadcom.com (Ray Jui)
Date: Fri, 18 Sep 2015 14:24:09 -0700
Subject: [PATCH v2 4/9] ARM: dts: Put Cygnus core components under core bus
In-Reply-To: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
References: <1442611454-16331-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442611454-16331-5-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put all Cygnus core components into "core" node of type "simple-bus" in
bcm-cygnus.dtsi

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 54 ++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 0a5898b..d4e2d04 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -58,6 +58,36 @@
 
 	/include/ "bcm-cygnus-clock.dtsi"
 
+	core {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		timer at 19020200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x19020200 0x100>;
+			interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&periph_clk>;
+		};
+
+		gic: interrupt-controller at 19021000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x19021000 0x1000>,
+			      <0x19020100 0x100>;
+		};
+
+		L2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0x19022000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+
 	pinctrl: pinctrl at 0x0301d0c8 {
 		compatible = "brcm,cygnus-pinmux";
 		reg = <0x0301d0c8 0x30>,
@@ -225,28 +255,4 @@
 
 		brcm,nand-has-wp;
 	};
-
-	gic: interrupt-controller at 19021000 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		interrupt-controller;
-		reg = <0x19021000 0x1000>,
-		      <0x19020100 0x100>;
-	};
-
-	L2: l2-cache {
-		compatible = "arm,pl310-cache";
-		reg = <0x19022000 0x1000>;
-		cache-unified;
-		cache-level = <2>;
-	};
-
-	timer at 19020200 {
-		compatible = "arm,cortex-a9-global-timer";
-		reg = <0x19020200 0x100>;
-		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&periph_clk>;
-	};
-
 };
-- 
1.9.1
