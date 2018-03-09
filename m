From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 09 Mar 2018 14:45:46 +0100
Subject: [linux-sunxi] [PATCH 6/9] sunxi-cedrus: Add device tree binding
 document
In-Reply-To: <20180309133857.GA20392@solar>
References: <20180309100933.15922-3-paul.kocialkowski@bootlin.com>
 <20180309101445.16190-4-paul.kocialkowski@bootlin.com>
 <20180309133857.GA20392@solar>
Message-ID: <1520603146.15946.4.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the review!

On Fri, 2018-03-09 at 15:38 +0200, Priit Laes wrote:
> On Fri, Mar 09, 2018 at 11:14:42AM +0100, Paul Kocialkowski wrote:
> > From: Florent Revest <florent.revest@free-electrons.com>
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
> 
> This should be updated to sunxi-ng clocks:
> 
> clocks = <&ccu CLK_BUS_VE>, <&ccu CLK_VE>, <&ccu CLK_DRAM_VE>;

I will definitely keep that in mind and make the change for the next
revision, thanks!

> > +	clock-names = "ahb", "mod", "ram";
> > +
> > +	assigned-clocks = <&ccu CLK_VE>;
> > +	assigned-clock-rates = <320000000>;
> > +
> > +	resets = <&ccu RST_VE>;
> > +
> > +	interrupts = <53>;
> > +
> > +	reg = <0x01c0e000 4096>;
> > +};
> > -- 
> > 2.16.2
> > 
> > -- 
> > You received this message because you are subscribed to the Google
> > Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it,
> > send an email to linux-sunxi+unsubscribe at googlegroups.com.
> > For more options, visit https://groups.google.com/d/optout.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/aa35cdbb/attachment-0001.sig>
