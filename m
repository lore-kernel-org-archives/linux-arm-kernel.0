From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 8 Jun 2011 09:35:34 +0530
Subject: [PATCH] ARM:SAMSUNG: Move S3C DMA driver to drivers/dma
In-Reply-To: <20110607222810.GB28451@n2100.arm.linux.org.uk>
References: <1307432901-22781-1-git-send-email-alim.akhtar@samsung.com>
	<BANLkTintADbXSiV07VTMbFfmUV+4-q2-gw@mail.gmail.com>
	<BANLkTimjWNf3PxHXj3o5qubH5g7gMHjhFg@mail.gmail.com>
	<20110607081527.GB20929@n2100.arm.linux.org.uk>
	<BANLkTin66PhYGmVSOJcuZr8wDH_iNgjhZQ@mail.gmail.com>
	<20110607182923.GA28451@n2100.arm.linux.org.uk>
	<20110607184329.GA20849@sirena.org.uk>
	<BANLkTikXGpxpyF8kQORqswD5tqNEjtj3dA@mail.gmail.com>
	<20110607222810.GB28451@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimy+on-kKAAiWbwoRCVb0A-JgTXBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2011 at 3:58 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> >
>> >> 2. Circular buffer support has been added - see device_prep_dma_cyclic().
>> >
>> >> However, 2 is not really a requirement for audio - you can queue several
>> >> single slave transfers (one per period) initially, and then you get
>> >> callbacks as each transfer completes. ?In the callback, you can submit
>> >> an additional buffer, and continue doing so causing DMA to never end.
>> >
>> >> I believe that this is a saner approach than the circular buffer support,
>> >> and its what I tried to put together for the AMBA PL041 AACI DMA (but
>> >> unfortunately, ARMs platforms are totally broken when it comes to DMA.)
>> >
>> > Circular buffers are nice from the point of view of allowing you to
>> > (providing the hardware supports it) totally disable the periodic audio
>> > interrupts and leave the system to run for very long times off the
>> > normal system timers. ?This gives a small but non-zero power benefit
>> > providing the hardware gives you enough information about where the DMA
>> > is so you can find out if you need to mix in a notification, otherwise
>> > you get obvious latency issues.
>>
>> This is what I called free-running circular buffer.
>> Besides power saving scenario, it is necessary for a fast peripheral
>> with shallow fifo.
>
> Please stop perpetuating this myth. ?It is not necessary for fast
> peripherals with shallow fifos.

I would beg you to please spend some time understanding what exactly I say.
More so because I am not very good at communicating.


> What is necessary for such peripherals is to have a large enough pending
> DMA queue already in place that you don't encounter underrun errors.
> That means chaining up several sequential smaller buffers so that you
> can replenish the queue before the underrun occurs.
>
> Eg, if you have eight 8K buffers, you submit 7 of the 8K buffers when
> you start having filled those 7 with data. ?You prepare the 8th and
> when the 1st buffer completes, you submit the 8th buffer and start
> re-filling the 1st buffer. ?Then, when the 2nd buffer completes, you
> re-submit the 1st buffer and start filling the 2nd buffer. ?etc.

In short, a simple ALSA ring buffer ?


> If you get to the end of all the pending buffers before you can service
> the DMA interrupt, then you don't have the data in place to continue to
> feed the peripheral, so DMA will stop and _correctly_ you will get an
> underrun. ?Hint: no more data prepared _is_ the underrun condition so
> it is only right that DMA should stop at that point.

Of course. And I am not complaining about those s/w reported underruns/overruns.
BTW, instead of 7/8 we could also set the threshold in ALSA drivers to
require apps
to fill it 8/8 before triggering and that would keep the buffer filled
to the brim.


>> The peripheral throws underrun errors, if the dma h/w doesn't support
>> LLI and cpu takes
>> a bit long loading-triggering the next transfer on DMA due to
>> irq-latency for some reason.
>
> There is no difference between moving to the next buffer in a chain of
> buffers and having to re-load the DMA hardware to simulate a real
> circular DMA buffer.

There is difference as explained below.


> The only difference would be if the hardware provides you with support
> for circular buffers itself, but it would also need some way of generating
> an interrupt every X bytes transferred to support the requirements of
> ALSA, or some other way to track progress.

I am afraid not so. Ex, PL080 provides LLI mechanism using which can have
true circular buffer behaviour and yet get updates/irqs from the PL080.

Let me try to elaborate the difference ...

* In h/w supported Linked-List-Item(LLI), the DMA finishes one
transfer, triggers an irq and then continues with
transferring the next linked transfer item.
 Please note the dma is active and peripheral fifos always keep
receiving/providing data while cpu services the irq.  H/w like PL080
provides this LLI mechanism readily.

* In s/w emulated LLI (DMA API driver maintaining circularly linked
transfer requests)  the dma finishes one
programmed transfer, triggers an irq and _stop_ transferring data,
the cpu then program the DMA with next item in the list and triggers
the DMA operation.
 Please note, the peripheral fifos don't get any data after dma
transfer completes and before cpu program and trigger the dma again.
In this case, a 'fast peripheral with shallow fifo' might run out of
data before the next DMA transfer begins. And some IPs consider the
state as erroneous.
In real life, I saw that with the Samsung's SPDIF controller which has
fifo depth only for a few samples and it gets very demanding if pro
quality is expected. Aggravate that with high irq-latency under system
load.
And in such cases, it is much more preferable to employ system timers
to generate period_elapsed updates and queue the whole ring buffer as
one transfer item to be iterated endlessly by dma. Ex, PL330 doesn't
lend to LLI but can be programmed endlessly looping one transfer item.

In short, I am talking about FIFO underruns/overruns _between_ two DMA
transfers.
I am not talking about ring buffer overruns/underruns.

Thanks,
Jassi
