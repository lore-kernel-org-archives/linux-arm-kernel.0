From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 20 Apr 2012 23:11:08 +0200
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120420053014.GK22219@S2101-09.ap.freescale.net>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
 <4F73CCC6.6000001@freescale.com>
 <20120329064320.GA20840@pengutronix.de>
 <20120418090551.GA30966@shlinux2.ap.freescale.net>
 <20120418092019.GB2232@pengutronix.de>
 <20120420053014.GK22219@S2101-09.ap.freescale.net>
Message-ID: <20120420211108.GC12691@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 01:30:17PM +0800, Shawn Guo wrote:
> On Wed, Apr 18, 2012 at 11:20:19AM +0200, Wolfram Sang wrote:
> > > If not, i guess include/linux/fsl which already exists may be the
> > > right place.
> > 
> > Which is a bad choice in my book. linux/dma would have been the proper
> > thing for mxs-dma.h, I'd think.
> > 
> If it already exists, it will be the proper place.  We do not want to
> be too invasive to create folders in include/linux for every subsystem
> for only the need of fsl drivers.

I think linux/dma would have made sense:

$:~/Kernel/linux/include/linux$ ll *dma*
-rw-r--r-- 1 ninja ninja  1809 Apr 15 23:32 dma-attrs.h
-rw-r--r-- 1 ninja ninja  8343 Apr 15 23:32 dma-buf.h
-rw-r--r-- 1 ninja ninja  4915 Aug 20  2011 dma-debug.h
-rw-r--r-- 1 ninja ninja   299 Nov  8 20:06 dma-direction.h
-rw-r--r-- 1 ninja ninja 33123 Apr 16 11:47 dmaengine.h
-rw-r--r-- 1 ninja ninja  7018 Apr 15 23:32 dma-mapping.h
-rw-r--r-- 1 ninja ninja   923 Aug 20  2011 dmapool.h
-rw-r--r-- 1 ninja ninja  1288 Mar 30 22:12 dma_remapping.h
-rw-r--r-- 1 ninja ninja  6933 Mar 30 22:12 dmar.h
-rw-r--r-- 1 ninja ninja  3203 Apr 15 23:32 dw_dmac.h
-rw-r--r-- 1 ninja ninja   157 Aug 20  2011 init_ohci1394_dma.h
-rw-r--r-- 1 ninja ninja  2463 Aug 20  2011 intel_mid_dma.h
-rw-r--r-- 1 ninja ninja  3305 Apr 15 23:32 nfs_idmap.h
-rw-r--r-- 1 ninja ninja   999 Aug 20  2011 pch_dma.h
-rw-r--r-- 1 ninja ninja   415 Aug 20  2011 pci-dma.h
-rw-r--r-- 1 ninja ninja   572 Apr 15 23:32 sa11x0-dma.h
-rw-r--r-- 1 ninja ninja  2631 Apr 15 23:32 sh_dma.h
-rw-r--r-- 1 ninja ninja   123 Mar 30 22:12 sirfsoc_dma.h
-rw-r--r-- 1 ninja ninja  1784 Aug 20  2011 timb_dma.h

> On the other hand, I have seen a clear need for include/linux/fsl.
> The following files are all good candidates to be moved there.
> 
>   include/linux/fsl_devices.h

I stumbled over this file some time ago. It is an arbitrary collection of stuff
which should better be seperate. See 'fsl_spi_platform_data'? That should be
cpm_spi_platform_data. It doesn't even fit to MPC5200 (which SPI driver
unnecessarily includes this file), let alone i.MX, so calling it 'fsl' doesn't
make sense at all. I fear similar confusion with a fsl-directory.

>   include/linux/fsl-diu-fb.h

Sadly, another bad choice. It should have gone to include/video like all other
fb-drivers.

>   include/linux/fsl_hypervisor.h

And that could simply stay in include/linux then, like kvm does.

> IMO, include/linux/stmp_device.h is just another good candidate.

Still not convinced, more the opposite.

> Oh, today I was asked by Fabio where is the good place for ssp-regs.h
> which will be shared by mxs-mmc and spi-mxs, as we are cleaning up
> <mach/*> from drivers.  I told him include/linux/fsl.

What's wrong with linux/spi? SPI devices capable of doing MMC as well shouldn't
be much of a surprise, they are common.

Also, what will happen if Freescale ever gets renamed?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120420/d3a18aca/attachment.sig>
