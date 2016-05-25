From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 25 May 2016 09:32:15 +0200
Subject: [PATCH v3 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <c0fd13d5-c5c4-579b-6fad-c637bda92398@de.bosch.com>
References: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
 <1464054880-25843-2-git-send-email-horms+renesas@verge.net.au>
 <b30c9c84-23b6-b088-4983-b2498317492b@de.bosch.com>
 <20160525004825.GC7292@verge.net.au>
 <c0fd13d5-c5c4-579b-6fad-c637bda92398@de.bosch.com>
Message-ID: <edee7345-280a-0d7c-7e5a-798215fbd2b9@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.05.2016 07:10, Dirk Behme wrote:
> Hi Simon,
>
> On 25.05.2016 02:48, Simon Horman wrote:
>> Hi Dirk,
>>
>> On Tue, May 24, 2016 at 07:30:17AM +0200, Dirk Behme wrote:
>>> Hi Simon,
>>
>> [...]
>>
>>> With Renesas R-Car3 we will get a whole family of SoCs. I.e. different
>>> computing power (e.g. different number of Cores) with more or less
>>> similar
>>> peripherals.
>>>
>>> I would think that we want to reflect this in the device tree, too.
>>> Therefore I think what we want is a hierarchy of device trees. Similar
>>> what's done with other SoC families (compare e.g. i.MX6).
>>>
>>> E.g. we want an initial rcar3.dtsi, which contains all common parts
>>> of all
>>> R-Car3 SoCs. E.g. one CA57 core, the SCIF where its common etc.
>>>
>>> Then you will have the r8a779x.dtsi which includes the rcar3.dtsi and
>>> extends it for SoC specific parts. Which then will be included by the
>>> board
>>> device trees, as already done, now.
>>>
>>> Or in other words: As soon as you have similar parts in the
>>> r8a779x.dtsi's,
>>> it's time to think about moving the parts one hierarchy level up into
>>> the
>>> rcar3.dtsi. Else you will end up in a maintenance hell once you have to
>>> change/fix anything.
>>
>> Thanks for raising this issue.
>>
>> I agree entirely that we should work towards a situation where
>> maintenance
>> is as easy as it can be. However, due to the per-SoC binding scheme that
>> we are using for IP related to Renesas SoCs I suspect that very few DT
>> nodes
>> can be shared between SoCs verbatim.
>
>
> Could you kindly share an example for this? Looking into the H3 and the
> M3-W manual, it looks to me that ~90% (?) of the peripherals are the same.
>
>
>> Probably some sort of scheme can be cooked up using preprocessor macros.
>> And probably there are other ways to resolve this problem. But I would
>> prefer if we worked towards resolving this maintenance problem in
>> parallel
>> with rather than as a dependency of merging r8a7796 support into
>> mainline.
>
>
> I'd propose to do it correct from the beginning.
>
> Doing it later would either be more work or forgotten, and never be
> done, then.
>
> For a starting point, I'd propose to put the r8a7795.dtsi and
> r8a7796.dtsi into a graphical diff tool and move all common parts to a
> rcar3.dtsi (I'd be happy to discuss the name, though)


To give an example what I'm talking about kindly have a look to the 
attached (draft) patch.

Best regards

Dirk

P.S.: This also results in the question why we need similar 
r8a7795-cpg-mssr.h and r8a7796-cpg-mssr.h with just different "numbers" 
for the same clocks. Can't we use the same numbers on all SoCs, with 
just having wholes in the list where the clocks don't exist on a SoC? I 
haven't looked into the manual if these numbers are given by the 
hardware, though.

-------------- next part --------------
>From 08078bf12780176ab116fe5f39a378f5ee374ae3 Mon Sep 17 00:00:00 2001
From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Wed, 25 May 2016 09:23:58 +0200
Subject: [PATCH] arm64: dts: Renesas R-Car3: Introduce common rcar3.dtsi

The R-Car3 SoC family will contain several similar SoCs, sharing
several peripherals.

Introduce a common rcar3.dtsi containing the common parts of all
R-Car3 family SoCs.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 109 ++----------------------------
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 109 ++----------------------------
 arch/arm64/boot/dts/renesas/rcar3.dtsi   | 112 +++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 205 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rcar3.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a7315eb..0737ed2 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -10,11 +10,10 @@
 
 #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "rcar3.dtsi"
 
 / {
 	compatible = "renesas,r8a7795";
-	#address-cells = <2>;
-	#size-cells = <2>;
 
 	aliases {
 		i2c0 = &i2c0;
@@ -26,23 +25,7 @@
 		i2c6 = &i2c6;
 	};
 
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
 	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		a57_0: cpu at 0 {
-			compatible = "arm,cortex-a57", "arm,armv8";
-			reg = <0x0>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA57>;
-			enable-method = "psci";
-		};
-
 		a57_1: cpu at 1 {
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x1>;
@@ -66,32 +49,12 @@
 		};
 	};
 
-	L2_CA57: cache-controller at 0 {
-		compatible = "cache";
-		cache-unified;
-		cache-level = <2>;
-	};
-
 	L2_CA53: cache-controller at 1 {
 		compatible = "cache";
 		cache-unified;
 		cache-level = <2>;
 	};
 
-	extal_clk: extal {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board */
-		clock-frequency = <0>;
-	};
-
-	extalr_clk: extalr {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board */
-		clock-frequency = <0>;
-	};
-
 	/*
 	 * The external audio clocks are configured as 0 Hz fixed frequency
 	 * clocks by default.
@@ -115,35 +78,7 @@
 		clock-frequency = <0>;
 	};
 
-	/* External SCIF clock - to be overridden by boards that provide it */
-	scif_clk: scif {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-		status = "disabled";
-	};
-
 	soc {
-		compatible = "simple-bus";
-		interrupt-parent = <&gic>;
-
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		gic: interrupt-controller at 0xf1010000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x0 0xf1010000 0 0x1000>,
-			      <0x0 0xf1020000 0 0x2000>,
-			      <0x0 0xf1040000 0 0x20000>,
-			      <0x0 0xf1060000 0 0x2000>;
-			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-		};
-
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7795",
 				     "renesas,gpio-rcar";
@@ -268,27 +203,6 @@
 					     <&a57_3>;
 		};
 
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-		};
-
-		cpg: clock-controller at e6150000 {
-			compatible = "renesas,r8a7795-cpg-mssr";
-			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>, <&extalr_clk>;
-			clock-names = "extal", "extalr";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-		};
-
 		audma0: dma-controller at ec700000 {
 			compatible = "renesas,rcar-dmac";
 			reg = <0 0xec700000 0 0x10000>;
@@ -625,21 +539,6 @@
 			status = "disabled";
 		};
 
