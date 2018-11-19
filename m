From: biao.huang@mediatek.com (biao huang)
Date: Mon, 19 Nov 2018 10:51:35 +0800
Subject: [v3, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
In-Reply-To: <20181117145611.GA26013@bogus>
References: <1542359926-28800-1-git-send-email-biao.huang@mediatek.com>
 <1542359926-28800-2-git-send-email-biao.huang@mediatek.com>
 <20181117145611.GA26013@bogus>
Message-ID: <1542595895.24219.28.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,
	Thanks for your comments.
On Sat, 2018-11-17 at 22:56 +0800, Rob Herring wrote:
> On Fri, Nov 16, 2018 at 05:18:46PM +0800, Biao Huang wrote:
> > The commit adds the device tree binding documentation for the MediaTek DWMAC
> > found on MediaTek MT2712.
> > 
> > Change-Id: I3728666bf65927164bd82fa8dddb90df8270bd44
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > ---
> >  .../devicetree/bindings/net/mediatek-dwmac.txt     |   77 ++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > new file mode 100644
> > index 0000000..7fd56e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > @@ -0,0 +1,77 @@
> > +MediaTek DWMAC glue layer controller
> > +
> > +This file documents platform glue layer for stmmac.
> > +Please see stmmac.txt for the other unchanged properties.
> > +
> > +The device node has following properties.
> > +
> > +Required properties:
> > +- compatible:  Should be "mediatek,mt2712-gmac" for MT2712 SoC
> > +- reg:  Address and length of the register set for the device
> > +- interrupts:  Should contain the MAC interrupts
> 
> How many?
> 
the common stmmac driver will parse interrupt-name "macirq",
so even only one interrupt is used in mediatek dwmac design,
the interrupt-names is still remained in device tree.
> > +- interrupt-names: Should contain a list of interrupt names corresponding to
> > +	the interrupts in the interrupts property, if available.
> > +	Should be "macirq" for the main MAC IRQ
> > +- clocks: Must contain a phandle for each entry in clock-names.
> > +- clock-names: The name of the clock listed in the clocks property. These are
> > +	"axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
> > +	for MT2712 SoC
> 
> Clocks should represent the physical clocks connected to a block. Parent 
> clocks are not in that category.
> 
Got it. assigned-clocks/assigned-clocks-parents properties can handle
it.
> > +- mac-address: See ethernet.txt in the same directory
> > +- phy-mode: See ethernet.txt in the same directory
> > +
> > +Optional properties:
> > +- tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> > +	It should be defined for rgmii/rgmii-rxid/mii interface.
> > +- rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> > +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> > +- fine-tune: This property will select coarse-tune delay or fine delay
> > +	for rgmii interface.
> > +	If fine-tune delay is enabled, tx-delay/rx-delay is 170+/-50ps
> > +	per stage.
> > +	Else coarse-tune delay is enabled, tx-delay/rx-delay is 0.55+/-0.2ns
> > +	per stage.
> > +	This property do not apply to non-rgmii PHYs.
> > +	Only coarse-tune delay is supported for mii/rmii PHYs.
> 
> Perhaps the delays should be in ps and the driver can figure out 
> fine-tune or not based on the value.
> 
the delay time in mediatek dwmac design is not so accurate, 
the current mt2712 and the following ICs will not use the same delay
design, but will use stages to indicate different delay time.
so, maybe "mediatek,tx-delay" represent the delay stage is a good
choice.
> > +- rmii-rxc: Reference clock of rmii is from external PHYs,
> > +	and it can be connected to TXC or RXC pin on MT2712 SoC.
> > +	If ref_clk <--> TXC, disable it.
> > +	Else ref_clk <--> RXC, enable it.
> > +- txc-inverse: Inverse tx clock for mii/rgmii.
> > +	Inverse tx clock inside MAC relative to reference clock for rmii,
> > +	and it rarely happen.
> > +- rxc-inverse: Inverse rx clock for mii/rgmii interfaces.
> > +	Inverse reference clock for rmii.
> 
> These should all have vendor prefixes. 'snps' if these are all standard 
> GMAC controls or 'mediatek' if Mediatek specific.
> 
Got it, will be modified in next version.
> > +
> > +Example:
> > +	eth: ethernet at 1101c000 {
> > +		compatible = "mediatek,mt2712-gmac";
> > +		reg = <0 0x1101c000 0 0x1300>;
> > +		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-names = "macirq";
> > +		phy-mode ="rgmii-id";
> > +		mac-address = [00 55 7b b5 7d f7];
> > +		clock-names = "axi",
> > +			      "apb",
> > +			      "mac_ext",
> > +			      "mac_parent",
> > +			      "ptp_ref",
> > +			      "ptp_parent",
> > +			      "ptp_top";
> > +		clocks = <&pericfg CLK_PERI_GMAC>,
> > +			 <&pericfg CLK_PERI_GMAC_PCLK>,
> > +			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
> > +			 <&topckgen CLK_TOP_ETHERPLL_125M>,
> > +			 <&topckgen CLK_TOP_ETHER_50M_SEL>,
> > +			 <&topckgen CLK_TOP_APLL1_D3>,
> > +			 <&topckgen CLK_TOP_APLL1>;
> > +		snps,txpbl = <32>;
> > +		snps,rxpbl = <32>;
> > +		snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
> > +		snps,reset-active-low;
> > +		tx-delay = <9>;
> > +		rx-delay = <9>;
> > +		fine-tune;
> > +		rmii-rxc;
> > +		txc-inverse;
> > +		rxc-inverse;
> > +	};
> > -- 
> > 1.7.9.5
> > 
