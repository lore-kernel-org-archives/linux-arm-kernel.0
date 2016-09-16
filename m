From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 15:42:07 +0200
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.9
In-Reply-To: <20160916014703.GC7398@tiger>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
 <2241121.MvRjeYAnGC@wuerfel> <20160916014703.GC7398@tiger>
Message-ID: <6140062.uQFBQdfrcg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 16, 2016 9:47:03 AM CEST Shawn Guo wrote:
> On Wed, Sep 14, 2016 at 05:30:49PM +0200, Arnd Bergmann wrote:
> > On Monday, September 12, 2016 5:02:27 PM CEST Shawn Guo wrote:
> > > i.MX arm64 device tree changes for 4.9:
> > >  - Add property dma-coherent for ls2080a PCI device to save software
> > >    cache maintenance.
> > >  - Update serial aliases and use stdout-path to sepecify console for
> > >    ls2080a and ls1043a boards.
> > >  - Add DDR memory controller device node for ls2080a and ls1043a SoCs.
> > > 
> > 
> > Pulled into next/dt64, thanks!
> > 
> > The "dma-coherent" change sounds like a bugfix, should that be backported
> > to stable kernels? Usually if you lack that property on a device that
> > is actually coherent, you can get silent data corruption by treating it as
> > non-coherent.
> 
> My impression is that those cache maintenance enforced for non-coherent
> device will hurt performance on coherent device.  I don't know it will
> cause data corruption.

The problem is that the device in this case is accessing data from
the cache, while the CPU bypasses the cache for coherent mappings.
The cache might have a stale cache line as the device reads data, or
it could be in a writeback configuration, where the data written
from the device to the cache has not made it into RAM at the time it
is accessed by the CPU.

For streaming mappings, the CPU will invalidate cache lines
before reading the data, so again if the device has written data
into the cache but not yet into memory, we will see stale data
after dma_unmap_single().

	Arnd
