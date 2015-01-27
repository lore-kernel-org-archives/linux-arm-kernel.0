From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Jan 2015 21:12:39 +0100
Subject: [PATCH v1 1/2] mmc: host: arasan: Add addition of-arasan quirks
 and IOMMU support for arasan SDHCI driver.
In-Reply-To: <1422379260-10139-2-git-send-email-stripathi@apm.com>
References: <1422379260-10139-1-git-send-email-stripathi@apm.com>
 <1422379260-10139-2-git-send-email-stripathi@apm.com>
Message-ID: <2889598.XIWjCcRL7e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 January 2015 22:50:59 Suman Tripathi wrote:
> @@ -174,6 +176,13 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         pltfm_host->priv = sdhci_arasan;
>         pltfm_host->clk = clk_xin;
> 
> +       ret = xgene_ahbc_iommu_attach_device(&pdev->dev);
> +       if (ret < 0 && IS_ENABLED(CONFIG_XGENE_AHBC_IOMMU)) {
> +               dev_err(&pdev->dev,
> +                       "unable to attach device to iommu %x\n", ret);
> +               goto clk_disable_all;
> +       }
> +
>         ret = sdhci_add_host(host);
>         if (ret) {
>                 dev_err(&pdev->dev, "platform register failed (%u)\n", ret);
> 

This looks wrong: the iommu should be automatically configured for devices
that need it, without any interaction from the driver.

	Arnd
