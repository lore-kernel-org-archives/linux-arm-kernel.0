From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 12 Jun 2013 15:28:42 +0300
Subject: [PATCH 1/3] usb: chipidea: add CSR SiRFSoC ci13xxx usb driver
In-Reply-To: <1370748338-13210-2-git-send-email-Baohua.Song@csr.com>
References: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
 <1370748338-13210-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <CAHp75VdBKMCPuRwiMRJHvt_ppDN99Hu3kzj13MqtOUFsENfyhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 9, 2013 at 6:25 AM, Barry Song <21cnbao@gmail.com> wrote:
> CSR SiRF SoCs licensed chipidea ci13xxx USB IP, this patch
> makes the chipidea drivers support CSR SiRF SoCS.
>
> It also changes the Kconfig, only compile MSM and IMX if related
> drivers are enabled. Otherwise, we always need to enable all
> clients of chipidea drivers.

> +       /* 5. set device dma mask */
> +       if (!pdev->dev.dma_mask) {
> +               pdev->dev.dma_mask = devm_kzalloc(&pdev->dev,
> +                                     sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> +               if (!pdev->dev.dma_mask) {
> +                       dev_err(&pdev->dev, "Failed to alloc dma_mask!\n");
> +                       ret = -ENOMEM;
> +                       goto err;
> +               }
> +               *pdev->dev.dma_mask = DMA_BIT_MASK(32);
> +               dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);

Perhaps you could avoid this allocation if you apply coherent mask
first and its address will be used as dma_mask value.

> +       }

> +err:
> +       clk_disable_unprepare(data->clk);
> +       return ret;

Please, check, but if I remember correctly devm_clk* is doing this for
you on release stage.

> +static int ci13xxx_sirf_remove(struct platform_device *pdev)
> +{
> +       struct ci13xxx_sirf_data *data = platform_get_drvdata(pdev);
> +
> +       pm_runtime_disable(&pdev->dev);
> +       ci13xxx_remove_device(data->ci_pdev);
> +
> +       clk_disable_unprepare(data->clk);

Ditto.

--
With Best Regards,
Andy Shevchenko
