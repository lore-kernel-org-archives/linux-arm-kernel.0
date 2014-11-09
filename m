From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 9 Nov 2014 19:55:09 -0200
Subject: [PATCH] mmc: wmt-sdmmc: fix unmatched release_mem_region
In-Reply-To: <1415567571-6144-1-git-send-email-alchark@gmail.com>
References: <1415567571-6144-1-git-send-email-alchark@gmail.com>
Message-ID: <CAOMZO5C+O4h=f=vtLTdBZktnfVWzfeLjOQG-oecxh_c9u-QMqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 9, 2014 at 7:12 PM, Alexey Charkov <alchark@gmail.com> wrote:

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res) {
> +               ret = -ENODEV;
> +               goto fail1;

You could save this NULL check...

> +       }
>         mmc = mmc_alloc_host(sizeof(struct wmt_mci_priv), &pdev->dev);
>         if (!mmc) {
>                 dev_err(&pdev->dev, "Failed to allocate mmc_host\n");
> @@ -813,7 +819,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>         if (of_get_property(np, "cd-inverted", NULL))
>                 priv->cd_inverted = 1;
>
> -       priv->sdmmc_base = of_iomap(np, 0);

If you move ' res = platform_get_resource' right here as
devm_ioremap_resource() already does the NULL check.

> +       priv->sdmmc_base = devm_ioremap_resource(&pdev->dev, res);
>         if (!priv->sdmmc_base) {
>                 dev_err(&pdev->dev, "Failed to map IO space\n");
>                 ret = -ENOMEM;
