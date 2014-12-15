From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Dec 2014 22:29:20 +0100
Subject: [PATCH 1/3] xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC
 IOMMU driver.
In-Reply-To: <1418662523-8458-2-git-send-email-stripathi@apm.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
 <1418662523-8458-2-git-send-email-stripathi@apm.com>
Message-ID: <6441239.m4vUuhaUcX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 December 2014 22:25:21 Suman Tripathi wrote:
> +       return 0;
> +}
> +
> +static struct of_device_id xgene_ahbc_mmu_of_match[] = {
> +       { .compatible = "apm,xgene-ahbc-iommu"},
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, xgene_ahbc_mmu_of_match);
> +
> +static struct platform_driver xgene_ahbc_mmu_driver = {
> +       .probe          = xgene_ahbc_mmu_probe,
> +       .remove         = xgene_ahbc_mmu_remove,
> +       .driver = {
> +               .owner  = THIS_MODULE,
> +               .name   = "xgene-ahbc",
> +               .of_match_table = of_match_ptr(xgene_ahbc_mmu_of_match),
> +       },
> +};
> +
> +static int xgene_ahbc_mmu_init(void)
> +{
> +       return platform_driver_register(&xgene_ahbc_mmu_driver);
> +}
> +subsys_initcall(xgene_ahbc_mmu_init);
> +
> +static void __exit xgene_ahbc_mmu_exit(void)
> +{
> +       platform_driver_unregister(&xgene_ahbc_mmu_driver);
> +}
> +module_exit(xgene_ahbc_mmu_exit);
> 

This should use the newly added of_iommu infrastructure that we
added for 3.19. Otherwise you are just duplicating common code.

	Arnd
