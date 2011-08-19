From: tixy@yxit.co.uk (Tixy)
Date: Fri, 19 Aug 2011 10:08:21 +0100
Subject: [PATCH 06/12] ARM: mxc: Setup consistent dma size at boot time
In-Reply-To: <20110818185128.GQ31404@pengutronix.de>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
	<1312813712-22808-7-git-send-email-tixy@yxit.co.uk>
	<20110808164731.GP31404@pengutronix.de>
	<alpine.LFD.2.00.1108172309450.20358@xanadu.home>
	<1313655216.2254.9.camel@computer2>
	<20110818185128.GQ31404@pengutronix.de>
Message-ID: <1313744901.28978.16.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-18 at 20:51 +0200, Sascha Hauer wrote:
> On Thu, Aug 18, 2011 at 09:13:36AM +0100, Tixy wrote:
> > On Wed, 2011-08-17 at 23:12 -0400, Nicolas Pitre wrote:
> > > On Mon, 8 Aug 2011, Sascha Hauer wrote:
> > > 
> > > > Hi Jon,
> > > > 
> > > > On Mon, Aug 08, 2011 at 03:28:26PM +0100, Jon Medhurst wrote:
> > > > > Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> > > > > CC: Sascha Hauer <kernel@pengutronix.de>
> > > > > CC: Amit Kucheria <amit.kucheria@canonical.com>
> > > > > ---
> > > > >  arch/arm/plat-mxc/include/mach/common.h |    1 +
> > > > >  arch/arm/plat-mxc/include/mach/memory.h |   15 ---------------
> > > > >  arch/arm/mach-imx/mm-imx1.c             |    1 +
> > > > >  arch/arm/mach-imx/mm-imx21.c            |    1 +
> > > > >  arch/arm/mach-imx/mm-imx25.c            |    1 +
> > > > >  arch/arm/mach-imx/mm-imx27.c            |    1 +
> > > > >  arch/arm/mach-imx/mm-imx31.c            |    1 +
> > > > >  arch/arm/mach-imx/mm-imx35.c            |    1 +
> > > > >  arch/arm/mach-mx5/mm-mx50.c             |    1 +
> > > > >  arch/arm/mach-mx5/mm.c                  |    2 ++
> > > > >  arch/arm/plat-mxc/system.c              |   16 ++++++++++++++++
> > > > >  11 files changed, 26 insertions(+), 15 deletions(-)
> > > > 
> > > > Should the base patch be ok I'd like to rework this one. I want to
> > > > call init_consistent_dma_size on a per board base instead in a global
> > > > function with ifdeffery.
> > > 
> > > Hello Sascha,
> > > 
> > > Did you manage to work on this?  Ideally it would be nice to have a 
> > > reworked patch from you that could be used in this series as some later 
> > > patches depend on this series.
> > 
> > Are we happy with the base patch? Specifically, having
> > init_consistent_dma_size() declaired in include/asm/dma-mapping.h?
> > 
> > If so, I don't mind making the changes if Sascha can give me some rules
> > and pattern to apply. E.g. is it
> > 
> > In mach-imx/mm-imx2*.c
> > 
> > #if defined(CONFIG_VIDEO_MX2_HOSTSUPPORT)
> > 	init_consistent_dma_size(SZ_4M);
> > #endif
> > 
> > And likewise with CONFIG_MX1_VIDEO in mach-imx/mm-imx1.c and
> > CONFIG_MX3_VIDEO in mach-imx/mm-imx3*.c.
> > 
> > What about mach-mx5?
> 
> Sorry, I forgot about this issue. The solution is really simple: All
> boards in tree using video use memblock_* functions to get their
> coherent dma space for the camera. So we can just remove all
> CONSISTENT_DMA_SIZE defines in arch/arm/plat-mxc/include/mach/memory.h.
> 
> If I understand your patch correctly we get a default size of 2MiB
> when init_consistent_dma_size() is not called. That's fine for the other
> i.MX boards.

Just to make sure I've understood. I see memblock_ calls in
	mach-mx31_3ds.c
	mach-pcm037.c
	mach-mx31moboard.c
these all seem to be mx3 related.

For mx1 and mx2, these currently increase CONSISTENT_DMA_SIZE to 4MB,
but the 2MB default is actually big enough for these?

Therefore, as you said, we can just delete the definitions of
CONSISTENT_DMA_SIZE from memory.h and leave all other imx and mx5 files
unchanged.

Thanks.

-- 
Tixy
