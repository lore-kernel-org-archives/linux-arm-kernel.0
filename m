From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Oct 2012 12:09:20 +0900
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.8
In-Reply-To: <20121018081310.GA27117@verge.net.au>
References: <1350448698-26985-1-git-send-email-horms@verge.net.au>
 <201210171342.29635.arnd@arndb.de>
 <20121018005811.GA4325@verge.net.au> <4502243.v9vY3prCgE@wuerfel>
 <20121018081310.GA27117@verge.net.au>
Message-ID: <20121019030917.GA6644@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 05:13:10PM +0900, Simon Horman wrote:
> On Thu, Oct 18, 2012 at 07:29:30AM +0000, Arnd Bergmann wrote:
> > On Thursday 18 October 2012 09:58:11 Simon Horman wrote:
> > > On Wed, Oct 17, 2012 at 01:42:29PM +0000, Arnd Bergmann wrote:
> > > > On Wednesday 17 October 2012, Simon Horman wrote:
> > > > > Hi Olof, Hi Arnd,
> > > > > 
> > > > > please consider the following defconfig enhancements for 3.8.
> > > > 
> > > > These look good to me, but I wonder what happened to the plan to reduce
> > > > the number of defconfig files we discussed before. Since you can build
> > > > a combined kernel that runs on all (or most) of the supported boards,
> > > > can you add a combined shmobile_defconfig that is able to work on
> > > > a wide variety of hardware and drop some of the less common defconfig
> > > > files?
> > > > 
> > > > Most of the modern platforms nowadays have just one defconfig that
> > > > covers everything.
> > > 
> > > Hi Arnd,
> > > 
> > > I wonder if such consolidation only makes sense for boards that
> > > make use of DT. If so, I can see that we may be able to come
> > > up with a single configuration for the Armadillo800eva, KZM9G
> > > and KZM9D boards. But not for older boards such as the Mackerel which
> > > have not been converted to use DT.
> > 
> > Usually you should just be able to enable any boards together,
> > independent of whether they are using DT or not. It's possible
> > that shmobile does something different from the other platforms
> > that I'm not aware of, of course. If you look at e.g.
> > omap2plus_defconfig or imx_v6_v7_defconfig, they both enable
> > all the available boards.
> 
> Thanks, I'll see what I can do within the scope of the boards
> that I have access to.
> 
> > > I am also wondering if more of the drivers that SH Mobile uses need to
> > > become DT aware before a consolidated configuration can work.  In
> > > particular, I am thinking about the SCI serial driver and the location of
> > > the serial port that can be used for serial console and early printk - this
> > > features in the kernel command line of the per-board defconfigs and is
> > > relied on by developers.
> > 
> > Device drivers that don't use DT should get their configuration from
> > platform_data. The command line can be used to override those, but it's
> > also normally passed by the boot loader, which also has to configure
> > e.g. how much memory is present or which uart to use.
> 
> Understood.

I have made a limited amount of progress on this trying to create a
defconfig that will work on both the Marzen and Armadillo 800 EVA boards.

* Serial console appears to work, although for the Marzen at
  least enabling earlyprintk seems to require the bootloader to specify
  e.g.  console=ttySC2,115200 earlyprintk

  This is done by fully specifying bootargs in U-Boot.
  The boodloaders on the Marzen board has an ampty bootargs by default.

  I guess I can live without earlyprink by default,
  though it does seem to be a regression in the user experience.

* A more significant problem seems to be the use of CONFIG_MEMORY_START
  to define PLAT_PHYS_OFFSET in arch/arm/mach-shmobile/include/mach/memory.h

  I'm not sure that I see an easy way to get around this one.
