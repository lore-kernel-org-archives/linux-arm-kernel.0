From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 16:09:28 +0200
Subject: [PATCH 1/2] arm: mvebu: increase atomic coherent pool size for
 armada 370/XP
In-Reply-To: <201210251346.41596.arnd@arndb.de>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
 <201210251127.36960.arnd@arndb.de> <20121025134352.16a8ef81@skate>
 <201210251346.41596.arnd@arndb.de>
Message-ID: <20121025160928.53daf18a@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 25 Oct 2012 13:46:41 +0000, Arnd Bergmann wrote:

> > Seems like the driver is too lazy and allocates everything coherent
> > to avoid the hassle of doing dma_map/dma_unmap operations when
> > needed, but I haven't looked in details at the driver yet to see if
> > it would be possible to switch those DMA coherent allocations into
> > non-coherent allocations + appropriate calls to the DMA operations.
> 
> Using coherent allocations is fine, I was wondering whether they need
> to be atomic or not.

You're raising a good point here: all the dma_pool_alloc()
allocations done by sata_mv are GFP_KERNEL. So why are we having
problems with the /atomic/ coherent pool size? Is it the libata core
that's doing GFP_ATOMIC DMA coherent allocations. It doesn't seem so.
Something's odd.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
