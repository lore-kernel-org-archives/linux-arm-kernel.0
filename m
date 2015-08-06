From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 6 Aug 2015 02:09:00 +0000
Subject: [PATCH v3 1/2] drivers: watchdog: add a driver to support
 SAMA5D4 watchdog timer
In-Reply-To: <20150805124030.6e73b975@ipc1.ka-ro>
References: <1438765043-11030-1-git-send-email-wenyou.yang@atmel.com>
 <1438765043-11030-2-git-send-email-wenyou.yang@atmel.com>
 <20150805124030.6e73b975@ipc1.ka-ro>
Message-ID: <B256D81BAE5131468A838E5D7A243641C9F87310@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

Thank you for your review.

> -----Original Message-----
> From: Lothar Wa?mann [mailto:LW at KARO-electronics.de]
> Sent: 2015?8?5? 18:41
> To: Yang, Wenyou
> Cc: wim at iguana.be; robh+dt at kernel.org; pawel.moll at arm.com;
> mark.rutland at arm.com; ijc+devicetree at hellion.org.uk; galak at codeaurora.org;
> boris.brezillon at free-electrons.com; linux-watchdog at vger.kernel.org;
> devicetree at vger.kernel.org; sylvain.rochet at finsecur.com; Ferre, Nicolas; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/2] drivers: watchdog: add a driver to support SAMA5D4
> watchdog timer
> 
> Hi,
> 
> > From SAMA5D4, the watchdog timer is upgrated with a new feature, which
> > is describled as in the datasheet, "WDT_MR can be written until a
> > LOCKMR command is issued in WDT_CR".
> > That is to say, as long as the bootstrap and u-boot don't issue a
> > LOCKMR command, WDT_MR can be written more than once in the driver.
> >
> > So the SAMA5D4 watchdog driver's implementation is different from the
> > at91sam9260 watchdog driver implemented in file at91sam9_wdt.c.
> > The user application open the device file to enable the watchdog timer
> > hardware, and close to disable it, and set the watchdog timer timeout
> > by seting WDV and WDD fields of WDT_MR register, and ping the watchdog
> > by issuing WDRSTT command to WDT_CR register with hard-coded key.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >  drivers/watchdog/Kconfig            |    9 ++
> >  drivers/watchdog/Makefile           |    1 +
> >  drivers/watchdog/at91_sama5d4_wdt.c |  279
> +++++++++++++++++++++++++++++++++++
> >  drivers/watchdog/at91sam9_wdt.h     |    2 +
> >  4 files changed, 291 insertions(+)
> >  create mode 100644 drivers/watchdog/at91_sama5d4_wdt.c
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> > e5e7c55..4ce8346 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -152,6 +152,15 @@ config ARM_SP805_WATCHDOG
> >  	  ARM Primecell SP805 Watchdog timer. This will reboot your system
> when
> >  	  the timeout is reached.
> >
> > +config AT91_SAMA5D4_WATCHDOG
> > +	tristate "Atmel SAMA5D4 Watchdog Timer"
> > +	depends on ARCH_AT91
> > +	select WATCHDOG_CORE
> > +	help
> > +	  Atmel SAMA5D4 watchdog timer is embedded into SAMA5D4 chips.
> > +	  Its Watchdog Timer Mode Register can be written more than once.
> > +	  This will reboot your system when the timeout is reached.
> > +
> >  config AT91RM9200_WATCHDOG
> >  	tristate "AT91RM9200 watchdog"
> >  	depends on SOC_AT91RM9200 && MFD_SYSCON diff --git
> > a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile index
> > 5c19294..c57569c 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -30,6 +30,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
> >
> >  # ARM Architecture
> >  obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
> > +obj-$(CONFIG_AT91_SAMA5D4_WATCHDOG) += at91_sama5d4_wdt.o
> consistency? Other AT91 entries don't have an '_' between 'AT91' and the
> remainder of the Kconfig name.
Accept, Remove the prefix AT91_ , use the chip name directly, SAMA5D4 in next verison.

> 
> >  obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.ovi 
> >  obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
> [...]
> > +static irqreturn_t atmel_wdt_irq_handler(int irq, void *dev_id) {
> > +	struct atmel_wdt *wdt = platform_get_drvdata(dev_id);
> > +
> > +	if (wdt_read(wdt, AT91_WDT_SR)) {
> > +		pr_crit("Atmel Watchdog Software Reset\n");
> > +		emergency_restart();
> > +		pr_crit("Reboot didn't ?????\n");
> >
> Reboot didn't what? 'succeed' perhaps?
Replace it with 'succeed' in next version. 

> 
> > +static const struct of_device_id atmel_wdt_of_match[] = {
> > +	{ .compatible = "atmel,sama5d4-wdt", },
> > +	{ },
> The empty initializer must always be the last element of the array, so there is no
> point in having a trailing ',' (whose purpose is to facilitate adding more entries after
> the last one).
> Without the comma there will be a compile error if (e.g. due to a badly resolved
> merge conflict) an additional entry would be added after the stop marker. With the
> comma after the stop marker any trailing entries would silently be ignored.
Remove this comma in next version.

> 
> 
> Lothar Wa?mann
> --
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________

Best Regards,
Wenyou 
