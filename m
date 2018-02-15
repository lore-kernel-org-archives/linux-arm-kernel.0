From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Feb 2018 17:56:02 +0100
Subject: [PATCH v3 2/5] arm64: dts: renesas: r8a77995: add VSP instances
In-Reply-To: <7db13491-f4f6-4c7c-e9e3-c1e91b0054b6@ideasonboard.com>
References: <1518602108-1724-1-git-send-email-kbingham@kernel.org>
 <1518602108-1724-3-git-send-email-kbingham@kernel.org>
 <20180215163342.4evihm3uts3lfu5c@verge.net.au>
 <7db13491-f4f6-4c7c-e9e3-c1e91b0054b6@ideasonboard.com>
Message-ID: <20180215165602.hkmwhwzt365ntton@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 04:41:58PM +0000, Kieran Bingham wrote:
> Hi Simon,
> 
> On 15/02/18 16:33, Simon Horman wrote:
> > On Wed, Feb 14, 2018 at 09:55:05AM +0000, Kieran Bingham wrote:
> >> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >>
> >> The r8a77995 has a VSPBS to support image processing such as blending of
> >> two input images, and has two VSPDs to handle display pipelines with a
> >> DU.
> >>
> >> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>
> >> ---
> >> v2:
> >>  - Fix VSPD register map size
> >>  - Squash VSPBS and VSPD patches together
> >>
> >> v3:
> >>  - Fix VSPBS register map size too :-)
> >>
> >>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 30 ++++++++++++++++++++++++++++++
> >>  1 file changed, 30 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> >> index 196a917afea6..0db242114bc5 100644
> >> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> >> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> >> @@ -692,6 +692,16 @@
> >>  			status = "disabled";
> >>  		};
> >>  
> >> +		vspbs: vsp at fe960000 {
> >> +			compatible = "renesas,vsp2";
> >> +			reg = <0 0xfe960000 0 0x8000>;
> >> +			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
> >> +			clocks = <&cpg CPG_MOD 627>;
> >> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> >> +			resets = <&cpg 627>;
> >> +			renesas,fcp = <&fcpvb0>;
> >> +		};
> >> +
> >>  		fcpvb0: fcp at fe96f000 {
> >>  			compatible = "renesas,fcpv";
> >>  			reg = <0 0xfe96f000 0 0x200>;
> >> @@ -701,6 +711,16 @@
> >>  			iommus = <&ipmmu_vp0 5>;
> >>  		};
> >>  
> >> +		vspd0: vsp at fea20000 {
> >> +			compatible = "renesas,vsp2";
> >> +			reg = <0 0xfea20000 0 0x8000>;
> >> +			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
> >> +			clocks = <&cpg CPG_MOD 623>;
> >> +			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> >> +			resets = <&cpg 623>;
> >> +			renesas,fcp = <&fcpvd0>;
> >> +		};
> >> +
> >>  		fcpvd0: fcp at fea27000 {
> >>  			compatible = "renesas,fcpv";
> >>  			reg = <0 0xfea27000 0 0x200>;
> >> @@ -710,6 +730,16 @@
> >>  			iommus = <&ipmmu_vi0 8>;
> >>  		};
> >>  
> >> +		vspd1: vsp at fea80000 {
> > 
> > The above should be:
> > 
> > 		vspd1: vsp at fea28000 {
> 
> Good spot.
> 
> </me looks to datasheet> That is correct.
> 
> Would you like me to resubmit this patch ? Or will you fix this up locally?

Thanks for confirming.

I noticed this using make dtbs W=1

I have fixed this up locally and applied your patch. The result is:


From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH] arm64: dts: renesas: r8a77995: add VSP instances

The r8a77995 has a VSPBS to support image processing such as blending of
two input images, and has two VSPDs to handle display pipelines with a
DU.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[simon: updated base address of vsp node to fea28000]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 196a917afea6..0db242114bc5 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -692,6 +692,16 @@
 			status = "disabled";
 		};
 
+		vspbs: vsp at fe960000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe960000 0 0x8000>;
+			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 627>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 627>;
+			renesas,fcp = <&fcpvb0>;
+		};
+
 		fcpvb0: fcp at fe96f000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe96f000 0 0x200>;
@@ -701,6 +711,16 @@
 			iommus = <&ipmmu_vp0 5>;
 		};
 
+		vspd0: vsp at fea20000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea20000 0 0x8000>;
+			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 623>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 623>;
+			renesas,fcp = <&fcpvd0>;
+		};
+
 		fcpvd0: fcp at fea27000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea27000 0 0x200>;
@@ -710,6 +730,16 @@
 			iommus = <&ipmmu_vi0 8>;
 		};
 
+		vspd1: vsp at fea80000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfea28000 0 0x8000>;
+			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 622>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 622>;
+			renesas,fcp = <&fcpvd1>;
+		};
+
 		fcpvd1: fcp at fea2f000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea2f000 0 0x200>;
-- 
2.11.0
