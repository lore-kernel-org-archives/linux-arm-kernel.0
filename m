From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 14 Aug 2015 17:57:17 +0800
Subject: [PATCH v4] pinctrl: mediatek: Implement wake handler and suspend
 resume
In-Reply-To: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
References: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
Message-ID: <CAGS+omAtW0O2FgGkDsw7BgZA1Vhdkp2UhCvsgjf5rP1Q+jybuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 4:38 PM, <maoguang.meng@mediatek.com> wrote:
>
> From: Maoguang Meng <maoguang.meng@mediatek.com>
>
> This patch implement irq_set_wake to get who is wakeup source and
> setup on suspend resume.
>
> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

Thanks!
-Dan

>
> ---
> changes since v3:
> -add a comment in mtk_eint_chip_read_mask.
> -delete ALIGN when allocate eint_offsets.ports.
> -fix unrelated change.
>
> changes since v2:
> -modify irq_wake to handle irq wakeup source.
> -allocate two buffers separately.
> -fix some codestyle.
>
> Changes since v1:
> -implement irq_wake handler.
> ---
>
>  drivers/pinctrl/mediatek/pinctrl-mt8173.c     |  1 +
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 91 ++++++++++++++++++++++++++-
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  4 ++
>  3 files changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
> index d0c811d..ad27184 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
> @@ -385,6 +385,7 @@ static struct platform_driver mtk_pinctrl_driver = {
>         .driver = {
>                 .name = "mediatek-mt8173-pinctrl",
>                 .of_match_table = mt8173_pctrl_match,
> +               .pm = &mtk_eint_pm_ops,
>         },
>  };
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index ad1ea16..fe34ce9 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -33,6 +33,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/pm.h>
>  #include <dt-bindings/pinctrl/mt65xx.h>
>
>  #include "../core.h"
> @@ -1062,6 +1063,77 @@ static int mtk_eint_set_type(struct irq_data *d,
>         return 0;
>  }
>
> +static int mtk_eint_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +       struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> +       int shift = d->hwirq & 0x1f;
> +       int reg = d->hwirq >> 5;
> +
> +       if (on)
> +               pctl->wake_mask[reg] |= BIT(shift);
> +       else
> +               pctl->wake_mask[reg] &= ~BIT(shift);
> +
> +       return 0;
> +}
> +
> +static void mtk_eint_chip_write_mask(const struct mtk_eint_offsets *chip,
> +               void __iomem *eint_reg_base, u32 *buf)
> +{
> +       int port;
> +       void __iomem *reg;
> +
> +       for (port = 0; port < chip->ports; port++) {
> +               reg = eint_reg_base + (port << 2);
> +               writel_relaxed(~buf[port], reg + chip->mask_set);
> +               writel_relaxed(buf[port], reg + chip->mask_clr);
> +       }
> +}
> +
> +static void mtk_eint_chip_read_mask(const struct mtk_eint_offsets *chip,
> +               void __iomem *eint_reg_base, u32 *buf)
> +{
> +       int port;
> +       void __iomem *reg;
> +
> +       for (port = 0; port < chip->ports; port++) {
> +               reg = eint_reg_base + chip->mask + (port << 2);
> +               buf[port] = ~readl_relaxed(reg);
> +               /* Mask is 0 when irq is enabled, and 1 when disabled. */
> +       }
> +}
> +
> +static int mtk_eint_suspend(struct device *device)
> +{
> +       void __iomem *reg;
> +       struct mtk_pinctrl *pctl = dev_get_drvdata(device);
> +       const struct mtk_eint_offsets *eint_offsets =
> +                       &pctl->devdata->eint_offsets;
> +
> +       reg = pctl->eint_reg_base;
> +       mtk_eint_chip_read_mask(eint_offsets, reg, pctl->cur_mask);
> +       mtk_eint_chip_write_mask(eint_offsets, reg, pctl->wake_mask);
> +
> +       return 0;
> +}
> +
> +static int mtk_eint_resume(struct device *device)
> +{
> +       struct mtk_pinctrl *pctl = dev_get_drvdata(device);
> +       const struct mtk_eint_offsets *eint_offsets =
> +                       &pctl->devdata->eint_offsets;
> +
> +       mtk_eint_chip_write_mask(eint_offsets,
> +                       pctl->eint_reg_base, pctl->cur_mask);
> +
> +       return 0;
> +}
> +
> +const struct dev_pm_ops mtk_eint_pm_ops = {
> +       .suspend = mtk_eint_suspend,
> +       .resume = mtk_eint_resume,
> +};
> +
>  static void mtk_eint_ack(struct irq_data *d)
>  {
>         struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> @@ -1076,10 +1148,12 @@ static void mtk_eint_ack(struct irq_data *d)
>
>  static struct irq_chip mtk_pinctrl_irq_chip = {
>         .name = "mt-eint",
> +       .irq_disable = mtk_eint_mask,
>         .irq_mask = mtk_eint_mask,
>         .irq_unmask = mtk_eint_unmask,
>         .irq_ack = mtk_eint_ack,
>         .irq_set_type = mtk_eint_set_type,
> +       .irq_set_wake = mtk_eint_irq_set_wake,
>         .irq_request_resources = mtk_pinctrl_irq_request_resources,
>         .irq_release_resources = mtk_pinctrl_irq_release_resources,
>  };
> @@ -1217,7 +1291,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
>         struct device_node *np = pdev->dev.of_node, *node;
>         struct property *prop;
>         struct resource *res;
> -       int i, ret, irq;
> +       int i, ret, irq, ports_buf;
>
>         pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
>         if (!pctl)
> @@ -1319,6 +1393,21 @@ int mtk_pctrl_init(struct platform_device *pdev,
>                 goto chip_error;
>         }
>
> +       ports_buf = pctl->devdata->eint_offsets.ports;
> +       pctl->wake_mask = devm_kcalloc(&pdev->dev, ports_buf,
> +                                       sizeof(*pctl->wake_mask), GFP_KERNEL);
> +       if (!pctl->wake_mask) {
> +               ret = -ENOMEM;
> +               goto chip_error;
> +       }
> +
> +       pctl->cur_mask = devm_kcalloc(&pdev->dev, ports_buf,
> +                                       sizeof(*pctl->cur_mask), GFP_KERNEL);
> +       if (!pctl->cur_mask) {
> +               ret = -ENOMEM;
> +               goto chip_error;
> +       }
> +
>         pctl->eint_dual_edges = devm_kcalloc(&pdev->dev, pctl->devdata->ap_num,
>                                              sizeof(int), GFP_KERNEL);
>         if (!pctl->eint_dual_edges) {
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> index 30213e5..f1be8e8 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
> @@ -266,6 +266,8 @@ struct mtk_pinctrl {
>         void __iomem            *eint_reg_base;
>         struct irq_domain       *domain;
>         int                     *eint_dual_edges;
> +       u32 *wake_mask;
> +       u32 *cur_mask;
>  };
>
>  int mtk_pctrl_init(struct platform_device *pdev,
> @@ -281,4 +283,6 @@ int mtk_pconf_spec_set_ies_smt_range(struct regmap *regmap,
>                 const struct mtk_pin_ies_smt_set *ies_smt_infos, unsigned int info_num,
>                 unsigned int pin, unsigned char align, int value);
>
> +extern const struct dev_pm_ops mtk_eint_pm_ops;
> +
>  #endif /* __PINCTRL_MTK_COMMON_H */
> --
> 1.8.1.1.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
