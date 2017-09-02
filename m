From: stefan.bruens@rwth-aachen.de (Stefan Bruens)
Date: Sat, 2 Sep 2017 02:38:31 +0200
Subject: [PATCH 3/3] dmaengine: sun6i: Add support for Allwinner A64
In-Reply-To: <d397d87b-5004-c8af-e590-037befc9b2b6@arm.com>
References: <20170830233609.13855-4-stefan.bruens@rwth-aachen.de>
 <1837534.s5pz9jWHnV@pebbles.site>
 <d397d87b-5004-c8af-e590-037befc9b2b6@arm.com>
Message-ID: <1663692.e5KjDkSFRC@pebbles.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Samstag, 2. September 2017 00:32:50 CEST Andr? Przywara wrote:
> Hi,
> 
> On 01/09/17 02:19, Stefan Bruens wrote:
> > On Freitag, 1. September 2017 02:31:35 CEST Andre Przywara wrote:
> >> Hi,
> >> 
> >> On 31/08/17 00:36, Stefan Br?ns wrote:
[...]
> > 
> > For these 3 properties it likely is a good idea, but we would IMHO still
> > have to care for the differences in the register settings:
> > 
> > - A31 does not have a clock autogating register
> > - A23 and A83t does have one at offset 0x20
> > - A64, H3, H5 and R40 have it at offset 0x28
> 
> Fair enough - I didn't look too closely at your new changes, especially
> why it apparently worked before.
> But as your list shows, we would only need one compatible string per
> line - in the driver - to cover all SoCs (and possibly future SoCs!),
> and do the rest via the properties.
> We can't use the existing h3 compatible string or touch the already
> existing SoCs and compatible strings, of course, but I guess
> the A64, R40 and future SoCs could make use of a new (generic?) string.
> 
> > There are also the incompatibilities in the "DMA channel configuration
> > register" (burst length; burst width; burst length field offset).
> > 
> > We can either have 3 different compatible strings, or another property for
> > the register model.
> 
> The latter is usually frowned upon, using separate compatible strings
> for each group of SoCs is the way to go here.
> 
> > For the aw,max_requests and aw,max_vchans, maybe a bitmask per direction
> > is a better option - it can encode the allowed DRQ numbers much better
> > (e.g. for H3, the highest source DRQ is 24). The DRQ field in the channel
> > configuration register is 5 bits, so the hightest port/DRQ number is 31.
> 
> So looking more closely at the manual and the code my understanding is
> that nr_max_requests is more or less some rough molly guard to prevent
> wrong settings? Derived from the DRQ table in the manual?
> So that trying to program port 28 on an H3 would fail?
> But source port 25 or dest port 26 wouldn't be caught by this check,
> though they would still be "illegal" according to the manual. (Which we
> are not sure of, I guess, it may just not be documented)
> So I wonder if this nr_max_requests is useful at all, and we should just
> check that it fits into 5 bits and assume that the DT has superior
> knowledge of what's allowed and what not.
> Now I see what you mean with the bitmask (to cover those gaps), but I am
> bit sceptical if that is actually useful. After all the DRQ number would
> be coming from the DT, which we can surely trust.
> 
> And nr_max_vchans seems to describe the sum of documented DRQs, to just
> limit the memory allocation? So this could become just 64 to cover all
> possible cases without SoC specific configuration at all?

Yes, thats my understanding as well. Allocating a few excess channels would 
waste a few kBytes (AFAICS 304 bytes per channel on 64bit).
 
> > For aw,max_channels my first thought is - why max? is it variable? is
> > there a min_channels? My suggestion would be (in order of preference):
> > "aw,channels", "aw,dma_channels", "aw,available_channels".
> 
> Sure, actually looking at Documentation/devicetree/bindings/dma/dma.txt
> I think we can even use the generic "dma-channels" property described
> there. And possibly the same with "dma-requests", should we keep this.
> 
> So summarizing this:
> - We create a new compatible string, which drives an H3 compatible DMA
> (clock autogating at 0x28, 64-bit data width capable). This name could
> either be generic, or actually "allwinner,sun50i-a64-dma".
> - This one sets nr_max_requests to 31 and nr_max_vchans to 64.
> - Alternatively we expose those values in the DT as properties.
> - We take the number of DMA channels from the (now required)
> "dma-channels" property.
> - We let the A64 (and R40?) use this new binding.
> - Any future SoC which is close enough can then just piggy-back on this.
> - Any future *changes* in the Allwinner DMA device which require driver
> changes create a new compatible string, but still keep the above
> semantics. Chances are that there are more than one SoC using this kind
> of new DMA device, so they would work out of the box.
> 
> Does that make sense?
> I am happy to provide the code for that, based on your H3 rework.

Sounds good for me. I will send a cleaned up series later.

Kind regards,

Stefan

-- 
Stefan Br?ns  /  Bergstra?e 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
