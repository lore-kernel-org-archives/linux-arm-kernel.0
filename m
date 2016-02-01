From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 1 Feb 2016 11:48:36 +0100
Subject: [PATCH V3 05/11] soc: mediatek: PMIC wrap: WRAP_INT_EN needs a
 different bitmask for MT2701/7623
In-Reply-To: <1453715604-36856-6-git-send-email-blogic@openwrt.org>
References: <1453715604-36856-1-git-send-email-blogic@openwrt.org>
 <1453715604-36856-6-git-send-email-blogic@openwrt.org>
Message-ID: <56AF3804.6070205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/01/16 10:53, John Crispin wrote:
> MT2701 and MT7623 use a different bitmask for PWRAP_INT_EN.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index ab2202d..948fc73 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -371,6 +371,7 @@ struct pmic_wrapper_type {
>   	int *regs;
>   	enum pwrap_type type;
>   	u32 arb_en_all;
> +	u32 int_en_all;
>   	int (*init_reg_clock)(struct pmic_wrapper *wrp);
>   	int (*init_special)(struct pmic_wrapper *wrp);
>   };
> @@ -824,6 +825,7 @@ static struct pmic_wrapper_type pwrap_mt8135 = {
>   	.regs = mt8135_regs,
>   	.type = PWRAP_MT8135,
>   	.arb_en_all = 0x1ff,
> +	.int_en_all = BIT(31) | BIT(1),
>   	.init_reg_clock = pwrap_mt8135_init_reg_clock,
>   	.init_special = pwrap_mt8135_init_special,
>   };
> @@ -832,6 +834,7 @@ static struct pmic_wrapper_type pwrap_mt8173 = {
>   	.regs = mt8173_regs,
>   	.type = PWRAP_MT8173,
>   	.arb_en_all = 0x3f,
> +	.int_en_all = BIT(31) | BIT(1),
>   	.init_reg_clock = pwrap_mt8173_init_reg_clock,
>   	.init_special = pwrap_mt8173_init_special,
>   };
> @@ -945,7 +948,7 @@ static int pwrap_probe(struct platform_device *pdev)
>   			PWRAP_WDT_SRC_MASK_NO_STAUPD : PWRAP_WDT_SRC_MASK_ALL;
>   	pwrap_writel(wrp, wdt_src, PWRAP_WDT_SRC_EN);
>   	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
> -	pwrap_writel(wrp, ~((1 << 31) | (1 << 1)), PWRAP_INT_EN);
> +	pwrap_writel(wrp, ~wrp->master->int_en_all, PWRAP_INT_EN);
>

Set the right value in int_en_all instead of use the bitwise not in 
pwrap_writel.
