From: tthayer@opensource.altera.com (Thor Thayer)
Date: Tue, 8 Mar 2016 09:52:11 -0600
Subject: [PATCHv2 07/11] EDAC, altera: Add status offset & masks
In-Reply-To: <1457379787-8327-8-git-send-email-tthayer@opensource.altera.com>
References: <1457379787-8327-1-git-send-email-tthayer@opensource.altera.com>
 <1457379787-8327-8-git-send-email-tthayer@opensource.altera.com>
Message-ID: <56DEF52B.9000801@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 03/07/2016 01:43 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
>
> In preparation for the Arria10 peripheral ECCs, the IRQ
> status needs to be determined because the IRQs are shared.
> The IRQ status register is read to determine if the IRQ
> was for this ECC peripheral. Cyclone5 and Arria5 have
> dedicated IRQs so the confirmation mechanism is not
> required and the mask is set to 0.
>
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2: Split large patch into smaller patches. Determine
>      if IRQ matches this ECC peripheral before handling it.
> ---
>   drivers/edac/altera_edac.c |   41 +++++++++++++++++++++++++++++++----------
>   drivers/edac/altera_edac.h |    3 +++
>   2 files changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index fd73a77..11b7291 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -556,19 +556,32 @@ static irqreturn_t altr_edac_device_handler(int irq, void *dev_id)
>   	struct edac_device_ctl_info *dci = dev_id;
>   	struct altr_edac_device_dev *drvdata = dci->pvt_info;
>   	const struct edac_device_prv_data *priv = drvdata->data;
> +	void __iomem *status_addr = drvdata->status + priv->err_status_ofst;
>   	void __iomem *clear_addr = drvdata->status + priv->clear_err_ofst;
>
> +	/*
> +	 * CycloneV is directly mapped to a specific IRQ. Arria10
> +	 * shares the IRQ with other ECCs so we must match first.
> +	 */
>   	if (irq == drvdata->sb_irq) {
> -		if (priv->ce_clear_mask)
> -			writel(priv->ce_clear_mask, clear_addr);
> -		edac_device_handle_ce(dci, 0, 0, drvdata->edac_dev_name);
> -		ret_value = IRQ_HANDLED;
> +		if (!priv->ce_status_mask ||
> +		    (priv->ce_status_mask & readl(status_addr))) {
> +			if (priv->ce_clear_mask)
> +				writel(priv->ce_clear_mask, clear_addr);
> +			edac_device_handle_ce(dci, 0, 0,
> +					      drvdata->edac_dev_name);
> +			ret_value = IRQ_HANDLED;
> +		}
>   	} else if (irq == drvdata->db_irq) {
> -		if (priv->ue_clear_mask)
> -			writel(priv->ue_clear_mask, clear_addr);
> -		edac_device_handle_ue(dci, 0, 0, drvdata->edac_dev_name);
> -		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
> -		ret_value = IRQ_HANDLED;
> +		if (!priv->ue_status_mask ||
> +		    (priv->ue_status_mask & readl(status_addr))) {
> +			if (priv->ue_clear_mask)
> +				writel(priv->ue_clear_mask, clear_addr);
> +			edac_device_handle_ue(dci, 0, 0,
> +					      drvdata->edac_dev_name);
> +			panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
> +			ret_value = IRQ_HANDLED;
> +		}
>   	} else {
>   		WARN_ON(1);
>   	}


While working on subsequent ECC components to upstream, I realized that 
the above is not an optimal solution for Arria10.

The Arria10 is significantly different from the Cyclone5/Arria5 and 
therefore should be it's own implementation.

Please disregard this patch series. I'll redo the series with a 
different IRQ implementation that is cleaner - it will be closer to the 
Xgene driver.

Sorry for the noise.

Thor


> @@ -882,6 +895,10 @@ const struct edac_device_prv_data ocramecc_data = {
>   	.ce_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_SERR),
>   	.ue_clear_mask = (ALTR_OCR_ECC_EN | ALTR_OCR_ECC_DERR),
>   	.clear_err_ofst = ALTR_OCR_ECC_REG_OFFSET,
> +	/* Cyclone5 & Arria5 have separate IRQs so status = 0 */
> +	.ce_status_mask = 0,
> +	.ue_status_mask = 0,
> +	.err_status_ofst = 0,
>   	.dbgfs_name = "altr_ocram_trigger",
>   	.alloc_mem = ocram_alloc_mem,
>   	.free_mem = ocram_free_mem,
> @@ -957,7 +974,11 @@ const struct edac_device_prv_data l2ecc_data = {
>   	.setup = altr_l2_check_deps,
>   	.ce_clear_mask = 0,
>   	.ue_clear_mask = 0,
> -	.clear_err_ofst = ALTR_L2_ECC_REG_OFFSET,
> +	.clear_err_ofst = ALTR_MAN_GRP_L2_ECC_OFFSET,
> +	/* Cyclone5 & Arria5 have separate IRQs so status = 0 */
> +	.ce_status_mask = 0,
> +	.ue_status_mask = 0,
> +	.err_status_ofst = 0,
>   	.dbgfs_name = "altr_l2_trigger",
>   	.alloc_mem = l2_alloc_mem,
>   	.free_mem = l2_free_mem,
> diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
> index b262f74..43e0dae 100644
> --- a/drivers/edac/altera_edac.h
> +++ b/drivers/edac/altera_edac.h
> @@ -226,6 +226,9 @@ struct edac_device_prv_data {
>   	int ce_clear_mask;
>   	int ue_clear_mask;
>   	int clear_err_ofst;
> +	int ce_status_mask;
> +	int ue_status_mask;
> +	int err_status_ofst;
>   	char dbgfs_name[20];
>   	void * (*alloc_mem)(size_t size, void **other);
>   	void (*free_mem)(void *p, size_t size, void *other);
>
