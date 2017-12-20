From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Dec 2017 11:11:00 +0100
Subject: [PATCH v2 2/2] ARM: dts: r8a7743: move timer node out of bus
In-Reply-To: <CAMuHMdXtfMnSQ90GsDQtK0ApM0ijtV44rQFBC86mj2Aj0S_ArQ@mail.gmail.com>
References: <20171218214043.10796-1-horms+renesas@verge.net.au>
 <20171218214043.10796-3-horms+renesas@verge.net.au>
 <CAMuHMdXtfMnSQ90GsDQtK0ApM0ijtV44rQFBC86mj2Aj0S_ArQ@mail.gmail.com>
Message-ID: <20171220101059.kpe6bhd3mfcg6nr6@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 09:43:53AM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 18, 2017 at 10:40 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > The timer node does not have any register properties and thus shouldn't be
> > placed on the bus.
> >
> > This problem is flagged by the compiler as follows:
> > $ make
> >   DTC     arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
> > arch/arm/boot/dts/r8a7743-iwg20d-q7.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> > arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >   DTC     arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb
> > arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks. I took the liberty of updating the patch to also move the
thermal-zones node, which was added by another patch earlier today.

The result I have queued up is as follows:

From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] ARM: dts: r8a7743: move timer and thermal-zones nodes out of
 bus

The timer and thermal-zones nodes do not have any register properties and
thus shouldn't be placed on the bus.

This problem is flagged by the compiler as follows:
$ make
  DTC     arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
arch/arm/boot/dts/r8a7743-iwg20d-q7.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
arch/arm/boot/dts/r8a7743-iwg20d-q7.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
  DTC     arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb
arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7743.dtsi | 60 ++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index ecbd39e5f630..0b74c6c7d21d 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -316,38 +316,6 @@
 			#thermal-sensor-cells = <0>;
 		};
 
-		thermal-zones {
-			cpu_thermal: cpu-thermal {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-
-				thermal-sensors = <&thermal>;
-
-				trips {
-					cpu-crit {
-						temperature = <95000>;
-						hysteresis = <0>;
-						type = "critical";
-					};
-				};
-
-				cooling-maps {
-				};
-			};
-		};
-
-		timer {
-			compatible = "arm,armv7-timer";
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_LOW)>;
-		};
-
 		cmt0: timer at ffca0000 {
 			compatible = "renesas,r8a7743-cmt0",
 				     "renesas,rcar-gen2-cmt0";
@@ -1675,6 +1643,34 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu-crit {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
 	/* External USB clock - can be overridden by the board */
 	usb_extal_clk: usb_extal {
 		compatible = "fixed-clock";
-- 
2.11.0
