From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 24 Jan 2018 16:12:15 +0100
Subject: [PATCH 3/3] soc: mediatek: pwrap: add mt6351 for mt6797 SoCs
In-Reply-To: <20180123033659.11401-3-argus.lin@mediatek.com>
References: <20180123033659.11401-1-argus.lin@mediatek.com>
 <20180123033659.11401-3-argus.lin@mediatek.com>
Message-ID: <dd83782d-15c5-f177-72ff-c1a808361904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/23/2018 04:36 AM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> mt6351 is a new power management IC and it is used for mt6797 SoCs.
> We need to add mt6351_regs for pmic register mapping and add
> mt6797_regs for MT6797 SoCs register mapping. It also has new
> interrupt event, so we add int1_en_all to register those events. We
> also add has_reset & has_dcm flag for reset controller
> and different dcm setting.

That indicates that you need to split up the patches, one for each flag, one for
the new SoC and one for the new management IC.

> 
> Change-Id: I9c3efb9bf0cf2d6b5b063b98890d1bd2183b112c
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 150 ++++++++++++++++++++++++++++++++---
>  1 file changed, 140 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index e9e054a15b7d..aff3e8251465 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -146,6 +146,21 @@ static const u32 mt6397_regs[] = {
>  	[PWRAP_DEW_CIPHER_SWRST] =	0xbc24,
>  };
>  
> +static const u32 mt6351_regs[] = {
> +	[PWRAP_DEW_DIO_EN] =		0x02F2,
> +	[PWRAP_DEW_READ_TEST] =		0x02F4,
> +	[PWRAP_DEW_WRITE_TEST] =	0x02F6,
> +	[PWRAP_DEW_CRC_EN] =		0x02FA,
> +	[PWRAP_DEW_CRC_VAL] =		0x02FC,
> +	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0300,
> +	[PWRAP_DEW_CIPHER_IV_SEL] =	0x0302,
> +	[PWRAP_DEW_CIPHER_EN] =		0x0304,
> +	[PWRAP_DEW_CIPHER_RDY] =	0x0306,
> +	[PWRAP_DEW_CIPHER_MODE] =	0x0308,
> +	[PWRAP_DEW_CIPHER_SWRST] =	0x030A,
> +	[PWRAP_DEW_RDDMY_NO] =		0x030C,
> +};
> +
>  enum pwrap_regs {
>  	PWRAP_MUX_SEL,
>  	PWRAP_WRAP_EN,
> @@ -278,6 +293,23 @@ enum pwrap_regs {
>  	PWRAP_DVFS_WDATA7,
>  	PWRAP_SPMINF_STA,
>  	PWRAP_CIPHER_EN,
> +
> +	/* MT6797 series regs */
> +	PWRAP_CSLEXT_WRITE,
> +	PWRAP_CSLEXT_READ,
> +	PWRAP_STAUPD_CTRL,
> +	PWRAP_EXT_CK_WRITE,
> +	PWRAP_INT1_EN,
> +	PWRAP_INT1_FLG_RAW,
> +	PWRAP_INT1_FLG,
> +	PWRAP_INT1_CLR,
> +	PWRAP_HPRIO_ARB_EN,
> +	PWRAP_TIMER_CTRL,
> +	PWRAP_WDT_SRC_EN_0,
> +	PWRAP_PRIORITY_USER_SEL_0,
> +	PWRAP_PRIORITY_USER_SEL_1,
> +	PWRAP_ARBITER_OUT_SEL_0,
> +	PWRAP_ARBITER_OUT_SEL_1,

A lot of these defines are never used. Is there any reason why you define them
here? Can't we just limit the code to define only the registers used by it?

>  };
>  
>  static int mt2701_regs[] = {
> @@ -633,10 +665,50 @@ static int mt8135_regs[] = {
>  	[PWRAP_DCM_DBC_PRD] =		0x160,
>  };
>  
> +static int mt6797_regs[] = {
> +	[PWRAP_MUX_SEL] =		0x0,
> +	[PWRAP_WRAP_EN] =		0x4,
> +	[PWRAP_DIO_EN] =		0x8,
> +	[PWRAP_SIDLY] =			0xC,
> +	[PWRAP_RDDMY] =			0x10,
> +	[PWRAP_CSHEXT_WRITE] =		0x18,
> +	[PWRAP_CSHEXT_READ] =		0x1C,
> +	[PWRAP_CSLEXT_START] =		0x20,
> +	[PWRAP_CSLEXT_END] =		0x24,
> +	[PWRAP_STAUPD_PRD] =		0x28,
> +	[PWRAP_HIPRIO_ARB_EN] =		0x54,
> +	[PWRAP_MAN_EN] =		0x60,
> +	[PWRAP_MAN_CMD] =		0x64,
> +	[PWRAP_WACS0_EN] =		0x70,
> +	[PWRAP_WACS1_EN] =		0x84,
> +	[PWRAP_WACS2_EN] =		0x98,
> +	[PWRAP_INIT_DONE2] =		0x9C,
> +	[PWRAP_WACS2_CMD] =		0xA0,
> +	[PWRAP_WACS2_RDATA] =		0xA4,
> +	[PWRAP_WACS2_VLDCLR] =		0xA8,
> +	[PWRAP_INT_EN] =		0xC0,
> +	[PWRAP_INT_FLG_RAW] =		0xC4,
> +	[PWRAP_INT_FLG] =		0xC8,
> +	[PWRAP_INT_CLR] =		0xCC,
> +	[PWRAP_INT1_EN] =		0xD0,
> +	[PWRAP_INT1_FLG_RAW] =		0xD4,
> +	[PWRAP_INT1_FLG] =		0xD8,
> +	[PWRAP_INT1_CLR] =		0xDC,
> +	[PWRAP_TIMER_EN] =		0xF4,
> +	[PWRAP_WDT_UNIT] =		0xFC,
> +	[PWRAP_WDT_SRC_EN] =		0x100,
> +	[PWRAP_DCM_EN] =		0x1CC,
> +	[PWRAP_DCM_DBC_PRD] =		0x1D4,
> +	[PWRAP_PRIORITY_USER_SEL_0] =	0x288,
> +	[PWRAP_PRIORITY_USER_SEL_1] =	0x28C,
> +	[PWRAP_ARBITER_OUT_SEL_0] =	0x290,
> +	[PWRAP_ARBITER_OUT_SEL_1] =	0x294,
> +};
>  enum pmic_type {
>  	PMIC_MT6323,
>  	PMIC_MT6380,
>  	PMIC_MT6397,
> +	PMIC_MT6351,
>  };
>  
>  enum pwrap_type {
> @@ -644,6 +716,7 @@ enum pwrap_type {
>  	PWRAP_MT7622,
>  	PWRAP_MT8135,
>  	PWRAP_MT8173,
> +	PWRAP_MT6797,
>  };
>  
>  struct pmic_wrapper;
> @@ -681,9 +754,12 @@ struct pmic_wrapper_type {
>  	enum pwrap_type type;
>  	u32 arb_en_all;
>  	u32 int_en_all;
> +	u32 int1_en_all;
>  	u32 spi_w;
>  	u32 wdt_src;
>  	unsigned int has_bridge:1;
> +	unsigned int has_reset:1;
> +	unsigned int has_dcm:1;

As far as I can see, all pmic wrappers present have this set to 1, which means
it is not necessary. Also if we start to add more flags here, we should think of
using a caps infrastructure as does the pwrap_slv_type.

>  	int (*init_reg_clock)(struct pmic_wrapper *wrp);
>  	int (*init_soc_specific)(struct pmic_wrapper *wrp);
>  };
> @@ -1073,6 +1149,8 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  	case PWRAP_MT7622:
>  		pwrap_writel(wrp, 0, PWRAP_CIPHER_EN);
>  		break;
> +	case PWRAP_MT6797:
> +		break;

default:
    break;

would be better here.

>  	}
>  
>  	/* Config cipher mode @PMIC */
> @@ -1080,8 +1158,6 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x0);
>  	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_KEY_SEL], 0x1);
>  	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_IV_SEL], 0x2);
> -	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_LOAD], 0x1);
> -	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_START], 0x1);
>  

