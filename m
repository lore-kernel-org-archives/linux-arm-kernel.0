From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Mar 2017 19:59:01 +0000
Subject: [Question] devm_kmalloc() for DMA ?
In-Reply-To: <fd2097a1-c9b5-e6ab-f3b3-04b432bda0a3@metafoo.de>
References: <CAK7LNARbD262isY7yOgQKAcbWQHV+3dsoRjtu6S+qUpPr98qSQ@mail.gmail.com>
 <b7dd01e6-ddcd-a34a-c26c-05ce6ae4015a@arm.com>
 <CAK7LNAQ3FbicgoV1Q70T2gZQS0j1Z8LffXquSM=v6DYcHP_m4Q@mail.gmail.com>
 <fd2097a1-c9b5-e6ab-f3b3-04b432bda0a3@metafoo.de>
Message-ID: <20170308195901.GD21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 08:48:31PM +0100, Lars-Peter Clausen wrote:
> When the DMA memory is mapped for reading from the device the associated
> cachelines are invalidated without writeback. There is no guarantee that
> the changes made to the devres_node have made it to main memory yet, or
> is there?

That is incorrect.

Overlapping cache lines are always written back on transitions from CPU
to device ownership of the buffer (eg, dma_map_*().)

Updates that are made by the CPU on overlapping cache lines while the
memory is mapped for DMA may end up doing one of two things: either
overwriting the newly DMA'd data, or being lost altogether.

In the case of devm_* list manipulations, these should only ever happen
during device probe and tear down, and if DMA is active at those times,
the driver is seriously buggy.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
