From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 08 Apr 2013 20:42:36 -0700
Subject: [PATCH v2] clk: add LP8788 clock driver
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E4AB29@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F82E4AB29@DQHE02.ent.ti.com>
Message-ID: <20130409034236.14359.17841@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kim, Milo (2013-04-03 18:34:37)
> Patch v2.
>   (a) Remove unnecessary 'is_enabled()' operation code.
>   (b) Add CLK_IGNORE_UNUSED flag.
>   (c) Add clock device detection code : lp8788_is_clk_device_ready()
>       If the device is not ready, return as -ENODEV on loading the driver.
> 
> Patch v1.
>   Initial patch
> 

It's better to put the above changelog stuff below in the scratchpad
area ...

> Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
> ---

... here.

>  drivers/clk/Kconfig        |    7 ++
>  drivers/clk/Makefile       |    1 +
>  drivers/clk/clk-lp8788.c   |  160 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/lp8788.c       |    2 +
>  include/linux/mfd/lp8788.h |    1 +
>  5 files changed, 171 insertions(+)
>  create mode 100644 drivers/clk/clk-lp8788.c
> 
> +static int lp8788_clk_probe(struct platform_device *pdev)
> +{
> +       struct lp8788 *lp = dev_get_drvdata(pdev->dev.parent);
> +       struct lp8788_clk *pclk;
> +
> +       pclk = devm_kzalloc(&pdev->dev, sizeof(struct lp8788_clk), GFP_KERNEL);
> +       if (!pclk)
> +               return -ENOMEM;
> +
> +       pclk->lp = lp;
> +       platform_set_drvdata(pdev, pclk);
> +
> +       if (!lp8788_is_clk_device_ready(pclk))
> +               return -ENODEV;

Would EPROBE_DEFER be better?

> +
> +       return lp8788_clk_register(&pdev->dev, pclk);
> +}
> +
> +static int lp8788_clk_remove(struct platform_device *pdev)
> +{
> +       struct lp8788_clk *pclk = platform_get_drvdata(pdev);
> +
> +       lp8788_clk_unregister(pclk);
> +       return 0;
> +}
> +
> +static struct platform_driver lp8788_clk_driver = {
> +       .probe = lp8788_clk_probe,
> +       .remove = lp8788_clk_remove,
> +       .driver         = {
> +               .name   = LP8788_DEV_CLK,
> +               .owner  = THIS_MODULE,
> +       },
> +};
> +
> +static int __init lp8788_clk_init(void)
> +{
> +       return platform_driver_register(&lp8788_clk_driver);
> +}
> +subsys_initcall(lp8788_clk_init);
> +
> +static void __exit lp8788_clk_exit(void)
> +{
> +       platform_driver_unregister(&lp8788_clk_driver);
> +}
> +module_exit(lp8788_clk_exit);
> +
> +MODULE_DESCRIPTION("TI LP8788 Clock Driver");
> +MODULE_AUTHOR("Milo Kim");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:lp8788-clk");
> diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
> index c3d3c9b..9f5596e 100644
> --- a/drivers/mfd/lp8788.c
> +++ b/drivers/mfd/lp8788.c
> @@ -72,6 +72,8 @@ static struct resource rtc_irqs[] = {
>  };
>  
>  static struct mfd_cell lp8788_devs[] = {
> +       MFD_DEV_SIMPLE(CLK),
> +
>         /* 4 bucks */
>         MFD_DEV_WITH_ID(BUCK, 1),
>         MFD_DEV_WITH_ID(BUCK, 2),
> diff --git a/include/linux/mfd/lp8788.h b/include/linux/mfd/lp8788.h
> index 786bf66..5f33be8 100644
> --- a/include/linux/mfd/lp8788.h
> +++ b/include/linux/mfd/lp8788.h
> @@ -28,6 +28,7 @@
>  #define LP8788_DEV_VIBRATOR    "lp8788-vibrator"
>  #define LP8788_DEV_KEYLED      "lp8788-keyled"
>  #define LP8788_DEV_ADC         "lp8788-adc"
> +#define LP8788_DEV_CLK         "lp8788-clk"
>  
>  #define LP8788_NUM_BUCKS       4
>  #define LP8788_NUM_DLDOS       12

I guess the above two hunks need Samuel's ACK.

Regards,
Mike

> -- 
> 1.7.9.5
> 
> 
> Best Regards,
> Milo
