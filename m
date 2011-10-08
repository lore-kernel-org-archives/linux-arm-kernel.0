From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 8 Oct 2011 17:12:55 +0800
Subject: [PATCH 2/2] pinmux: add a driver for the U300 pinmux
In-Reply-To: <1317629883-13582-1-git-send-email-linus.walleij@stericsson.com>
References: <1317629883-13582-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAGsJ_4yKZTRXW+qBOOCZiVZkm8UR=P=PKH=MW85fi884gtCFnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int __init u300_pmx_probe(struct platform_device *pdev)
> +{
> + ? ? ? int ret;
> + ? ? ? struct u300_pmx *upmx;
> + ? ? ? struct resource *res;
> +
> + ? ? ? /* Create state holders etc for this driver */
> + ? ? ? upmx = devm_kzalloc(&pdev->dev, sizeof(struct u300_pmx), GFP_KERNEL);

and this would be "devm_kzalloc(&pdev->dev, sizeof(*upmx), GFP_KERNEL); " ?

> + ? ? ? if (!upmx)
> + ? ? ? ? ? ? ? return -ENOMEM;
> +
> + ? ? ? upmx->dev = &pdev->dev;
> +
> + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + ? ? ? if (!res) {
> + ? ? ? ? ? ? ? ret = -ENOENT;
> + ? ? ? ? ? ? ? goto out_no_resource;
> + ? ? ? }
> + ? ? ? upmx->phybase = res->start;
> + ? ? ? upmx->physize = resource_size(res);
> +
> + ? ? ? if (request_mem_region(upmx->phybase, upmx->physize,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?DRIVER_NAME) == NULL) {
> + ? ? ? ? ? ? ? ret = -EBUSY;
> + ? ? ? ? ? ? ? goto out_no_memregion;
> + ? ? ? }
> +
> + ? ? ? upmx->virtbase = ioremap(upmx->phybase, upmx->physize);
> + ? ? ? if (!upmx->virtbase) {
> + ? ? ? ? ? ? ? ret = -ENOMEM;
> + ? ? ? ? ? ? ? goto out_no_remap;
> + ? ? ? }
> +
> + ? ? ? upmx->pctl = pinctrl_register(&u300_pmx_desc, &pdev->dev, upmx);
> + ? ? ? if (IS_ERR(upmx->pctl)) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "could not register U300 pinmux driver\n");
> + ? ? ? ? ? ? ? ret = PTR_ERR(upmx->pctl);
> + ? ? ? ? ? ? ? goto out_no_pmx;
> + ? ? ? }
> +
> + ? ? ? /* We will handle a range of GPIO pins */
> + ? ? ? pinctrl_add_gpio_range(upmx->pctl, &u300_gpio_range);
> +
> + ? ? ? platform_set_drvdata(pdev, upmx);
> +
> + ? ? ? u300_pmx_dumpregs(upmx);
> +
> + ? ? ? dev_info(&pdev->dev, "initialized U300 pinmux driver\n");
> +
> + ? ? ? return 0;
> +
> +out_no_pmx:
> + ? ? ? iounmap(upmx->virtbase);
> +out_no_remap:
> + ? ? ? platform_set_drvdata(pdev, NULL);
> +out_no_memregion:
> + ? ? ? release_mem_region(upmx->phybase, upmx->physize);
> +out_no_resource:
> + ? ? ? devm_kfree(&pdev->dev, upmx);
> + ? ? ? return ret;
> +}
> +
-barry
