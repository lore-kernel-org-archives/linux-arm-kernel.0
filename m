From: horms@verge.net.au (Simon Horman)
Date: Wed, 22 Aug 2018 12:00:07 +0200
Subject: [PATCH] arm64: dts: renesas: r8a77980: add CSI2/VIN support
In-Reply-To: <ea1ae505-d03a-6993-73f1-0ee2ad935c44@cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
 <758a8c87-272c-e861-4aab-01309cff2f84@cogentembedded.com>
 <20180809130854.65nvmnuuz6gffjjr@verge.net.au>
 <6032159b-ad2b-9a19-77f1-fc7a0ce3c5b0@cogentembedded.com>
 <20180817085109.ekvnhcuei5aexpx4@verge.net.au>
 <ea1ae505-d03a-6993-73f1-0ee2ad935c44@cogentembedded.com>
Message-ID: <20180822100007.hf7yhsxcemdtzp43@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2018 at 02:13:55PM +0300, Sergei Shtylyov wrote:
> On 08/17/2018 11:51 AM, Simon Horman wrote:
> 
> >>>> Describe the CSI2 and VIN (and their interconnections) in the R8A77980
> >>>> device tree.
> >>>>
> >>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>>>
> >>>> ---
> >>>> This patch is against the 'renesas-devel-20180802v2-v4.18-rc7' branch of
> >>>> Simon Horman's 'renesas.git' repo.
> >>>>
> >>>> The R8A77980 CSI2/VIN DT binding updates have been posted earlier today...
> >>>>
> >>>>  arch/arm64/boot/dts/renesas/r8a77980.dtsi |  374 ++++++++++++++++++++++++++++++
> >>>>  1 file changed, 374 insertions(+)
> >>>>
> >>>> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> >>>> ===================================================================
> >>>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> >>>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> [...]
> >>>> +		csi41: csi2 at feab0000 {
> >>>> +			compatible = "renesas,r8a77980-csi2";
> >>>> +			reg = <0 0xfeab0000 0 0x10000>;
> >>>> +			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
> >>>
> >>> The use of GIC_SPI 246 for both csi40 and csi41 seems suspicious.
> >>> Is this intentional?
> >>
> >>     No, must be copy/paste artefact... Sorry about that, it should be 241 instead.
> >>
> >>>> +			clocks = <&cpg CPG_MOD 716>;
> >>>
> >>> Should this clock be 715 rather than 716?
> >>
> >>    Yes, sure.
> >>
> >>    I'm seeing this patch merged despite your remarks. Please either fix it up or
> >> pull it out!
> > 
> > Oops, that was not intended.
> > 
> > I have fixed up the patch as you suggested.
> > The result is as follows:
> 
>    Still buggy... :-)
> 
> > From c703c196b847c654b392f027d3fa995e378792ac Mon Sep 17 00:00:00 2001
> > From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Date: Mon, 6 Aug 2018 22:55:00 +0300
> > Subject: [PATCH] arm64: dts: renesas: r8a77980: add CSI2/VIN support
> > 
> > Describe the CSI2 and VIN (and their interconnections) in the R8A77980
> > device tree.
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a77980.dtsi | 374 ++++++++++++++++++++++++++++++
> >  1 file changed, 374 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> > index 4bc99d6763ce..71636fd1a819 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> [...]
> > @@ -769,6 +1065,84 @@
> >  			resets = <&cpg 603>;
> >  		};
> >  
> > +		csi40: csi2 at feaa0000 {
> > +			compatible = "renesas,r8a77980-csi2";
> > +			reg = <0 0xfeaa0000 0 0x10000>;
> > +			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cpg CPG_MOD 716>;
> > +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> > +			resets = <&cpg 716>;
> > +			status = "disabled";
> > +
> > +			ports {
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				port at 1 {
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +
> > +					reg = <1>;
> > +
> > +					csi40vin0: endpoint at 0 {
> > +						reg = <0>;
> > +						remote-endpoint = <&vin0csi40>;
> > +					};
> > +					csi40vin1: endpoint at 1 {
> > +						reg = <1>;
> > +						remote-endpoint = <&vin1csi40>;
> > +					};
> > +					csi40vin2: endpoint at 2 {
> > +						reg = <2>;
> > +						remote-endpoint = <&vin2csi40>;
> > +					};
> > +					csi40vin3: endpoint at 3 {
> > +						reg = <3>;
> > +						remote-endpoint = <&vin3csi40>;
> > +					};
> > +				};
> > +			};
> > +		};
> > +
> > +		csi41: csi2 at feab0000 {
> > +			compatible = "renesas,r8a77980-csi2";
> > +			reg = <0 0xfeab0000 0 0x10000>;
> > +			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cpg CPG_MOD 715>;
> > +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> > +			resets = <&cpg 716>;
> 
>    You forgot to fix up this prop...

Thanks, I now have the following in my tree:

>From f3e8d4c1e3c3a826310a220d7373ac7c076e7120 Mon Sep 17 00:00:00 2001
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 6 Aug 2018 22:55:00 +0300
Subject: [PATCH] arm64: dts: renesas: r8a77980: add CSI2/VIN support

Describe the CSI2 and VIN (and their interconnections) in the R8A77980
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi | 374 ++++++++++++++++++++++++++++++
 1 file changed, 374 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index 4bc99d6763ce..c099053cf5fe 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -579,6 +579,302 @@
 			status = "disabled";
 		};
 
