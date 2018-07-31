From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 31 Jul 2018 16:43:53 +0800
Subject: [PATCH v1 1/2] arm64: dts: mt7622: add some misc device nodes
In-Reply-To: <2839886f07dc47afb9a05d06fb1acc84@mtkmbs08n1.mediatek.inc>
References: <2ff39c40ef6bc3054667e63c785a1d28527b5ddf.1531753039.git.ryder.lee@mediatek.com>
 <864955d5-26c4-a5f3-ec1a-420acba50880@gmail.com>
 <2839886f07dc47afb9a05d06fb1acc84@mtkmbs08n1.mediatek.inc>
Message-ID: <1533026633.10540.20.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Sorry for the late reply.

On Tue, 2018-07-31 at 16:17 +0800, Ryder Lee (???) wrote:
> Hi Ryder,
> 
> On 16/07/18 16:59, Ryder Lee wrote:
> > Add some misc nodes support - timer and ARM CCI-400.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 36 
> > ++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi 
> > b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > index 9213c96..8cdec52 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > @@ -217,6 +217,16 @@
> >  		#reset-cells = <1>;
> >  	};
> >  
> > +	timer: timer at 10004000 {
> > +		compatible = "mediatek,mt7622-timer",
> > +			     "mediatek,mt6577-timer";
> > +		reg = <0 0x10004000 0 0x80>;
> > +		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&infracfg CLK_INFRA_APXGPT_PD>,
> > +			 <&topckgen CLK_TOP_RTC>;
> > +		clock-names = "system-clk", "rtc-clk";
> > +	};
> > +
> >  	scpsys: scpsys at 10006000 {
> >  		compatible = "mediatek,mt7622-scpsys",
> >  			     "syscon";
> > @@ -317,6 +327,32 @@
> >  		      <0 0x10360000 0 0x2000>;
> >  	};
> >  
> > +	cci: cci at 10390000 {
> > +		compatible = "arm,cci-400";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		reg = <0 0x10390000 0 0x1000>;
> > +		ranges = <0 0 0x10390000 0x10000>;
> 
> From my understanding of the binding description ranges should hold child address, parent address and size of the region in the child address space. I can see in arch/arm64 two different variants using 4 ranges values (like here) and using three values.
> 
> @Rob + Will what is the preferred way to describe this?

Hmmm... it's just a copy-paste (I take zynqmp.dtsi as an example).
> > +
> > +		cci_control0: slave-if at 1000 {
> > +			compatible = "arm,cci-400-ctrl-if";
> > +			interface-type = "ace-lite";
> > +			reg = <0x1000 0x1000>;
> > +		};
> 
> Don't we need to add phandles to the cci-control-port property in the cpu nodes?
> 
> Regards,
> Matthias

MT7622 use cci-400 to improve performance (DMA IO coherence) for
high-speed IPs. (i.e., ETH/WIFI/SATA/...)

I added it early but actually the related features have not supported in
mainline yet.

Ryder
