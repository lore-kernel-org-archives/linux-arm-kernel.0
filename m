From: bp@alien8.de (Borislav Petkov)
Date: Wed, 17 Oct 2018 18:30:26 +0200
Subject: [PATCH v9 4/6] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
In-Reply-To: <1539581388-23963-5-git-send-email-manish.narani@xilinx.com>
References: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
 <1539581388-23963-5-git-send-email-manish.narani@xilinx.com>
Message-ID: <20181017163026.GF22535@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2018 at 10:59:46AM +0530, Manish Narani wrote:
> Add EDAC ECC support for ZynqMP DDRC IP. The IP supports interrupts for
> corrected and uncorrected errors. Add interrupt handlers for the same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/Kconfig         |   2 +-
>  drivers/edac/synopsys_edac.c | 324 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 308 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 57304b2..7c40eb2 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
>  
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
> -	depends on ARCH_ZYNQ
> +	depends on ARCH_ZYNQ || ARCH_ZYNQMP
>  	help
>  	  Support for error detection and correction on the Synopsys DDR
>  	  memory controller.
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index d1999e0..603c4bd 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -22,6 +22,7 @@
>  #include <linux/edac.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  
> @@ -272,6 +273,8 @@
>   * @bank:	Bank number.
>   * @bitpos:	Bit position.
>   * @data:	Data causing the error.
> + * @bankgrpnr:	Bank group number.
> + * @blknr:	Block number.
>   */
>  struct ecc_error_info {
>  	u32 row;
> @@ -279,6 +282,8 @@ struct ecc_error_info {
>  	u32 bank;
>  	u32 bitpos;
>  	u32 data;
> +	u32 bankgrpnr;
> +	u32 blknr;
>  };
>  
>  /**
> @@ -385,6 +390,66 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
>  }
>  
>  /**
> + * zynqmp_get_error_info - Get the current ECC error info.
> + * @priv:	DDR memory controller private instance data.
> + *
> + * Return: one if there is no error otherwise returns zero.
> + */
> +static int zynqmp_get_error_info(struct synps_edac_priv *priv)
> +{
> +	struct synps_ecc_status *p;
> +	u32 regval, clearval = 0;
> +	void __iomem *base;
> +
> +	base = priv->baseaddr;
> +	p = &priv->stat;
> +
> +	regval = readl(base + ECC_STAT_OFST);
> +	if (!regval)
> +		return 1;
> +
> +	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
> +	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
> +	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
> +
> +	regval = readl(base + ECC_CEADDR0_OFST);
> +	if (!p->ce_cnt)
> +		goto ue_err;

This check should happen right under the p->ce_cnt assignment a couple
of lines above it. Otherwise the readl() is useless if you jump to the
ue_err label.

IOW, those two readl()'s should happen *after* the ce/ue_cnt checks.

> +
> +	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
> +	regval = readl(base + ECC_CEADDR1_OFST);
> +	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
> +					ECC_CEADDR1_BNKNR_SHIFT;
> +	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
> +					ECC_CEADDR1_BNKGRP_SHIFT;
> +	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
> +	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
> +	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
> +		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
> +		 readl(base + ECC_CSYND2_OFST));
> +ue_err:
> +	regval = readl(base + ECC_UEADDR0_OFST);
> +	if (!p->ue_cnt)
> +		goto out;
> +
> +	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
> +	regval = readl(base + ECC_UEADDR1_OFST);
> +	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
> +					ECC_CEADDR1_BNKGRP_SHIFT;
> +	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
> +					ECC_CEADDR1_BNKNR_SHIFT;
> +	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
> +	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
> +out:
> +	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
> +	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
> +	writel(clearval, base + ECC_CLR_OFST);
> +	writel(0x0, base + ECC_CLR_OFST);
> +
> +	return 0;
> +}
> +

...

> +static int setup_irq(struct mem_ctl_info *mci,
> +			  struct platform_device *pdev)

Align arguments on the opening brace.

> +{
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +	int ret, irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "No IRQ %d in DT\n", irq);
> +		return irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, intr_handler,
> +			       0, dev_name(&pdev->dev), mci);
> +	if (ret < 0) {
> +		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
> +		return ret;
> +	}
> +
> +	enable_intr(priv);
> +
> +	return 0;
> +}
> +
>  static const struct synps_platform_data zynq_edac_def = {
>  	.get_error_info	= zynq_get_error_info,
>  	.get_mtype	= zynq_get_mtype,
> @@ -613,9 +872,26 @@ static const struct synps_platform_data zynq_edac_def = {
>  	.quirks		= 0,
>  };
>  
> +static const struct synps_platform_data zynqmp_edac_def = {
> +	.get_error_info	= zynqmp_get_error_info,
> +	.get_mtype	= zynqmp_get_mtype,
> +	.get_dtype	= zynqmp_get_dtype,
> +	.get_ecc_state	= zynqmp_get_ecc_state,
> +	.quirks		= DDR_ECC_INTR_SUPPORT,
> +};
> +
>  static const struct of_device_id synps_edac_match[] = {
> -	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
> -	{ /* end of table */ }
> +	{
> +		.compatible = "xlnx,zynq-ddrc-a05",
> +		.data = (void *)&zynq_edac_def
> +	},
> +	{
> +		.compatible = "xlnx,zynqmp-ddrc-2.40a",
> +		.data = (void *)&zynqmp_edac_def
> +	},
> +	{
> +		/* end of table */
> +	}
>  };
>  
>  MODULE_DEVICE_TABLE(of, synps_edac_match);
> @@ -674,6 +950,12 @@ static int mc_probe(struct platform_device *pdev)
>  
>  	mc_init(mci, pdev);
>  
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
> +		rc = setup_irq(mci, pdev);
> +		if (rc)
> +			goto free_edac_mc;
> +	}
> +
>  	rc = edac_mc_add_mc(mci);
>  	if (rc) {
>  		edac_printk(KERN_ERR, EDAC_MC,
> @@ -685,7 +967,9 @@ static int mc_probe(struct platform_device *pdev)
>  	 * Start capturing the correctable and uncorrectable errors. A write of
>  	 * 0 starts the counters.
>  	 */
> -	writel(0x0, baseaddr + ECC_CTRL_OFST);
> +	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
> +		writel(0x0, baseaddr + ECC_CTRL_OFST);
> +
>  	return rc;
>  
>  free_edac_mc:
> @@ -703,6 +987,12 @@ static int mc_probe(struct platform_device *pdev)
>  static int mc_remove(struct platform_device *pdev)
>  {
>  	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +	struct synps_edac_priv *priv;
> +
> +	priv = mci->pvt_info;

Or simply:

	struct synps_edac_priv *priv = mci->pvt_info;

> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
> +		disable_intr(priv);
>  
>  	edac_mc_del_mc(&pdev->dev);
>  	edac_mc_free(mci);
> -- 
> 2.1.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
