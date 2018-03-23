From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 23 Mar 2018 17:44:22 +0800
Subject: [PATCH v4 4/5] pintcrl: support bias-disable of generic and
 special pins simultaneously
In-Reply-To: <1521687523-1604-5-git-send-email-zhiyong.tao@mediatek.com>
References: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
 <1521687523-1604-5-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1521798262.28226.12.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-03-22 at 10:58 +0800, Zhiyong Tao wrote:
> For generic pins, parameter "arg" is 0 or 1.
> For special pins, bias-disable is set by R0R1,
> so we need transmited "00" to set bias-disable
> When we set "bias-disable" as high-z property,
> the parameter should be "MTK_PUPD_SET_R1R0_00".
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 3cf384f..f991ff3 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -293,7 +293,7 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
>  		unsigned int pin, bool enable, bool isup, unsigned int arg)
>  {
>  	unsigned int bit;
> -	unsigned int reg_pullen, reg_pullsel;
> +	unsigned int reg_pullen, reg_pullsel, r1r0;
>  	int ret;
>  
>  	/* Some pins' pull setting are very different,
> @@ -301,8 +301,12 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
>  	 * resistor bit, so we need this special handle.
>  	 */
>  	if (pctl->devdata->spec_pull_set) {
> +		/* For special pins, bias-disable is set by R1R0,
> +		 * the parameter should be "MTK_PUPD_SET_R1R0_00".
> +		 */
> +		r1r0 = enable ? arg : MTK_PUPD_SET_R1R0_00;
>  		ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
> -			pin, pctl->devdata->port_align, isup, arg);
> +			pin, pctl->devdata->port_align, isup, r1r0);
>  		if (!ret)
>  			return 0;
>  	}

Reviewed-by: Sean Wang <sean.wang@mediatek.com>
