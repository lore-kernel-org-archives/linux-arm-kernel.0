From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 26 Sep 2018 10:38:18 +0800
Subject: [Resend PATCH 5/5] arm: dts: mt7623: add display subsystem
 related device nodes
In-Reply-To: <1537925879.20118.3.camel@mtksdaap41>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536155449.git.ryder.lee@mediatek.com>
 <7105c341de3525761ad4067ca57c641c7097f773.1536155449.git.ryder.lee@mediatek.com>
 <1537925879.20118.3.camel@mtksdaap41>
Message-ID: <1537929498.32631.16.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-09-26 at 09:37 +0800, CK Hu wrote:
> Hi, Ryder:
> 
> On Wed, 2018-09-05 at 22:09 +0800, Ryder Lee wrote:
> > Add display subsystem related device nodes for MT7623.
> > 
> > Cc: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> > I forgot to sort nodes in my previous mail. Sorry for the inconvenience.
> > 
> > This patch depends on the series: https://lkml.org/lkml/2018/9/5/223
> > 
> > @Matthias,
> > I know you're working on broken MMSYS - just want to ask whether it's possible
> > to let the patch to go to your tree (if others are okay with it), and send a
> > fixup one for MT7623 MMSYS later?
> > ---
> >  arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++++++++++
> >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  83 ++++++++++++
> >  arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  83 ++++++++++++
> >  3 files changed, 343 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> > index d01bdee..fdf9078 100644
> > --- a/arch/arm/boot/dts/mt7623.dtsi
> > +++ b/arch/arm/boot/dts/mt7623.dtsi
> > @@ -23,6 +23,11 @@
> >  	#address-cells = <2>;
> >  	#size-cells = <2>;
> >  
> > +	aliases {
> > +		rdma0 = &rdma0;
> > +		rdma1 = &rdma1;
> > +	};
> > +
> >  	cpu_opp_table: opp-table {
> >  		compatible = "operating-points-v2";
> >  		opp-shared;
> > @@ -311,6 +316,25 @@
> >  		clock-names = "spi", "wrap";
> >  	};
> >  
> > +	mipi_tx0: mipi-dphy at 10010000 {
> > +		compatible = "mediatek,mt7623-mipi-tx",
> > +			     "mediatek,mt2701-mipi-tx";
> > +		reg = <0 0x10010000 0 0x90>;
> > +		clocks = <&clk26m>;
> > +		clock-output-names = "mipi_tx0_pll";
> > +		#clock-cells = <0>;
> > +		#phy-cells = <0>;
> > +	};
> > +
> > +	cec: cec at 10012000 {
> > +		compatible = "mediatek,mt7623-cec",
> > +			     "mediatek,mt8173-cec";
> > +		reg = <0 0x10012000 0 0xbc>;
> > +		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&infracfg CLK_INFRA_CEC>;
> > +		status = "disabled";
> > +	};
> > +
> >  	cir: cir at 10013000 {
> >  		compatible = "mediatek,mt7623-cir";
> >  		reg = <0 0x10013000 0 0x1000>;
> > @@ -359,6 +383,18 @@
> >  		#clock-cells = <1>;
> >  	};
> >  
> > +	hdmi_phy: phy at 10209100 {
> > +		compatible = "mediatek,mt7623-hdmi-phy",
> > +			     "mediatek,mt2701-hdmi-phy";
> > +		reg = <0 0x10209100 0 0x24>;
> > +		clocks = <&apmixedsys CLK_APMIXED_HDMI_REF>;
> > +		clock-names = "pll_ref";
> > +		clock-output-names = "hdmitx_dig_cts";
> > +		#clock-cells = <0>;
> > +		#phy-cells = <0>;
> > +		status = "disabled";
> > +	};
> > +
> >  	rng: rng at 1020f000 {
> >  		compatible = "mediatek,mt7623-rng";
> >  		reg = <0 0x1020f000 0 0x1000>;
> > @@ -558,6 +594,16 @@
> >  		status = "disabled";
> >  	};
> >  
> > +	hdmiddc0: i2c at 11013000 {
> > +		compatible = "mediatek,mt7623-hdmi-ddc",
> > +			     "mediatek,mt8173-hdmi-ddc";
> > +		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_LOW>;
> > +		reg = <0 0x11013000 0 0x1C>;
> > +		clocks = <&pericfg CLK_PERI_I2C3>;
> > +		clock-names = "ddc-i2c";
> > +		status = "disabled";
> > +	};
> > +
> >  	nor_flash: spi at 11014000 {
> >  		compatible = "mediatek,mt7623-nor",
> >  			     "mediatek,mt8173-nor";
> > @@ -732,6 +778,84 @@
> >  		#clock-cells = <1>;
> >  	};
> >  
> > +	display_components: dispsys at 14000000 {
> > +		compatible = "mediatek,mt7623-mmsys",
> 
> Checkpatch warning:
> 
> WARNING: DT compatible string "mediatek,mt7623-mmsys" appears
> un-documented -- check ./Documentation/devicetree/bindings/
> #101: FILE: arch/arm/boot/dts/mt7623.dtsi:782:
> +               compatible = "mediatek,mt7623-mmsys",
> 
> 
> > +			     "mediatek,mt2701-mmsys";
> > +		reg = <0 0x14000000 0 0x1000>;
> > +		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
> > +	};
> > +
> > +	ovl at 14007000 {
> > +		compatible = "mediatek,mt7623-disp-ovl",
> 
> I think this is also un-documented, but I don't know why checkpatch does
> not show any warning.
> 
> Regards,
> CK
> > +			     "mediatek,mt2701-disp-ovl";
> > +		reg = <0 0x14007000 0 0x1000>;
> > +		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
> > +		clocks = <&mmsys CLK_MM_DISP_OVL>;
> > +		iommus = <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
> > +		mediatek,larb = <&larb0>;
> > +	};
> > +

I fallback to use the MT2701's compatible string here and there, but I
could add a new one for MT7623.

BTW, I've had this question for a long time - should I add a new
compatible for the very same IPs, or could we just use the old one in
DTS?

Ryder
