From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 4 May 2018 10:40:08 +0200
Subject: [PATCH v2 09/10] ARM: dts: sun7i-a20: Add Video Engine and
 reserved memory nodes
In-Reply-To: <82057e2f734137a3902d9313c228b01ceb345ee7.camel@bootlin.com>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154536.17846-5-paul.kocialkowski@bootlin.com>
 <20180420073908.nkcbsdxibnzkqski@flea>
 <82057e2f734137a3902d9313c228b01ceb345ee7.camel@bootlin.com>
Message-ID: <20180504084008.h6p4brari3xrbv6l@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 09:49:16AM +0200, Paul Kocialkowski wrote:
> > > +	reserved-memory {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		ranges;
> > > +
> > > +		/* Address must be kept in the lower 256 MiBs of
> > > DRAM for VE. */
> > > +		ve_memory: cma at 4a000000 {
> > > +			compatible = "shared-dma-pool";
> > > +			reg = <0x4a000000 0x6000000>;
> > > +			no-map;
> > 
> > I'm not sure why no-map is needed.
> 
> In fact, having no-map here would lead to reserving the area as cache-
> coherent instead of contiguous and thus prevented dmabuf support.
> Replacing it by "resuable" allows proper CMA reservation.
> 
> > And I guess we could use alloc-ranges to make sure the region is in
> > the proper memory range, instead of hardcoding it.
> 
> As far as I could understand from the documentation, "alloc-ranges" is
> used for dynamic allocation while only "reg" is used for static
> allocation. We are currently going with static allocation and thus
> reserve the whole 96 MiB. Is using dynamic allocation instead desirable
> here?

I guess we could turn the question backward. Why do we need a static
allocation? This isn't a buffer that is always allocated on the same
area, but rather that we have a range available. So our constraint is
on the range, nothing else.

> > > +			reg = <0x01c0e000 0x1000>;
> > > +			memory-region = <&ve_memory>;
> > 
> > Since you made the CMA region the default one, you don't need to tie
> > it to that device in particular (and you can drop it being mandatory
> > from your binding as well).
> 
> What if another driver (or the system) claims memory from that zone and
> that the reserved memory ends up not being available for the VPU
> anymore?
> 
> Acccording to the reserved-memory documentation, the reusable property
> (that we need for dmabuf) puts a limitation that the device driver
> owning the region must be able to reclaim it back.
> 
> How does that work out if the CMA region is not tied to a driver in
> particular?

I'm not sure to get what you're saying. You have the property
linux,cma-default in your reserved region, so the behaviour you
described is what you explicitly asked for.

> 
> > > +
> > > +			clocks = <&ccu CLK_AHB_VE>, <&ccu CLK_VE>,
> > > +				 <&ccu CLK_DRAM_VE>;
> > > +			clock-names = "ahb", "mod", "ram";
> > > +
> > > +			assigned-clocks = <&ccu CLK_VE>;
> > > +			assigned-clock-rates = <320000000>;
> > 
> > This should be set from within the driver. If it's something that you
> > absolutely needed for the device to operate, you have no guarantee
> > that the clock rate won't change at any point in time after the device
> > probe, so that's not a proper solution.
> > 
> > And if it's not needed and can be adjusted depending on the
> > framerate/codec/resolution, then it shouldn't be in the DT either.
> 
> Yes, that makes sense.
> 
> > Don't you also need to map the SRAM on the A20?
> 
> That's a good point, there is currently no syscon handle for A20 (and
> also A13). Maybe SRAM is muxed to the VE by default so it "just works"? 
> 
> I'll investigate on this side, also keeping in mind that the actual
> solution is to use the SRAM controller driver (but that won't make it to
> v3).

The SRAM driver is available on the A20, so you should really use that
instead of a syscon.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/5dcc102b/attachment.sig>
