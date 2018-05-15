From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 15 May 2018 11:56:05 +0200
Subject: [PATCH V5 3/4] soc: mediatek: pwrap: add pwrap driver for mt6797
 SoCs
In-Reply-To: <1525957319-20557-4-git-send-email-argus.lin@mediatek.com>
References: <1525957319-20557-1-git-send-email-argus.lin@mediatek.com>
 <1525957319-20557-4-git-send-email-argus.lin@mediatek.com>
Message-ID: <eca7c8a9-684c-6d58-2eef-5f79b7f8e81e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/2018 03:01 PM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> mt6797 is a highly integrated SoCs, it uses mt6351 for power management.
> We need to add pwrap driver to access mt6351. Pwrap of mt6797 support
> dynamic priority meichanism, sequence monitor and starvation mechanism
> to make transaction more reliable.
> 

This is drivers differs vastly from V4, but I can't find any explanation why.
Can you please elaborate. For the record the explanation should have been done
in the cover letter.

Thanks,
Matthias

> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 50 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 9a01e30..d03e2d4 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -366,6 +366,39 @@ enum pwrap_regs {
>  	[PWRAP_ADC_RDATA_ADDR2] =	0x154,
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
> +	[PWRAP_HARB_HPRIO] =		0x50,
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
> +	[PWRAP_TIMER_EN] =		0xF4,
> +	[PWRAP_WDT_UNIT] =		0xFC,
> +	[PWRAP_WDT_SRC_EN] =		0x100,
> +	[PWRAP_DCM_EN] =		0x1CC,
> +	[PWRAP_DCM_DBC_PRD] =		0x1D4,
> +};
> +
>  static int mt7622_regs[] = {
>  	[PWRAP_MUX_SEL] =		0x0,
>  	[PWRAP_WRAP_EN] =		0x4,
> @@ -641,6 +674,7 @@ enum pmic_type {
>  
>  enum pwrap_type {
>  	PWRAP_MT2701,
> +	PWRAP_MT6797,
>  	PWRAP_MT7622,
>  	PWRAP_MT8135,
>  	PWRAP_MT8173,
> @@ -1067,6 +1101,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_START);
>  		break;
>  	case PWRAP_MT2701:
> +	case PWRAP_MT6797:
>  	case PWRAP_MT8173:
>  		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
>  		break;
> @@ -1396,6 +1431,18 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  	.init_soc_specific = pwrap_mt2701_init_soc_specific,
>  };
>  
> +static const struct pmic_wrapper_type pwrap_mt6797 = {
> +	.regs = mt6797_regs,
> +	.type = PWRAP_MT6797,
> +	.arb_en_all = 0x01fff,
> +	.int_en_all = 0xffffffc6,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.has_bridge = 0,
> +	.init_reg_clock = pwrap_common_init_reg_clock,
> +	.init_soc_specific = NULL,
> +};
> +
>  static const struct pmic_wrapper_type pwrap_mt7622 = {
>  	.regs = mt7622_regs,
>  	.type = PWRAP_MT7622,
> @@ -1437,6 +1484,9 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
>  		.compatible = "mediatek,mt2701-pwrap",
>  		.data = &pwrap_mt2701,
>  	}, {
> +		.compatible = "mediatek,mt6797-pwrap",
> +		.data = &pwrap_mt6797,
> +	}, {
>  		.compatible = "mediatek,mt7622-pwrap",
>  		.data = &pwrap_mt7622,
>  	}, {
> -- 
> 1.8.1.1.dirty
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
