From: bp@alien8.de (Borislav Petkov)
Date: Tue, 7 Jun 2016 19:26:36 +0200
Subject: [PATCH 2/5] EDAC, altera: ECC Manager IRQ controller support
In-Reply-To: <1464193783-5071-3-git-send-email-tthayer@opensource.altera.com>
References: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
 <1464193783-5071-3-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160607172636.GB1152@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 11:29:40AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> To better support child devices, the ECC manager needs to be
> implemented as an IRQ controller.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  drivers/edac/altera_edac.c |  162 +++++++++++++++++++++++++++++++++-----------
>  drivers/edac/altera_edac.h |    5 +-
>  2 files changed, 125 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 5b4d223..3eb73bc 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -22,9 +22,11 @@
>  #include <linux/edac.h>
>  #include <linux/genalloc.h>
>  #include <linux/interrupt.h>
> +#include <linux/irqchip/chained_irq.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -882,22 +884,27 @@ static void ocram_free_mem(void *p, size_t size, void *other)
>  	gen_pool_free((struct gen_pool *)other, (u32)p, size);
>  }
>  
> -static irqreturn_t altr_edac_a10_ecc_irq(struct altr_edac_device_dev *dci,
> -					 bool sberr)
> +static irqreturn_t altr_edac_a10_ecc_irq(int irq, void *dev_id)
>  {
> +	irqreturn_t ret_value = IRQ_NONE;

This ret_value looks funny:

> +	struct altr_edac_device_dev *dci = dev_id;
>  	void __iomem  *base = dci->base;
>  
> -	if (sberr) {
> +	if (irq == dci->sb_irq) {
> +		ret_value = IRQ_HANDLED;
>  		writel(ALTR_A10_ECC_SERRPENA,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
>  		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);

You can do
		return IRQ_HANDLED;

here

> -	} else {
> +	} else if (irq == dci->db_irq) {
> +		ret_value = IRQ_HANDLED;
>  		writel(ALTR_A10_ECC_DERRPENA,
>  		       base + ALTR_A10_ECC_INTSTAT_OFST);
>  		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
>  		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");

No need to return any value after panic so who cares. But you can still do

		return IRQ_HANDLED;

for consistency.

> +	} else {
> +		WARN_ON(1);
>  	}
> -	return IRQ_HANDLED;
> +	return ret_value;

	return IRQ_NONE;



>  }
>  
>  const struct edac_device_prv_data ocramecc_data = {
> @@ -988,22 +995,28 @@ static int altr_l2_check_deps(struct altr_edac_device_dev *device)
>  	return -ENODEV;
>  }
>  
> -static irqreturn_t altr_edac_a10_l2_irq(struct altr_edac_device_dev *dci,
> -					bool sberr)
> +static irqreturn_t altr_edac_a10_l2_irq(int irq, void *dev_id)
>  {
> -	if (sberr) {
> +	irqreturn_t ret_value = IRQ_NONE;
> +	struct altr_edac_device_dev *dci = dev_id;
> +
> +	if (irq == dci->sb_irq) {
> +		ret_value = IRQ_HANDLED;
>  		regmap_write(dci->edac->ecc_mgr_map,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_SB);
>  		edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
> -	} else {
> +	} else if (irq == dci->db_irq) {
> +		ret_value = IRQ_HANDLED;
>  		regmap_write(dci->edac->ecc_mgr_map,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_OFST,
>  			     A10_SYSGMR_MPU_CLEAR_L2_ECC_MB);
>  		edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
>  		panic("\nEDAC:ECC_DEVICE[Uncorrectable errors]\n");
> +	} else {
> +		WARN_ON(1);
>  	}
> -	return IRQ_HANDLED;
> +	return ret_value;

Ditto.

>  }
>  
>  const struct edac_device_prv_data l2ecc_data = {
> @@ -1075,28 +1088,27 @@ static ssize_t altr_edac_a10_device_trig(struct file *file,
>  	return count;
>  }
>  
> -static irqreturn_t altr_edac_a10_irq_handler(int irq, void *dev_id)
> +static void altr_edac_a10_irq_handler(struct irq_desc *desc)
>  {
> -	irqreturn_t rc = IRQ_NONE;
> -	struct altr_arria10_edac *edac = dev_id;
> -	struct altr_edac_device_dev *dci;
> -	int irq_status;
> -	bool sberr = (irq == edac->sb_irq) ? 1 : 0;
> -	int sm_offset = sberr ? A10_SYSMGR_ECC_INTSTAT_SERR_OFST :
> -				A10_SYSMGR_ECC_INTSTAT_DERR_OFST;
> +	int dberr, bit, sm_offset, irq_status;
> +	struct altr_arria10_edac *edac = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	int irq = irq_desc_get_irq(desc);
> +
> +	chained_irq_enter(chip, desc);
> +	dberr = (irq == edac->db_irq) ? 1 : 0;
> +	sm_offset = dberr ? A10_SYSMGR_ECC_INTSTAT_DERR_OFST :
> +			    A10_SYSMGR_ECC_INTSTAT_SERR_OFST;

Move
	chained_irq_enter()

here, after the assignments.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
