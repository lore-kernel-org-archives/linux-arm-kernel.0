From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Thu, 14 May 2015 15:20:52 -0500
Subject: [PATCH 3/4] edac, altera: Addition of Arria10 EDAC
In-Reply-To: <1431553787-27741-4-git-send-email-tthayer@opensource.altera.com>
References: <1431553787-27741-1-git-send-email-tthayer@opensource.altera.com>
 <1431553787-27741-4-git-send-email-tthayer@opensource.altera.com>
Message-ID: <555503A4.2070802@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2015 04:49 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> The Arria10 SDRAM and ECC system differs significantly from the
> Cyclone5 and Arria5 SoCs. This patch adds support for the Arria10
> SoC.
> 1) IRQ handler needs to support SHARED IRQ
> 2) Support sberr and dberr address reporting.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  drivers/edac/altera_edac.c |  132 ++++++++++++++++++++++++++++++++++++++------
>  drivers/edac/altera_edac.h |   85 ++++++++++++++++++++++++++++
>  2 files changed, 201 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 204ad2d..735a180 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -42,6 +42,7 @@ const struct altr_sdram_prv_data c5_data = {
>  	.ecc_stat_ce_mask   = CV_DRAMSTS_SBEERR,
>  	.ecc_stat_ue_mask   = CV_DRAMSTS_DBEERR,
>  	.ecc_saddr_offset   = CV_ERRADDR_OFST,
> +	.ecc_daddr_offset   = CV_ERRADDR_OFST,
>  	.ecc_cecnt_offset   = CV_SBECOUNT_OFST,
>  	.ecc_uecnt_offset   = CV_DBECOUNT_OFST,
>  	.ecc_irq_en_offset  = CV_DRAMINTR_OFST,
> @@ -57,37 +58,62 @@ const struct altr_sdram_prv_data c5_data = {
>  #endif
>  };
>  
> +const struct altr_sdram_prv_data a10_data = {\

This should be static.

> +	.ecc_ctrl_offset    = A10_ECCCTRL1_OFST,
> +	.ecc_ctl_en_mask    = A10_ECCCTRL1_ECC_EN,
> +	.ecc_stat_offset    = A10_INTSTAT_OFST,
> +	.ecc_stat_ce_mask   = A10_INTSTAT_SBEERR,
> +	.ecc_stat_ue_mask   = A10_INTSTAT_DBEERR,
> +	.ecc_saddr_offset   = A10_SERRADDR_OFST,
> +	.ecc_daddr_offset   = A10_DERRADDR_OFST,
> +	.ecc_irq_en_offset  = A10_ERRINTEN_OFST,
> +	.ecc_irq_en_mask    = A10_ECC_IRQ_EN_MASK,
> +	.ecc_irq_clr_offset = A10_INTSTAT_OFST,
> +	.ecc_irq_clr_mask   = (A10_INTSTAT_SBEERR | A10_INTSTAT_DBEERR),
> +	.ecc_cnt_rst_offset = A10_ECCCTRL1_OFST,
> +	.ecc_cnt_rst_mask   = A10_ECC_CNT_RESET_MASK,
> +#ifdef CONFIG_EDAC_DEBUG
> +	.ce_ue_trgr_offset  = A10_DIAGINTTEST_OFST,
> +	.ce_set_mask        = A10_DIAGINT_TSERRA_MASK,
> +	.ue_set_mask        = A10_DIAGINT_TDERRA_MASK,
> +#endif
> +};
> +
>
<snip>

> +
>  static int altr_sdram_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *id;
> @@ -221,8 +295,8 @@ static int altr_sdram_probe(struct platform_device *pdev)
>  	struct regmap *mc_vbase;
>  	struct dimm_info *dimm;
>  	u32 read_reg;
> -	int irq, res = 0;
> -	unsigned long mem_size;
> +	int irq, irq2, res = 0;
> +	unsigned long mem_size, irqflags;
>  
>  	id = of_match_device(altr_sdram_ctrl_of_match, &pdev->dev);
>  	if (!id)
> @@ -288,6 +362,9 @@ static int altr_sdram_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	/* Arria10 has a 2nd IRQ */
> +	irq2 = platform_get_irq(pdev, 1);
> +
>  	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
>  	layers[0].size = 1;
>  	layers[0].is_virt_csrow = true;
> @@ -332,8 +409,31 @@ static int altr_sdram_probe(struct platform_device *pdev)
>  	if (res < 0)
>  		goto err;
>  
> +	/* Only the Arria10 has separate IRQs */
> +	if (irq2 > 0) {
> +		/* Arria10 specific initialization */
> +		res = a10_init(mc_vbase);
> +		if (res < 0)
> +			goto err2;
> +
> +		res = a10_unmask_irq(pdev, A10_DDR0_IRQ_MASK);
> +		if (res < 0)
> +			goto err2;
> +
> +		res = devm_request_irq(&pdev->dev, irq2,
> +				       altr_sdram_mc_err_handler,
> +				       IRQF_SHARED, dev_name(&pdev->dev), mci);
> +		if (res < 0) {
> +			edac_mc_printk(mci, KERN_ERR,
> +				       "Unable to request irq %d\n", irq2);
> +			res = -ENODEV;
> +			goto err2;
> +		}
> +		irqflags = IRQF_SHARED;
> +	}
> +
>  	res = devm_request_irq(&pdev->dev, irq, altr_sdram_mc_err_handler,
> -			       0, dev_name(&pdev->dev), mci);
> +			       irqflags, dev_name(&pdev->dev), mci);

irqflags was never set for the case of !(irq2 > 0).

Dinh
