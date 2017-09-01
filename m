From: stefan.bruens@rwth-aachen.de (Stefan Bruens)
Date: Fri, 1 Sep 2017 03:19:50 +0200
Subject: [PATCH 3/3] dmaengine: sun6i: Add support for Allwinner A64
In-Reply-To: <20170901003135.10058-1-andre.przywara@arm.com>
References: <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
 <20170901003135.10058-1-andre.przywara@arm.com>
Message-ID: <1837534.s5pz9jWHnV@pebbles.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Freitag, 1. September 2017 02:31:35 CEST Andre Przywara wrote:
> Hi,
> 
> On 31/08/17 00:36, Stefan Br?ns wrote:
> > The A64 SoC has the same dma engine as the H3 (sun8i), with a
> > reduced amount of physical channels. Add the proper config data
> > and compatible string to support it.
> 
> ...
> 
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index 5f4eee4513e5..6a17c5d63582 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -1068,6 +1068,12 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
> > 
> >  	.nr_max_vchans   = 34,
> >  	.dmac_variant    = DMAC_VARIANT_H3,
> >  
> >  };
> > 
> > +
> > +static struct sun6i_dma_config sun50i_a64_dma_cfg = {
> > +	.nr_max_channels = 8,
> > +	.nr_max_requests = 27,
> > +	.nr_max_vchans   = 38,
> > +	.dmac_variant    = DMAC_VARIANT_H3,
> > 
> >  };
> >  
> >  static const struct of_device_id sun6i_dma_match[] = {
> > 
> > @@ -1075,6 +1081,7 @@ static const struct of_device_id sun6i_dma_match[] =
> > {> 
> >  	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg 
},
> >  	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg
> >  	},
> >  	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
> > 
> > +	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg
> > },> 
> >  	{ /* sentinel */ }
> >  
> >  };
> >  MODULE_DEVICE_TABLE(of, sun6i_dma_match);
> 
> I was wondering if should use the opportunity to expose those values as
> DT properties instead of hard-wiring them to a compatible string in the
> driver every time we add support for a new SoC?
> We could introduce a new compatible string (say: "allwinner,sunxi-dma"),
> then describe properties for the number of channels and requests and
> vchans and parse those from the DT at probe time.
> With this we might be able to support future SoCs without Linux *driver*
> changes, by just providing the right DT. This would have worked already
> for instance for the A83T support, which just changed those values.
> 
> For instance with this quick patch below (just compile tested, and without
> your refactoring).
> The DT node would then read something like:
> 	dma: dma-controller at 01c02000 {
> 		compatible = "allwinner,sun50i-a64-dma",
> 			     "allwinner,sunxi-dma";
> 		reg = <0x01c02000 0x1000>;
> 		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> 		clocks = <&ccu CLK_BUS_DMA>;
> 		resets = <&ccu RST_BUS_DMA>;
> 		#dma-cells = <1>;
> 		allwinner,max_channels = <8>;
> 		allwinner,max_requests = <27>;
> 		allwinner,max_vchans = <38>;
> 	};

For these 3 properties it likely is a good idea, but we would IMHO still have 
to care for the differences in the register settings:

- A31 does not have a clock autogating register
- A23 and A83t does have one at offset 0x20
- A64, H3, H5 and R40 have it at offset 0x28

There are also the incompatibilities in the "DMA channel configuration 
register" (burst length; burst width; burst length field offset).

We can either have 3 different compatible strings, or another property for the 
register model.

For the aw,max_requests and aw,max_vchans, maybe a bitmask per direction is a 
better option - it can encode the allowed DRQ numbers much better (e.g. for 
H3, the highest source DRQ is 24). The DRQ field in the channel configuration 
register is 5 bits, so the hightest port/DRQ number is 31.

For aw,max_channels my first thought is - why max? is it variable? is there a 
min_channels? My suggestion would be (in order of preference): "aw,channels", 
"aw,dma_channels", "aw,available_channels".

Kind regards,

Stefan

-- 
Stefan Br?ns  /  Bergstra?e 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
