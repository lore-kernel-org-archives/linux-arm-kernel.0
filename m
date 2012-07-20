From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 20 Jul 2012 15:07:27 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <201207200839.24259.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201207171924.33756.arnd@arndb.de> <1342756850.1726.74.camel@vkoul-udesk3>
 <201207200839.24259.arnd@arndb.de>
Message-ID: <1342777047.1726.435.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-20 at 08:39 +0000, Arnd Bergmann wrote:
> On Friday 20 July 2012, Vinod Koul wrote:
> > > Required property:
> > >     dmas: list of one or more dma specifiers, each consisting of
> > >      - phandle pointing to dma controller node
> > >      - flags word, a bit map that can hold these flags
> > >        * 0x00000001 channel can be used for transfer from device
> > >        * 0x00000002 channel can be user for transfer to device
> >
> > Is this for identifying which channel is for TX and RX? If not I am not
> > sure I understood it well
> 
> Yes, but we can potentially add more flags here.
> 
> The argument we had when coming up with this was roughly:
> 
> * we need to identify which specifiers are referring to the same
>   conceptual channel and can be used as alternatives
> * this could be done just using the dma-names property, but making
>   dma-names mandatory adds complexity for everyone.
> * Most devices have just one or two channels, and if they have two,
>   there is usually one input and one output.
> 
> => if the common dmaengine code can find out whether a channel is
>   input or output without looking at the dmac driver specific configuration,
>   we don't need to add dma-names in most cases, but just let the client
>   driver ask for "give me a channel with these flags".
No we don't export the direction of the channel and usually channel can
be configured either way.
But from a client POV it makes sense as with the given direction you
would need a specific request line for a channel. So this is right.
But direction is something I don't expect to be used for "give me a
channel" 

> > > 4. A dma controller requiring complex configuration:
> > > 
> > >        dma: dmaengine at 48000000 {
> > >                compatible = "foo,foo-sdma"
> > >                reg = <0x48000000 0x1000>;
> > >                interrupts = <4>;
> > >                #dma-cells = <6>; /* phandle, flag, request, channel,
> > >                                        input-width, output-width */
> >
> > Why would we want the widths to be here?
> > Assuming a DMA from System memory to a peripheral, source width should
> > be system memory width and destination the peripheral width. IMO these
> > should not be in dma property even if we need these
> 
> I was just trying to come up with an example of something we might put
> into the additional configuration fields. This may or may not be a
> realistic one, I have no idea. If you know something else that one
> of the dma controllers might want to put in there, we should change the
> example.
> 
> I took the example of data width from 'struct stedma40_chan_cfg', which
> is used in some places to configure this from platform data. My
> impression was that if we want to move that data from board files into
> the device tree, it has to be here, but it can well be that there is
> a better place for it, e.g. in the global (channel independent)
> configuration of the dmac.
> 
> 	Arnd


-- 
~Vinod
