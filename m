From: horms@verge.net.au (Simon Horman)
Date: Wed, 23 May 2018 10:30:44 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add SMP support
In-Reply-To: <CAMuHMdWepA=YbjtVN2iw7uXrWu62LRx1ymix_AUgp6NrOTUgpw@mail.gmail.com>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <ec4c6905-23d1-8600-a1cc-4297fbd1ddaa@cogentembedded.com>
 <CAMuHMdU9JXvN2GLFGLZGeNOpZ9AdJYokbpTqt-Wy97-Z0tXaCA@mail.gmail.com>
 <ec73ce6d-f062-6c4f-d6fa-b99ef6c6bc67@cogentembedded.com>
 <20180522085430.eqhan4njajnp5hkk@verge.net.au>
 <CAMuHMdWepA=YbjtVN2iw7uXrWu62LRx1ymix_AUgp6NrOTUgpw@mail.gmail.com>
Message-ID: <20180523083041.v3c6rphtuyztwdgk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 11:49:36AM +0200, Geert Uytterhoeven wrote:
> On Tue, May 22, 2018 at 10:54 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Sat, May 19, 2018 at 08:38:13PM +0300, Sergei Shtylyov wrote:
> >> On 05/17/2018 11:23 PM, Geert Uytterhoeven wrote:
> >>
> >> >> Add the device nodes for 3 more Cortex-A53 CPU cores; adjust the interrupt
> >> >> delivery masks for the ARM GIC and Architectured Timer.
> >> >>
> >> >> Based on the original (and large) patch by Vladimir Barinov.
> >> >>
> >> >> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> >
> >> > Thanks for your patch!
> >> >
> >> >> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> >> >> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> >> >> @@ -30,6 +30,36 @@
> >> >>                         enable-method = "psci";
> >> >>                 };
> >> >>
> >> >> +               a53_1: cpu at 1 {
> >> >> +                       device_type = "cpu";
> >> >> +                       compatible = "arm,cortex-a53","arm,armv8";
> >> >
> >> > Please stop copying spaceless lists ;-)
> >>
> >>    Oops! Simon, do I need to re-post?
> >
> > No, but Geert, are you otherwise ok with this patch?
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have applied the following:

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] arm64: dts: renesas: r8a77980: add SMP support

Add the device nodes for 3 more Cortex-A53 CPU cores; adjust the interrupt
delivery masks for the ARM GIC and Architectured Timer.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: corrected whitespace]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 40 +++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 4c40f9f0ebc9..6d2b61d83caf 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -30,6 +30,36 @@
 			enable-method = "psci";
 		};
 
+		a53_1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <1>;
+			clocks = <&cpg CPG_CORE R8A77980_CLK_Z2>;
+			power-domains = <&sysc R8A77980_PD_CA53_CPU1>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <2>;
+			clocks = <&cpg CPG_CORE R8A77980_CLK_Z2>;
+			power-domains = <&sysc R8A77980_PD_CA53_CPU2>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
+		a53_3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <3>;
+			clocks = <&cpg CPG_CORE R8A77980_CLK_Z2>;
+			power-domains = <&sysc R8A77980_PD_CA53_CPU3>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
 		L2_CA53: cache-controller {
 			compatible = "cache";
 			power-domains = <&sysc R8A77980_PD_CA53_SCU>;
@@ -408,7 +438,7 @@
 			      <0x0 0xf1020000 0 0x20000>,
 			      <0x0 0xf1040000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x20000>;
-			interrupts = <GIC_PPI 9	(GIC_CPU_MASK_SIMPLE(1) |
+			interrupts = <GIC_PPI 9	(GIC_CPU_MASK_SIMPLE(4) |
 				      IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
@@ -424,13 +454,13 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
 				       IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
 				       IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) |
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
 				       IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) |
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
 				       IRQ_TYPE_LEVEL_LOW)>;
 	};
 };
-- 
2.11.0
