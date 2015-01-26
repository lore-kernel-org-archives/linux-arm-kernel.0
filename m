From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Jan 2015 11:16:58 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <201501242314.58201@pali>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <2871852.qm0MoZvdlF@wuerfel> <201501242314.58201@pali>
Message-ID: <3668717.H6LOeCvYZ4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 January 2015 23:14:58 Pali Roh?r wrote:
> On Saturday 24 January 2015 23:08:00 Arnd Bergmann wrote:
> > On Saturday 24 January 2015 13:00:00 Pali Roh?r wrote:
> > > Another regression for DT setup (which does not occur for
> > > board code):
> > > 
> > > omap_hsmmc driver does not export slot_name sysfs entry
> > > because it not supported by DT yet. Entry slot_name is used
> > > by userspace application to determinate if mmc block device
> > > is internal eMMC memory or external uSD card. So support
> > > for this property also in DT is needed.
> > 
> > > Here is simple patch which fix this problem:
> > The sysfs file only exists for the two OMAP drivers, and the
> > naming is used only by board-n8x0, board-rx51 and
> > board-omap3logic.
> > 
> > It may be better to add a board-specific hack for these to
> > keep the existing user space working but not spread the use
> > of this file anywhere else.
> 
> Why? omap_hsmmc.c has already support for slot_name sysfs entry, 
> just it is not filled from DT data (only from platform_data)...

It's a highly nonstandard interface, none of the other controllers
support it, and even changing the the other omap machines to use
the same strings might break existing user space that might rely
on whatever gets printed in those properties today.

We should limit the use of those strings to the boards that
are known to run software that requires them to avoid regressions.
We could also define a standard way of finding out whether an
mmc device is removable. We already have the MMC_CAP_NONREMOVABLE
flag in the kernel and could have a read-only boolean attribute
in sysfs for it.

Putting a "name" property into DT because some random user space
requires a particular name to show up in sysfs however does not
seem a legitimate hardware description.

	Arnd
