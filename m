From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 27 Apr 2010 09:30:29 +0200
Subject: [PATCH 5/5] drivers: mtd: add Samsung SoC OneNAND driver
In-Reply-To: <20100427051916.GI6684@trinity.fluff.org>
References: <1270796266-8272-1-git-send-email-m.szyprowski@samsung.com>
	<1270796266-8272-6-git-send-email-m.szyprowski@samsung.com>
	<20100427051916.GI6684@trinity.fluff.org>
Message-ID: <001201cae5db$85f1df20$91d59d60$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, April 27, 2010 7:19 AM Ben Dooks wrote:

> ...

> > +static int s3c_read_reg(int offset)
> > +{
> > +	return readl(onenand->base + offset);
> > +}
> > +
> > +static void s3c_write_reg(int value, int offset)
> > +{
> > +	writel(value, onenand->base + offset);
> > +}
> 
> I can sort of see why you've done this, it would be interesting to see
> if the compiler is continually reloading onenand->base or not (currently
> too lazy to try this myself).

I will check this, but probably changing these functions to 'static inline' 
would solve the problem for sure.

> ...

> > +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!r) {
> > +		dev_err(&pdev->dev, "no resource defined\n");
> > +		return -ENXIO;
> 
> If i rember correctly, -ENXIO will make the driver layer fail to report
> any binding issue. However there seems to be a group of people who feel
> that using filesystem errors such as -ENOENT inappropriate for drivers...
> 
> Not sure what to recommend here, maybe just leave as is.

I will change it to -ENOENT. Most the drivers returns it if get_resource()
fails. I don't think that this really matters anyway...

> ...

> > +static int __init s3c_onenand_init(void)
> > +{
> > +	return platform_driver_register(&s3c_onenand_driver);
> > +}
> > +
> > +static void __exit s3c_onenand_exit(void)
> > +{
> > +	platform_driver_unregister(&s3c_onenand_driver);
> > +}
> > +
> > +module_init(s3c_onenand_init);
> > +module_exit(s3c_onenand_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Kyungmin Park <kyungmin.park@samsung.com>");
> > +MODULE_DESCRIPTION("Samsung OneNAND controller support");
> > +MODULE_ALIAS("platform:samsung-onenand");
> 
> don't think you need a MODULE_ALIAS when you have a MODULE_DEVICE_TABLE
> decleration, the module tools should support reading this table for use
> with the autoloader.

Ok. Thanks for your hints.

> Don't see any show stopping problems with this. It would be nice to
> sort out as many of the issues raised before final submission.

I will do all required cleanup and send the new patch series soon. Thanks for
your detailed review.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
