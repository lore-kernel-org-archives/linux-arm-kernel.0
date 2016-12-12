From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 12 Dec 2016 10:31:43 +0530
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <7900ae24-6803-a271-944c-8830f718fef0@free.fr>
References: <20161208103921.GC6408@localhost>
 <91b0d10c-1bc2-c3e1-4088-f4ad9adcd6c0@free.fr>
 <20161208163755.GH6408@localhost>
 <yw1xy3zqxt7x.fsf@unicorn.mansr.com>
 <20161209065955.GJ6408@localhost>
 <6ce1ea97-1d68-2203-c7b4-73315e801655@laposte.net>
 <20161209171727.GK6408@localhost>
 <ec33d3f0-6474-2b13-8a26-077ce3785d31@free.fr>
 <20161209175606.GM6408@localhost>
 <7900ae24-6803-a271-944c-8830f718fef0@free.fr>
Message-ID: <20161212050143.GO6408@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 07:23:17PM +0100, Mason wrote:
> [ Dropping Mans to preserve his peace-of-mind ]
> 
> On 09/12/2016 18:56, Vinod Koul wrote:
> > On Fri, Dec 09, 2016 at 06:34:15PM +0100, Mason wrote:
> >> On 09/12/2016 18:17, Vinod Koul wrote:
> >>
> >>> On Fri, Dec 09, 2016 at 11:25:57AM +0100, Sebastian Frias wrote:
> >>>>
> >>>> What concrete solution do you propose?
> >>>
> >>> I have already proposed two solutions.
> >>>
> >>> A) Request a channel only when you need it. Obviously we can't do virtual
> >>> channels with this (though we should still use virt-channels framework).
> >>> The sbox setup and teardown can be done as part of channel request and
> >>> freeup. PL08x already does this.
> >>>
> >>> Downside is that we can only have as many consumers at a time as channels.
> >>>
> >>> I have not heard any technical reason for not doing this apart from drivers
> >>> grab the channel at probe, which is incorrect and needs to be fixed
> >>> irrespective of the problem at hand.
> >>>
> >>> This is my preferred option.
> >>
> >> There is one important drawback with this solution. If a driver calls
> >> dma_request_chan() when no channels are currently available, it will
> >> get -EBUSY. If there were a flag in dma_request_chan to be put to
> >> sleep (with timeout) until a channel is available, then it would
> >> work. But busy waiting in the client driver is a waste of power.
> > 
> > Right, but in that case the fallback would be PIO mode, and if that is
> > not availble (IIRC some f your devices don't) then reject the usage with
> > EAGAIN.
> 
> Maybe I'm missing something, but I don't see how that would help.
> Take the NAND Flash controller driver, for instance. PIO is not
> an option, because the ECC engine is tied to DMA.
> 
> And failing with -EAGAIN doesn't help the busy looping situation.
> The caller should be put on some kind of queue to wait for a
> "channel ready" event.

So if you go down this route then we have do a bit of engineering for this
solutions to solve the hardware issue.

Can you tell me the clients for this controller and channels available?

In this case possibly we can dedicate one for NAND and keep the ones with
PIO mode dynamic in nature.. But yes it is not an elegant one.

-- 
~Vinod
