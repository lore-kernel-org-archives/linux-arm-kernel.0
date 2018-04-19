From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 19 Apr 2018 16:55:10 +0200
Subject: [PATCH 6/9] sunxi-cedrus: Add device tree binding document
In-Reply-To: <20180318124800.7soqh34fxvwjm7pn@rob-hp-laptop>
References: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
 <20180309101445.16190-4-paul.kocialkowski@bootlin.com>
 <20180318124800.7soqh34fxvwjm7pn@rob-hp-laptop>
Message-ID: <b8d7f6606b880962d23323cb794111580de948ac.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, 2018-03-18 at 07:48 -0500, Rob Herring wrote:
> On Fri, Mar 09, 2018 at 11:14:42AM +0100, Paul Kocialkowski wrote:
> > From: Florent Revest <florent.revest@free-electrons.com>
> 
> "device tree binding document" can all be summarized with the subject 
> prefix "dt-bindings: media: ".

Will do in v2, thanks.

> Also, email should be updated to @bootlin.com?

I will keep the address @free-electrons.com (since there is no matching
@bootlin.com address). Although that address was broken at the time of
sending v1, it should be a valid redirect nowadays.

> > 
> > Device Tree bindings for the Allwinner's video engine
> > 
> > Signed-off-by: Florent Revest <florent.revest@free-electrons.com>
> > ---
> >  .../devicetree/bindings/media/sunxi-cedrus.txt     | 44
> > ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/sunxi-
> > cedrus.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/sunxi-
> > cedrus.txt b/Documentation/devicetree/bindings/media/sunxi-
> > cedrus.txt
> > new file mode 100644
> > index 000000000000..138581113c49
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/sunxi-cedrus.txt
> > @@ -0,0 +1,44 @@
> > +Device-Tree bindings for SUNXI video engine found in sunXi SoC
> > family
> > +
> > +Required properties:
> > +- compatible	    : "allwinner,sun4i-a10-video-engine";
> > +- memory-region     : DMA pool for buffers allocation;
> 
> Why do you need this linkage? Many drivers use CMA and don't need
> this.

The VPU can only access the first 256 MiB of DRAM, that are DMA-mapped
starting from the DRAM base. This requires specific memory allocation
and handling. I'll add the information in v2.

> > +- clocks	    : list of clock specifiers, corresponding to
> > +		      entries in clock-names property;
> > +- clock-names	    : should contain "ahb", "mod" and "ram"
> > entries;
> > +- resets	    : phandle for reset;
> > +- interrupts	    : should contain VE interrupt number;
> > +- reg		    : should contain register base and length
> > of VE.
> > +
> > +Example:
> > +
> > +reserved-memory {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	ranges;
> > +
> > +	ve_reserved: cma {
> > +		compatible = "shared-dma-pool";
> > +		reg = <0x43d00000 0x9000000>;
> > +		no-map;
> > +		linux,cma-default;
> > +	};
> > +};
> > +
> > +video-engine {
> > +	compatible = "allwinner,sun4i-a10-video-engine";
> > +	memory-region = <&ve_reserved>;
> > +
> > +	clocks = <&ahb_gates 32>, <&ccu CLK_VE>,
> > +		 <&dram_gates 0>;
> > +	clock-names = "ahb", "mod", "ram";
> > +
> > +	assigned-clocks = <&ccu CLK_VE>;
> > +	assigned-clock-rates = <320000000>;
> 
> Not documented.

Will do in v2.

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180419/3d066ee5/attachment.sig>
