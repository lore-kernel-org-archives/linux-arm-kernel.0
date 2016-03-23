From: js@sig21.net (Johannes Stezenbach)
Date: Wed, 23 Mar 2016 17:23:09 +0100
Subject: dmaengine pl08x dt crash
In-Reply-To: <CACRpkdZ3ecJPcUfv7TTPhTT+rMtAC+b1=HfE3cH0OR=swvNi6w@mail.gmail.com>
References: <20160323154049.GA2170@sig21.net>
 <CACRpkdZ3ecJPcUfv7TTPhTT+rMtAC+b1=HfE3cH0OR=swvNi6w@mail.gmail.com>
Message-ID: <20160323162309.GA9472@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 05:12:13PM +0100, Linus Walleij wrote:
> On Wed, Mar 23, 2016 at 4:40 PM, Johannes Stezenbach <js@sig21.net> wrote:
> 
> > I'm trying to use the new devicetree support for pl08x
> > added in commit aa4734da667442
> > (dmaengine: pl08x: support dt channel assignment).
> >
> > It causes crash in the pl011 serial driver when it calls
> > dma_chan_name() because the dma_chan->dev->device is NULL.
> > I think the reason is dma_async_device_register() is called
> > during pl08x_probe(), but at this time the number of slave
> > channels is still 0 as these get allocated later in
> > pl08x_of_xlate() when clients request the channels.
> >
> > [    0.420835] pl08xdmac dma8ch0: initialized 8 virtual memcpy channels
> > [    0.427380] pl08xdmac dma8ch0: initialized 0 virtual slave channels
> > [    0.436185] pl08xdmac dma8ch0: DMA: PL080s rev1 at 0xfec00000 irq 8
> 
> So you are trying to use it on the Samsung S3C?

The platform is an internal development board with ARM11 based SoC.

> I have it working on the Nomadik, but for platforms with fixed signal
> assignement I had to apply these patches:
> https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-nomadik.git/log/?h=pl08x-dma
> 
> dma: pl08x: support fixed signal assignment
> dma: pl08x: allocate OF slave channel data at probe time
> 
> And the example:
> ARM: nomadik: add DMA engine and some channelspl08x-dma
> 
> I have meant to follow up on it but haven't gotten around to.
> 
> If the Samsung also has fixed channels (no mux in front of the
> DMA lines) I think this might be what you need. They are not
> yet merged because Joachim reported a crash with the second
> patch and I haven't yet figured out why.

I'll give it a try.  My platform also has fixed channels,
previously it used platform data but I always thought it is
ugly, so I tried the new dt support.

Thanks for quick reply.


Johannes
