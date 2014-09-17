From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 17 Sep 2014 16:50:50 +0530
Subject: [PATCH v3] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <20140917085818.GA10285@shlinux1.ap.freescale.net>
References: <1410935510-1567-1-git-send-email-pankaj.dubey@samsung.com>
 <20140917085818.GA10285@shlinux1.ap.freescale.net>
Message-ID: <000401cfd269$922dfc40$b689f4c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday, September 17, 2014, Dong Aisheng Wrote,
> >
> > +static struct syscon *of_syscon_register(struct device_node *np) {
> > +	struct syscon *syscon;
> > +	struct regmap *regmap;
> > +	void __iomem *base;
> > +
> > +	if (!of_device_is_compatible(np, "syscon"))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
> > +	if (!syscon)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	base = of_iomap(np, 0);
> > +	if (!base)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	regmap = regmap_init_mmio(NULL, base, &syscon_regmap_config);
> 
> Does a NULL device pointer work?

Yes, it is safe, at least we are able to test on Exynos based SoC. 
I have tested it with kgene/for-next kernel on Exynos3250.
Also it has been tested on Exynos5250 based Snow board with 3.17-rc5 based
kernel
by Vivek Gautam. 

Patch V2 also has been tested by "Borris Brezillon" on AT91 platform.


> I just tested on MX6SX SDB board and it seemed crashed at here in
regmap_init
> function.
> 

Can you please provide crash log which can give more information about the
crash?


Thanks,
Pankaj Dubey

> Regards
> Dong Aisheng
> 
> > +	if (IS_ERR(regmap)) {
> > +		pr_err("regmap init failed\n");
> > +		return ERR_CAST(regmap);
> > +	}
> > +
> > +	syscon->regmap = regmap;
> > +	syscon->np = np;
> > +
> > +	spin_lock(&syscon_list_slock);
> > +	list_add_tail(&syscon->list, &syscon_list);
> > +	spin_unlock(&syscon_list_slock);
> > +
> > +	return syscon;
> > +}
> > +
> >  static int syscon_probe(struct platform_device *pdev)  {
> >  	struct device *dev = &pdev->dev;
> > @@ -167,7 +204,6 @@ static struct platform_driver syscon_driver = {
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
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
