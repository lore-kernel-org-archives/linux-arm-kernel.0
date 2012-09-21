From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Sep 2012 10:42:05 +0100
Subject: [RFC PATCH 01/13] ARM: davinci: move private EDMA API to
 arm/common
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA8AA3C@DBDE01.ent.ti.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-2-git-send-email-mporter@ti.com>
 <20120921092923.GA31374@n2100.arm.linux.org.uk>
 <1BAFE6F6C881BF42822005164F1491C33EA8AA3C@DBDE01.ent.ti.com>
Message-ID: <20120921094205.GC31374@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 09:33:42AM +0000, Hebbar, Gururaja wrote:
> On Fri, Sep 21, 2012 at 14:59:23, Russell King - ARM Linux wrote:
> > On Thu, Sep 20, 2012 at 10:43:34AM -0400, Matt Porter wrote:
> > > Move mach-davinci/dma.c to common/edma.c so it can be used
> > > by OMAP (specifically AM33xx atm) as well. This just moves
> > > the private EDMA API but does not support OMAP.
> > > 
> > > Signed-off-by: Matt Porter <mporter@ti.com>
> > > ---
> > >  arch/arm/Kconfig                           |    1 +
> > >  arch/arm/common/Kconfig                    |    3 +
> > >  arch/arm/common/Makefile                   |    1 +
> > >  arch/arm/common/edma.c                     | 1588 ++++++++++++++++++++++++++++
> > >  arch/arm/include/asm/mach/edma.h           |  267 +++++
> > 
> > asm/mach should not be used as a dumping ground for platform header files.
> > It is there to provide the interfaces between generic ARM architecture
> > code and platform code.  (At least four files that are there at the
> > moment need to be moved out of there - patch series to follow...)
> 
> Can this be moved to include/linux/platform_data/ ?

Here's the pertinant question: "is it platform data?"  Looking at the
file, it appears to be internal data structures and register definitions
for the driver itself.  Therefore, it isn't platform data, and it
shouldn't be living separately from the driver.

If the driver itself only makes use of the data structures, the data
structures should be defined either within the driver, or a header file
co-located next to the driver itself.  The same goes for register
definitions too.

The only structure that I can find which isn't internal to the driver
is struct edma_soc_info, struct edma_rsv_info, and the enum dma_event_q.
Those can go to include/linux/platform_data, but the rest should not.
