From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 2 Apr 2010 01:23:37 +0200
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <k2q1b68c6791003312234qe5da41e7oa1a0c7f535dbb179@mail.gmail.com>
References: <4BAAD5BB.7050101@samsung.com>
	<1b68c6791003242234h106d9530p12b5a046a906227e@mail.gmail.com>
	<63386a3d1003250130w6f34854ag2ca163799e9b7bed@mail.gmail.com>
	<1b68c6791003250517y4e2789baoe147e5982c363682@mail.gmail.com>
	<63386a3d1003250820x3cf81000i9d27e95c755b9ca8@mail.gmail.com>
	<k2q1b68c6791003312234qe5da41e7oa1a0c7f535dbb179@mail.gmail.com>
Message-ID: <t2t63386a3d1004011623m43212bb4z4dde424b30e3d184@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

this is looking good.

The only advantage of the other driver by Joonyoung is that it is finished and
ready for integration. If you finalize the DMA devices/engine API and post
this in time for the next merge window I would easily vote for including this
one rather than the other one. (Whatever that means for the world.)
Simply for technical merits.

It's sad that you two have done duplicate work but such is life..

I understand it that as this is the core engine so you intend to keep the core
in arch/arm/common/* and then a separate interface to the DMAdevices
implementing <linux/dmaengine.h> in drivers/dma/ and this is what the
"DMA API" referenced below refers to?

In that case I really like this clear separation between hardware driver
and DMA devices/engine API. And I see that the DMA API is not far
away. If you implement it you will be able to excersise this with the
DMA engine memcpy test to assure it's working.

There is nothing wrong with moving this entire thing except the header
file into drivers/dma it will be more comfortable there, with the other
DMA drivers. Whether the header should be in include/linux/amba
or include/linux/dma is however a good question for the philosophers,
but I would stick it into linux/amba with the rest of the PrimeCells.
But perhaps you have better ideas.

2010/4/1 jassi brar <jassisinghbrar@gmail.com>:

> o ?The DMA API driver submits 'request' to PL330 engine.
> ? ? A request is a sequence of DMA 'xfers' to be done before the DMA
> API driver wants to be notified.

This hints that there is some other patch to provide that API
<linux/dmaengine.h> that is not part of this patch, right?

> ? ? A req can be a scatter-Gather-List.

This is great, do you also plan to support that for M<->M xfers like we
added for the DMA40? Then we might want to lift that into the generic
DMA engine.

> o ?PL330 engine accepts requests from DMA API drivers in ping-pong manner,
> ? ?i.e, at any time maximum two reqs can be queued. Other reqs have
> ? ?to be buffered by DMA API drivers and enqueued whenever a req-finish
> ? ?callback is made.

Nice!

> o ?TODO: Desirable is to implement true LLI using MicroCode
> modification during each
> ? ?request enqueue, so that the xfer continues even while IRQ is
> handled and callbacks made.
> ? ?To me, there doesn't seem to be a way to flush ICACHE of a channel
> without halting it, so we
> ? ?can't modify MicroCode in runtime. Using two channels per client
> to achieve true LLI is the last resort.

True, not as elegant as being able to do it with microcode but
still quite elegant.

> ? ?So currently, cpu intervention is required to trigger each xfer,
> hence interrupt latency might play
> ? ?some role.
