From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 6 Dec 2016 10:42:22 +0530
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
Message-ID: <20161206051222.GQ6408@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 07:25:02PM +0100, Mason wrote:

Sorry I was away for a week in meeting with laptop down.

> [ Nothing new added below.
>   Vinod, was the description of my HW's quirks clear enough?

Yes

>   Is there a way to write a driver within the existing framework?

I think so, looking back at comments from Russell, I do tend to agree with
that. Is there a specfic reason why sbox can't be tied to alloc and free
channels?

>   How can I get that HW block supported upstream?
>   Regards. ]
> 
> On 25/11/2016 13:46, Mason wrote:
> 
> > On 25/11/2016 05:55, Vinod Koul wrote:
> > 
> >> On Wed, Nov 23, 2016 at 11:25:44AM +0100, Mason wrote:
> >>
> >>> On my platform, setting up a DMA transfer is a two-step process:
> >>>
> >>> 1) configure the "switch box" to connect a device to a memory channel
> >>> 2) configure the transfer details (address, size, command)
> >>>
> >>> When the transfer is done, the sbox setup can be torn down,
> >>> and the DMA driver can start another transfer.
> >>>
> >>> The current software architecture for my NFC (NAND Flash controller)
> >>> driver is as follows (for one DMA transfer).
> >>>
> >>>   sg_init_one
> >>>   dma_map_sg
> >>>   dmaengine_prep_slave_sg
> >>>   dmaengine_submit
> >>>   dma_async_issue_pending
> >>>   configure_NFC_transfer
> >>>   wait_for_IRQ_from_DMA_engine // via DMA_PREP_INTERRUPT
> >>>   wait_for_NFC_idle
> >>>   dma_unmap_sg
> >>
> >> Looking at thread and discussion now, first thinking would be to ensure
> >> the transaction is completed properly and then isr fired. You may need
> >> to talk to your HW designers to find a way for that. It is quite common
> >> that DMA controllers will fire and complete whereas the transaction is
> >> still in flight.
> > 
> > It seems there is a disconnect between what Linux expects - an IRQ
> > when the transfer is complete - and the quirks of this HW :-(
> > 
> > On this system, there are MBUS "agents" connected via a "switch box".
> > An agent fires an IRQ when it has dealt with its *half* of the transfer.
> > 
> > SOURCE_AGENT <---> SBOX <---> DESTINATION_AGENT
> > 
> > Here are the steps for a transfer, in the general case:
> > 
> > 1) setup the sbox to connect SOURCE TO DEST
> > 2) configure source to send N bytes
> > 3) configure dest to receive N bytes
> > 
> > When SOURCE_AGENT has sent N bytes, it fires an IRQ
> > When DEST_AGENT has received N bytes, it fires an IRQ
> > The sbox connection can be torn down only when the destination
> > agent has received all bytes.
> > (And the twist is that some agents do not have an IRQ line.)
> > 
> > The system provides 3 RAM-to-sbox agents (read channels)
> > and 3 sbox-to-RAM agents (write channels).
> > 
> > The NAND Flash controller read and write agents do not have
> > IRQ lines.
> > 
> > So for a NAND-to-memory transfer (read from device)
> > - nothing happens when the NFC has finished sending N bytes to the sbox
> > - the write channel fires an IRQ when it has received N bytes
> > 
> > In that case, one IRQ fires when the transfer is complete,
> > like Linux expects.
> > 
> > For a memory-to-NAND transfer (write to device)
> > - the read channel fires an IRQ when it has sent N bytes
> > - the NFC driver is supposed to poll the NFC to determine
> > when the controller has finished writing N bytes
> > 
> > In that case, the IRQ does not indicate that the transfer
> > is complete, merely that the sending half has finished
> > its part.
> > 
> > For a memory-to-memory transfer (memcpy)
> > - the read channel fires an IRQ when it has sent N bytes
> > - the write channel fires an IRQ when it has received N bytes
> > 
> > So you actually get two IRQs in that case, which I don't
> > think Linux (or the current DMA driver) expects.
> > 
> > I'm not sure how we're supposed to handle this kind of HW
> > in Linux? (That's why I started this thread.)
> > 
> > 
> >> If that is not doable, then since you claim this is custom part which
> >> other vendors won't use (hope we are wrong down the line),
> > 
> > I'm not sure how to interpret "you claim this is custom part".
> > Do you mean I may be wrong, that it is not custom?
> > I don't know if other vendors may have HW with the same
> > quirky behavior. What do you mean about being wrong down
> > the line?
> > 
> >> then we can have a custom api,
> >>
> >> foo_sbox_configure(bool enable, ...);
> >>
> >> This can be invoked from NFC driver when required for configuration and
> >> teardown. For very specific cases where people need some specific
> >> configuration we do allow custom APIs.
> > 
> > I don't think that would work. The fundamental issue is
> > that Linux expects a single IRQ to indicate "transfer
> > complete". And the driver (as written) starts a new
> > transfer as soon as the IRQ fires.
> > 
> > But the HW may generate 0, 1, or even 2 IRQs for a single
> > transfer. And when there is a single IRQ, it may not
> > indicate "transfer complete" (as seen above).
> > 
> >> Only problem with that would be it wont be a generic solution
> >> and you seem to be fine with that.
> > 
> > I think it is possible to have a generic solution:
> > Right now, the callback is called from tasklet context.
> > If we can have a new flag to have the callback invoked
> > directly from the ISR, then the driver for the client
> > device can do what is required.
> > 
> > For example, the NFC driver waits for the IRQ from the
> > memory agent, and then polls the controller itself.
> > 
> > I can whip up a proof-of-concept if it's better to
> > illustrate with a patch?
> 

-- 
~Vinod
