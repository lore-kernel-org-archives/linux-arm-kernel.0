From: codekipper@gmail.com (Code Kipper)
Date: Wed, 3 Feb 2016 09:41:42 +0100
Subject: [PATCH v3 2/2] ASOC: sunxi: Add support for the SPDIF block
In-Reply-To: <20160202211743.GD4652@lukather>
References: <1454424594-25208-1-git-send-email-codekipper@gmail.com>
 <1454424594-25208-3-git-send-email-codekipper@gmail.com>
 <20160202211743.GD4652@lukather>
Message-ID: <CAEKpxBk3kFM-Qqn50P9VYuOgz5uJ_p__rVLZhQKDmf7GkVkzOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 February 2016 at 22:17, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> It looks mostly good on my side, a few comments though.
>
> On Tue, Feb 02, 2016 at 03:49:54PM +0100, codekipper at gmail.com wrote:
>> +#ifdef CONFIG_PM
>> +static int sun4i_spdif_runtime_suspend(struct device *dev)
>> +{
>> +     struct sun4i_spdif_dev *host  = dev_get_drvdata(dev);
>> +
>> +     clk_disable_unprepare(host->spdif_clk);
>> +
>> +     return 0;
>> +}
>> +
>> +static int sun4i_spdif_runtime_resume(struct device *dev)
>> +{
>> +     struct sun4i_spdif_dev *host  = dev_get_drvdata(dev);
>> +
>> +     clk_prepare_enable(host->spdif_clk);
>> +
>> +     return 0;
>> +}
>> +#endif /* CONFIG_PM */
>
> You can also shut down the bus clock here. That will reset the device,
> so you'll have to reinit it in your resume, but since you won't be
> suspended while you play something, and that you set up most of your
> controller any way when you start streaming, it shouldn't be a big
> deal.
ACK
>
>> +
>> +static int sun4i_spdif_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     struct sun4i_spdif_dev *host;
>> +     struct resource *res;
>> +     int ret;
>> +     void __iomem *base;
>> +
>> +     dev_dbg(&pdev->dev, "Entered %s\n", __func__);
>> +
>> +     if (!np)
>> +             return -ENODEV;
>
> You won't probe without DT.
ACK
>
>> +
>> +     if (!of_match_device(sun4i_spdif_of_match, &pdev->dev)) {
>> +             dev_err(&pdev->dev, "No matched devices found.\n");
>> +             return -EINVAL;
>> +     }
>
> And you won't probe if the compatibles don't match.
ACK
>
>> +     host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
>> +     if (!host)
>> +             return -ENOMEM;
>> +
>> +     host->pdev = pdev;
>> +
>> +     /* Initialize this copy of the CPU DAI driver structure */
>> +     memcpy(&host->cpu_dai_drv, &sun4i_spdif_dai, sizeof(sun4i_spdif_dai));
>> +     host->cpu_dai_drv.name = dev_name(&pdev->dev);
>> +
>> +     /* Get the addresses */
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>> +                                             &sun4i_spdif_regmap_config);
>> +
>> +     /* Clocks */
>> +     host->apb_clk = devm_clk_get(&pdev->dev, "apb");
>> +     if (IS_ERR(host->apb_clk)) {
>> +             dev_err(&pdev->dev, "failed to get a apb clock.\n");
>> +             return PTR_ERR(host->apb_clk);
>> +     }
>> +
>> +     ret = clk_prepare_enable(host->apb_clk);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "try to enable apb_spdif_clk failed\n");
>> +             return ret;
>> +     }
>> +
>> +     host->spdif_clk = devm_clk_get(&pdev->dev, "spdif");
>> +     if (IS_ERR(host->spdif_clk)) {
>> +             dev_err(&pdev->dev, "failed to get a spdif clock.\n");
>> +             goto exit_clkdisable_apb_clk;
>> +     }
>> +
>> +     host->playback_supported = false;
>> +     host->capture_supported = false;
>> +
>> +     if (of_property_read_bool(np, "spdif-out"))
>> +             host->playback_supported = true;
>> +
>> +     if (!host->playback_supported) {
>> +             dev_err(&pdev->dev, "no enabled S/PDIF DAI link\n");
>> +             goto exit_clkdisable_clk;
>> +     }
>> +
>> +     host->dma_params_tx.addr = res->start + SUN4I_SPDIF_TXFIFO;
>> +     host->dma_params_tx.maxburst = 4;
>> +     host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +     host->dma_params_rx.addr = res->start + SUN4I_SPDIF_RXFIFO;
>> +     host->dma_params_rx.maxburst = 4;
>> +     host->dma_params_rx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +
>> +     platform_set_drvdata(pdev, host);
>> +
>> +     ret = devm_snd_soc_register_component(&pdev->dev,
>> +                             &sun4i_spdif_component, &sun4i_spdif_dai, 1);
>> +     if (ret)
>> +             goto exit_clkdisable_clk;
>> +
>> +     pm_runtime_enable(&pdev->dev);
>> +
>> +     ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
>> +     if (ret)
>> +             goto exit_clkdisable_clk;
>> +     return 0;
>> +
>> +exit_clkdisable_clk:
>> +     clk_disable_unprepare(host->spdif_clk);
>
> You disabled a clock that you didn't enable.
ACK
>
>> +exit_clkdisable_apb_clk:
>> +     clk_disable_unprepare(host->apb_clk);
>> +     return ret;
>> +}
>> +
>> +static int sun4i_spdif_remove(struct platform_device *pdev)
>> +{
>> +     struct sun4i_spdif_dev *host = dev_get_drvdata(&pdev->dev);
>> +
>> +     snd_soc_unregister_platform(&pdev->dev);
>> +     snd_soc_unregister_component(&pdev->dev);
>> +
>> +     pm_runtime_disable(&pdev->dev);
>> +
>> +     if (!IS_ERR(host->spdif_clk)) {
>
> Probe will fail on this condition. If probe failed, remove won't be
> called.
>
>> +             clk_disable_unprepare(host->spdif_clk);
>
> And here as well.
>
>> +             clk_disable_unprepare(host->apb_clk);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct dev_pm_ops sun4i_spdif_pm = {
>> +     SET_RUNTIME_PM_OPS(sun4i_spdif_runtime_suspend,
>> +                        sun4i_spdif_runtime_resume, NULL)
>> +};
>> +
>> +static struct platform_driver sun4i_spdif_driver = {
>> +     .driver         = {
>> +             .name   = "sun4i-spdif",
>> +             .owner  = THIS_MODULE,
>
> This is not needed.
ACK
>
>> +             .of_match_table = of_match_ptr(sun4i_spdif_of_match),
>> +             .pm     = &sun4i_spdif_pm,
>
> IIRC, the pm field is not defined if PM is not set.
>
> Have you tested your driver without PM?
No but I'll have a go!

>
>> +     },
>> +     .probe          = sun4i_spdif_probe,
>> +     .remove         = sun4i_spdif_remove,
>> +};
>> +
>> +module_platform_driver(sun4i_spdif_driver);
>> +
>> +MODULE_AUTHOR("Marcus Cooper <codekipper@gmail.com>");
>> +MODULE_AUTHOR("Andrea Venturi <be17068@iperbole.bo.it>");
>> +MODULE_DESCRIPTION("Allwinner sun4i SPDIF SoC Interface");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:sun4i-spdif");
>
> Thanks!
> Maxime
Thanks,
CK
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
