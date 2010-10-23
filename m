From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 23 Oct 2010 19:50:31 +0200
Subject: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
In-Reply-To: <AANLkTi=RNDf-A98LN3AH=JdegHXKRjHvtGCDYtkJ5ADg@mail.gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<201010231624.03293.marek.vasut@gmail.com>
	<AANLkTi=RNDf-A98LN3AH=JdegHXKRjHvtGCDYtkJ5ADg@mail.gmail.com>
Message-ID: <201010231950.31707.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 23. ??jna 2010 18:47:10 zhangfei gao napsal(a):
> On Sat, Oct 23, 2010 at 10:24 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >> +/**********************************************************************
> >> *** ****\ + *
> >>         * + * Device probing/removal
> >>              * + *
> >>                   *
> >> +\**********************************************************************
> >> ** *****/ +
> >> +static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
> >> +{
> >> +     struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
> >> +     struct device *dev = &pdev->dev;
> >> +     struct sdhci_host *host = NULL;
> >> +     struct resource *iomem = NULL;
> >> +     struct sdhci_pxa *pxa = NULL;
> >> +     int ret, irq;
> >> +
> >> +     irq = platform_get_irq(pdev, 0);
> >> +     if (irq < 0) {
> >> +             dev_err(dev, "no irq specified\n");
> >> +             return irq;
> >> +     }
> >> +
> >> +     iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >> +     if (!iomem) {
> >> +             dev_err(dev, "no memory specified\n");
> >> +             return -ENOENT;
> >> +     }
> >> +
> >> +     host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pxa));
> >> +     if (IS_ERR(host)) {
> >> +             dev_err(dev, "failed to alloc host\n");
> >> +             return PTR_ERR(host);
> >> +     }
> >> +
> >> +     pxa = sdhci_priv(host);
> >> +     pxa->host = host;
> >> +     pxa->pdata = pdata;
> >> +     pxa->clk_enable = 0;
> >> +
> >> +     pxa->clk = clk_get(dev, "PXA-SDHCLK");
> >> +     if (IS_ERR(pxa->clk)) {
> >> +             dev_err(dev, "failed to get io clock\n");
> >> +             ret = PTR_ERR(pxa->clk);
> >> +             goto out;
> >> +     }
> >> +
> >> +     pxa->res = request_mem_region(iomem->start, resource_size(iomem),
> >> +             mmc_hostname(host->mmc));
> >> +     if (!pxa->res) {
> >> +             dev_err(&pdev->dev, "cannot request region\n");
> >> +             ret = -EBUSY;
> >> +             goto out;
> >> +     }
> >> +
> >> +     host->ioaddr = ioremap(iomem->start, resource_size(iomem));
> >> +     if (!host->ioaddr) {
> >> +             dev_err(&pdev->dev, "failed to remap registers\n");
> >> +             ret = -ENOMEM;
> >> +             goto out;
> >> +     }
> >> +
> >> +     host->hw_name = "MMC";
> >> +     host->ops = &sdhci_pxa_ops;
> >> +     host->irq = irq;
> >> +     host->quirks = SDHCI_QUIRK_BROKEN_ADMA |
> >> SDHCI_QUIRK_BROKEN_TIMEOUT_VAL; +
> > 
> > Maybe check if these aren't already set in pdata and warn user ?
> 
> Here pdata->quirks only provide specific quirk like
> SDHCI_QUIRK_BROKEN_CARD_DETECTION for on-chip device, the common quirk
> is provided above.

Right, but what if the user also provides such a quirk? It's unnecessary ... and 
in case the quirk was removed from here later, it'd have to be removed from 
user's code too ...

> In sdhci-s3c, host->quirks is modified here via pdata->cd_type, which
> is also a good method.
> Here we transfer SDHCI_QUIRK_BROKEN_CARD_DETECTION directly from pdata
> since it already move to include folder.
> 
> >> +     if (pdata->quirks)
> >> +             host->quirks |= pdata->quirks;
> >> +
> >> +     ret = sdhci_add_host(host);
> >> +     if (ret) {
> >> +             dev_err(&pdev->dev, "failed to add host\n");
> >> +             goto out;
> >> +     }
> >> +
> >> +     if (pxa->pdata->max_speed)
> >> +             host->mmc->f_max = pxa->pdata->max_speed;
> > 
> > What happens otherwise ?
> 
> Otherwise, host->mmc->f_max = host->max_clk set in sdhci_add_host,
> host->max_clk is 50M in 2.0 controller, and 200M in 3.0 controller, if
> controller does not need to provide get_max_clock.
> it's better add defalut value in else condition.

Thanks for clearing this
> 
> Thanks Marek for review.
> 
> >> +
> >> +     platform_set_drvdata(pdev, host);
> >> +
> >> +     return 0;
> >> +out:
> >> +     if (host) {
> >> +             clk_put(pxa->clk);
> >> +             if (host->ioaddr)
> >> +                     iounmap(host->ioaddr);
> >> +             if (pxa->res)
> >> +                     release_mem_region(pxa->res->start,
> >> +                                     resource_size(pxa->res));
> >> +             sdhci_free_host(host);
> >> +     }
> >> +
> >> +     return ret;
> >> +}
> >> +
> > 
> > Thanks!
> > 
> > Cheers
