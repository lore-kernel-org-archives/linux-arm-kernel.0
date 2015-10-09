From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 9 Oct 2015 11:48:34 +0200
Subject: [PATCH 4/8] mmc: sdhci-pxav3: enable proper resuming on Armada
 38x SoC
In-Reply-To: <20151009090902.3b5b9bc8@xhacker>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-5-git-send-email-mw@semihalf.com>
 <20151009090902.3b5b9bc8@xhacker>
Message-ID: <CAPv3WKfB=5Xz+f=BMiPTD1EYZifX41g0BK0kwX5rNFjG3PQ3ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,


>> +     res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mbus");
>> +     pxa->mbus_win_regs = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(pxa->mbus_win_regs)) {
>> +             dev_err(mmc_dev(host->mmc),
>> +                     "failed to obtain MBus windows register base\n");
>
> devm_ioremap_resource() has warned us if it fails, so is it better to remove
> this dev_err() here?
>

Indeed, I'll remove this excessive verbosity.

>>       struct sdhci_host *host = dev_get_drvdata(dev);
>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +     struct sdhci_pxa *pxa = pltfm_host->priv;
>> +     struct device_node *np = dev->of_node;
>> +
>> +     if (of_device_is_compatible(np, "marvell,armada-380-sdhci"))
>
> this would increase resume time especially those non armada-380-sdhci host
> although it's trivial. Is it better to check "if (pxa->mbus_win_regs)"?
>

Already implemented in v2.

Thanks for the comments,
Marcin
