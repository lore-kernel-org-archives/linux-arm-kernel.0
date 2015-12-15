From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 16:45:04 +0100
Subject: [PATCH] soc: mediatek: SCPSYS: use module_platform_driver
In-Reply-To: <20151215154203.GP11966@pengutronix.de>
References: <1450188966-2921-1-git-send-email-s.hauer@pengutronix.de>
 <3837885.qE6MXzvvpu@wuerfel> <20151215154203.GP11966@pengutronix.de>
Message-ID: <3919968.fveBmeY89b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 16:42:03 Sascha Hauer wrote:
> On Tue, Dec 15, 2015 at 03:30:01PM +0100, Arnd Bergmann wrote:
> > On Tuesday 15 December 2015 15:16:06 Sascha Hauer wrote:
> > > @@ -542,6 +542,7 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
> > >  };
> > >  
> > >  static struct platform_driver scpsys_drv = {
> > > +       .probe = scpsys_probe,
> > >         .driver = {
> > >                 .name = "mtk-scpsys",
> > >                 .owner = THIS_MODULE,
> > > @@ -549,4 +550,4 @@ static struct platform_driver scpsys_drv = {
> > >         },
> > >  };
> > >  
> > > -module_platform_driver_probe(scpsys_drv, scpsys_probe);
> > > +module_platform_driver(scpsys_drv);
> > > 
> > 
> > Good idea, but I wonder why there is no remove function in the
> > driver. Do we also need to make the module non-removable and
> > set .suppress_bind_attrs, or is all of the probe function
> > reversible through devm_* helpers?
> 
> pm domains currently can't be unregistered, removal of this driver is
> not supported. The driver can't be compiled as a module.

Ok, then you need the suppress_bind_attrs flag to ensure that users
cannot unbind and rebind the device through sysfs. The module_exit()
function will be dropped implicitly for built-in drivers, so the
module_platform_driver() is ok.

	Arnd
