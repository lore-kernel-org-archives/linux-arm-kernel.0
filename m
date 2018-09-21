From: bp@alien8.de (Borislav Petkov)
Date: Fri, 21 Sep 2018 14:56:13 +0200
Subject: [PATCH v7 5/7] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
In-Reply-To: <1537194305-9243-6-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-6-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180921125527.GE30439@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 07:55:03PM +0530, Manish Narani wrote:
> Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts for
> corrected and uncorrected errors. Add interrupt handlers for the same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/Kconfig         |   2 +-
>  drivers/edac/synopsys_edac.c | 304 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 287 insertions(+), 19 deletions(-)

...

> @@ -639,7 +878,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	struct mem_ctl_info *mci;
>  	void __iomem *baseaddr;
>  	struct resource *res;
> -	int rc;
> +	int rc, irq;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	baseaddr = devm_ioremap_resource(&pdev->dev, res);
> @@ -673,6 +912,28 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  
>  	edac_mc_init(mci, pdev);
>  
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {

This whole chunk together with the if, looks like it could be a separate
function called maybe request_irq() or so.

> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +					"No irq %d in DT\n", irq);

Align arguments on opening brace.

Then, here it is "irq"...

> +			rc = irq;
> +			goto free_edac_mc;
> +		}
> +
> +		rc = devm_request_irq(&pdev->dev, irq,
> +			synps_edac_intr_handler,
> +			0, dev_name(&pdev->dev), mci);

Also align on opening brace.

> +		if (rc < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");

... here it is "Irq".

I'd say it should be "IRQ" everywhere.

> +			goto free_edac_mc;
> +		}
> +
> +		/* Enable UE/CE Interrupts */
> +		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
> +			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
> +	}
> +
>  	rc = edac_mc_add_mc(mci);
>  	if (rc) {
>  		edac_printk(KERN_ERR, EDAC_MC,
> @@ -684,7 +945,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	 * Start capturing the correctable and uncorrectable errors. A write of
>  	 * 0 starts the counters.
>  	 */
> -	writel(0x0, baseaddr + ECC_CTRL_OFST);
> +	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
> +		writel(0x0, baseaddr + ECC_CTRL_OFST);
>  	return rc;
>  
>  free_edac_mc:
> @@ -702,7 +964,13 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  static int synps_edac_mc_remove(struct platform_device *pdev)
>  {
>  	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +	struct synps_edac_priv *priv;
>  
> +	priv = mci->pvt_info;
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
> +		/* Disable UE/CE Interrupts */
> +		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
> +			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);

This could be a disable_irq() function. Makes the code easier to follow.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