Ok, it looks like these two lines are actually a bug, which shouldn't be here.
Adding John, as he added these calls twice in
5ae48040aa47 ("soc: mediatek: PMIC wrap: add mt6323 slave support")

@John, this is an oversight in your commit, right?

If so, we should fix this in a separate patch, concerning to send it to stable
as well.

>  	switch (wrp->slave->type) {
>  	case PMIC_MT6397:
> @@ -1367,6 +1443,15 @@ static const struct pwrap_slv_type pmic_mt6397 = {
>  	.pwrap_write = pwrap_write16,
>  };
>  
> +static const struct pwrap_slv_type pmic_mt6351 = {
> +	.dew_regs = mt6351_regs,
> +	.type = PMIC_MT6351,
> +	.regmap = &pwrap_regmap_config16,
> +	.caps = 0,
> +	.pwrap_read = pwrap_read16,
> +	.pwrap_write = pwrap_write16,
> +};
> +
>  static const struct of_device_id of_slave_match_tbl[] = {
>  	{
>  		.compatible = "mediatek,mt6323",
> @@ -1381,6 +1466,9 @@ static const struct of_device_id of_slave_match_tbl[] = {
>  		.compatible = "mediatek,mt6397",
>  		.data = &pmic_mt6397,
>  	}, {
> +		.compatible = "mediatek,mt6351",
> +		.data = &pmic_mt6351,
> +	}, {
>  		/* sentinel */
>  	}
>  };
> @@ -1391,9 +1479,12 @@ static const struct pmic_wrapper_type pwrap_mt2701 = {
>  	.type = PWRAP_MT2701,
>  	.arb_en_all = 0x3f,
>  	.int_en_all = ~(u32)(BIT(31) | BIT(2)),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE_NEW,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 0,
> +	.has_reset = 1,
> +	.has_dcm = 1,
>  	.init_reg_clock = pwrap_mt2701_init_reg_clock,
>  	.init_soc_specific = pwrap_mt2701_init_soc_specific,
>  };
> @@ -1403,6 +1494,7 @@ static const struct pmic_wrapper_type pwrap_mt7622 = {
>  	.type = PWRAP_MT7622,
>  	.arb_en_all = 0xff,
>  	.int_en_all = ~(u32)BIT(31),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 0,
> @@ -1415,9 +1507,12 @@ static const struct pmic_wrapper_type pwrap_mt8135 = {
>  	.type = PWRAP_MT8135,
>  	.arb_en_all = 0x1ff,
>  	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 1,
> +	.has_reset = 1,
> +	.has_dcm = 1,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt8135_init_soc_specific,
>  };
> @@ -1427,13 +1522,31 @@ static const struct pmic_wrapper_type pwrap_mt8173 = {
>  	.type = PWRAP_MT8173,
>  	.arb_en_all = 0x3f,
>  	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
> +	.int1_en_all = 0,
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_NO_STAUPD,
>  	.has_bridge = 0,
> +	.has_reset = 1,
> +	.has_dcm = 1,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt8173_init_soc_specific,
>  };
>  
> +static const struct pmic_wrapper_type pwrap_mt6797 = {
> +	.regs = mt6797_regs,
> +	.type = PWRAP_MT6797,
> +	.arb_en_all = 0x01fff,
> +	.int_en_all = 0xfffffffd,
> +	.int1_en_all = 0x0001ffff,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.has_bridge = 0,
> +	.has_reset = 0,
> +	.has_dcm = 1,
> +	.init_reg_clock = NULL,
> +	.init_soc_specific = NULL,
> +};
> +
>  static const struct of_device_id of_pwrap_match_tbl[] = {
>  	{
>  		.compatible = "mediatek,mt2701-pwrap",
> @@ -1448,6 +1561,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>  		.compatible = "mediatek,mt8173-pwrap",
>  		.data = &pwrap_mt8173,
>  	}, {
> +		.compatible = "mediatek,mt6797-pwrap",
> +		.data = &pwrap_mt6797,
> +	}, {
>  		/* sentinel */
>  	}
>  };
> @@ -1491,11 +1607,13 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (IS_ERR(wrp->base))
>  		return PTR_ERR(wrp->base);
>  
> -	wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
> -	if (IS_ERR(wrp->rstc)) {
> -		ret = PTR_ERR(wrp->rstc);
> -		dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> -		return ret;
> +	if (wrp->master->has_reset) {
> +		wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
> +		if (IS_ERR(wrp->rstc)) {
> +			ret = PTR_ERR(wrp->rstc);
> +			dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
>  	if (wrp->master->has_bridge) {
> @@ -1537,9 +1655,19 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_out1;
>  
> -	/* Enable internal dynamic clock */
> -	pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> -	pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> +	/*
> +	 * add has_dcm check for different setting for project
> +	 */
> +	if (wrp->master->has_dcm) {
> +		if (wrp->master->type == PWRAP_MT6797) {
> +			/* Enable internal dynamic clock */
> +			pwrap_writel(wrp, 3, PWRAP_DCM_EN);
> +		} else {
> +			/* Enable internal dynamic clock */

Put the comment before the if, instead of commenting the same information twice

Thanks!
Matthias

> +			pwrap_writel(wrp, 1, PWRAP_DCM_EN);
> +		}
> +		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
> +	}
>  
>  	/*
>  	 * The PMIC could already be initialized by the bootloader.
> @@ -1568,6 +1696,8 @@ static int pwrap_probe(struct platform_device *pdev)
>  	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
>  	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>  	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
> +	if (wrp->master->int1_en_all != 0)
> +		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>  
>  	irq = platform_get_irq(pdev, 0);
>  	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
> -- 
> 2.12.5
> 
> ************* Email Confidentiality Notice
>  ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe
>  
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank
>  you!
> 
