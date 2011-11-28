From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Nov 2011 10:08:16 +0100
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdYPd7a29Sj-F-Aj8vqa3v7unCKNtPH5EPWwapbYgKFLRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2011 at 12:08 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> Support PXA300/PXA310/PXA320/PXA910 pinmux.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Cool!

> +#ifdef CONFIG_ARCH_PXA
> +static struct pinctrl_pin_desc pxa300_pads[] = {
(...)

Ick, per-arch #ifdefs in the driver/ directory is not good. Can you arrange
for this to be #ifdef:ed up in your board file and passed in as platform
data instead of being defined here?

I know that the U300 driver defines all it's pins in the driver file,
but it only supports one single board on one single chipset and
is thus pretty fixed, nominally this kind of stuff should come from
the board file(s) or the device tree.

> +static int pxa3xx_get_gpio_func(unsigned int cpuid, unsigned int gpio)
> +{
> + ? ? ? int ret = 0;
> +
> + ? ? ? switch (cpuid) {
> +#ifdef CONFIG_ARCH_PXA
> + ? ? ? case PINMUX_PXA300:
> + ? ? ? case PINMUX_PXA310:
> + ? ? ? ? ? ? ? if (gpio == 50)
> + ? ? ? ? ? ? ? ? ? ? ? ret = 2;
> + ? ? ? ? ? ? ? else if (gpio == 49 || gpio == 51 || gpio == 53)
> + ? ? ? ? ? ? ? ? ? ? ? ret = 3;
> + ? ? ? ? ? ? ? break;
> + ? ? ? case PINMUX_PXA320:
> + ? ? ? ? ? ? ? if (gpio == 56 || (gpio > 58 && gpio < 63))
> + ? ? ? ? ? ? ? ? ? ? ? goto out;
> + ? ? ? ? ? ? ? break;
> +#endif
> +#ifdef CONFIG_ARCH_MMP
> + ? ? ? case PINMUX_PXA910:
> + ? ? ? ? ? ? ? if ((gpio > 116 && gpio < 121) || gpio == 122 || gpio == 123 ||
> + ? ? ? ? ? ? ? ? ? ? ? gpio == 125 || gpio == 99 || gpio == 58 || gpio == 59)
> + ? ? ? ? ? ? ? ? ? ? ? ret = 1;
> + ? ? ? ? ? ? ? break;
> +#endif

Do you need these #ifdef:s?

They need to go, one way or another.

Switching on cpuid is excellent, provided it's passed in from
the outside, the definitons of these cases should be available
anyway should they not.

#ifdef:in out for footprint or unused code paths on some platforms
should *not* be done, it creates more trouble than it solves, see
Documentation/SubmittingPatches section 2) #ifdefs are ugly.

> +static int pxa3xx_get_mfpr(unsigned int cpuid, unsigned int pin)
> +{
> + ? ? ? int ret;
> + ? ? ? switch (cpuid) {
> +#ifdef CONFIG_ARCH_PXA

Dito. Etc.

> +#ifdef CONFIG_ARCH_MMP
> +static struct pinctrl_desc pxa910_pctrl_desc = {
> +       .name           = "pxa910-pinctrl",
> +       .pins           = pxa910_pads,
> +       .npins          = ARRAY_SIZE(pxa910_pads),
> +       .maxpin         = 260,
> +       .pctlops        = &pxa3xx_pctrl_ops,
> +       .pmxops         = &pxa3xx_pmx_ops,
> +       .owner          = THIS_MODULE,
> +};

This is not good either. Get rid of all #ifdef

> +#ifdef CONFIG_ARCH_PXA
> + ? ? ? if (cpu_is_pxa300()) {
> + ? ? ? ? ? ? ? info->cpuid = PINMUX_PXA300;
> + ? ? ? ? ? ? ? info->grp = pxa300_pin_groups;
> + ? ? ? ? ? ? ? info->func = pxa300_pmx_functions;
> + ? ? ? ? ? ? ? info->num_grps = ARRAY_SIZE(pxa300_pin_groups);
> + ? ? ? ? ? ? ? info->num_funcs = ARRAY_SIZE(pxa300_pmx_functions);
> + ? ? ? ? ? ? ? info->pctl = pinctrl_register(&pxa300_pctrl_desc, &pdev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? info);
> + ? ? ? ? ? ? ? range = pxa300_gpio_ranges;
> + ? ? ? ? ? ? ? range_num = ARRAY_SIZE(pxa300_gpio_ranges);
> + ? ? ? } else if (cpu_is_pxa310()) {
> + ? ? ? ? ? ? ? info->cpuid = PINMUX_PXA310;
> + ? ? ? ? ? ? ? info->grp = pxa310_pin_groups;
> + ? ? ? ? ? ? ? info->func = pxa310_pmx_functions;
> + ? ? ? ? ? ? ? info->num_grps = ARRAY_SIZE(pxa310_pin_groups);
> + ? ? ? ? ? ? ? info->num_funcs = ARRAY_SIZE(pxa310_pmx_functions);
> + ? ? ? ? ? ? ? info->pctl = pinctrl_register(&pxa310_pctrl_desc, &pdev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? info);
> + ? ? ? ? ? ? ? range = pxa310_gpio_ranges;
> + ? ? ? ? ? ? ? range_num = ARRAY_SIZE(pxa310_gpio_ranges);
> + ? ? ? } else if (cpu_is_pxa320()) {
> + ? ? ? ? ? ? ? info->cpuid = PINMUX_PXA320;
> + ? ? ? ? ? ? ? info->grp = pxa320_pin_groups;
> + ? ? ? ? ? ? ? info->func = pxa320_pmx_functions;
> + ? ? ? ? ? ? ? info->num_grps = ARRAY_SIZE(pxa320_pin_groups);
> + ? ? ? ? ? ? ? info->num_funcs = ARRAY_SIZE(pxa320_pmx_functions);
> + ? ? ? ? ? ? ? info->pctl = pinctrl_register(&pxa320_pctrl_desc, &pdev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? info);
> + ? ? ? ? ? ? ? range = pxa320_gpio_ranges;
> + ? ? ? ? ? ? ? range_num = ARRAY_SIZE(pxa320_gpio_ranges);
> + ? ? ? }
> +#endif
> +#ifdef CONFIG_ARCH_MMP
> + ? ? ? if (cpu_is_pxa910()) {
> + ? ? ? ? ? ? ? info->cpuid = PINMUX_PXA910;
> + ? ? ? ? ? ? ? info->grp = pxa910_pin_groups;
> + ? ? ? ? ? ? ? info->func = pxa910_pmx_functions;
> + ? ? ? ? ? ? ? info->num_grps = ARRAY_SIZE(pxa910_pin_groups);
> + ? ? ? ? ? ? ? info->num_funcs = ARRAY_SIZE(pxa910_pmx_functions);
> + ? ? ? ? ? ? ? info->pctl = pinctrl_register(&pxa910_pctrl_desc, &pdev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? info);
> + ? ? ? ? ? ? ? range = pxa910_gpio_ranges;
> + ? ? ? ? ? ? ? range_num = ARRAY_SIZE(pxa910_gpio_ranges);
> + ? ? ? }
> +#endif

Same here.

But *apart* from the #ifdef stuff it looks very good!
So if you can get rid of that, I'll be very happy!

Yours,
Linus Walleij
