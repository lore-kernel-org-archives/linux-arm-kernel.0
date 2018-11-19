From: biao.huang@mediatek.com (biao huang)
Date: Mon, 19 Nov 2018 10:12:48 +0800
Subject: [v3, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
In-Reply-To: <CAGp9LzrHm-ympV2zAKZKcEfA25aJp8BSS+=01B6G=sP_HiSSdA@mail.gmail.com>
References: <1542359926-28800-1-git-send-email-biao.huang@mediatek.com>
 <1542359926-28800-2-git-send-email-biao.huang@mediatek.com>
 <CAGp9LzrHm-ympV2zAKZKcEfA25aJp8BSS+=01B6G=sP_HiSSdA@mail.gmail.com>
Message-ID: <1542593568.24219.5.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sean,

	Thanks for your detailed comments~

On Sat, 2018-11-17 at 08:21 +0800, Sean Wang wrote:
> On Fri, Nov 16, 2018 at 1:19 AM Biao Huang <biao.huang@mediatek.com> wrote:
> >
> > The commit adds the device tree binding documentation for the MediaTek DWMAC
> > found on MediaTek MT2712.
> >
> > Change-Id: I3728666bf65927164bd82fa8dddb90df8270bd44
> 
> Drop change-id
sorry, I forgot it. will remove in next version.
> 
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
> > +- interrupt-names: Should contain a list of interrupt names corresponding to
> > +       the interrupts in the interrupts property, if available.
> > +       Should be "macirq" for the main MAC IRQ
> > +- clocks: Must contain a phandle for each entry in clock-names.
> > +- clock-names: The name of the clock listed in the clocks property. These are
> > +       "axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
> > +       for MT2712 SoC
> 
> About not including these parent clocks to the controller, you can
> refer to assigned-clocks, assigned-clock-parents, assigned-clock-rates
> noted in Documentation/devicetree/bindings/clock/clock-bindings.txt to
> determine what speed these MUXs should be run at and see [1] as the
> example how applied in dts.
> 
> [1]
> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/mt7623.dtsi#L660
> 
Got it, I'll remove parent info to dts.
> > +- mac-address: See ethernet.txt in the same directory
> > +- phy-mode: See ethernet.txt in the same directory
> > +
> > +Optional properties:
> > +- tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> > +       It should be defined for rgmii/rgmii-rxid/mii interface.
> > +- rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> > +       It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> > +- fine-tune: This property will select coarse-tune delay or fine delay
> > +       for rgmii interface.
> what is the property's type?
> 
ok, property type info will be added in next version.
> > +       If fine-tune delay is enabled, tx-delay/rx-delay is 170+/-50ps
> > +       per stage.
> > +       Else coarse-tune delay is enabled, tx-delay/rx-delay is 0.55+/-0.2ns
> > +       per stage.
> > +       This property do not apply to non-rgmii PHYs.
> > +       Only coarse-tune delay is supported for mii/rmii PHYs.
> > +- rmii-rxc: Reference clock of rmii is from external PHYs,
> what is the property's type?
> 
got it.
> > +       and it can be connected to TXC or RXC pin on MT2712 SoC.
> > +       If ref_clk <--> TXC, disable it.
> > +       Else ref_clk <--> RXC, enable it.
> > +- txc-inverse: Inverse tx clock for mii/rgmii.
> what is the property's type?
> 
> > +       Inverse tx clock inside MAC relative to reference clock for rmii,
> > +       and it rarely happen.
> > +- rxc-inverse: Inverse rx clock for mii/rgmii interfaces.
> what is the property's type?
> 
got it.
> > +       Inverse reference clock for rmii.
> 
> If these optional properties look like generic enough, it would be
> good that place them to stmmac.txt. Otherwise, they should be added
> "mediatek," as the prefix string for these vendor-specific things.
> 
it's mediatek-specific, and the prefix string will be added in next
version.
> > +
> > +Example:
> > +       eth: ethernet at 1101c000 {
> > +               compatible = "mediatek,mt2712-gmac";
> > +               reg = <0 0x1101c000 0 0x1300>;
> > +               interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> > +               interrupt-names = "macirq";
> > +               phy-mode ="rgmii-id";
> > +               mac-address = [00 55 7b b5 7d f7];
> > +               clock-names = "axi",
> > +                             "apb",
> > +                             "mac_ext",
> > +                             "mac_parent",
> > +                             "ptp_ref",
> > +                             "ptp_parent",
> > +                             "ptp_top";
> > +               clocks = <&pericfg CLK_PERI_GMAC>,
> > +                        <&pericfg CLK_PERI_GMAC_PCLK>,
> > +                        <&topckgen CLK_TOP_ETHER_125M_SEL>,
> > +                        <&topckgen CLK_TOP_ETHERPLL_125M>,
> > +                        <&topckgen CLK_TOP_ETHER_50M_SEL>,
> > +                        <&topckgen CLK_TOP_APLL1_D3>,
> > +                        <&topckgen CLK_TOP_APLL1>;
> > +               snps,txpbl = <32>;
> > +               snps,rxpbl = <32>;
> > +               snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
> > +               snps,reset-active-low;
> > +               tx-delay = <9>;
> > +               rx-delay = <9>;
> > +               fine-tune;
> > +               rmii-rxc;
> > +               txc-inverse;
> > +               rxc-inverse;
> > +       };
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
