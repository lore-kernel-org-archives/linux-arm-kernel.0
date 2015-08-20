From: axel.lin@ingics.com (Axel Lin)
Date: Thu, 20 Aug 2015 11:49:35 +0800
Subject: [PATCH v2] pinctrl: mediatek: Fix multiple registration issue.
In-Reply-To: <1440041931-38278-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1440041931-38278-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CAFRkauDE4QRnZP4q61JyX+t8rn3zOtokiESJTV4uak71zM0kTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-20 11:38 GMT+08:00 Hongzhou Yang <hongzhou.yang@mediatek.com>:
> Since our common driver need support main chip and PMU
> at the same time, that means it will register two
> pinctrl device, and the pinctrl_desc structure should
> be used two times.
>
> But pinctrl_desc use global static definition, then
> the latest registered pinctrl device will overwrite
> the old one's, all members in pinctrl_desc will set to
> the new one's, such as name, pins and pins numbers, etc.
> This is a bug. Changing to use devm_kzalloc to fix it.
>
> Cc: stable at vger.kernel.org # v4.1+
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  Use dynamic allocation to fix multiple registration issue.
>
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   26 ++++++++++++++-----------
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    1 +
>  2 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index ad1ea16..911c736 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -1202,12 +1202,6 @@ static int mtk_pctrl_build_state(struct platform_device *pdev)
>         return 0;
>  }
>
> -static struct pinctrl_desc mtk_pctrl_desc = {
> -       .confops        = &mtk_pconf_ops,
> -       .pctlops        = &mtk_pctrl_ops,
> -       .pmxops         = &mtk_pmx_ops,
> -};
> -
>  int mtk_pctrl_init(struct platform_device *pdev,
>                 const struct mtk_pinctrl_devdata *data,
>                 struct regmap *regmap)
> @@ -1265,12 +1259,22 @@ int mtk_pctrl_init(struct platform_device *pdev,
>
>         for (i = 0; i < pctl->devdata->npins; i++)
>                 pins[i] = pctl->devdata->pins[i].pin;
> -       mtk_pctrl_desc.name = dev_name(&pdev->dev);
> -       mtk_pctrl_desc.owner = THIS_MODULE;
> -       mtk_pctrl_desc.pins = pins;
> -       mtk_pctrl_desc.npins = pctl->devdata->npins;
> +
> +       pctl->pctl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctl->pctl_desc),
> +                               GFP_KERNEL);
> +       if (!pctl->pctl_desc)
> +               return -ENOMEM;
> +
> +       pctl->pctl_desc->name = dev_name(&pdev->dev);
> +       pctl->pctl_desc->owner = THIS_MODULE;
> +       pctl->pctl_desc->pins = pins;
> +       pctl->pctl_desc->npins = pctl->devdata->npins;
> +       pctl->pctl_desc->confops = &mtk_pconf_ops;
> +       pctl->pctl_desc->pctlops = &mtk_pctrl_ops;
> +       pctl->pctl_desc->pmxops = &mtk_pmx_ops;
>         pctl->dev = &pdev->dev;
> -       pctl->pctl_dev = pinctrl_register(&mtk_pctrl_desc, &pdev->dev, pctl);
> +
> +       pctl->pctl_dev = pinctrl_register(pctl->pctl_desc, &pdev->dev, pctl);
>         if (IS_ERR(pctl->pctl_dev)) {
>                 dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
>                 return PTR_ERR(pctl->pctl_dev);
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> index 30213e5..93d6f5b 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> @@ -256,6 +256,7 @@ struct mtk_pinctrl_devdata {
>  struct mtk_pinctrl {
>         struct regmap   *regmap1;
>         struct regmap   *regmap2;
> +       struct pinctrl_desc *pctl_desc;
Use
struct pinctrl_desc pctl_desc;

Then you can remove the devm_kzalloc.
