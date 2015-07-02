From: leilk.liu@mediatek.com (leilk liu)
Date: Thu, 2 Jul 2015 15:43:42 +0800
Subject: [PATCH v2 2/4] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for spi bus
In-Reply-To: <CAGS+omBLNWUnNCt5XEAAqiCxzCZOsNQOXSK0ij13Wxro+Q9qLQ@mail.gmail.com>
References: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
 <1435583070-9600-3-git-send-email-leilk.liu@mediatek.com>
 <CAGS+omBLNWUnNCt5XEAAqiCxzCZOsNQOXSK0ij13Wxro+Q9qLQ@mail.gmail.com>
Message-ID: <1435823022.7819.8.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +
> > +- pad-select: should specify spi pad used, only required for MT8173.
> > +       This value should be 0~3.
> > +
> > +Example:
> > +
> > +- SoC Specific Portion:
> > +spi: spi at 1100a000 {
> > +       compatible = "mediatek,mt8173-spi";
> > +       reg = <0 0x1100a000 0 0x1000>;
> > +       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
> > +       clocks = <&pericfg PERI_SPI0>;
> 
> CLK_PERI_SPI0

yes,it will be fixed.

> 
> > +       clock-names = "main";
> > +       pad-select = <1>;
> 
> According to [0], a SPI bus should also specify
> address-cells/size-cells to allow SPI bus devices to specify a chip
> select.
> [0] Documentation/devicetree/bindings/spi/spi-bus.txt
> 
> - #address-cells  - number of cells required to define a chip select
> address on the SPI bus.
> - #size-cells     - should be zero.
> 
> The spi-bus document even describes how to mix "native" and gpio CS lines.
> 
 Got it, it will be added in mt8173.dtsi.

> 
> I am still not sure what to do with the "pad-select" feature.
> Does "pad-select" just select one of 4 dedicated chip select lines?
> Or, does it also change which CK/MOSI/MISO lines are used?
> 
> Ideally, the same CK/MOSI/MISO signals are sent on all CK/MOSI/MISO
> lines enabled by pinctrl, and "pad-select" just chooses which CS_N
> line to use.
> In this case, we can use the SPI slave device reg value to select
> which CS_N to use for any given device.
> Furthermore, we can also support using additional cs-gpios.
> 
> However, if the pad-select also specifies which CK/MOSI/MISO pins are
> used for a given transaction, then supporting cs-gpios becomes a bit
> trickier, since the spi slave device would need to specify both which
> gpio-cs to use, as well as which SPI pad it is connected to.
> 
> -Dan

The pad-select changes CS/CK/MO/MI lines. Mt8173 spi has 4 group pins,
and it can select which group pins will be used.

Leilk.

> > +       status = "disabled";
> > +};
> > --
> > 1.8.1.1.dirty
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
