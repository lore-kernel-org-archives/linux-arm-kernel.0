From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Nov 2018 08:16:25 -0800
Subject: [PATCH 4/4] ARM: dts: am335x: Move l4 child devices to probe
 them with ti-sysc
In-Reply-To: <612b09a4-5007-39bf-becb-66fdca9d6d41@ti.com>
References: <20180925000545.22931-1-tony@atomide.com>
 <20180925000545.22931-5-tony@atomide.com>
 <612b09a4-5007-39bf-becb-66fdca9d6d41@ti.com>
Message-ID: <20181127161625.GR53235@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181127 13:01]:
> Reverting this patch in linux-next makes audio working again on am335x
> (bb white + audio cape) :o
> 
> Without revert the McASP FIFO would constantly underflow.

Thanks for testing. Hmm the dts change looks right. And
am3_l3s_clkctrl_regs[] has CLKF_SW_SUP for the mcasp fcks.
And there are no opt clocks to enable according to the TRM.

> Memcpy test via dmatest works with EDMA

OK. Can you please test if the following partial revert
also works or is there maybe a dependency to some other
device?

Regards,

Tony

8< ------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 27 Nov 2018 08:11:48 -0800
Subject: [PATCH] ARM: dts: Revert am335x mcasp ti-sysc changes

Without this McASP FIFO would constantly underflow. EDMA
test via dmatest works though.

Let's revert the change for now until we know the root cause.

Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 28 ++--------------------------
 arch/arm/boot/dts/am33xx.dtsi    | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1056,19 +1056,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x38000 0x2000>;
-
-			mcasp0: mcasp at 0 {
-				compatible = "ti,am33xx-mcasp-audio";
-				reg = <0x0 0x2000>,
-				      <0x46000000 0x400000>;
-				reg-names = "mpu", "dat";
-				interrupts = <80>, <81>;
-				interrupt-names = "tx", "rx";
-				status = "disabled";
-				dmas = <&edma 8 2>,
-					<&edma 9 2>;
-				dma-names = "tx", "rx";
-			};
+			status = "disabled";
 		};
 
 		target-module at 3c000 {			/* 0x4803c000, ap 20 32.0 */
@@ -1086,19 +1074,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x3c000 0x2000>;
-
-			mcasp1: mcasp at 0 {
-				compatible = "ti,am33xx-mcasp-audio";
-				reg = <0x0 0x2000>,
-				      <0x46400000 0x400000>;
-				reg-names = "mpu", "dat";
-				interrupts = <82>, <83>;
-				interrupt-names = "tx", "rx";
-				status = "disabled";
-				dmas = <&edma 10 2>,
-					<&edma 11 2>;
-				dma-names = "tx", "rx";
-			};
+			status = "disabled";
 		};
 
 		target-module at 40000 {			/* 0x48040000, ap 22 1e.0 */
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -440,7 +440,36 @@
 			       <&edma 5 0>;
 			dma-names = "tx", "rx";
 		};
+
+		mcasp0: mcasp at 48038000 {
+			compatible = "ti,am33xx-mcasp-audio";
+			ti,hwmods = "mcasp0";
+			reg = <0x48038000 0x2000>,
+			      <0x46000000 0x400000>;
+			reg-names = "mpu", "dat";
+			interrupts = <80>, <81>;
+			interrupt-names = "tx", "rx";
+			status = "disabled";
+			dmas = <&edma 8 2>,
+				<&edma 9 2>;
+			dma-names = "tx", "rx";
+		};
+
+		mcasp1: mcasp at 4803c000 {
+			compatible = "ti,am33xx-mcasp-audio";
+			ti,hwmods = "mcasp1";
+			reg = <0x4803C000 0x2000>,
+			      <0x46400000 0x400000>;
+			reg-names = "mpu", "dat";
+			interrupts = <82>, <83>;
+			interrupt-names = "tx", "rx";
+			status = "disabled";
+			dmas = <&edma 10 2>,
+				<&edma 11 2>;
+			dma-names = "tx", "rx";
+		};
 	};
+
 };
 
 #include "am33xx-l4.dtsi"
-- 
2.19.1
