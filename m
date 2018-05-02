From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 2 May 2018 12:37:02 +0200
Subject: [PATCH V4 5/8] soc: mediatek: pwrap: add pwrap for mt6797 SoCs
In-Reply-To: <20180502092112.3991-6-argus.lin@mediatek.com>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
 <20180502092112.3991-6-argus.lin@mediatek.com>
Message-ID: <621f9868-ec13-6c21-79ee-a9d2047bcb65@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/02/2018 11:21 AM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> mt6797 is a highly integrated SoCs, it uses mt6351 for power
> management. We need to add pwrap support to access mt6351.
> Pwrap of mt6797 support new feature include starvation and channel
> request exception interrupt, dynamic starvation priority
> adjustment mechanism.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 110 ++++++++++++++++++++++++++++++++---
>  1 file changed, 102 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index a6366f147b79..0d4a2dae6912 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c

[...]

> @@ -1076,11 +1126,14 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  		break;
>  	case PWRAP_MT2701:
>  	case PWRAP_MT8173:
> +	case PWRAP_MT6797:
>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
>  		break;
>  	case PWRAP_MT7622:
>  		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
>  		break;
> +	default:
> +		break;

Why do we need that now?

>  	}
>  
>  	/* Config cipher mode @PMIC */
> @@ -1325,6 +1378,15 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  
>  	pwrap_writel(wrp, 0xffffffff, PWRAP_INT_CLR);
>  
> +	/* If we support INT1 interrupt, we also need to clear it */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN)) {
> +		rdata = pwrap_readl(wrp, PWRAP_INT1_FLG);
> +
> +		dev_err(wrp->dev, "unexpected interrupt int1=0x%x\n", rdata);
> +
> +		pwrap_writel(wrp, rdata, PWRAP_INT1_CLR);
> +	}
> +

This should go in 4/8. You will need to add PWRAP_INT1_FLG to the enum
pwrap_regs as well.

>  	return IRQ_HANDLED;
>  }
>  
> @@ -1446,6 +1508,19 @@ static const struct pmic_wrapper_type pwrap_mt8173 = {
>  	.init_soc_specific = pwrap_mt8173_init_soc_specific,
>  };
>  
> +static const struct pmic_wrapper_type pwrap_mt6797 = {
> +	.regs = mt6797_regs,
> +	.type = PWRAP_MT6797,
> +	.arb_en_all = 0x01fff,
> +	.int_en_all = 0xffffffc6,
> +	.int1_en_all = 0x0001ffff,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.caps = PWRAP_CAP_DCM | PWRAP_CAP_INT1_EN,
> +	.init_reg_clock = pwrap_common_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>  static const struct of_device_id of_pwrap_match_tbl[] = {
>  	{
>  		.compatible = "mediatek,mt2701-pwrap",
> @@ -1460,6 +1535,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>  		.compatible = "mediatek,mt8173-pwrap",
>  		.data = &pwrap_mt8173,
>  	}, {
> +		.compatible = "mediatek,mt6797-pwrap",
> +		.data = &pwrap_mt6797,
> +	}, {
>  		/* sentinel */
>  	}
>  };
> @@ -1503,11 +1581,13 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (IS_ERR(wrp->base))
>  		return PTR_ERR(wrp->base);
>  
> -	wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
> -	if (IS_ERR(wrp->rstc)) {
> -		ret = PTR_ERR(wrp->rstc);
> -		dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> -		return ret;
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_RESET)) {
> +		wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
> +		if (IS_ERR(wrp->rstc)) {
> +			ret = PTR_ERR(wrp->rstc);
> +			dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> +			return ret;
> +		}

This goes into 2/8.

>  	}
>  
>  	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
> @@ -1549,9 +1629,17 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_out1;
>  
> -	/* Enable internal dynamic clock */
> -	pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> -	pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> +	/*
> +	 * add dcm capability check
> +	 */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {

Into 2/8 please.

> +		if (wrp->master->type == PWRAP_MT6797)
> +			pwrap_writel(wrp, 3, PWRAP_DCM_EN);
> +		else
> +			pwrap_writel(wrp, 1, PWRAP_DCM_EN);

The if statement is ok here, but it should change the if of the caps check
introduced in 2/8. Does this make sense?

> +
> +		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> +	}

Into 2/8 please.

>  
>  	/*
>  	 * The PMIC could already be initialized by the bootloader.
> @@ -1580,6 +1668,12 @@ static int pwrap_probe(struct platform_device *pdev)
>  	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
>  	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>  	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
> +	/*
> +	 * We add INT1 interrupt to handle starvation and request exception
> +	 * If we support it, we should enable them here.
> +	 */
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
> +		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);

Into 4/8 please.

Best regards,
Matthias
