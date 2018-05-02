From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 2 May 2018 12:27:55 +0200
Subject: [PATCH V4 3/8] soc: mediatek: pwrap: remove has_bridge flag
In-Reply-To: <20180502092112.3991-4-argus.lin@mediatek.com>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
 <20180502092112.3991-4-argus.lin@mediatek.com>
Message-ID: <490d35d0-1ea9-f2be-d362-48af56437ead@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/02/2018 11:21 AM, argus.lin at mediatek.com wrote:
> From: Argus Lin <argus.lin@mediatek.com>
> 
> We use new flag caps to replace has_bridge.
> Legacy chips support bridge use PWRAP_CAP_BRIDGE
> to explain such capability.
> 
> Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> ---

Squash this one into 2/8.

Regards,
Matthias

>  drivers/soc/mediatek/mtk-pmic-wrap.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 3a25ff6e6907..911a8508f39f 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -689,7 +689,6 @@ struct pmic_wrapper_type {
>  	u32 int_en_all;
>  	u32 spi_w;
>  	u32 wdt_src;
> -	unsigned int has_bridge:1;
>  	/* Flags indicating the capability for the target pwrap */
>  	u8 caps;
>  	int (*init_reg_clock)(struct pmic_wrapper *wrp);
> @@ -1306,7 +1305,7 @@ static int pwrap_init(struct pmic_wrapper *wrp)
>  	pwrap_writel(wrp, 1, PWRAP_INIT_DONE0);
>  	pwrap_writel(wrp, 1, PWRAP_INIT_DONE1);
>  
> -	if (wrp->master->has_bridge) {
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
>  		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE3);
>  		writel(1, wrp->bridge_base + PWRAP_MT8135_BRIDGE_INIT_DONE4);
>  	}
> @@ -1401,7 +1400,6 @@ static const struct pmic_wrapper_type pwrap_mt2701 = {
>  	.int_en_all = ~(u32)(BIT(31) | BIT(2)),
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE_NEW,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> -	.has_bridge = 0,
>  	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_mt2701_init_reg_clock,
>  	.init_soc_specific = pwrap_mt2701_init_soc_specific,
> @@ -1414,7 +1412,6 @@ static const struct pmic_wrapper_type pwrap_mt7622 = {
>  	.int_en_all = ~(u32)BIT(31),
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> -	.has_bridge = 0,
>  	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt7622_init_soc_specific,
> @@ -1427,7 +1424,6 @@ static const struct pmic_wrapper_type pwrap_mt8135 = {
>  	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> -	.has_bridge = 1,
>  	.caps = PWRAP_CAP_BRIDGE | PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt8135_init_soc_specific,
> @@ -1440,7 +1436,7 @@ static const struct pmic_wrapper_type pwrap_mt8173 = {
>  	.int_en_all = ~(u32)(BIT(31) | BIT(1)),
>  	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
>  	.wdt_src = PWRAP_WDT_SRC_MASK_NO_STAUPD,
> -	.has_bridge = 0,
> +	.caps = PWRAP_CAP_RESET | PWRAP_CAP_DCM,
>  	.init_reg_clock = pwrap_common_init_reg_clock,
>  	.init_soc_specific = pwrap_mt8173_init_soc_specific,
>  };
> @@ -1509,7 +1505,7 @@ static int pwrap_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (wrp->master->has_bridge) {
> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
>  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  				"pwrap-bridge");
>  		wrp->bridge_base = devm_ioremap_resource(wrp->dev, res);
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
