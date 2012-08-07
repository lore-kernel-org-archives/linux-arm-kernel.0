From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Aug 2012 19:15:25 +0000
Subject: [PATCH 1/6] ARM: mxs: tx28: reset fec phy for device tree boot
In-Reply-To: <1344267769-31166-2-git-send-email-shawn.guo@linaro.org>
References: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
 <1344267769-31166-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <201208071915.26932.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 August 2012, Shawn Guo wrote:
> +static void __init tx28_post_init(void)
> +{
> +       struct device_node *np;
> +       struct platform_device *pdev;
> +       struct pinctrl *pctl;
> +       int ret;
> +
> +       enable_clk_enet_out();
> +
> +       np = of_find_compatible_node(NULL, NULL, "fsl,imx28-fec");
> +       pdev = of_find_device_by_node(np);
> +       if (!pdev) {
> +               pr_err("%s: failed to find fec device\n", __func__);
> +               return;
> +       }
> +
> +       pctl = pinctrl_get_select(&pdev->dev, "gpio_mode");
> +       if (IS_ERR(pctl)) {
> +               pr_err("%s: failed to get pinctrl state\n", __func__);
> +               return;
> +       }
> +
> +       ret = gpio_request_array(tx28_gpios, ARRAY_SIZE(tx28_gpios));
> +       if (ret) {
> +               pr_err("%s: failed to request gpios: %d\n", __func__, ret);
> +               return;
> +       }
> +
> +       /* Power up fec phy */
> +       gpio_set_value(TX28_FEC_PHY_POWER, 1);
> +       mdelay(26); /* 25ms according to data sheet */

26 ms is a long time for a delay. I think you should use msleep here.

	Arnd
