From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 1 Feb 2016 11:43:11 +0100
Subject: [PATCH V3 04/11] soc: mediatek: PMIC wrap: split SoC specific
 init into callback
In-Reply-To: <1453715604-36856-5-git-send-email-blogic@openwrt.org>
References: <1453715604-36856-1-git-send-email-blogic@openwrt.org>
 <1453715604-36856-5-git-send-email-blogic@openwrt.org>
Message-ID: <56AF36BF.2050109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/01/16 10:53, John Crispin wrote:
> This patch moves the SoC specific wrapper init code into separate callback
> to avoid pwrap_init() getting too large.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c |   68 +++++++++++++++++++++-------------
>   1 file changed, 42 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index b22b664..ab2202d 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -372,6 +372,7 @@ struct pmic_wrapper_type {
>   	enum pwrap_type type;
>   	u32 arb_en_all;
>   	int (*init_reg_clock)(struct pmic_wrapper *wrp);
> +	int (*init_special)(struct pmic_wrapper *wrp);
>   };
>
>   static inline int pwrap_is_mt8135(struct pmic_wrapper *wrp)
> @@ -665,6 +666,41 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>   	return 0;
>   }
>
> +static int pwrap_mt8135_init_special(struct pmic_wrapper *wrp)
> +{
> +	/* enable pwrap events and pwrap bridge in AP side */
> +	pwrap_writel(wrp, 0x1, PWRAP_EVENT_IN_EN);
> +	pwrap_writel(wrp, 0xffff, PWRAP_EVENT_DST_EN);
> +	writel(0x7f, wrp->bridge_base + PWRAP_MT8135_BRIDGE_IORD_ARB_EN);
> +	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS3_EN);
> +	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS4_EN);
> +	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_UNIT);
> +	writel(0xffff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_SRC_EN);
> +	writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_TIMER_EN);
> +	writel(0x7ff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INT_EN);
> +
> +	/* enable PMIC event out and sources */
> +	if (pwrap_write(wrp, PWRAP_DEW_EVENT_OUT_EN, 0x1) ||
> +		pwrap_write(wrp, PWRAP_DEW_EVENT_SRC_EN, 0xffff)) {
> +		dev_err(wrp->dev, "enable dewrap fail\n");
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pwrap_mt8173_init_special(struct pmic_wrapper *wrp)
> +{
> +	/* PMIC_DEWRAP enables */
> +	if (pwrap_write(wrp, PWRAP_DEW_EVENT_OUT_EN, 0x1) ||
> +		pwrap_write(wrp, PWRAP_DEW_EVENT_SRC_EN, 0xffff)) {
> +		dev_err(wrp->dev, "enable dewrap fail\n");
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>   static int pwrap_init(struct pmic_wrapper *wrp)
>   {
>   	int ret;
> @@ -743,32 +779,10 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>   	pwrap_writel(wrp, 0x5, PWRAP_STAUPD_PRD);
>   	pwrap_writel(wrp, 0xff, PWRAP_STAUPD_GRPEN);
>
> -	if (pwrap_is_mt8135(wrp)) {
> -		/* enable pwrap events and pwrap bridge in AP side */
> -		pwrap_writel(wrp, 0x1, PWRAP_EVENT_IN_EN);
> -		pwrap_writel(wrp, 0xffff, PWRAP_EVENT_DST_EN);
> -		writel(0x7f, wrp->bridge_base + PWRAP_MT8135_BRIDGE_IORD_ARB_EN);
> -		writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS3_EN);
> -		writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WACS4_EN);
> -		writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_UNIT);
> -		writel(0xffff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_WDT_SRC_EN);
> -		writel(0x1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_TIMER_EN);
> -		writel(0x7ff, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INT_EN);
> -
> -		/* enable PMIC event out and sources */
> -		if (pwrap_write(wrp, PWRAP_DEW_EVENT_OUT_EN, 0x1) ||
> -				pwrap_write(wrp, PWRAP_DEW_EVENT_SRC_EN, 0xffff)) {
> -			dev_err(wrp->dev, "enable dewrap fail\n");
> -			return -EFAULT;
> -		}
> -	} else {
> -		/* PMIC_DEWRAP enables */
> -		if (pwrap_write(wrp, PWRAP_DEW_EVENT_OUT_EN, 0x1) ||
> -				pwrap_write(wrp, PWRAP_DEW_EVENT_SRC_EN, 0xffff)) {
> -			dev_err(wrp->dev, "enable dewrap fail\n");
> -			return -EFAULT;
> -		}
> -	}
> +	if (wrp->master->init_special)
> +		ret = wrp->master->init_special(wrp);
> +	if (ret)
> +		return ret;
>

Check ret only if you have called init_special before.

Apart from that the patch look fine.
