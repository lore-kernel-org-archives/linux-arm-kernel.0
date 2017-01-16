From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Mon, 16 Jan 2017 10:54:12 +0800
Subject: [PATCH v2 2/6] arm: dts: mt2701: Add iommu/smi device node
In-Reply-To: <02062506-f917-0140-4934-31d7d3317b80@gmail.com>
References: <1484296978-18572-1-git-send-email-erin.lo@mediatek.com>
 <1484296978-18572-3-git-send-email-erin.lo@mediatek.com>
 <02062506-f917-0140-4934-31d7d3317b80@gmail.com>
Message-ID: <1484535252.27576.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-01-13 at 16:05 +0100, Matthias Brugger wrote:
> Hi Erin,
> 
> I just took the patch from Honghui he send in june.
> Please see my comment inline.
> 
> On 13/01/17 09:42, Erin Lo wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> >
> > Add the device node of iommu and smi for MT2701.
> >
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> >  arch/arm/boot/dts/mt2701.dtsi | 54 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
> > index eb4c6fd..87be52c 100644
> > --- a/arch/arm/boot/dts/mt2701.dtsi
> > +++ b/arch/arm/boot/dts/mt2701.dtsi
> > @@ -17,6 +17,7 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/reset/mt2701-resets.h>
> > +#include <dt-bindings/memory/mt2701-larb-port.h>
> >  #include "skeleton64.dtsi"
> >  #include "mt2701-pinfunc.h"
> >
> > @@ -161,6 +162,16 @@
> >  		clock-names = "system-clk", "rtc-clk";
> >  	};
> >
> > +	smi_common: smi at 1000c000 {
> > +		compatible = "mediatek,mt2701-smi-common";
> > +		reg = <0 0x1000c000 0 0x1000>;
> > +		clocks = <&infracfg CLK_INFRA_SMI>,
> > +			 <&mmsys CLK_MM_SMI_COMMON>,
> > +			 <&infracfg CLK_INFRA_SMI>;
> > +		clock-names = "apb", "smi", "async";
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> > +	};
> > +
> >  	sysirq: interrupt-controller at 10200100 {
> >  		compatible = "mediatek,mt2701-sysirq",
> >  			     "mediatek,mt6577-sysirq";
> > @@ -170,6 +181,16 @@
> >  		reg = <0 0x10200100 0 0x1c>;
> >  	};
> >
> > +	iommu: mmsys_iommu at 10205000 {
> > +		compatible = "mediatek,mt2701-m4u";
> > +		reg = <0 0x10205000 0 0x1000>;
> > +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&infracfg CLK_INFRA_M4U>;
> > +		clock-names = "bclk";
> > +		mediatek,larbs = <&larb0 &larb1 &larb2>;
> > +		#iommu-cells = <1>;
> > +	};
> > +
> >  	apmixedsys: syscon at 10209000 {
> >  		compatible = "mediatek,mt2701-apmixedsys", "syscon";
> >  		reg = <0 0x10209000 0 0x1000>;
> > @@ -272,18 +293,51 @@
> >  		#clock-cells = <1>;
> >  	};
> >
> > +	larb0: larb at 14010000 {
> > +		compatible = "mediatek,mt2701-smi-larb";
> > +		reg = <0 0x14010000 0 0x1000>;
> > +		mediatek,smi = <&smi_common>;
> > +		mediatek,larbidx = <0>;
> 
> Did I miss something? 'mediatek,larbidx' does not sound familiar to me.
> 

Hi, Mathias,
	It's my mistake, we found a bug need this to fix in smi driver,
but I mix those patches together and make it un-clear.

	I will send new patch serial to add the 'mediatek,larbidx' later since
you have applied the last one.

thanks very much.

> Regards,
> Matthias
> 
> > +		clocks = <&mmsys CLK_MM_SMI_LARB0>,
> > +			 <&mmsys CLK_MM_SMI_LARB0>;
> > +		clock-names = "apb", "smi";
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> > +	};
> > +
> >  	imgsys: syscon at 15000000 {
> >  		compatible = "mediatek,mt2701-imgsys", "syscon";
> >  		reg = <0 0x15000000 0 0x1000>;
> >  		#clock-cells = <1>;
> >  	};
> >
> > +	larb2: larb at 15001000 {
> > +		compatible = "mediatek,mt2701-smi-larb";
> > +		reg = <0 0x15001000 0 0x1000>;
> > +		mediatek,smi = <&smi_common>;
> > +		mediatek,larbidx = <2>;
> > +		clocks = <&imgsys CLK_IMG_SMI_COMM>,
> > +			 <&imgsys CLK_IMG_SMI_COMM>;
> > +		clock-names = "apb", "smi";
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> > +	};
> > +
> >  	vdecsys: syscon at 16000000 {
> >  		compatible = "mediatek,mt2701-vdecsys", "syscon";
> >  		reg = <0 0x16000000 0 0x1000>;
> >  		#clock-cells = <1>;
> >  	};
> >
> > +	larb1: larb at 16010000 {
> > +		compatible = "mediatek,mt2701-smi-larb";
> > +		reg = <0 0x16010000 0 0x1000>;
> > +		mediatek,smi = <&smi_common>;
> > +		mediatek,larbidx = <1>;
> > +		clocks = <&vdecsys CLK_VDEC_CKGEN>,
> > +			 <&vdecsys CLK_VDEC_LARB>;
> > +		clock-names = "apb", "smi";
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
> > +	};
> > +
> >  	hifsys: syscon at 1a000000 {
> >  		compatible = "mediatek,mt2701-hifsys", "syscon";
> >  		reg = <0 0x1a000000 0 0x1000>;
> >
