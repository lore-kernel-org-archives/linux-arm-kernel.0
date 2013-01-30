From: rtivy@ti.com (Tivy, Robert)
Date: Wed, 30 Jan 2013 02:28:12 +0000
Subject: [PATCH v6 1/2] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <5103E907.8020206@mvista.com>
References: <1359168322-17733-1-git-send-email-rtivy@ti.com>
 <1359168322-17733-2-git-send-email-rtivy@ti.com>
 <5103E907.8020206@mvista.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C1431206D5A@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov at mvista.com]
> Sent: Saturday, January 26, 2013 6:33 AM
> 
> Hello.
> 
> On 26-01-2013 6:45, Robert Tivy wrote:
> 
> > Adding a remoteproc driver implementation for OMAP-L138 DSP
> 
>     You forgot to sign off the patch.

Ugh, thanks for pointing that out, I will correct this in the next submission.

> 
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index 96ce101..e923599 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> [...]
> > @@ -41,4 +41,28 @@ config STE_MODEM_RPROC
> >   	  This can be either built-in or a loadable module.
> >   	  If unsure say N.
> >
> > +config DA8XX_REMOTEPROC
> > +	tristate "DaVinci DA850/OMAPL138 remoteproc support
> (EXPERIMENTAL)"
> 
>     Neither DA850 nor OMAP-L138 are true DaVinci processors. Please
> drop the
> "DaVinci" word.

Ok, although DaVinci is used extensively in other places that support DA830/DA850.

> 
> > +	depends on ARCH_DAVINCI_DA850
> 
>     It's also not clear why you limit the driver d\to DA850 while you
> call it
> da8xx_remoteproc.c. There's at least one more member to DA8xx familiy
> (at
> least supported in the community): DA830/OMAP-L137.

I'll change this to:
	Depends on ARCH_DAVINCI_DA8XX
since that gets selected for either ARCH_DAVINCI_DA830 or ARCH_DAVINCI_DA850.

> 
> > +	select REMOTEPROC
> > +	select RPMSG
> > +	select CMA
> > +	default n
> > +	help
> > +	  Say y here to support DaVinci DA850/OMAPL138 remote processors
> 
>     Same here.
> 
> > diff --git a/drivers/remoteproc/da8xx_remoteproc.c
> b/drivers/remoteproc/da8xx_remoteproc.c
> > new file mode 100644
> > index 0000000..c6eb6bf
> > --- /dev/null
> > +++ b/drivers/remoteproc/da8xx_remoteproc.c
> > @@ -0,0 +1,327 @@
> > +/*
> > + * Remote processor machine-specific module for DA8XX
> > + *
> > + * Copyright (C) 2013 Texas Instruments, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * version 2 as published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/remoteproc.h>
> > +
> > +#include <mach/clock.h>   /* for davinci_clk_reset_assert/deassert()
> */
> > +
> > +#include "remoteproc_internal.h"
> > +
> > +static char *da8xx_fw_name;
> > +module_param(da8xx_fw_name, charp, S_IRUGO);
> > +MODULE_PARM_DESC(da8xx_fw_name,
> > +	"\n\t\tName of DSP firmware file in /lib/firmware");
> > +
> > +/*
> > + * OMAP-L138 Technical References:
> > + * http://www.ti.com/product/omap-l138
> > + */
> > +#define SYSCFG_CHIPSIG_OFFSET 0x174
> > +#define SYSCFG_CHIPSIG_CLR_OFFSET 0x178
> 
>     <mach/da8xx.h> has SYSCFG register #define's ending with '_REG',
> not
> '_OFFSET' -- I'd like this tradition to be kept. And perhaps we should
> #define
> these registers there instead of the driver?

#include'ing header files in 'mach' subdirectories is frowned upon due to such header files being machine-specific, so I'm trying to avoid that.  But as you noted in your subsequent email, these register offsets aren't used so I'll delete them altogether.

> 
> > +#define SYSCFG_CHIPINT0 BIT(0)
> > +#define SYSCFG_CHIPINT1 BIT(1)
> > +#define SYSCFG_CHIPINT2 BIT(2)
> > +#define SYSCFG_CHIPINT3 BIT(3)
> 
>     DA830/OMAP-l137 has the same registers. Only the datasheet calls
> the bits
> CHIPSIGn there. Bit 4 also exists and means DSP NMI.

