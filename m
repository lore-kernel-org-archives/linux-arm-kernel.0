From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jul 2018 19:13:03 +0100
Subject: [PATCH v2 7/7] OF: Don't set default coherent DMA mask
In-Reply-To: <c7a9c7ae-1f4a-af9d-df78-1f48bb5c28a5@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
 <66c08e4df2032fde82a2f97544f41fd3a2f24a94.1532382222.git.robin.murphy@arm.com>
 <4ed75bc9-1694-2bcb-2ea9-3f2a04f33f54@ti.com>
 <92d6b010-b5c0-fc59-0668-5b455e26c912@ti.com>
 <c7a9c7ae-1f4a-af9d-df78-1f48bb5c28a5@arm.com>
Message-ID: <20180727181302.GC17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 12:36:00PM +0100, Robin Murphy wrote:
> That is intentional. Consider a 32-bit device on a bus with an upstream DMA
> range of 40 bits (which could easily happen with e.g. PCI). If the firmware
> code gives that device 40-bit DMA masks and the driver doesn't change them,
> then DMA is not going to work correctly. Therefore the firmware code cannot
> safely make {coherent_}dma_mask larger than the default value passed in, and
> if the default is 0 then that should be fixed in whatever code created the
> device, not worked around later.

I think you're missing the point.

When OF creates platform devices, they are created without any DMA masks
what so ever.  It is only during device probe that dma_configure() gets
called, which then calls of_dma_configure(), where the DMA mask for any
DT declared device is setup.

What this means is that your change has broken all existing DT devices
that are trying to use DMA, because they now end up with a zero coherent
DMA mask and/or streaming DMA mask.

Your original idea behind the patch may be a sound one, but since the
implementation has caused a regression, the implementation is obviously
broken, and that needs fixing or reworking in some way.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
