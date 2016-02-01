From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 1 Feb 2016 11:55:14 +0100
Subject: [PATCH V3 08/11] soc: mediatek: PMIC wrap: remove
 pwrap_is_mt8135() and pwrap_is_mt8173()
In-Reply-To: <1453715604-36856-9-git-send-email-blogic@openwrt.org>
References: <1453715604-36856-1-git-send-email-blogic@openwrt.org>
 <1453715604-36856-9-git-send-email-blogic@openwrt.org>
Message-ID: <56AF3992.8020004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/01/16 10:53, John Crispin wrote:
> With ore SoCs being added the list of helper functions like these would

The commit message is something strange:
"With every new SoC being added..." maybe?

> grow. While at it also add a new flag "bridge" and use that insted of

s/insted/instead

> pwrap_is_mt8173() where appropriate.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c |   27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 8bb091b..54553b4 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -374,20 +374,11 @@ struct pmic_wrapper_type {
>   	u32 int_en_all;
>   	u32 spi_w;
>   	u32 wdt_src;
> +	int has_bridge;
>   	int (*init_reg_clock)(struct pmic_wrapper *wrp);
>   	int (*init_special)(struct pmic_wrapper *wrp);
>   };
>
> -static inline int pwrap_is_mt8135(struct pmic_wrapper *wrp)
> -{
> -	return wrp->master->type == PWRAP_MT8135;
> -}
> -
> -static inline int pwrap_is_mt8173(struct pmic_wrapper *wrp)
> -{
> -	return wrp->master->type == PWRAP_MT8173;
> -}
> -
>   static u32 pwrap_readl(struct pmic_wrapper *wrp, enum pwrap_regs reg)
>   {
>   	return readl(wrp->base + wrp->master->regs[reg]);
> @@ -619,11 +610,14 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>   	pwrap_writel(wrp, 0x1, PWRAP_CIPHER_KEY_SEL);
>   	pwrap_writel(wrp, 0x2, PWRAP_CIPHER_IV_SEL);
>
> -	if (pwrap_is_mt8135(wrp)) {
> +	switch (wrp->master->type) {
> +	case PWRAP_MT8135:
>   		pwrap_writel(wrp, 1, PWRAP_CIPHER_LOAD);
>   		pwrap_writel(wrp, 1, PWRAP_CIPHER_START);
> -	} else {
> +		break;
> +	case PWRAP_MT8173:
>   		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
> +		break;
>   	}
>
>   	/* Config cipher mode @PMIC */
> @@ -713,7 +707,7 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>   	if (wrp->rstc_bridge)
>   		reset_control_reset(wrp->rstc_bridge);
>
> -	if (pwrap_is_mt8173(wrp)) {
> +	if (wrp->master->type == PWRAP_MT8173) {
>   		/* Enable DCM */
>   		pwrap_writel(wrp, 3, PWRAP_DCM_EN);
>   		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> @@ -773,7 +767,7 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>   	pwrap_writel(wrp, PWRAP_DEW_CRC_VAL, PWRAP_SIG_ADR);
>   	pwrap_writel(wrp, wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
>
> -	if (pwrap_is_mt8135(wrp))
> +	if (wrp->master->type == PWRAP_MT8135)
>   		pwrap_writel(wrp, 0x7, PWRAP_RRARB_EN);
>
>   	pwrap_writel(wrp, 0x1, PWRAP_WACS0_EN);
> @@ -792,7 +786,7 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>   	pwrap_writel(wrp, 1, PWRAP_INIT_DONE0);
>   	pwrap_writel(wrp, 1, PWRAP_INIT_DONE1);
>
> -	if (pwrap_is_mt8135(wrp)) {
> +	if (wrp->master->has_bridge) {
>   		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE3);
>   		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE4);
>   	}
> @@ -830,6 +824,7 @@ static struct pmic_wrapper_type pwrap_mt8135 = {
>   	.int_en_all = BIT(31) | BIT(1),
>   	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>   	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.has_bridge = 1,
>   	.init_reg_clock = pwrap_mt8135_init_reg_clock,
>   	.init_special = pwrap_mt8135_init_special,
>   };

Please set has_bridge explicitly for mt8173.
