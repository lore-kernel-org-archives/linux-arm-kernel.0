From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 5 May 2011 18:24:31 +0400
Subject: [PATCH v2 1/7] mmc: sdhci: make sdhci-pltfm device drivers
	self registered
In-Reply-To: <1304601778-13837-2-git-send-email-shawn.guo@linaro.org>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110505142431.GA12444@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 09:22:52PM +0800, Shawn Guo wrote:
[...]
> +static int __devinit sdhci_cns3xxx_probe(struct platform_device *pdev)
> +{
> +	return sdhci_pltfm_register(pdev, &sdhci_cns3xxx_pdata);
> +}
> +
> +static int __devexit sdhci_cns3xxx_remove(struct platform_device *pdev)
> +{
> +	return sdhci_pltfm_unregister(pdev);
> +}
> +
> +static struct platform_driver sdhci_cns3xxx_driver = {
> +	.driver		= {
> +		.name	= "sdhci-cns3xxx",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= sdhci_cns3xxx_probe,
> +	.remove		= __devexit_p(sdhci_cns3xxx_remove),
> +#ifdef CONFIG_PM
> +	.suspend	= sdhci_pltfm_suspend,
> +	.resume		= sdhci_pltfm_resume,
> +#endif
> +};
> +
> +static int __init sdhci_cns3xxx_init(void)
> +{
> +	return platform_driver_register(&sdhci_cns3xxx_driver);
> +}
> +module_init(sdhci_cns3xxx_init);
> +
> +static void __exit sdhci_cns3xxx_exit(void)
> +{
> +	platform_driver_unregister(&sdhci_cns3xxx_driver);
> +}
> +module_exit(sdhci_cns3xxx_exit);

I don't think I like this duplicate code for each platform sub-
driver. It's repetitive and annoying. :-/

But considering that ARM will be multiplatform soon, we don't
want to have every mach-* stuff in the single sdhci-pltfm.

So... OK. If that compiles, I'm fine with it. :-D

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
