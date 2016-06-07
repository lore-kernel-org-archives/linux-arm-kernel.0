From: eric@anholt.net (Eric Anholt)
Date: Tue, 07 Jun 2016 13:56:13 -0700
Subject: [PATCH] dmaengine: bcm2835: Fix polling for completion of DMA
 with interrupts masked.
In-Reply-To: <20160607072121.GM16910@localhost>
References: <1465007351-5559-1-git-send-email-eric@anholt.net>
 <20160606042635.GU16910@localhost> <87a8iy6x41.fsf@eliezer.anholt.net>
 <20160607052405.GC16910@localhost> <87k2i1leap.fsf@eliezer.anholt.net>
 <20160607072121.GM16910@localhost>
Message-ID: <87eg8867ma.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Mon, Jun 06, 2016 at 11:10:38PM -0700, Eric Anholt wrote:
>> >> >> -	if (ret == DMA_COMPLETE || !txstate)
>> >> >> +	if (ret == DMA_COMPLETE)
>> >> >
>> >> > Why do you change this? txstate can be NULL, so no point calculating reside
>> >> > for those cases
>> >> 
>> >> The point was to go into the "Calculate where we're at in our current
>> >> DMA (if the current DMA is the one we're asking about status for)" path,
>> >> so that we could note when the DMA is complete even when there's no
>> >> txstate passed in.
>> >
>> > Can you explain what you mean by current DMA!
>> >
>> > The claulation is always done for 'descriptor' represnted by the cookie. So
>> > it doesnt not matter...!
>> 
>> By current I mean the current descriptor that has been submitted to the
>> hardware, in bcm2835_chan->desc.
>
> As I said, you calculate for the descriptor respresnted by cookie and
> not the one getting processed!

I believe I'm calculating the state for the descriptor being processed
only in the case where the cookie being asked about is for the
descriptor being processed.  I'm confused what your objection is, so I'm
going to annotate what I think is going on in the function so maybe you
can point to where I've got something wrong.

	spin_lock_irqsave(&c->vc.lock, flags);
	vd = vchan_find_desc(&c->vc, cookie);
	if (vd) {
		txstate->residue =
			bcm2835_dma_desc_size(to_bcm2835_dma_desc(&vd->tx));

I believe this is the case for "the descriptor for the cookie being
asked about hasn't been pulled off the list and submitted to the
hardware yet"

	} else if (c->desc && c->desc->vd.tx.cookie == cookie) {
		struct bcm2835_desc *d = c->desc;
		dma_addr_t pos;

		if (d->dir == DMA_MEM_TO_DEV)
			pos = readl(c->chan_base + BCM2835_DMA_SOURCE_AD);
		else if (d->dir == DMA_DEV_TO_MEM)
			pos = readl(c->chan_base + BCM2835_DMA_DEST_AD);
		else
			pos = 0;

		txstate->residue = bcm2835_dma_desc_size_pos(d, pos);

Here the descriptor for the cookie is currently being processed by the
hardware.  It might also be done but hasn't had its done interrupt
handled yet, so this is the case where I want to effectively do the done
IRQ's work of updating the status.

	} else {
		txstate->residue = 0;

Here, it's not in the hardware and it's not queued to be submitted to
the hardware, so it must be done.

	}

What am I missing?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/b8e28b95/attachment.sig>
