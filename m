From: matt@genesi-usa.com (Matt Sealey)
Date: Sun, 5 Feb 2012 13:35:33 -0600
Subject: i.MX SDMA questions
In-Reply-To: <CAKGA1bnyY4pd4Ptw3X=e2j_E2gpS4kRZeu+1efjhSw9=2qffkQ@mail.gmail.com>
References: <CAKGA1bnyY4pd4Ptw3X=e2j_E2gpS4kRZeu+1efjhSw9=2qffkQ@mail.gmail.com>
Message-ID: <CAKGA1bmQ09p9EfBHe0m+PhEHhTU9GocoaxfVnJFr-s4fjE54-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Top posting because I want to reframe by questions :)

Basically there are two ways we can do DMA here - take advantage of
the SDMA unit and it's events to "enable" a channel (which I find by
arduous code reading is done at slave config time) to receive events,
and enable the peripheral to respond to SDMA events (in libata this is
done at bmdma_setup and then bmdma_start). In this case the ATA FIFO
seems to be handled internally by the SDMA script so I don't need to
tell it (and Freescale's driver also doesn't) where the FIFO is for
transfer.. I'm still trying to figure out how I actually set this up
(why does the SSI dma usage require the RX/TX fifo addresses but ATA
not? I assume only because there are multiple SSI units and it's
easier to script as a variable than to have different scripts per SSI
unit? :)

Apart from that, would it be safe/happy usage of SDMA to request a
channel on probe and never release it OR are we expected to request,
configure, run and free the channel at every transfer setup so as to
give back to the pool of available channels?

The other way is to simply use the DMA unit to perform DMA transfers
from the ATA drive data register (a 16-bit value) - we can do this if
we override ata_sff_data_xfer and somehow configure a DMA operation to
read from or write to a particular portion of memory with an
incrementing counter, while the transfer location stays fixed. Given
SDMA is script based, is there a generic script for "read 16 bytes of
data, increment read counter, throw at fifo"? What do I set as my
peripheral_type? There is a script "ap_2_ap_fixed_addr" which is never
referenced?

Also also, Freescale's driver seems to have an optional "use IRAM"
option, did this ever prove fruitful/higher performance or did it just
destroy worlds and wasn't worth reimplementing? I noticed
plat-mxc/iram_alloc.c doesn't use gen_pool's built-in virtual to
physical conversion utility function (which got implemented recently).
Is this driver best split somewhere else than platform code too (since
an SRAM pool is a very reasonably common function I somehow don't
think it needs to be i.MX specific anyway). I can do that if need be.

Since these scripts are an infuriating blob with no docs, Sascha, did
you ever get any docs for it, if so what did you bug Freescale for to
get it (so I can bug them and get it too)..?

My main questions are now basically what SDMA code is actually in the
SDMA "ROM" (i.e. before scripts are loaded from request_firmware
binary blobs), and what the expected function of these scripts are. If
that information is contained in docs from Freescale I just need a
pointer on what to ask for..

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.



On Thu, Feb 2, 2012 at 4:00 PM, Matt Sealey <matt@genesi-usa.com> wrote:
> I guess Sascha would be best to answer these but if anyone has any
> experience here it would be much appreciated;
>
> We're trying to bring up UDMA support for MX5 PATA and in doing so
> we've found some small differences between the old Freescale driver
> and the new dmaengine implementation, but some things which are
> basically the same from a high level point of view. What we're
> currently mulling over is basically how channels are allocated and
> mapped and what the relevance is to the dma request numbers in
> arch/arm/plat-mxc/include/mach/mx51.h actually play a role.
>
> With so few users of the API on MX5 it's hard to find "correct"
> operation as they all have subtle differences in when and where they
> do their DMA. My only references right now are the SSI driver (which
> is annoyingly abstract in it's DMA usage), the FSL/Linaro SPDIF driver
> (which is cleaner but seems to be incomplete after setup, and doesn't
> actually use any dma in the codec or fabric, which makes it all the
> more confusing) and the drivers from MX3 which use the same dmaengine
> (SD controller etc.).
>
> With regards to the original Freescale ATA driver it seems to allocate
> two channels, one for receive and one for transmit - looking at the
> SSI driver, it also grabs two channels, one for receive and one for
> transmit. There are THREE dma request ids in the mx51.h include (rx,
> tx and tx_end) which I am not sure what they are meant to map to (the
> only things with similar names are fifo alarms). Since ATA is a
> dynamic channel allocation, and the script code is picked by setting
> the peripheral_type and the direction is mapped by slave_config
> fields, do we actually need two DMA channels, or can we reuse the same
> one and change the slave config (I note that the SSI driver does not,
> but I kind of assume this is because there are two FIFOs, and a
> possibility of playing and recording audio at the same time, but on
> ATA there is only one and accesses are implicitly consecutive?)
>
> So here are the big questions;
>
> Does the ATA driver need to know those 3 MX51_DMA_REQ_ATA_*
> assignments, and what are they used for anyway apart from stuffing
> into the request structure? Are these just SDMA events fired when
> peripherals have a FIFO alarm as I assume (and what is #define
> MX51_DMA_REQ_GPU 15? That's not in the manual, on MX51 it's IOMUX GPIO
> 1_5 and on MX53 it's the SPDIF TX DMA request :) If we are manhandling
> the DMA (libata setup/start/status/stop) do we need to do something
> about these events?
>
> Do we need two or just one channel if we can change the slave config
> to change direction?
>
> There are a couple of tweaks we may need to make to sdma channel setup
> for ATA (FSL's driver turns off interrupts after every buffer
> descriptor specifically for ATA) besides, but the platform data
> required - or not required as the case may be - and the actual
> specific steps to get a channel (or more than one, and reasons for
> using more than one) are seemingly a mystery from that point of view.
> Some drivers just request a channel, others get platform data from
> those MX51_DMA_REQ values and use them in the DMA request and we can't
> tell whether this is required since all the channels besides IRAM
> usage are dynamic?
>
> Goal after pata_dma is somehow implement DMA_MEMCPY cap and find
> places to use it since I think it's fairly easy to add, but finding
> users for asynchronous memcpy is going to be a difficult one (although
> enabling NET_DMA would be cool). Are we ready for that kind of feature
> on i.MX?
>
> --
> Matt Sealey <matt@genesi-usa.com>
> Product Development Analyst, Genesi USA, Inc.