Since the register bits are termed CHIPSIGn I will change them to that name (I believe the "lines" or signals are called CHIPINTn).

> 
> > +static int da8xx_rproc_probe(struct platform_device *pdev)
> [...]
> > +	chipsig = devm_request_and_ioremap(dev, chipsig_res);
> > +	if (!chipsig) {
> > +		dev_err(dev, "unable to map CHIPSIG register\n");
> > +		return -EINVAL;
> 
>     Why -EINVAL? Comment to devm_request_and_ioremap() suggests
> returning
> -EADDRNOTAVAIL.

OK, sounds better, I will change it.

> 
> > +	}
> > +
> > +	bootreg = devm_request_and_ioremap(dev, bootreg_res);
> > +	if (!bootreg) {
> > +		dev_err(dev, "unable to map boot register\n");
> > +		return -EINVAL;
> 
>     Same here.
> 
> > +static int __devexit da8xx_rproc_remove(struct platform_device
> *pdev)
> > +{
> > +	struct rproc *rproc = platform_get_drvdata(pdev);
> > +	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
> > +	int ret;
> > +
> > +	/*
> > +	 * The devm subsystem might end up releasing things before
> > +	 * freeing the irq, thus allowing an interrupt to sneak in while
> > +	 * the device is being removed.  This should prevent that.
> > +	 */
> > +	disable_irq(drproc->irq);
> 
>     Will the IRQ be enabled properly upon reloading the driver? You're
> effectively disabling it twice, once here and once in devm_free_irq(),
> aren't you?

I suppose I am.  I recall reading somewhere (can't find it now) that when using devm_request_threaded_irq(), when you remove the driver the irq doesn't actually get auto-freed until after some driver resources have been freed, thus rendering the ISR unusable were it to fire, so it suggested disabling the irq in the driver "remove" function.

Regardless, the irq appears to get enabled properly on the next module insertion.

> 
> > +static struct platform_driver da8xx_rproc_driver = {
> > +	.probe = da8xx_rproc_probe,
> > +	.remove = __devexit_p(da8xx_rproc_remove),
> 
>     Isn't _devexit_p() removed now? I thought __devinit and friends
> have all
> been removed in 3.8-rc1...

It appears that they're being deprecated for now, being #defined to empty.  I will remove the macro usage and associated __dev* keywords.

> 
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> > index dd3bfaf..ac4449a 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1222,19 +1222,39 @@ struct rproc *rproc_alloc(struct device *dev,
> const char *name,
> >   				const char *firmware, int len)
> >   {
> >   	struct rproc *rproc;
> > +	char *template = "rproc-%s-fw";
> > +	char *p;
> >
> >   	if (!dev || !name || !ops)
> >   		return NULL;
> >
> > +        if (!firmware)
> 
>     It makes sense to use {} despite singkle-statement branch.

According to Documentation/CodingStyle:
	Do not unnecessarily use braces where a single statement will do.

	if (condition)
		action();

> 
> > +                /*
> 
>     Indent with tabs please.

My bad, I will fix this (although I blame cut-and-paste, as well as it being a Friday night :)

> 
> > +		 * Make room for default firmware name (minus %s plus
> '\0').
> > +		 * If the caller didn't pass in a firmware name then
> > +		 * construct a default name.  We're already glomming 'len'
> > +		 * bytes onto the end of the struct rproc allocation, so do
> > +		 * a few more for the default firmware name (but only if
> > +		 * the caller doesn't pass one).
> > +		 */
> > +                len += strlen(name) + strlen(template) - 2 + 1;
> 
>     Same here.
> 
> >   	rproc = kzalloc(sizeof(struct rproc) + len, GFP_KERNEL);
> >   	if (!rproc) {
> >   		dev_err(dev, "%s: kzalloc failed\n", __func__);
> >   		return NULL;
> >   	}
> >
> > +        if (!firmware) {
> > +                p = (char *)rproc + sizeof(struct rproc) + len;
> > +                sprintf(p, template, name);
> > +        }
> > +        else
> > +                p = (char *)firmware;
> > +
> > +        rproc->firmware = p;
> 
>     Same here.

This one does violate Documentation/CodingStyle, as it says:
	if (condition) {
		do_this();
		do_that();
	} else {
		otherwise();
	}
I will correct this.

> 
> WBR, Sergei
> 
