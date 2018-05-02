From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 2 May 2018 12:27:26 +0200
Subject: [PATCH V4 2/8] soc: mediatek: pwrap: add caps flag for pwrap
In-Reply-To: <20180502092112.3991-3-argus.lin@mediatek.com>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
 <20180502092112.3991-3-argus.lin@mediatek.com>
Message-ID: <41027d71-a0b5-b78d-e9bf-aec4beb05a59@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/02/2018 11:21 AM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> We use caps to describe pwrap's capability, used
> to replace has_bridge flag for single meaning.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index e9e054a15b7d..3a25ff6e6907 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -76,6 +76,12 @@
>  #define PWRAP_SLV_CAP_SECURITY	BIT(2)
>  #define HAS_CAP(_c, _x)	(((_c) & (_x)) == (_x))
>  
> +/* Group of bits used for shown pwrap capability */
> +#define PWRAP_CAP_BRIDGE	BIT(0)
> +#define PWRAP_CAP_RESET		BIT(1)
> +#define PWRAP_CAP_DCM		BIT(2)
> +#define PWRAP_CAP_INT1_EN	BIT(3)
> +

You are missing the logic to handle the caps.
With out this logic, this patch is useless.

Regards,
Matthias

>  /* defines for slave device wrapper registers */
>  enum dew_regs {
>  	PWRAP_DEW_BASE,
> @@ -684,6 +690,8 @@ struct pmic_wrapper_type {
>  	u32 spi_w;
>  	u32 wdt_src;
>  	unsigned int has_bridge:1;
> +	/* Flags indicating the capability for the target pwrap */
> +	u8 caps;
>  	int (*init_reg_clock)(struct pmic_wrapper *wrp);
>  	int (*init_soc_specific)(struct pmic_wrapper *wrp);
>  };
> @@ -1394,6 +1402,7 @@ static const struct pmic_wrapper_type pwrap_mt2701 = {
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE_NEW,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 0,
> +	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_mt2701_init_reg_clock,
>  	.init_soc_specific = pwrap_mt2701_init_soc_specific,
>  };
> @@ -1406,6 +1415,7 @@ static const struct pmic_wrapper_type pwrap_mt7622 = {
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 0,
> +	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt7622_init_soc_specific,
>  };
> @@ -1418,6 +1428,7 @@ static const struct pmic_wrapper_type pwrap_mt8135 = {
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
>  	.has_bridge = 1,
> +	.caps = PWRAP_CAP_BRIDGE | PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt8135_init_soc_specific,
>  };
> -- 
> 2.12.5
> 
> ************* Email Confidentiality Notice ********************
> The information contained in this e-mail message (including any 
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be 
> conveyed only to the designated recipient(s). Any use, dissemination, 
> distribution, printing, retaining or copying of this e-mail (including its 
> attachments) by unintended recipient(s) is strictly prohibited and may 
> be unlawful. If you are not an intended recipient of this e-mail, or believe 
> that you have received this e-mail in error, please notify the sender 
> immediately (by replying to this e-mail), delete any and all copies of 
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 
