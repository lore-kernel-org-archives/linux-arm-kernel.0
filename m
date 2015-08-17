From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 17 Aug 2015 15:52:54 +0800
Subject: [PATCH v4] pinctrl: mediatek: Implement wake handler and
 suspend resume
In-Reply-To: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
References: <1439541486-22203-1-git-send-email-maoguang.meng@mediatek.com>
Message-ID: <1439797974.22004.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-08-14 at 16:38 +0800, maoguang.meng at mediatek.com wrote:
> From: Maoguang Meng <maoguang.meng@mediatek.com>
> 
> This patch implement irq_set_wake to get who is wakeup source and
> setup on suspend resume.
> 
> Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
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
>  	.driver = {
>  		.name = "mediatek-mt8173-pinctrl",
>  		.of_match_table = mt8173_pctrl_match,
> +		.pm = &mtk_eint_pm_ops,
>  	},
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
>  	return 0;
>  }
>  
> +static int mtk_eint_irq_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	struct mtk_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> +	int shift = d->hwirq & 0x1f;
> +	int reg = d->hwirq >> 5;
> +
> +	if (on)
> +		pctl->wake_mask[reg] |= BIT(shift);
> +	else
> +		pctl->wake_mask[reg] &= ~BIT(shift);
> +
> +	return 0;
> +}

Hi Maoguang,

You changed from set_bit/clear_bit to this, but didn't add any locking.
Since this is basic read/modify/write, is it OK to do it without
locking?

Joe.C
