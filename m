From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 25 Aug 2016 23:30:16 +0900
Subject: [PATCH v2 3/7] pinctrl: samsung: Add the support the multiple
 IORESOURCE_MEM for one pin-bank
In-Reply-To: <1472046551-703-4-git-send-email-cw00.choi@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <CA+Ln22Ew=8S382zn+M8Ys5vztqvzp1+3EOTKtd81WSfuSyvY6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

2016-08-24 22:49 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
> This patch supports the multiple IORESOURCE_MEM resources for one pin-bank.
> In the pre-existing Exynos series, the registers of the gpio bank are included
> in the one memory map. But, some gpio bank need to support the one more memory
> map (IORESOURCE_MEM) because the registers of gpio bank are located in
> the different memory map.

Please see my comments inline.

> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> index 6db16b90873a..37bc692445d4 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> @@ -94,6 +94,11 @@ Required Properties:
>    pin configuration should use the bindings listed in the "pinctrl-bindings.txt"
>    file.
>
> +Optional Properties:
> +- reg: Second base address of the pin controller hardware module and length of
> +  the address space it occupies if the specific register of the pin controller
> +  are located in the different base address.
> +

I believe it should be required for certain controllers instead. So it
should be moved to required properties and a list of compatible string
and controller indices that need this second entry added. It should be
also precisely stated what are the first and second entry supposed to
point to for given controllers.

> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
> index 0f0f7cedb2dc..865a84c32fdc 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.h
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
> @@ -56,7 +56,9 @@
>                 .pctl_offset    = reg,                  \
>                 .nr_pins        = pins,                 \
>                 .eint_type      = EINT_TYPE_NONE,       \
> -               .name           = id                    \
> +               .name           = id,                   \
> +               .pctl_res_idx   = 0,                    \
> +               .eint_res_idx   = 0                     \

No need to explicitly initialize to 0.

>         }
>
>  #define EXYNOS_PIN_BANK_EINTG(pins, reg, id, offs)     \
> @@ -66,7 +68,9 @@
>                 .nr_pins        = pins,                 \
>                 .eint_type      = EINT_TYPE_GPIO,       \
>                 .eint_offset    = offs,                 \
> -               .name           = id                    \
> +               .name           = id,                   \
> +               .pctl_res_idx   = 0,                    \
> +               .eint_res_idx   = 0                     \

Ditto.

>         }
>
>  #define EXYNOS_PIN_BANK_EINTW(pins, reg, id, offs)     \
> @@ -76,7 +80,44 @@
>                 .nr_pins        = pins,                 \
>                 .eint_type      = EINT_TYPE_WKUP,       \
>                 .eint_offset    = offs,                 \
> -               .name           = id                    \
> +               .name           = id,                   \
> +               .pctl_res_idx   = 0,                    \
> +               .eint_res_idx   = 0                     \

Ditto.

> +       }
> +
> +#define EXYNOS_PIN_BANK_EINTN_EXT(pins, reg, id, pctl_idx, eint_idx)   \
> +       {                                               \
> +               .type           = &bank_type_off,       \
> +               .pctl_offset    = reg,                  \
> +               .nr_pins        = pins,                 \
> +               .eint_type      = EINT_TYPE_NONE,       \
> +               .name           = id,                   \
> +               .pctl_res_idx   = pctl_idx,             \
> +               .eint_res_idx   = eint_dix              \
> +       }

Your patch 4/7 doesn't seem to use this one, so this is dead code for
the time being. Please add when there is real need for it.

Also it doesn't really make much sense to have index for both pctl and
eint. Please define first entry of regs property as always pointing to
pctl registers and by also eint registers for usual controllers. Then
second regs entry would be eint registers for controllers with
separate register blocks. Then there is only a need to have
eint_res_idx in the driver and no need for pctl_res_idx, because it
would be always 0.

> +
> +#define EXYNOS_PIN_BANK_EINTG_EXT(pins, reg, id, offs, pctl_idx, eint_idx) \
> +       {                                               \
> +               .type           = &bank_type_off,       \
> +               .pctl_offset    = reg,                  \
> +               .nr_pins        = pins,                 \
> +               .eint_type      = EINT_TYPE_GPIO,       \
> +               .eint_offset    = offs,                 \
> +               .name           = id,                   \
> +               .pctl_res_idx   = pctl_idx,             \
> +               .eint_res_idx   = eint_idx              \
> +       }

Ditto.

> +
> +#define EXYNOS_PIN_BANK_EINTW_EXT(pins, reg, id, offs, pctl_idx, eint_idx) \
> +       {                                               \
> +               .type           = &bank_type_alive,     \
> +               .pctl_offset    = reg,                  \
> +               .nr_pins        = pins,                 \
> +               .eint_type      = EINT_TYPE_WKUP,       \
> +               .eint_offset    = offs,                 \
> +               .name           = id,                   \
> +               .pctl_res_idx   = pctl_idx,             \
> +               .eint_res_idx   = eint_idx              \
>         }
>
>  /**
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 513fe6b23248..f63f7608aef6 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -338,6 +338,7 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
>                         struct samsung_pin_bank **bank)
>  {
>         struct samsung_pin_bank *b;
> +       unsigned int pctl_res_idx;
>
>         b = drvdata->pin_banks;
>
> @@ -345,7 +346,8 @@ static void pin_to_reg_bank(struct samsung_pinctrl_drv_data *drvdata,
>                         ((b->pin_base + b->nr_pins - 1) < pin))
>                 b++;
>
> -       *reg = drvdata->virt_base + b->pctl_offset;
> +       pctl_res_idx = b->pctl_res_idx;
> +       *reg = drvdata->virt_base[pctl_res_idx] + b->pctl_offset;

I suggested something slightly different. Instead of
bank::pctl_res_idx, I proposed bank::pctl_base.
bank_info::pctl_res_idx would be specified only in init driver data
and bank::pctl_base would be calculated at probe time as
drvdata->virt_base[bank_info->pctl_res_idx] + bank_info->pctl_offset.
This would eliminate the need to do any indexing and adding further in
the code and make things simpler.

Taking my other comments above, pctl part would be unchanged and only
eint addresses and offsets would be affected.

>
> +       d->virt_base = devm_kzalloc(&pdev->dev, sizeof(void __iomem) *
> +                               (ctrl->nr_ext_resources + 1), GFP_KERNEL);
> +       if (!d->virt_base)
> +               return NULL;

Can we just define SAMSUNG_PiNCTRL_NUM_EXT_RESOURCES to 2 and have a
static array?

Also error code information is lost here by returning NULL.

> +
> +       for (j = 0 ; j < ctrl->nr_ext_resources + 1; j++) {
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, j);
> +               d->virt_base[j] = devm_ioremap_resource(&pdev->dev, res);
> +               if (IS_ERR(d->virt_base[j]))
> +                       return NULL;

This causes the error code information to be lost. Error

> +       }
> +
> +       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       if (res)
> +               d->irq = res->start;
> +

Also why all the code above was moved out of samsung_pinctrl_probe()?

Best regards,
Tomasz
