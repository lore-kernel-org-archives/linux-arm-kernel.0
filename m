From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 13:43:52 +0200
Subject: [PATCH 1/2] arm: mvebu: increase atomic coherent pool size for
 armada 370/XP
In-Reply-To: <201210251127.36960.arnd@arndb.de>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
 <1351086561-13569-2-git-send-email-gregory.clement@free-electrons.com>
 <201210251127.36960.arnd@arndb.de>
Message-ID: <20121025134352.16a8ef81@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Thu, 25 Oct 2012 11:27:36 +0000, Arnd Bergmann wrote:
> On Wednesday 24 October 2012, Gregory CLEMENT wrote:
> > For Armada 370/XP we have the same problem that for the commit
> > cb01b63, so we applied the same solution: "The default 256 KiB
> > coherent pool may be too small for some of the Kirkwood devices, so
> > increase it to make sure that devices will be able to allocate their
> > buffers with GFP_ATOMIC flag"
> > 
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Do you know why the ATA driver needs this? I find it surprising that
> it's necessary, so I'd like to make sure we're not just working around
> a device driver bug here.

The sata_mv driver create dma_pool and allocate objects from them, and
all the memory allocated for dma_pools is allocated using
dma_alloc_coherent(), and I guess the driver is using too much of them.

Seems like the driver is too lazy and allocates everything coherent to
avoid the hassle of doing dma_map/dma_unmap operations when needed, but
I haven't looked in details at the driver yet to see if it would be
possible to switch those DMA coherent allocations into non-coherent
allocations + appropriate calls to the DMA operations.

That said, that's for sure a larger task than just enabling SATA on
Armada 370/XP, so I would advocate to handle this problem separately.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
