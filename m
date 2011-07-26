From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jul 2011 19:14:41 +0100
Subject: [PATCH V4 06/14] ARM: SAMSUNG: Add common DMA operations
In-Reply-To: <CABb+yY2rQXxHGJuvhtJGgrCsoFZgsACHWUEV0L-kpqaDaCFAQA@mail.gmail.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-7-git-send-email-boojin.kim@samsung.com>
	<CABb+yY0nWLpdVGqTJPO2YwkGWiDw5tRjC2xn7Le0bO0ZNFHC_g@mail.gmail.com>
	<20110726080233.GN9653@n2100.arm.linux.org.uk>
	<CABb+yY2rQXxHGJuvhtJGgrCsoFZgsACHWUEV0L-kpqaDaCFAQA@mail.gmail.com>
Message-ID: <20110726181441.GE1655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 11:13:35PM +0530, Jassi Brar wrote:
> Before we start, let me be clear that I don't say it's all possible
> today as such.

It _is_ possible today.

1. Arrange for individual DMA engine drivers to provide a filter
   function - eg, pl08x_filter_id() for pl08x channels.

2. Have the filter function check chan->device->dev->driver == its
   own struct driver as the very first thing, and reject on failure.

3. Have its own matching algorithm using whatever data is appropriate
   for the DMA engine driver.

4. Platforms (or SoC code) provide the match function plus match data
   via platform data to each driver.

That is essentially (except for (2)) how we deal with differing DMA
engine drivers with AMBA peripherals, and it seems to work remarkably
well.

> I hope we agree, clients (esp 'generic' ones of the future)
> should not ask for channels from a particular dmac.
> They should simply tell DMA API, what capabilities they expect
> from the allocated channel - of whatever index on whichever dmac.
> And the platform should have specified capabilities of a channel
> while introducing it to the DMA API.   Yes, imho, DMA API should
> only work with a pool of channels and not dmacs - it shouldn't
> matter from which dmac a channel comes.

You're quite clearly confused.  "DMA API" has not very much to do with
the subject we're discussing.  The "DMA API" is the API for mapping and
unmapping buffers for DMA.  It has not much to do with the DMA engine
API.  So I'm not going to bother trying to decode what you said above
until you start using the right terminology.  I'm a stickler for that,
get used to it.

No point talking about how round bananas are when you're actually
discussing orange fruit.

> So when a client asks for a channel, the dmaengine would return
> the first free channel that has just as much the requested capability.

No.  For slave DMA, peripheral drivers normally need a specific
channel on the DMA controller.  Peripheral drivers normally do not
know which channel they need, or even which DMA controller they
require.  That information is specific to the platform and SoC.

So, returning the "first free channel that matches the capability"
is senseless - insane - for slave DMA.

> That is, the generic filter function would look equivalent of :-
> 
>       return is_free(chan) && (cap_requested == cap_of(chan) & cap_requested)
> 
> 
> Now it all boils down to defining the set of _practically_ possible capabilities
> and a method to exchange them between the API, Client and DMAC drivers.

What are these capabilities?

> The above is the overall approach.
> 
> The following is my idea of implementing it as of now, I am open to suggestions.
> 
> Assuming :-
> ***********
> There are no more than 256 types of DMA'able devices
>  (MMC, USB, SPI etc) --  [8bits]
> 
> A type of device never has more than 16 instances in a platform
>  (MMC-0, MMC-1, MMC-2 etc) --  [4bits]
> 
> Mem->Mem, Mem->Dev, Dev->Mem, Dev->Dev capability in [4bits]

No.  You're being far too specific to your own DMA controller.  Many
DMA controllers (eg, PL08x) have a number of physical channels, all of
which can be programmed for M2M, M2P, P2M and P2P.  There is nothing
in the design which restricts what a channel can do.

So to put that as the basis for a generic match algorithm is absolutely
senseless.

> Max_Burst_Len for any channel is less than 64KB, in power of two [4bits]
> Support programmable Max_Burst_Len(tunable in geometric steps of 2)  [1bit]
> 
> Max_RW_width/fifo_width is less than 128, in power of two -- [3bits]
> Support programmable Max_RW_Width(tunable in geometric steps of 2)  [1bit]
> 
> Finally, No platform has more than 128 channels with identicial
> capabilities [7bits]

There is absolutely no way that this will work in reality - are you on
a different planet?  As has already been described to you, MMCI can
use one DMA channel, and programs it according to the DMA direction,
and has in the past adjusted the burst size according to what's going
on with the driver.

With your model, it would have to claim N channels from the DMA
engine for all possible different configurations.

That's utterly unworkable and unrealistic.

So no, I don't think your idea of 'capabilities' is any solution.  It
just creates yet more problems - more than it solves.
