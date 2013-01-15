From: balbi@ti.com (Felipe Balbi)
Date: Tue, 15 Jan 2013 17:04:32 +0200
Subject: [RFC PATCH 0/7] usb: musb: add driver for control module
In-Reply-To: <50F56A1A.3040504@ti.com>
References: <1358239378-10030-1-git-send-email-kishon@ti.com>
 <201301151341.08297.arnd@arndb.de> <50F56A1A.3040504@ti.com>
Message-ID: <20130115150432.GB26272@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 15, 2013 at 08:09:22PM +0530, kishon wrote:
> Hi Arnd,
> 
> On Tuesday 15 January 2013 07:11 PM, Arnd Bergmann wrote:
> >On Tuesday 15 January 2013, Kishon Vijay Abraham I wrote:
> >>Added a new driver for the usb part of control module. This has an API
> >>to power on the USB2 phy and an API to write to the mailbox depending on
> >>whether MUSB has to act in host mode or in device mode.
> >>
> >>Writing to control module registers for doing the above task which was
> >>previously done in omap glue and in omap-usb2 phy is removed.
> >>
> >>Also added the dt data to get MUSB working in OMAP platforms.
> >>This series has patches for both drivers and ARCH folders, so If it has to
> >>be split I'll do it.
> >>
> >
> >The series looks good to me, I just had a minor comment on one patch.
> >
> >One a somewhat related topic, I wonder whether there are any plans
> >on your side to change this driver to support multiple bus glues
> >to be built for one kernel image. With a multiplatform kernel, we
> >may need all of TUSB6010/OMAP2PLUS/DSPS/UX500 for instance.
> 
> We don't have plans as of now. I actually don't expect any changes in
> the driver other than the Kconfig changes. Anyways the probe of
> glue's other than the platform it's running won't get called. right
> Felipe?

AFAICT there's nothing preventing those from being built together as
long as you don't use DMA (yeah, that's a touchy subject still with
MUSB).

If there are any build breaks, please report them so bus glue owners can
fix. I see that at least the davinci folks need to work a bit

$ git grep -e "mach\/" drivers/usb/musb/
drivers/usb/musb/da8xx.c:#include <mach/da8xx.h>
drivers/usb/musb/davinci.c:#include <mach/cputype.h>
drivers/usb/musb/davinci.c:#include <mach/hardware.h>

I'm adding Ravi B to the loop here for those.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130115/b9e42659/attachment.sig>
