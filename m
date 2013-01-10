From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Jan 2013 17:20:16 +0100
Subject: [PATCH v3 06/18] ARM: clps711x: cdb89712: Special driver for
 handling memory is removed
In-Reply-To: <20130110193916.16f1a92eb5048250004b6b03@mail.ru>
References: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
 <1353160644-22446-7-git-send-email-shc_work@mail.ru>
 <20130110140921.GC14860@pengutronix.de>
 <20130110193916.16f1a92eb5048250004b6b03@mail.ru>
Message-ID: <20130110162016.GD14860@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alexander,

On Thu, Jan 10, 2013 at 07:39:16PM +0400, Alexander Shiyan wrote:
> On Thu, 10 Jan 2013 15:09:21 +0100
> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> ...
> > >  static void __init cdb89712_init(void)
> > >  {
> > > +	platform_device_register(&cdb89712_flash_pdev);
> > > +	platform_device_register(&cdb89712_bootrom_pdev);
> > > +	platform_device_register(&cdb89712_sram_pdev);
> > This is broken, all these structs are located in .init.data which is
> > discarded after the machine is fully booted. Also platformdata must not
> > live in init data. Consider using platform_device_register_full which
> > allows more data to be init data.
> 
> I agree. Error is invisible when not using loadable modules, but will
> become apparent when using these.
This is not true. It can trigger a problem for sure when you rebind the
driver via sysfs. And in general you cannot assume that a driver doesn't
need platform_data or it's struct platform_device during operation. Take
for example physmap_flash_shutdown (defined in
drivers/mtd/maps/physmap.c). Maybe even $(find /sys) triggers a problem.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