-		scif2: serial at e6e88000 {
-			compatible = "renesas,scif-r8a7795",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6e88000 0 64>;
-			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 310>,
-				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
-			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		scif3: serial at e6c50000 {
 			compatible = "renesas,scif-r8a7795",
 				     "renesas,rcar-gen3-scif", "renesas,scif";
@@ -1120,3 +1019,9 @@
 		};
 	};
 };
+
+&scif2 {
+	clocks = <&cpg CPG_MOD 310>,
+		 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+		 <&scif_clk>;
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 178debf..3e480d9 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -10,111 +10,14 @@
 
 #include <dt-bindings/clock/r8a7796-cpg-mssr.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "rcar3.dtsi"
 
 / {
 	compatible = "renesas,r8a7796";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	psci {
-		compatible = "arm,psci-0.2";
-		method = "smc";
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* 1 core only at this point */
-		a57_0: cpu at 0 {
-			compatible = "arm,cortex-a57", "arm,armv8";
-			reg = <0x0>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA57>;
-			enable-method = "psci";
-		};
-
-		L2_CA57: cache-controller at 0 {
-			compatible = "cache";
-			reg = <0>;
-			cache-unified;
-			cache-level = <2>;
-		};
-	};
-
-	extal_clk: extal {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board */
-		clock-frequency = <0>;
-	};
-
-	extalr_clk: extalr {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* This value must be overridden by the board */
-		clock-frequency = <0>;
-	};
-
-	/* External SCIF clock - to be overridden by boards that provide it */
-	scif_clk: scif {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		interrupt-parent = <&gic>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		gic: interrupt-controller at f1010000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x0 0xf1010000 0 0x1000>,
-			      <0x0 0xf1020000 0 0x20000>,
-			      <0x0 0xf1040000 0 0x20000>,
-			      <0x0 0xf1060000 0 0x20000>;
-			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
-		};
-
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 13
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-		};
-
-		cpg: clock-controller at e6150000 {
-			compatible = "renesas,r8a7796-cpg-mssr";
-			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>, <&extalr_clk>;
-			clock-names = "extal", "extalr";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-		};
+};
 
-		scif2: serial at e6e88000 {
-			compatible = "renesas,scif-r8a7796",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6e88000 0 64>;
-			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 310>,
-				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-	};
+&scif2 {
+	clocks = <&cpg CPG_MOD 310>,
+		 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
+		 <&scif_clk>;
 };
diff --git a/arch/arm64/boot/dts/renesas/rcar3.dtsi b/arch/arm64/boot/dts/renesas/rcar3.dtsi
new file mode 100644
index 0000000..c02c8e4
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rcar3.dtsi
@@ -0,0 +1,112 @@
+/*
+ * Device Tree Source for the R-Car3 SoC family
+ *
+ * Copyright (C) 2015-2016 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		a57_0: cpu at 0 {
+			compatible = "arm,cortex-a57", "arm,armv8";
+			reg = <0x0>;
+			device_type = "cpu";
+			next-level-cache = <&L2_CA57>;
+			enable-method = "psci";
+		};
+	};
+
+	L2_CA57: cache-controller at 0 {
+		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	extalr_clk: extalr {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		status = "disabled";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller at f1010000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xf1010000 0 0x1000>,
+			      <0x0 0xf1020000 0 0x20000>,
+			      <0x0 0xf1040000 0 0x20000>,
+			      <0x0 0xf1060000 0 0x20000>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 13
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7795-cpg-mssr", "renesas,r8a7796-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&extalr_clk>;
+			clock-names = "extal", "extalr";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+		};
+
+		scif2: serial at e6e88000 {
+			compatible = "renesas,scif-r8a7795", "renesas,scif-r8a7796",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.8.0
