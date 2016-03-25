From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 26 Mar 2016 00:34:39 +0100
Subject: dmaengine pl08x dt crash
In-Reply-To: <20160323154049.GA2170@sig21.net>
References: <20160323154049.GA2170@sig21.net>
Message-ID: <CACRpkdZKpm3MVO+ABpCmOdkHdmpnUeqK75c=oGbqDyGeFA92xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 4:40 PM, Johannes Stezenbach <js@sig21.net> wrote:

> I'm trying to use the new devicetree support for pl08x
> added in commit aa4734da667442
> (dmaengine: pl08x: support dt channel assignment).
>
> It causes crash in the pl011 serial driver when it calls
> dma_chan_name() because the dma_chan->dev->device is NULL.
> I think the reason is dma_async_device_register() is called
> during pl08x_probe(), but at this time the number of slave
> channels is still 0 as these get allocated later in
> pl08x_of_xlate() when clients request the channels.

The more I look at this the more broken it looks.

The channels NEED to be present when
dma_async_device_register() is called or their
sysfs devices will never get initialized, this is used by
the core code and thus we get this NULL dereference
from dma_chan_name().

I think the only system currently using this is the LPCs,
and it works because they are using a mux
(drivers/dma/lpc18xx-dmamux.c) in front of the DMA
engine. Thus the dma_chan_name() will go to the
mux intermediary channel, not to the actual channel.

I sort of feel like the mux code should just call
dma_chan_name() on the channels it handles to
make a point...

I think the patch I made entitled
"dma: pl08x: allocate OF slave channel data at probe time"
must be applied, and a harsher version at that: one
that DELETE the dynamic channel allocation in pl08x_of_xlate(),
obviously the dmaengine core is not supposed to be used
like that. If we want to create slave channels on-the-fly, the code
inside dma_async_device_register() that create sysfs entries
etc need to be factored out and made use of from the xlate().

Yours,
Linus Walleij
