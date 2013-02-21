From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 20:01:42 +0100
Subject: [PATCH v3 05/12] gpio: pxa: define nr gpios in platform data
In-Reply-To: <1361164358-5845-6-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYGWeKYXTvcpe+n7z=F61Njzt9s8Jhur0V3UHE-T_x=3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Avoid to define gpio numbers in gpio driver. Define it in platform data
> instead.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Very nice patch overall!

> -               if (!of_have_populated_dt())
> -                       ret = platform_add_devices(devices, ARRAY_SIZE(devices));
> +               if (!of_have_populated_dt()) {
> +                       if (cpu_is_pxa93x())
> +                               pxa3xx_gpio_info.nr_gpios = 192;

We need to get rid of cpu_is_* and pass this from the machine
instead, but this is OK as a stepping stone.

> -#ifdef CONFIG_ARCH_PXA
> -       if (cpu_is_pxa25x()) {
> -#ifdef CONFIG_CPU_PXA26x
> -               count = 89;
> -#elif defined(CONFIG_PXA25x)
> -               count = 84;
> -#endif /* CONFIG_CPU_PXA26x */
> -       } else if (cpu_is_pxa27x()) {
> -               count = 120;
> -       } else if (cpu_is_pxa93x()) {
> -               count = 191;
> -       } else if (cpu_is_pxa3xx()) {
> -               count = 127;
> -       }
> -#endif /* CONFIG_ARCH_PXA */
> -
> -#ifdef CONFIG_ARCH_MMP
> -       if (cpu_is_pxa168() || cpu_is_pxa910()) {
> -               count = 127;
> -       } else if (cpu_is_mmp2()) {
> -               count = 191;
> -       }
> -#endif /* CONFIG_ARCH_MMP */
> -       return count;
> -}

This alone warrants ACKing the patch :-)

> +       ret = of_property_read_u32(np, "marvell,nr-gpios", &pdata->nr_gpios);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "nr-gpios isn't specified\n");
> +               return -ENOTSUPP;
> +       }

Add this to the binding document?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
