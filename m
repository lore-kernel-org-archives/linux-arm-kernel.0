From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 2 Feb 2012 16:00:37 -0600
Subject: i.MX SDMA questions
Message-ID: <CAKGA1bnyY4pd4Ptw3X=e2j_E2gpS4kRZeu+1efjhSw9=2qffkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I guess Sascha would be best to answer these but if anyone has any
experience here it would be much appreciated;

We're trying to bring up UDMA support for MX5 PATA and in doing so
we've found some small differences between the old Freescale driver
and the new dmaengine implementation, but some things which are
basically the same from a high level point of view. What we're
currently mulling over is basically how channels are allocated and
mapped and what the relevance is to the dma request numbers in
arch/arm/plat-mxc/include/mach/mx51.h actually play a role.

With so few users of the API on MX5 it's hard to find "correct"
operation as they all have subtle differences in when and where they
do their DMA. My only references right now are the SSI driver (which
is annoyingly abstract in it's DMA usage), the FSL/Linaro SPDIF driver
(which is cleaner but seems to be incomplete after setup, and doesn't
actually use any dma in the codec or fabric, which makes it all the
more confusing) and the drivers from MX3 which use the same dmaengine
(SD controller etc.).

With regards to the original Freescale ATA driver it seems to allocate
two channels, one for receive and one for transmit - looking at the
SSI driver, it also grabs two channels, one for receive and one for
transmit. There are THREE dma request ids in the mx51.h include (rx,
tx and tx_end) which I am not sure what they are meant to map to (the
only things with similar names are fifo alarms). Since ATA is a
dynamic channel allocation, and the script code is picked by setting
the peripheral_type and the direction is mapped by slave_config
fields, do we actually need two DMA channels, or can we reuse the same
one and change the slave config (I note that the SSI driver does not,
but I kind of assume this is because there are two FIFOs, and a
possibility of playing and recording audio at the same time, but on
ATA there is only one and accesses are implicitly consecutive?)

So here are the big questions;

Does the ATA driver need to know those 3 MX51_DMA_REQ_ATA_*
assignments, and what are they used for anyway apart from stuffing
into the request structure? Are these just SDMA events fired when
peripherals have a FIFO alarm as I assume (and what is #define
MX51_DMA_REQ_GPU 15? That's not in the manual, on MX51 it's IOMUX GPIO
1_5 and on MX53 it's the SPDIF TX DMA request :) If we are manhandling
the DMA (libata setup/start/status/stop) do we need to do something
about these events?

Do we need two or just one channel if we can change the slave config
to change direction?

There are a couple of tweaks we may need to make to sdma channel setup
for ATA (FSL's driver turns off interrupts after every buffer
descriptor specifically for ATA) besides, but the platform data
required - or not required as the case may be - and the actual
specific steps to get a channel (or more than one, and reasons for
using more than one) are seemingly a mystery from that point of view.
Some drivers just request a channel, others get platform data from
those MX51_DMA_REQ values and use them in the DMA request and we can't
tell whether this is required since all the channels besides IRAM
usage are dynamic?

Goal after pata_dma is somehow implement DMA_MEMCPY cap and find
places to use it since I think it's fairly easy to add, but finding
users for asynchronous memcpy is going to be a difficult one (although
enabling NET_DMA would be cool). Are we ready for that kind of feature
on i.MX?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
