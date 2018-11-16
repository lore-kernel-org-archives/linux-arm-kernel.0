From: biao.huang@mediatek.com (biao huang)
Date: Fri, 16 Nov 2018 14:58:07 +0800
Subject: [PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
In-Reply-To: <20181112162204.GA8910@bogus>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
 <1540782294-27721-3-git-send-email-biao.huang@mediatek.com>
 <20181112162204.GA8910@bogus>
Message-ID: <1542351487.26982.28.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob,

Thanks for your comments.

On Mon, 2018-11-12 at 10:22 -0600, Rob Herring wrote:
> On Mon, Oct 29, 2018 at 11:04:54AM +0800, Biao Huang wrote:
> > The commit adds the device tree binding documentation for the MediaTek DWMAC
> > found on MediaTek MT2712.
> > 
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > ---
> >  .../devicetree/bindings/net/mediatek-dwmac.txt     |   49 ++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > new file mode 100644
> > index 0000000..8baf0e4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > @@ -0,0 +1,49 @@
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
> > +- interrupt-names: Should contain a list of interrupt names corresponding to
> > +	the interrupts in the interrupts property, if available.
> > +	Should be "macirq" for the main MAC IRQ
> > +- clocks: Must contain a phandle for each entry in clock-names.
> > +- clock-names: the name of the clock listed in the clocks property. These are
> > +	"axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
> > +	for MT2712 SoC
> 
> Clocks should represent the physical clocks connected to a block. Parent 
> clocks are not in that category.
There are two categories of physical clocks related to MAC.
1. axi/apb/ptp_top, these clks are from clk gates, so only on/off is
needed.
2. mac_ext/ptp_ref, these clks are from mux. If different source is
selected, the clk frequecy will be different. So it's necessary to set a
proper parent for them, i.e. mac_parent/ptp_parent.

How should I handle parent clocks if not defined here? Any examples I
can refer to?
> 
> > +- mac-address: See ethernet.txt in the same directory
> > +- phy-mode: See ethernet.txt in the same directory
> > +
> > +Example:
> > +
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
> > +	};
> > -- 
> > 1.7.9.5
> > 
> 
Best Regards!
Biao
