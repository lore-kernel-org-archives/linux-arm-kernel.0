From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 May 2012 17:27:02 +0100
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <1335974475.1593.20.camel@vkoul-udesk3>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
Message-ID: <20120502162702.GE3548@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 09:31:15PM +0530, Vinod Koul wrote:
> On Wed, 2012-05-02 at 15:45 +0100, Russell King - ARM Linux wrote:
> > Dan, Vinod,
> > 
> > What is the desired behaviour of the callback for cyclic DMA?
>
> Typically cyclic DMA is used in the case of sound. This is where alsa
> expects the "period" callback for every DMA period.
> Generally, such notification serves the purpose of letting client know
> that one "block" has been completed.

Yes, though as we have this interface as something generic I didn't want
to call it "the alsa dma interface".

> > My understanding is:
> > 1. Such callbacks will be made from tasklet context.
> > 2. Exactly one callback will be issued for every 'period' of the transfer
> >    which has completed.
> > 
> > My main reason for asking is point (2) - because tasklets have a property
> > which means that they are guaranteed to run exactly once after a
> > tasklet_schedule() call even if there are further tasklet_schedule()
> > calls before the tasklet is actually run.  This property can lead to
> > dropped callbacks unless DMA engine authors have thought about this.
>
> Yes, that can happen and would make sense to have dmac drivers handle
> this.

So we need something that documents this behaviour.

> > Alternatively, we could document that for cyclic transfers, one callback
> > will be made after the expiry of a period or number of periods.  In
> > other words, if two periods expire before we issue the callback, the
> > user will only get _one_ callback issued.  In that case, we definitely
> > need some way to determine the DMA position...
>
> I think this would be fine with me. 

This is also fine by ALSA, because in response to snd_pcm_period_elapsed()
ALSA calls back to request the current DMA position, where that is defined
as the offset from the starting address of the buffer.  (Think,
next_dma_transfer_address - buf_addr passed into device_prep_dma_cyclic()).

> > The next issue is this tx_status method, and the residue bytes returned.
> > There seems to be quite a bit of confusion over what this is, and what
> > it should be, and its relationship to the passed in cookie.  The drivers
> > I've seen using it appear to total up the number of pending bytes to
> > be transferred for every transfer which has been issued.  This seems
> > wrong to me, I think it should be the number of bytes left until the
> > transfer with the specified cookie has completed.
>
> From what I understand (Dan please correct me as you may know this much
> better than me), the tx_status tells you wrt passed cookie what is the
> status. Further, (as you pointed), it also tells you which is last
> completed cookie and what is the current "running". And wrt the
> currently "running" cookie it tells you how may bytes are left.

That means we have a number of buggy drivers on both sides of the API...
PL08x for example always total up all the pending bytes from the position
in the current descriptor to the last issued descriptor.  Many other
implementations simply always return zero.

> > Moreover, what's the requirement here when we're using cyclic transfers?
> > If we take that same definition, then, because cyclic transfers never
> > complete, effectively they have an infinite number of bytes.  That's not
> > useful.  What would be more useful is if this was defined as the number
> > of bytes to the end of the cyclic buffer - or something similar.  That
> > then would allow the current DMA position to be determined for applications
> > like ASoC to know how much of the buffer it could refill with new data.
>
> IIRC had pointed Lars to this API, but quick check of code reveals that
> this is unused. I think returning residue as remaining bytes of current
> "block" makes sense. This easily gives knowledge of where DMA pointer is
> wrt current ongoing transaction. Was that your meaning of end of cyclic
> buffer, not sure what end means here?

I think the residue thing was something Linus created, which is why he's
included in this thread...