+		vin0: video at e6ef0000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef0000 0 0x1000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 811>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin0csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin0>;
+					};
+				};
+			};
+		};
+
+		vin1: video at e6ef1000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef1000 0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 810>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			status = "disabled";
+			resets = <&cpg 810>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin1csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin1>;
+					};
+				};
+			};
+		};
+
+		vin2: video at e6ef2000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef2000 0 0x1000>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 809>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 809>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin2csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin2>;
+					};
+				};
+			};
+		};
+
+		vin3: video at e6ef3000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef3000 0 0x1000>;
+			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 808>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 808>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin3csi40: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi40vin3>;
+					};
+				};
+			};
+		};
+
+		vin4: video at e6ef4000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef4000 0 0x1000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 807>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 807>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin4csi41: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi41vin4>;
+					};
+				};
+			};
+		};
+
+		vin5: video at e6ef5000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef5000 0 0x1000>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 806>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 806>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin5csi41: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi41vin5>;
+					};
+				};
+			};
+		};
+
+		vin6: video at e6ef6000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef6000 0 0x1000>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 805>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 805>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin6csi41: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi41vin6>;
+					};
+				};
+			};
+		};
+
+		vin7: video at e6ef7000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef7000 0 0x1000>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 804>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 804>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					vin7csi41: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint= <&csi41vin7>;
+					};
+				};
+			};
+		};
+
+		vin8: video at e6ef8000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef8000 0 0x1000>;
+			interrupts = <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 628>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 628>;
+			status = "disabled";
+		};
+
+		vin9: video at e6ef9000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6ef9000 0 0x1000>;
+			interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 627>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 627>;
+			status = "disabled";
+		};
+
+		vin10: video at e6efa000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6efa000 0 0x1000>;
+			interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 625>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 625>;
+			status = "disabled";
+		};
+
+		vin11: video at e6efb000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6efb000 0 0x1000>;
+			interrupts = <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 618>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 618>;
+			status = "disabled";
+		};
+
+		vin12: video at e6efc000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6efc000 0 0x1000>;
+			interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 612>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 612>;
+			status = "disabled";
+		};
+
+		vin13: video at e6efd000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6efd000 0 0x1000>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 608>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 608>;
+			status = "disabled";
+		};
+
+		vin14: video at e6efe000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6efe000 0 0x1000>;
+			interrupts = <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 605>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 605>;
+			status = "disabled";
+		};
+
+		vin15: video at e6eff000 {
+			compatible = "renesas,vin-r8a77980";
+			reg = <0 0xe6eff000 0 0x1000>;
+			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 604>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 604>;
+			status = "disabled";
+		};
+
 		dmac1: dma-controller at e7300000 {
 			compatible = "renesas,dmac-r8a77980",
 				     "renesas,rcar-dmac";
@@ -769,6 +1065,84 @@
 			resets = <&cpg 603>;
 		};
 
+		csi40: csi2 at feaa0000 {
+			compatible = "renesas,r8a77980-csi2";
+			reg = <0 0xfeaa0000 0 0x10000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 716>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 716>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					csi40vin0: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&vin0csi40>;
+					};
+					csi40vin1: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&vin1csi40>;
+					};
+					csi40vin2: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&vin2csi40>;
+					};
+					csi40vin3: endpoint at 3 {
+						reg = <3>;
+						remote-endpoint = <&vin3csi40>;
+					};
+				};
+			};
+		};
+
+		csi41: csi2 at feab0000 {
+			compatible = "renesas,r8a77980-csi2";
+			reg = <0 0xfeab0000 0 0x10000>;
+			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 715>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 715>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					reg = <1>;
+
+					csi41vin4: endpoint at 0 {
+						reg = <0>;
+						remote-endpoint = <&vin4csi41>;
+					};
+					csi41vin5: endpoint at 1 {
+						reg = <1>;
+						remote-endpoint = <&vin5csi41>;
+					};
+					csi41vin6: endpoint at 2 {
+						reg = <2>;
+						remote-endpoint = <&vin6csi41>;
+					};
+					csi41vin7: endpoint at 3 {
+						reg = <3>;
+						remote-endpoint = <&vin7csi41>;
+					};
+				};
+			};
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a77980",
 				     "renesas,du-r8a77970";
-- 
2.11.0

ATCH] ?
