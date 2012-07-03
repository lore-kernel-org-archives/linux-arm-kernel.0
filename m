From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 22:02:04 +0800
Subject: [PATCH] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <4FF1F154.3050506@codeaurora.org>
References: <1341245355-21397-1-git-send-email-shawn.guo@linaro.org>
 <4FF1F154.3050506@codeaurora.org>
Message-ID: <20120703140202.GF22705@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for looking at it, Stephen.

On Mon, Jul 02, 2012 at 12:07:00PM -0700, Stephen Boyd wrote:
> On 07/02/12 09:09, Shawn Guo wrote:
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 08cbdb9..511ddcb 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1087,4 +1087,14 @@ config RTC_DRV_MXC
> >  	   This driver can also be built as a module, if so, the module
> >  	   will be called "rtc-mxc".
> >  
> > +config RTC_DRV_SNVS
> > +	tristate "Freescale SNVS RTC support"
> > +	depends on ARCH_MXC
> 
> If you want more build coverage you can depend on HAS_IOMEM and drop the
> ARCH_MXC part.
> 
Dropping ARCH_MXC sounds like a good idea.  But why do we need to
depend on HAS_IOMEM?  readl/writel are not always available?

I would add "depends on OF" though.

> > +	help
> > +	   If you say yes here you get support for the Freescale SNVS
> > +	   Low Power (LP) RTC module.
> > +
> > diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> > new file mode 100644
> > index 0000000..761c91f
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-snvs.c
> > @@ -0,0 +1,350 @@
> > +/*
> > + * Copyright (C) 2011-2012 Freescale Semiconductor, Inc.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/delay.h>
> 
> Is this include used?
> 
No.  It should be removed.

> > +
> > +static struct rtc_class_ops snvs_rtc_ops = {
> 
> const?
> 
Indeed.

> > +static irqreturn_t snvs_rtc_irq_handler(int irq, void *dev_id)
> > +{
> > +	struct device *dev = dev_id;
> > +	struct snvs_rtc_data *data = dev_get_drvdata(dev);
> 
> Why not just pass the svsns_rtc_data to request_irq() so you can cast
> dev_id directly?
> 
Because snvs_rtc_alarm_irq_enable(dev, 0) is being called in there
with dev as the first parameter.

> > +static int __devinit snvs_rtc_probe(struct platform_device *pdev)
> > +{
> > +	struct snvs_rtc_data *data;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	data->ioaddr = devm_request_and_ioremap(&pdev->dev, res);
> > +	if (!data->ioaddr)
> > +		return -EADDRNOTAVAIL;
> > +
> > +	data->irq = platform_get_irq(pdev, 0);
> 
> What if this irq fails to exist?
> 
The later devm_request_irq() call will report error then.

> 
> > +static const struct of_device_id __devinitdata snvs_dt_ids[] = {
> 
> Is this supposed to be __devinitconst?
> 
Right.

> > +	{ .compatible = "fsl,sec-v4.0-mon" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, snvs_dt_ids);
> 
> Surround this of_device table in #ifdef CONFIG_OF?
> 
Maybe not.  I intend to have the driver OF only.

> > +
> > +static struct platform_driver snvs_rtc_driver = {
> > +	.driver = {
> > +		.name	= "snvs_rtc",
> > +		.owner	= THIS_MODULE,
> > +		.of_match_table = snvs_dt_ids,
> 
> .of_match_table = of_match_ptr(svns_dt_ids)
> 
Ditto

> > +	},
> > +	.probe		= snvs_rtc_probe,
> > +	.remove		= __devexit_p(snvs_rtc_remove),
> > +	.suspend	= snvs_rtc_suspend,
> > +	.resume		= snvs_rtc_resume,
> 
> Can you use dev_pm_ops?
> 
Ok.

-- 
Regards,
Shawn
