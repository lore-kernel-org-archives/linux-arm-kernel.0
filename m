From: john@phrozen.org (John Crispin)
Date: Wed, 21 Jun 2017 14:22:31 +0200
Subject: [PATCH RESEND 4/4] pwm: mediatek: add MT2712/MT7622 support
In-Reply-To: <1498032672-7172-5-git-send-email-zhi.mao@mediatek.com>
References: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
 <1498032672-7172-5-git-send-email-zhi.mao@mediatek.com>
Message-ID: <4600cf23-5e59-df02-37dc-056cb4a9744c@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/06/17 10:11, Zhi Mao wrote:
> support multiple chip(MT2712, MT7622, MT7623)
This patch does more than add extra SoC support. It also
* adds PWM_CLK_DIV_MAX which really should go into its own patch
* adds mtk_pwm_com_reg which should also go into its own patch

more comments inline

>
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>   drivers/pwm/pwm-mediatek.c |   63 +++++++++++++++++++++++++++++++++++---------
>   1 file changed, 51 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index c803ff6..d520356 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -16,6 +16,7 @@
>   #include <linux/module.h>
>   #include <linux/clk.h>
>   #include <linux/of.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/pwm.h>
>   #include <linux/slab.h>
[...]
> @@ -215,9 +238,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>   	return pwmchip_remove(&pc->chip);
>   }
>   
> +/*==========================================*/

please remove these comment lines

     John
> +static const struct mtk_com_pwm_data mt2712_pwm_data = {
> +	.pwm_nums = 8,
> +};
> +
> +static const struct mtk_com_pwm_data mt7622_pwm_data = {
> +	.pwm_nums = 6,
> +};
> +
> +static const struct mtk_com_pwm_data mt7623_pwm_data = {
> +	.pwm_nums = 5,
> +};
> +/*==========================================*/
> +
>   static const struct of_device_id mtk_pwm_of_match[] = {
> -	{ .compatible = "mediatek,mt7623-pwm" },
> -	{ }
> +	{.compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data},
> +	{.compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data},
> +	{.compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data},
> +	{},
>   };
>   MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
>   
