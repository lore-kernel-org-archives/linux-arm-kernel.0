From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Fri, 18 May 2018 13:35:08 -0700
Subject: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH 02/20]
 dma-mapping: provide a generic dma-noncoherent implementation)
In-Reply-To: <20180518175004.GF17671@n2100.armlinux.org.uk>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
 <5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
 <20180518175004.GF17671@n2100.armlinux.org.uk>
Message-ID: <cecfe6bd-ef1f-1e25-bfcf-992d1f828efb@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2018 10:50 AM, Russell King - ARM Linux wrote:
> On Fri, May 18, 2018 at 10:20:02AM -0700, Vineet Gupta wrote:
>> I never understood the need for this direction. And if memory serves me
>> right, at that time I was seeing twice the amount of cache flushing !
> It's necessary.  Take a moment to think carefully about this:
>
> 	dma_map_single(, dir)
>
> 	dma_sync_single_for_cpu(, dir)
>
> 	dma_sync_single_for_device(, dir)
>
> 	dma_unmap_single(, dir)

As an aside, do these imply a state machine of sorts - does a driver needs to 
always call map_single first ?

My original point of contention/confusion is the specific combinations of API and 
direction, specifically for_cpu(TO_DEV) and for_device(TO_CPU)

Semantically what does dma_sync_single_for_cpu(TO_DEV) even imply for a non dma 
coherent arch.
Your tables below have "none" for both, implying it is unlikely to be a real 
combination (for ARM and ARC atleast).

The other case, actually @dir TO_CPU, independent of for_{cpu, device}? implies 
driver intends to touch it after the call, so it would invalidate any stray lines, 
unconditionally (and not just for speculative prefetch case).


> In the case of a DMA-incoherent architecture, the operations done at each
> stage depend on the direction argument:
>
> 	map		for_cpu		for_device	unmap
> TO_DEV	writeback	none		writeback	none
> TO_CPU	invalidate	invalidate*	invalidate	invalidate*
> BIDIR	writeback	invalidate	writeback	invalidate
>
> * - only necessary if the CPU speculatively prefetches.
>
> The multiple invalidations for the TO_CPU case handles different
> conditions that can result in data corruption, and for some CPUs, all
> four are necessary.

Can you please explain in some more detail, TO_CPU row, why invalidate is 
conditional sometimes.
