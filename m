From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 10 Oct 2017 20:00:41 +0200
Subject: [PATCH v4 4/7] soc: mediatek: pwrap: update pwrap_init without
 slave programming
In-Reply-To: <604078485ca9ab04cea5bc531425d6035b27bc88.1505980364.git.sean.wang@mediatek.com>
References: <cover.1505980364.git.sean.wang@mediatek.com>
 <604078485ca9ab04cea5bc531425d6035b27bc88.1505980364.git.sean.wang@mediatek.com>
Message-ID: <f3a04159-8491-6ca6-d2ad-7df1dfd64331@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/21/2017 10:26 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> pwrap initialization is highly associated with the base SoC, so
> update here for allowing pwrap_init without slave program which would be
> used to those PMICs without extra encryption on bus such as MT6380.
> 
> Signed-off-by: Chenglin Xu <chenglin.xu@mediatek.com>
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 91 +++++++++++++++++++++---------------
>   1 file changed, 54 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 27d7ccc..9c6d855 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -531,6 +531,7 @@ struct pmic_wrapper_type {
>   	u32 spi_w;
>   	u32 wdt_src;
>   	int has_bridge:1;
> +	int slv_program:1;
>   	int (*init_reg_clock)(struct pmic_wrapper *wrp);
>   	int (*init_soc_specific)(struct pmic_wrapper *wrp);
>   };
> @@ -999,9 +1000,12 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>   	}
>   
>   	/* Reset SPI slave */
> -	ret = pwrap_reset_spislave(wrp);
> -	if (ret)
> -		return ret;
> +
> +	if (wrp->master->slv_program) {
> +		ret = pwrap_reset_spislave(wrp);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	pwrap_writel(wrp, 1, PWRAP_WRAP_EN);
>   
> @@ -1013,45 +1017,52 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>   	if (ret)
>   		return ret;
>   
> -	/* Setup serial input delay */
> -	ret = pwrap_init_sidly(wrp);
> -	if (ret)
> -		return ret;
> +	if (wrp->master->slv_program) {

This if branch is really long and complex enough to put it into function apart.

Thanks,
Matthias

PD please take into account the comments I made on v3 of the series.
