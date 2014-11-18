From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 18 Nov 2014 16:20:40 +0530
Subject: [PATCH v4 2/2] ARM: EXYNOS: PMU: move restart code into pmu driver
In-Reply-To: <20141117164116.GA28915@roeck-us.net>
References: <1416223273-1279-1-git-send-email-pankaj.dubey@samsung.com>
 <1416223273-1279-3-git-send-email-pankaj.dubey@samsung.com>
 <20141117164116.GA28915@roeck-us.net>
Message-ID: <000001d0031d$96c32250$c44966f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 17, 2014 10:11 PM, Guenter Roeck wrote:
> On Mon, Nov 17, 2014 at 04:51:13PM +0530, Pankaj Dubey wrote:
> >
> > +/*
> > + * Exynos PMU reboot notifier, handles reboot functionality
> 
> restart, really.
> 
> > + */
> > +static struct notifier_block pmu_restart_handler = {
> > +	.notifier_call = pmu_restart_notify,
> > +	.priority = 128,
> > +};
> > +
> >  static int exynos_pmu_probe(struct platform_device *pdev)  {
> >  	const struct of_device_id *match;
> >  	struct device *dev = &pdev->dev;
> >  	struct resource *res;
> > +	int ret;
> >
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	pmu_base_addr = devm_ioremap_resource(dev, res); @@ -794,6 +813,10
> > @@ static int exynos_pmu_probe(struct platform_device *pdev)
> >
> >  	platform_set_drvdata(pdev, pmu_context);
> >
> > +	ret = register_restart_handler(&pmu_restart_handler);
> > +	if (ret)
> > +		dev_err(dev, "can't register restart handler err=%d\n",
ret);
> > +
> 
> dev_warn might be more appropriate, since you ignore the error.
> But that is a nitpick, really, as well as the above.
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 

Thanks for review. I will update both patches as per your review comments.

Thanks,
Pankaj Dubey

> >  	dev_dbg(dev, "Exynos PMU Driver probe done\n");
> >  	return 0;
> >  }
> > --
> > 1.7.9.5
> >
