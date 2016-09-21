From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Wed, 21 Sep 2016 21:57:14 +0000
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.9
In-Reply-To: <CALRxmdDLRPLr3yD_wGW+3=thr8eZwX4DVGzMad0Gh7n-ERi+og@mail.gmail.com>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
 <2241121.MvRjeYAnGC@wuerfel> <20160916014703.GC7398@tiger>
 <6140062.uQFBQdfrcg@wuerfel>
 <CALRxmdDLRPLr3yD_wGW+3=thr8eZwX4DVGzMad0Gh7n-ERi+og@mail.gmail.com>
Message-ID: <VI1PR0401MB26380A4FF1141C69C4F364A58DF60@VI1PR0401MB2638.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, Sep 16, 2016 at 8:42 AM
> Subject: Re: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.9
> To: Shawn Guo <shawnguo@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>, arm at kernel.org,
> kernel at pengutronix.de, linux-arm-kernel at lists.infradead.org
> 
> 
> On Friday, September 16, 2016 9:47:03 AM CEST Shawn Guo wrote:
> > On Wed, Sep 14, 2016 at 05:30:49PM +0200, Arnd Bergmann wrote:
> > > On Monday, September 12, 2016 5:02:27 PM CEST Shawn Guo wrote:
> > > > i.MX arm64 device tree changes for 4.9:
> > > >  - Add property dma-coherent for ls2080a PCI device to save software
> > > >    cache maintenance.
> > > >  - Update serial aliases and use stdout-path to sepecify console for
> > > >    ls2080a and ls1043a boards.
> > > >  - Add DDR memory controller device node for ls2080a and ls1043a SoCs.
> > > >
> > >
> > > Pulled into next/dt64, thanks!
> > >
> > > The "dma-coherent" change sounds like a bugfix, should that be backported
> > > to stable kernels? Usually if you lack that property on a device that
> > > is actually coherent, you can get silent data corruption by treating it as
> > > non-coherent.
> >
> > My impression is that those cache maintenance enforced for non-coherent
> > device will hurt performance on coherent device.  I don't know it will
> > cause data corruption.
> 
> The problem is that the device in this case is accessing data from
> the cache, while the CPU bypasses the cache for coherent mappings.
> The cache might have a stale cache line as the device reads data, or
> it could be in a writeback configuration, where the data written
> from the device to the cache has not made it into RAM at the time it
> is accessed by the CPU.
> 
> For streaming mappings, the CPU will invalidate cache lines
> before reading the data, so again if the device has written data
> into the cache but not yet into memory, we will see stale data
> after dma_unmap_single().

I'm not following the potential data corruption issue.  In this case 
at least, DMA cohrerent devices are not directly reading or writing
any L1/L2 cache. If the device is writing a physical address, the write goes to
memory, and snoops invalidate any corresponding cache lines in L1/L2 caches.
If the device is reading a physical address, snoop transactions ensure that
dirty L1/L2 cache lines are written to memory and the device gets the right data.

The device is already sending the needed snoop transactions.  The problem
is that because of the missing dma-coherent property the kernel doesn't know it
and unnecessarily does invalidates/flushes.

Thanks,
Stuart
