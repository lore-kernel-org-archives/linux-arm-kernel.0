From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 23 Apr 2013 09:26:04 -0700
Subject: [PATCH] usb: phy: phy core cannot yet be a module
In-Reply-To: <20130423160759.GF15177@arwen.pp.htv.fi>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
 <1366732475-479886-2-git-send-email-arnd@arndb.de>
 <20130423160759.GF15177@arwen.pp.htv.fi>
Message-ID: <20130423162604.GA6983@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 07:07:59PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Apr 23, 2013 at 05:54:32PM +0200, Arnd Bergmann wrote:
> > A lot of platform code calls into the usb phy core at the moment, which
> > does not work if it is built as a loadable module. This will hopefully
> > change when those platforms are all converted to DT based probing,
> > but for now, the easiest solution is to change it from "tristate"
> > to "bool".
> > 
> > This solves at least these ARM allmodconfig build errors:
> > 
> > arch/arm/mach-imx/built-in.o: In function `imx_otg_ulpi_create':
> > arch/arm/mach-imx/ulpi.c:117: undefined reference to `otg_ulpi_create'
> > arch/arm/mach-omap2/built-in.o: In function `usbhs_init_phys':
> > arch/arm/mach-omap2/usb-host.c:652: undefined reference to `usb_bind_phy'
> > arch/arm/mach-omap2/built-in.o: In function `omap_2430sdp_init':
> > arch/arm/mach-omap2/board-2430sdp.c:236: undefined reference to `usb_bind_phy'
> > arch/arm/mach-omap2/built-in.o: In function `omap3_beagle_init':
> > arch/arm/mach-omap2/board-omap3beagle.c:554: undefined reference to `usb_bind_phy'
> > arch/arm/mach-omap2/built-in.o: In function `devkit8000_init':
> > arch/arm/mach-omap2/board-devkit8000.c:596: undefined reference to `usb_bind_phy'
> > arch/arm/mach-omap2/built-in.o: In function `omap_ldp_init':
> > arch/arm/mach-omap2/board-ldp.c:379: undefined reference to `usb_bind_phy'
> > drivers/built-in.o: In function `ab8500_charger_probe':
> > drivers/power/ab8500_charger.c:3629: undefined reference to `usb_get_phy'
> > drivers/power/ab8500_charger.c:3706: undefined reference to `usb_put_phy'
> > drivers/built-in.o: In function `ab8500_charger_remove':
> > drivers/power/ab8500_charger.c:3411: undefined reference to `usb_put_phy'
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb at vger.kernel.org
> > ---
> >  drivers/usb/phy/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> > index 21153d1..371d0e7 100644
> > --- a/drivers/usb/phy/Kconfig
> > +++ b/drivers/usb/phy/Kconfig
> > @@ -2,7 +2,7 @@
> >  # Physical Layer USB driver configuration
> >  #
> >  menuconfig USB_PHY
> > -	tristate "USB Physical Layer drivers"
> > +	bool "USB Physical Layer drivers"
> 
> looks like this is the only way, indeed. Do you need on the merge window
> on can this wait until -rc1 ? I just sent a pull request to Greg with
> urgent fixes for the merge window.
> 
> Greg, if you want to take this one as a patch, go for it:
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

I'll take this now, thanks.

greg k-h
