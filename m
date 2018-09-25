From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Sep 2018 17:38:32 +0200
Subject: [PATCH 2/3] soc: mediatek: pwrap: add pwrap driver for mt6765 SoCs
In-Reply-To: <1536064314-31967-3-git-send-email-argus.lin@mediatek.com>
References: <1536064314-31967-1-git-send-email-argus.lin@mediatek.com>
 <1536064314-31967-3-git-send-email-argus.lin@mediatek.com>
Message-ID: <dc257382-f930-158e-f5b3-4375707f2a63@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/09/2018 14:31, Argus Lin wrote:
> mt6765 is a highly integrated SoCs, it uses mt6357 for power management.
> This patch adds pwrap driver to access mt6357. Pwrap of mt6765 support
> dynamic priority meichanism, sequence monitor and starvation mechanism
> to make transaction more reliable.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>

I fixed the has_bridge variable, as this is obsolete now.
Please check that I didn't do an error.

Applied to v4.19-next/soc

> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 49 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 4e931fd..ddaeace 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -381,6 +381,38 @@ enum pwrap_regs {
>  	[PWRAP_ADC_RDATA_ADDR2] =	0x154,
>  };
>  
> +static int mt6765_regs[] = {
> +	[PWRAP_MUX_SEL] =		0x0,
> +	[PWRAP_WRAP_EN] =		0x4,
> +	[PWRAP_DIO_EN] =		0x8,
> +	[PWRAP_RDDMY] =			0x20,
> +	[PWRAP_CSHEXT_WRITE] =		0x24,
> +	[PWRAP_CSHEXT_READ] =		0x28,
> +	[PWRAP_CSLEXT_START] =		0x2C,
> +	[PWRAP_CSLEXT_END] =		0x30,
> +	[PWRAP_STAUPD_PRD] =		0x3C,
> +	[PWRAP_HARB_HPRIO] =		0x68,
> +	[PWRAP_HIPRIO_ARB_EN] =		0x6C,
> +	[PWRAP_MAN_EN] =		0x7C,
> +	[PWRAP_MAN_CMD] =		0x80,
> +	[PWRAP_WACS0_EN] =		0x8C,
> +	[PWRAP_WACS1_EN] =		0x94,
> +	[PWRAP_WACS2_EN] =		0x9C,
> +	[PWRAP_INIT_DONE2] =		0xA0,
> +	[PWRAP_WACS2_CMD] =		0xC20,
> +	[PWRAP_WACS2_RDATA] =		0xC24,
> +	[PWRAP_WACS2_VLDCLR] =		0xC28,
> +	[PWRAP_INT_EN] =		0xB4,
> +	[PWRAP_INT_FLG_RAW] =		0xB8,
> +	[PWRAP_INT_FLG] =		0xBC,
> +	[PWRAP_INT_CLR] =		0xC0,
> +	[PWRAP_TIMER_EN] =		0xE8,
> +	[PWRAP_WDT_UNIT] =		0xF0,
> +	[PWRAP_WDT_SRC_EN] =		0xF4,
> +	[PWRAP_DCM_EN] =		0x1DC,
> +	[PWRAP_DCM_DBC_PRD] =		0x1E0,
> +};
> +
>  static int mt6797_regs[] = {
>  	[PWRAP_MUX_SEL] =		0x0,
>  	[PWRAP_WRAP_EN] =		0x4,
> @@ -690,6 +722,7 @@ enum pmic_type {
>  
>  enum pwrap_type {
>  	PWRAP_MT2701,
> +	PWRAP_MT6765,
>  	PWRAP_MT6797,
>  	PWRAP_MT7622,
>  	PWRAP_MT8135,
> @@ -1117,6 +1150,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_START);
>  		break;
>  	case PWRAP_MT2701:
> +	case PWRAP_MT6765:
>  	case PWRAP_MT6797:
>  	case PWRAP_MT8173:
>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
> @@ -1460,6 +1494,18 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  	.init_soc_specific = pwrap_mt2701_init_soc_specific,
>  };
>  
> +static const struct pmic_wrapper_type pwrap_mt6765 = {
> +	.regs = mt6765_regs,
> +	.type = PWRAP_MT6765,
> +	.arb_en_all = 0x3fd35,
> +	.int_en_all = 0xffffffff,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.has_bridge = 0,
> +	.init_reg_clock = pwrap_common_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>  static const struct pmic_wrapper_type pwrap_mt6797 = {
>  	.regs = mt6797_regs,
>  	.type = PWRAP_MT6797,
> @@ -1513,6 +1559,9 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  		.compatible = "mediatek,mt2701-pwrap",
>  		.data = &pwrap_mt2701,
>  	}, {
> +		.compatible = "mediatek,mt6765-pwrap",
> +		.data = &pwrap_mt6765,
> +	}, {
>  		.compatible = "mediatek,mt6797-pwrap",
>  		.data = &pwrap_mt6797,
>  	}, {
> 
