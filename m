From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Apr 2012 11:09:42 +0000
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120420211108.GC12691@pengutronix.de>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <20120420053014.GK22219@S2101-09.ap.freescale.net>
 <20120420211108.GC12691@pengutronix.de>
Message-ID: <201204211109.42732.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 April 2012, Wolfram Sang wrote:
> On Fri, Apr 20, 2012 at 01:30:17PM +0800, Shawn Guo wrote:
> > On Wed, Apr 18, 2012 at 11:20:19AM +0200, Wolfram Sang wrote:
> > > > If not, i guess include/linux/fsl which already exists may be the
> > > > right place.
> > > 
> > > Which is a bad choice in my book. linux/dma would have been the proper
> > > thing for mxs-dma.h, I'd think.
> > > 
> > If it already exists, it will be the proper place.  We do not want to
> > be too invasive to create folders in include/linux for every subsystem
> > for only the need of fsl drivers.
> 
> I think linux/dma would have made sense:
> 
> $:~/Kernel/linux/include/linux$ ll *dma*
> -rw-r--r-- 1 ninja ninja  1809 Apr 15 23:32 dma-attrs.h
> ...
> -rw-r--r-- 1 ninja ninja  2631 Apr 15 23:32 sh_dma.h
> -rw-r--r-- 1 ninja ninja   123 Mar 30 22:12 sirfsoc_dma.h
> -rw-r--r-- 1 ninja ninja  1784 Aug 20  2011 timb_dma.h

+1

> > On the other hand, I have seen a clear need for include/linux/fsl.
> > The following files are all good candidates to be moved there.
> > 
> >   include/linux/fsl_devices.h
> 
> I stumbled over this file some time ago. It is an arbitrary collection of stuff
> which should better be seperate. See 'fsl_spi_platform_data'? That should be
> cpm_spi_platform_data. It doesn't even fit to MPC5200 (which SPI driver
> unnecessarily includes this file), let alone i.MX, so calling it 'fsl' doesn't
> make sense at all. I fear similar confusion with a fsl-directory.

Agreed. I would much prefer to avoid any such vendor specific silos for where to
dump random code. A file for a company that makes both powerpc and arm SoCs
that have a few components in common but also share other components with other
SoCs of the respective architectures does not seem very useful to me.

> >   include/linux/fsl-diu-fb.h
> 
> Sadly, another bad choice. It should have gone to include/video like all other
> fb-drivers.
> 
> >   include/linux/fsl_hypervisor.h
> 
> And that could simply stay in include/linux then, like kvm does.

Well, we could also have a linux/virt/ directory. Unfortunately in both these
cases we have no choice any more because they contain ioctl data structures
that are exported to user space, so we cannot move these files without
breaking user space programs and we don't do that.

	Arnd
