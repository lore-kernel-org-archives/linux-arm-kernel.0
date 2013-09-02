From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 2 Sep 2013 14:13:24 -0300
Subject: [PATCH] mtd: atmel_nand: fix the warning when CONFIG_OF is not
 defined
In-Reply-To: <522437E8.1050604@atmel.com>
References: <1375846569-9499-1-git-send-email-josh.wu@atmel.com>
 <1377894233.22372.86.camel@shinybook.infradead.org>
 <20130831170422.GA21617@localhost> <522437E8.1050604@atmel.com>
Message-ID: <20130902171323.GA28419@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 03:02:00PM +0800, Josh Wu wrote:
> Hi, Ezequiel
> 
> On 9/1/2013 1:04 AM, Ezequiel Garcia wrote:
> > On Fri, Aug 30, 2013 at 09:23:53PM +0100, David Woodhouse wrote:
> >> On Wed, 2013-08-07 at 11:36 +0800, Josh Wu wrote:
> >>> This patch fix following warning:
> >>>
> >>> drivers/mtd/nand/atmel_nand.c:2007: warning: 'atmel_nand_nfc_match' defined but not used
> >>>
> >>> This patch add '#if defined(CONFIG_OF)' block to guard around the definition of
> >>> atmel_nand_nfc_match, in order to avoid the warning when kernel is configurated
> >>> as non-dt supported.
> >> Ick. This driver is littered with CONFIG_OF checks. Yet I've just seen a
> >> patch to pxa3xx_nand which *removes* ifdefs, on the basis that all the
> >> of_match_ functions/macros will just 'do the right thing'. Can't we do
> >> that here too? We might just need to add __maybe_unused?
> >>
> > We can. We just need to provide a few dummy functions in linux/of_mtd.h
> > just like the other of_xxx() are doing. See below!
> >
> >>> +#if defined(CONFIG_OF)
> >>>   static struct of_device_id atmel_nand_nfc_match[] = {
> >>>   	{ .compatible = "atmel,sama5d3-nfc" },
> >>>   	{ /* sentinel */ }
> >>>   };
> >>> +#endif
> >> Also, why doesn't this one appear in a MODULE_DEVICE_TABLE() ?
> >>
> > Indeed. And why doesn't it have a "const" keyword?
> 
> Thanks to point these out.
> 
> >
> > So, in order to remove the CONFIG_OF safely from this driver,
> > and avoid any stupid warnings, we need to first implement
> > these dummies:
> >
> > --------------------------------8<-----------------------------------
> > diff --git a/include/linux/of_mtd.h b/include/linux/of_mtd.h
> > index ed7f267..66f173e 100644
> > --- a/include/linux/of_mtd.h
> > +++ b/include/linux/of_mtd.h
> > @@ -14,6 +14,21 @@
> >   int of_get_nand_ecc_mode(struct device_node *np);
> >   int of_get_nand_bus_width(struct device_node *np);
> >   bool of_get_nand_on_flash_bbt(struct device_node *np);
> > +#else
> > +static inline int of_get_nand_ecc_mode(struct device_node *np)
> > +{
> > +	return -ENOSYS;
> > +}
> > +
> > +static inline int of_get_nand_bus_width(struct device_node *np)
> > +{
> > +	return -ENOSYS;
> > +}
> > +
> > +static inline bool of_get_nand_on_flash_bbt(struct device_node *np)
> > +{
> > +	return false;
> > +}
> >   #endif
> >   
> >   #endif /* __LINUX_OF_MTD_H */
> > -------------------------------->8-----------------------------------
> >
> > And then, with this little patch, we get rid of the ugly CONFIG_OF check
> > from the atmel_nand driver:
> >
> > --------------------------------8<-----------------------------------
> > diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> > index 0e365da..ac58098 100644
> > --- a/drivers/mtd/nand/atmel_nand.c
> > +++ b/drivers/mtd/nand/atmel_nand.c
> > @@ -1448,7 +1448,6 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
> >   		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
> >   }
> >   
> > -#if defined(CONFIG_OF)
> >   static int atmel_of_init_port(struct atmel_nand_host *host,
> >   			      struct device_node *np)
> >   {
> > @@ -1456,7 +1455,7 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
> >   	u32 offset[2];
> >   	int ecc_mode;
> >   	struct atmel_nand_data *board = &host->board;
> > -	enum of_gpio_flags flags;
> > +	enum of_gpio_flags flags = 0;
> >   
> >   	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
> >   		if (val >= 32) {
> > @@ -1539,13 +1538,6 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
> >   
> >   	return 0;
> >   }
> > -#else
> > -static int atmel_of_init_port(struct atmel_nand_host *host,
> > -			      struct device_node *np)
> > -{
> > -	return -EINVAL;
> > -}
> > -#endif
> >   
> >   static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
> >   					 struct atmel_nand_host *host)
> > @@ -2205,14 +2197,12 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
> >   	return 0;
> >   }
> >   
> > -#if defined(CONFIG_OF)
> >   static const struct of_device_id atmel_nand_dt_ids[] = {
> >   	{ .compatible = "atmel,at91rm9200-nand" },
> >   	{ /* sentinel */ }
> >   };
> >   
> >   MODULE_DEVICE_TABLE(of, atmel_nand_dt_ids);
> > -#endif
> >   
> >   static int atmel_nand_nfc_probe(struct platform_device *pdev)
> >   {
> > @@ -2251,12 +2241,11 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
> >   	return 0;
> >   }
> >   
> > -#if defined(CONFIG_OF)
> > -static struct of_device_id atmel_nand_nfc_match[] = {
> > +static const struct of_device_id atmel_nand_nfc_match[] = {
> >   	{ .compatible = "atmel,sama5d3-nfc" },
> >   	{ /* sentinel */ }
> >   };
> > -#endif
> > +MODULE_DEVICE_TABLE(of, atmel_nand_nfc_match);
> >   
> >   static struct platform_driver atmel_nand_nfc_driver = {
> >   	.driver = {
> > -------------------------------->8-----------------------------------
> >
> > Of course, these are untested. If they look OK and don't cause any trouble,
> > then I'll prepare proper patches.
> 
> Looks nice to me. Your proposal patch does the right thing to remove the 
> CONFIG_OF.

Great!

> So please sent them out. ;)
> 

I'm a bit short on time these days, how about I send the first one
for the stub !OF addition and on top of that you send the atmel
patches?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
