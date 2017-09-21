From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 21 Sep 2017 17:53:36 +0800
Subject: [PATCH v1 3/4] arm: dts: mt7623: add display related nodes
In-Reply-To: <1505869897.27600.6.camel@mtksdaap41>
References: <cover.1505801355.git.ryder.lee@mediatek.com>
 <0eb19ae1a4717d316cdaec44f6c20bfa8aa24ddc.1505801355.git.ryder.lee@mediatek.com>
 <1505869897.27600.6.camel@mtksdaap41>
Message-ID: <1505987616.3084.12.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Wed, 2017-09-20 at 09:11 +0800, CK Hu wrote:
> Hi, Ryder:
> 
> Mode comment inline.
> 
> On Tue, 2017-09-19 at 14:27 +0800, Ryder Lee wrote:
>  
> > +	smi_common: smi at 1000c000 {
> > +		compatible = "mediatek,mt7623-smi-common",
> > +			     "mediatek,mt2701-smi-common";
> > +		reg = <0 0x1000c000 0 0x1000>;
> > +		clocks = <&infracfg CLK_INFRA_SMI>,
> > +			 <&mmsys CLK_MM_SMI_COMMON>,
> > +			 <&infracfg CLK_INFRA_SMI>;
> > +		clock-names = "apb", "smi", "async";
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> > +	};
> > +

> > +	iommu: mmsys_iommu at 10205000 {
> > +		compatible = "mediatek,mt7623-m4u",
> > +			     "mediatek,mt2701-m4u";
> > +		reg = <0 0x10205000 0 0x1000>;
> > +		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&infracfg CLK_INFRA_M4U>;
> > +		clock-names = "bclk";
> > +		mediatek,larbs = <&larb0 &larb1 &larb2>;
> > +		#iommu-cells = <1>;
> > +	};
> > +
> > +	mmsys: syscon at 14000000 {
> > +		compatible = "mediatek,mt7623-mmsys",
> > +			     "mediatek,mt2701-mmsys",
> > +			     "syscon";
> > +		reg = <0 0x14000000 0 0x1000>;
> > +		#clock-cells = <1>;
> > +	};
> > +

> > +	larb0: larb at 14010000 {
> > +		compatible = "mediatek,mt7623-smi-larb",
> > +			     "mediatek,mt2701-smi-larb";
> > +		reg = <0 0x14010000 0 0x1000>;
> > +		mediatek,smi = <&smi_common>;
> > +		mediatek,larb-id = <0>;
> > +		clocks = <&mmsys CLK_MM_SMI_LARB0>,
> > +			 <&mmsys CLK_MM_SMI_LARB0>;
> > +		clock-names = "apb", "smi";
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> > +	};

> > +	imgsys: syscon at 15000000 {
> > +		compatible = "mediatek,mt7623-imgsys",
> > +			     "mediatek,mt2701-imgsys",
> > +			     "syscon";
> > +		reg = <0 0x15000000 0 0x1000>;
> > +		#clock-cells = <1>;
> > +	};
> > +
> > +	larb2: larb at 15001000 {
> > +		compatible = "mediatek,mt7623-smi-larb",
> > +			     "mediatek,mt2701-smi-larb";
> > +		reg = <0 0x15001000 0 0x1000>;
> > +		mediatek,smi = <&smi_common>;
> > +		mediatek,larb-id = <2>;
> > +		clocks = <&imgsys CLK_IMG_SMI_COMM>,
> > +			 <&imgsys CLK_IMG_SMI_COMM>;
> > +		clock-names = "apb", "smi";
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> > +	};
> > +
> > +	jpegdec: jpegdec at 15004000 {
> > +		compatible = "mediatek,mt7623-jpgdec",
> > +			     "mediatek,mt2701-jpgdec";
> > +		reg = <0 0x15004000 0 0x1000>;
> > +		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
> > +			  <&imgsys CLK_IMG_JPGDEC>;
> > +		clock-names = "jpgdec-smi",
> > +			      "jpgdec";
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
> > +		mediatek,larb = <&larb2>;
> > +		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
> > +			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
> > +	};
> 
> jpegdec and some other device node is not related to display. I think
> you should move them to another patch.

Yes, you're right.
> > +
> > +	vdecsys: syscon at 16000000 {
> > +		compatible = "mediatek,mt7623-vdecsys",
> > +			     "mediatek,mt2701-vdecsys",
> > +			     "syscon";
> > +		reg = <0 0x16000000 0 0x1000>;
> > +		#clock-cells = <1>;
> > +	};
> > +
> > +	larb1: larb at 16010000 {
> > +		compatible = "mediatek,mt7623-smi-larb",
> > +			     "mediatek,mt2701-smi-larb";
> > +		reg = <0 0x16010000 0 0x1000>;
> > +		mediatek,smi = <&smi_common>;
> > +		mediatek,larb-id = <1>;
> > +		clocks = <&vdecsys CLK_VDEC_CKGEN>,
> > +			 <&vdecsys CLK_VDEC_LARB>;
> > +		clock-names = "apb", "smi";
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
> > +	};
> > +
> >  	hifsys: syscon at 1a000000 {
> >  		compatible = "mediatek,mt7623-hifsys",
> >  			     "mediatek,mt2701-hifsys",
> > @@ -799,4 +1001,12 @@
> >  		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
> >  		status = "disabled";
> >  	};
> > +
> > +	bdpsys: syscon at 1c000000 {
> > +		compatible = "mediatek,mt7623-bdpsys",
> > +			     "mediatek,mt2701-bdpsys",
> > +			     "syscon";
> > +		reg = <0 0x1c000000 0 0x1000>;
> > +		#clock-cells = <1>;
> > +	};
> >  };

I will move these nodes to different patches.

> > diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > index 688a863..267a05a 100644
> > --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > @@ -17,6 +17,17 @@
> >  		serial2 = &uart2;
> >  	};
> >  
> > +	backlight_lcd: backlight_lcd {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&bls 0 100000>;
> > +		brightness-levels = <
> > +			  0  16  32  48  64  80  96 112
> > +			128 144 160 176 192 208 224 240
> > +			255
> > +		>;
> > +		default-brightness-level = <9>;
> > +	};
> > +
> 
> I think this patch only for mt7623 common dtsi modification. This part
> is just for bananapi-bpi-r2, so move non-common part to another patch.
> 
Okay.
