From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 23 Sep 2014 15:59:43 +0530
Subject: [PATCH v5] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <20140922091925.GA19778@shlinux1.ap.freescale.net>
References: <1411360807-7750-1-git-send-email-pankaj.dubey@samsung.com>
 <20140922091925.GA19778@shlinux1.ap.freescale.net>
Message-ID: <000001cfd719$51e7e560$f5b7b020$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

On Monday, September 22, 2014, Dong Aisheng wrote,
> On Mon, Sep 22, 2014 at 10:10:07AM +0530, Pankaj Dubey wrote:

[snip]

> > -static int syscon_match_node(struct device *dev, void *data)
> > +static struct syscon *of_syscon_register(struct device_node *np)
> >  {
> > -	struct device_node *dn = data;
> > +	struct platform_device *pdev = NULL;
> > +	struct syscon *syscon;
> > +	struct regmap *regmap;
> > +	void __iomem *base;
> > +	int ret;
> > +
> > +	if (!of_device_is_compatible(np, "syscon"))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
> > +	if (!syscon)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	base = of_iomap(np, 0);
> > +	if (!base) {
> > +		ret = -ENOMEM;
> > +		goto err_map;
> > +	}
> > +
> > +	/* if device is already populated and available then use it */
> > +	pdev = of_find_device_by_node(np);
> > +	if (!pdev) {
> > +		/* for early users create dummy syscon device and use it */
> > +		pdev = platform_device_alloc("dummy-syscon", -1);
> 
> Can we create specific devices for each syscon device?
> That looks more reasonable to me.
> Then we can dump registers in regmap debugfs more clearly, just like other
devices.
> And i think it's better to follow device tree way to generate devices from
node.
> If DT core find a device is already created, it can ignore that device to
avoid creating
> duplicated device during of_platform_populate.
> 

If you are referring to use "of_platform_device_create", then I am afraid
that it can't be used
in very early stage. For example, current patch I tested by calling
syscon_lookup_by_phandle from
"init_irq" hook of machine_desc, and it worked well, but If I use
"of_platform_device_create"
instead of dummy device, it fails to create pdev and this I verified on
Exynos platform. The reason
I selected "init_irq" is because this comes just before smp init and where
once we tried to get regmap handle,
but could not do so. 

Also if it was just a matter of creating platform_device at early stage then
early initialization of
syscon could have been solved till now.

So I would suggest if we really want this patch to cover early
initialization of syscon
(which is not it's main purpose) current patch is sufficient. 

@Arnd, since I have addressed crash issue as reported by Dong Aisheng, I
would like to take your ack,
but since there are some more code changes other than what you suggested I
request you to check this
and if you are ok, then I would like to your ack so that I can request to
maintainer for taking this patch.

Thanks,
Pankaj Dubey

> Regards
> Dong Aisheng
> 
> > +		if (!pdev) {
> > +			ret = -ENOMEM;
> > +			goto err_pdev;
> > +		}
> > +		pdev->dev.of_node = of_node_get(np);
> > +	}
> > +
> > +	regmap = devm_regmap_init_mmio(&pdev->dev, base,
> &syscon_regmap_config);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&pdev->dev, "regmap init failed\n");
> > +		ret = PTR_ERR(regmap);
> > +		goto err_regmap;
> > +	}
> > +
> > +	syscon->regmap = regmap;
> > +	syscon->np = np;
> >
> > -	return (dev->of_node == dn) ? 1 : 0;
> > +	spin_lock(&syscon_list_slock);
> > +	list_add_tail(&syscon->list, &syscon_list);
> > +	spin_unlock(&syscon_list_slock);
> > +
> > +	return syscon;
> > +
> > +err_regmap:
> > +	if (!strcmp(pdev->name, "dummy-syscon")) {
> > +		of_node_put(np);
> > +		platform_device_put(pdev);
> > +	}
> > +err_pdev:
> > +	iounmap(base);
> > +err_map:
> > +	kfree(syscon);
> > +	return ERR_PTR(ret);
> >  }
> >
> >  struct regmap *syscon_node_to_regmap(struct device_node *np)  {
> > -	struct syscon *syscon;
> > -	struct device *dev;
> > +	struct syscon *entry, *syscon = NULL;
> >
> > -	dev = driver_find_device(&syscon_driver.driver, NULL, np,
> > -				 syscon_match_node);
> > -	if (!dev)
> > -		return ERR_PTR(-EPROBE_DEFER);
> > +	spin_lock(&syscon_list_slock);
> >
> > -	syscon = dev_get_drvdata(dev);
> > +	list_for_each_entry(entry, &syscon_list, list)
> > +		if (entry->np == np) {
> > +			syscon = entry;
> > +			break;
> > +		}
> > +
> > +	spin_unlock(&syscon_list_slock);
> > +
> > +	if (!syscon)
> > +		syscon = of_syscon_register(np);
> > +
> > +	if (IS_ERR(syscon))
> > +		return ERR_CAST(syscon);
> >
> >  	return syscon->regmap;
> >  }
> > @@ -110,17 +185,6 @@ struct regmap
> > *syscon_regmap_lookup_by_phandle(struct device_node *np,  }
> > EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
> >
> > -static const struct of_device_id of_syscon_match[] = {
> > -	{ .compatible = "syscon", },
> > -	{ },
> > -};
> > -
> > -static struct regmap_config syscon_regmap_config = {
> > -	.reg_bits = 32,
> > -	.val_bits = 32,
> > -	.reg_stride = 4,
> > -};
> > -
> >  static int syscon_probe(struct platform_device *pdev)  {
> >  	struct device *dev = &pdev->dev;
> > @@ -167,7 +231,6 @@ static struct platform_driver syscon_driver = {
> >  	.driver = {
> >  		.name = "syscon",
> >  		.owner = THIS_MODULE,
> > -		.of_match_table = of_syscon_match,
> >  	},
> >  	.probe		= syscon_probe,
> >  	.id_table	= syscon_ids,
> > --
> > 1.7.9.5
> >
