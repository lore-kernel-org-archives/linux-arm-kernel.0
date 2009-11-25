From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2009 16:31:19 +0000
Subject: [PATCH v2 07/17] ARM: dma-mapping: no need to clean
	overlapping cache lines on invalidate
In-Reply-To: <1259151582.30270.61.camel@pc1117.cambridge.arm.com>
References: <E1NBYEI-0005lA-8a@rmk-PC.arm.linux.org.uk>
	<E1NCZ7s-0002A3-0R@rmk-PC.arm.linux.org.uk>
	<1259151582.30270.61.camel@pc1117.cambridge.arm.com>
Message-ID: <20091125163119.GB5136@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 12:19:42PM +0000, Catalin Marinas wrote:
> On Mon, 2009-11-23 at 13:38 +0000, Russell King - ARM Linux wrote:
> > Since we now clean the DMA buffers on map, 
> 
> Is this still valid with the latest patch you sent?

Again, welcome to why the DMA functions end up being screwed over my
ARMv7... and why I think we should hold off merging this until
post-2.6.33 when we've had time to properly sorted out issues like
this.

> > there's no need to clean
> > overlapping cache lines on invalidation anymore.  (Note: the DMA API
> > prohibits other data sharing the same cache line as a DMA buffer
> > anyway.)
> 
> Why was this cleaning ever needed if the DMA API prohibits cache line
> sharing?
>
> Even if we do cleaning on map, having shared cache lines is broken since
> you may do an invalidate on unmap but the shared cache line may have
> been dirtied.

It happens, particularly with SCSI.

And congratuations on realising why it's not permitted.  I do wish
other people would see the light and not do things like DMA directly
to the kernel stack and similar tricks.

In fact, I've made the decision.  I'm not merging this for the upcoming
merge window.  It will wait another cycle to give us time to properly
sort this problem out in a sane way, rather than rushing through with
a half baked solution.
