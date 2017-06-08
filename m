From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 8 Jun 2017 09:12:40 +0200
Subject: [PATCH 2/3] mmc: host: omap_hsmmc: use mmc_regulator_get_supply()
 to get regulators
In-Reply-To: <20170607083612.14224-3-kishon@ti.com>
References: <20170607083612.14224-1-kishon@ti.com>
 <20170607083612.14224-3-kishon@ti.com>
Message-ID: <CAPDyKFrsrUYTmpYE9WYgCfvNkvhtfaFDXUrgr8rxtNVUk0BxTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>         host->pbias = devm_regulator_get_optional(host->dev, "pbias");
> @@ -2143,7 +2136,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_irq;
>
> -       mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
> +       if (mmc_pdata(host)->ocr_mask)
> +               mmc->ocr_avail = mmc_pdata(host)->ocr_mask;

This should rather be:

if (!mmc->ocr_avail)
     mmc->ocr_avail = mmc_pdata(host)->ocr_mask

In other words, fall back to the platform ocr mask.

>
>         omap_hsmmc_disable_irq(host);
>
> --
> 2.11.0
>

Kind regards
Uffe
