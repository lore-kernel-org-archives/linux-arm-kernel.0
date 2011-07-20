From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 20 Jul 2011 12:37:15 +0530
Subject: [PATCH v4 REPOST 13/20] gpio/omap: cleanup omap_gpio_mod_init
	function
In-Reply-To: <20110716182649.GA990@google.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
	<1310804152-9243-14-git-send-email-tarun.kanti@ti.com>
	<20110716182649.GA990@google.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037C0C4CBE@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> >  static int __init omap16xx_gpio_init(void)
> >  {
> >  	int i;
> > +	void __iomem *base;
> > +	struct resource *res;
> > +	struct platform_device *pdev;
> > +	struct omap_gpio_platform_data *pdata;
> >
> >  	if (!cpu_is_omap16xx())
> >  		return -EINVAL;
> >
> > -	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
> > +	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> > +		pdev = omap16xx_gpio_dev[i];
> > +		pdata = pdev->dev.platform_data;
> > +
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +		if (unlikely(!res)) {
> > +			dev_err(&pdev->dev, "Invalid mem resource.\n");
> > +			return -ENODEV;
> > +		}
> > +
> > +		base = ioremap(res->start, resource_size(res));
> > +		if (unlikely(!base)) {
> > +			dev_err(&pdev->dev, "ioremap failed.\n");
> > +			return -ENOMEM;
> > +		}
> 
> The value of base isn't saved anywhere, and the memory is not
> unmapped, looks like a virtual memory leak.  If the purpose of the
> ioremap is to perform the single write below then iounmap when done?
This is one time write only.
I will iounmap(base) after use. Thanks.

> The previous code to perform that write used a
> struct gpio_bank *bank->base ioremapped by omap_gpio_probe, but
> apparently omap16xx_gpio_init isn't called in that path.
Right.

> 
> > +
> > +		__raw_writel(0x0014, base + OMAP1610_GPIO_SYSCONFIG);
> 
> Suggest a symbol for the 0x14 value, or add a comment describing what
> this does.  (I realize the existing code has many naked constants.)
Sure.
--
Tarun
> 
> 
> 
> Todd
