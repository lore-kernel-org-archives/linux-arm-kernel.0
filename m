From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 8 Jun 2011 01:16:40 +0530
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <20110607182923.GA28451@n2100.arm.linux.org.uk>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
	<BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
	<20110607182923.GA28451@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikLFCyzU3UApjjwfX0Vjujo9WAFZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2011 at 11:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> The discussion did take off a few months ago, but we didn't reach anywhere.
>> Being able to queue request from the 'done' callback, the need of
>> circular buffer
>> API (possibly a free-running one too) and callbacks in irq-context, as
>> they happen,
>> were a few requirements for having fast peripherals with shallow fifo
>> work without underruns.
>
> I can see why you have these concerns; the problem is the slave DMA
> engine API was never properly documented.
>
> 1. The slave API does permit the done callback to submit new requests
> ? already (and any DMA engine driver which doesn't allow that is broken.)
>
> Note that slave APIs _should_ permit several requests to be queued up
> and as each finish, the next one should be started. ?In other words,
> once DMA has started it should continue until there is no more work for
> the DMA engine to perform.
>
> 2. Circular buffer support has been added - see device_prep_dma_cyclic().
>
> However, 2 is not really a requirement for audio - you can queue several
> single slave transfers (one per period) initially, and then you get
> callbacks as each transfer completes. ?In the callback, you can submit
> an additional buffer, and continue doing so causing DMA to never end.
>
> I believe that this is a saner approach than the circular buffer support,
> and its what I tried to put together for the AMBA PL041 AACI DMA (but
> unfortunately, ARMs platforms are totally broken when it comes to DMA.)
>
> This also removes the need for the callback to be in IRQ context.
>
> So I don't see that anything you've mentioned is a problem with the API
> as it stands today - there may be issues with the way the DMA engine
> driver has been implemented which cause it not to conform to what I've
> said above, but those are driver bugs and not a fault of the API.

Yes, after reading Vinod's mail, I did see that CYCLIC option has been added.
Though I am still not sure how effective would that be for fast
peripherals(please
have a look at my reply to Mark's post), when doing callbacks from
tasklets scheduled
from irq-handlers is the norm with dma drivers of generic api.
Playing regular audio is no problem, but playing pro quality over
SPDIF with active multimedia h/w, sometimes is for some devices.

Besides, people might have different work priorities atm. I don't
think anybody believes we can do without common APIs.

Btw, Samsung DMA API doesn't support the 'free-running' circular
buffer either. But that was my planned TODO while I was there and I
think someone is working on it(?)

IMHO Samsung SoC team (not his majesty Mr Kyungmin Park) are justified if they
are not so eager right now. Since I no more would have to spend
sleepless nights over
SPDIF underruns, I can side with what Kukjin Kim(Samsung maintainer)
decides, who has to live with the results.

Thanks,
Jassi
