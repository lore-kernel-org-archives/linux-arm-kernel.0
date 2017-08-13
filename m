From: bp@alien8.de (Borislav Petkov)
Date: Sun, 13 Aug 2017 14:12:29 +0200
Subject: [PATCH v2 3/6] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
In-Reply-To: <144221fcb30f984fa3b438ccbdd64388395e4e2f.1502091561.git.michal.simek@xilinx.com>
References: <91fd6532076e4c905b5a228d852bba4941c54a28.1502091561.git.michal.simek@xilinx.com>
 <144221fcb30f984fa3b438ccbdd64388395e4e2f.1502091561.git.michal.simek@xilinx.com>
Message-ID: <20170813121229.GB22812@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 09:39:25AM +0200, Michal Simek wrote:
> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> 
> This patch adds EDAC ECC support for ZynqMP DDRC IP

It does much more and the commit message could talk about it.

> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Add binding doc to this series to resolve checkpatch warning
> - Rebased on the top of
>   https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=for-next
>   and resolve conflict caused by "EDAC: Get rid of mci->mod_ver" patch
> - Add changes done in previous patch
> 
>  drivers/edac/Kconfig         |   2 +-
>  drivers/edac/synopsys_edac.c | 305 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 302 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 96afb2aeed18..e2f62dda8944 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -445,7 +445,7 @@ config EDAC_ALTERA_SDMMC
>  
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
> -	depends on ARCH_ZYNQ
> +	depends on ARCH_ZYNQ || ARM64

This is an unrelated change and it needs a separate patch and a commit
message explaining that you're enabling the driver on arm64 now too.

>  	help
>  	  Support for error detection and correction on the Synopsys DDR
>  	  memory controller.
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 293380f884fe..11016cd13a08 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -22,6 +22,7 @@
>  #include <linux/edac.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/interrupt.h>
>  #include <linux/of.h>
>  
>  #include "edac_module.h"
> @@ -99,6 +100,87 @@
>  /* DDR ECC Quirks */
>  #define DDR_ECC_INTR_SUPPORT		BIT(0)
>  
> +/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
> +/* ECC Configuration Registers */
> +#define ECC_CFG0_OFST	0x70
> +#define ECC_CFG1_OFST	0x74
> +
> +/* ECC Status Register */
> +#define ECC_STAT_OFST	0x78
> +
> +/* ECC Clear Register */
> +#define ECC_CLR_OFST	0x7C
> +
> +/* ECC Error count Register */
> +#define ECC_ERRCNT_OFST	0x80

Some of those are unused. Kill them if they remain unused.

> +
> +/* ECC Corrected Error Address Register */
> +#define ECC_CEADDR0_OFST	0x84
> +#define ECC_CEADDR1_OFST	0x88
> +
> +/* ECC Syndrome Registers */
> +#define ECC_CSYND0_OFST	0x8C
> +#define ECC_CSYND1_OFST	0x90
> +#define ECC_CSYND2_OFST	0x94
> +
> +/* ECC Bit Mask0 Address Register */
> +#define ECC_BITMASK0_OFST	0x98
> +#define ECC_BITMASK1_OFST	0x9C
> +#define ECC_BITMASK2_OFST	0xA0
> +
> +/* ECC UnCorrected Error Address Register */
> +#define ECC_UEADDR0_OFST	0xA4
> +#define ECC_UEADDR1_OFST	0xA8
> +
> +/* ECC Syndrome Registers */
> +#define ECC_UESYND0_OFST	0xAC
> +#define ECC_UESYND1_OFST	0xB0
> +#define ECC_UESYND2_OFST	0xB4
> +
> +/* ECC Poison Address Reg */
> +#define ECC_POISON0_OFST	0xB8
> +#define ECC_POISON1_OFST	0xBC
> +
> +/* Control register bitfield definitions */
> +#define ECC_CTRL_BUSWIDTH_MASK	0x3000
> +#define ECC_CTRL_BUSWIDTH_SHIFT	12
> +#define ECC_CTRL_CLR_CE_ERRCNT	BIT(2)
> +#define ECC_CTRL_CLR_UE_ERRCNT	BIT(3)
> +
> +/* DDR Control Register width definitions  */
> +#define DDRCTL_EWDTH_16		2
> +#define DDRCTL_EWDTH_32		1
> +#define DDRCTL_EWDTH_64		0
> +
> +/* ECC status register definitions */
> +#define ECC_STAT_UECNT_MASK	0xF0000
> +#define ECC_STAT_UECNT_SHIFT	16
> +#define ECC_STAT_CECNT_MASK	0xF00
> +#define ECC_STAT_CECNT_SHIFT	8
> +#define ECC_STAT_BITNUM_MASK	0x7F
> +
> +/* DDR QOS Interrupt register definitions */
> +#define DDR_QOS_IRQ_STAT_OFST	0x20200
> +#define DDR_QOSUE_MASK		0x4
> +#define DDR_QOSCE_MASK		0x2
> +#define ECC_CE_UE_INTR_MASK	0x6
> +
> +/* ECC Corrected Error Register Mask and Shifts*/
> +#define ECC_CEADDR0_RW_MASK	0x3FFFF
> +#define ECC_CEADDR0_RNK_MASK	BIT(24)
> +#define ECC_CEADDR1_BNKGRP_MASK	0x3000000
> +#define ECC_CEADDR1_BNKNR_MASK	0x70000
> +#define ECC_CEADDR1_BLKNR_MASK	0xFFF
> +#define ECC_CEADDR1_BNKGRP_SHIFT	24
> +#define ECC_CEADDR1_BNKNR_SHIFT	16
> +
> +/* DDR Memory type defines */
> +#define MEM_TYPE_DDR3	0x1
> +#define MEM_TYPE_LPDDR3	0x1
> +#define MEM_TYPE_DDR2	0x4
> +#define MEM_TYPE_DDR4	0x10
> +#define MEM_TYPE_LPDDR4	0x10
> +
>  /**
>   * struct ecc_error_info - ECC error log information
>   * @row:	Row number
> @@ -106,6 +188,8 @@
>   * @bank:	Bank number
>   * @bitpos:	Bit position
>   * @data:	Data causing the error
> + * @bankgrpnr:	Bank group number
> + * @blknr:	Block number
>   */
>  struct ecc_error_info {
>  	u32 row;
> @@ -113,6 +197,8 @@ struct ecc_error_info {
>  	u32 bank;
>  	u32 bitpos;
>  	u32 data;
> +	u32 bankgrpnr;
> +	u32 blknr;

u32? Can those fit in a smaller integer?

>  };
>  
>  /**
> @@ -171,7 +257,7 @@ struct synps_platform_data {
>   *
>   * Determines there is any ecc error or not
>   *
> - * Return: one if there is no error otherwise returns zero
> + * Return: 1 if there is no error otherwise returns 0

So you corrected this to use numbers (1 and 0) which is as arbitrary
change as any...

>   */
>  static int synps_edac_geterror_info(void __iomem *base,
>  				    struct synps_ecc_status *p)
> @@ -219,6 +305,65 @@ static int synps_edac_geterror_info(void __iomem *base,
>  }
>  
>  /**
> + * synps_enh_edac_geterror_info - Get the current ecc error info
> + * @base:	Pointer to the base address of the ddr memory controller
> + * @p:		Pointer to the synopsys ecc status structure
> + *
> + * Determines there is any ecc error or not
> + *
> + * Return: one if there is no error otherwise returns zero

... and yet copied the old text and didn't change it here. Looks like
this needs making up mind.

> + */
> +static int synps_enh_edac_geterror_info(void __iomem *base,
> +					struct synps_ecc_status *p)

And you have "_edac_" in all those functions which are static and which
only encumbers readability. I think naming scheme like

	get_error_info
	zynq_mp_get_error_info
	...

should be much easier on the eyes.

> +{
> +	u32 regval, clearval = 0;
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
> +	if (!(p->ce_cnt))
> +		goto ue_err;
> +
> +	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
> +	regval = readl(base + ECC_CEADDR1_OFST);
> +	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
> +					ECC_CEADDR1_BNKNR_SHIFT;
> +	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
> +					ECC_CEADDR1_BNKGRP_SHIFT;
> +	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
> +	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);

Align vertically and let it stick out for better readability, like this:

	p->ceinfo.bank	    = (regval & ECC_CEADDR1_BNKNR_MASK) >> ECC_CEADDR1_BNKNR_SHIFT;
	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >> ECC_CEADDR1_BNKGRP_SHIFT;
	p->ceinfo.blknr	    = (regval & ECC_CEADDR1_BLKNR_MASK);
	p->ceinfo.data	    = readl(base + ECC_CSYND0_OFST);

> +	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
> +		 p->ceinfo.data);
> +
> +ue_err:
> +	regval = readl(base + ECC_UEADDR0_OFST);
> +	if (!(p->ue_cnt))
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

Ditto.

> +out:
> +	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
> +	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
> +	writel(clearval, base + ECC_CLR_OFST);
> +	writel(0x0, base + ECC_CLR_OFST);
> +
> +	return 0;
> +}
> +
> +/**
>   * synps_edac_handle_error - Handle controller error types CE and UE
>   * @mci:	Pointer to the edac memory controller instance
>   * @p:		Pointer to the synopsys ecc status structure
> @@ -255,6 +400,41 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
>  }
>  
>  /**
> + * synps_edac_intr_handler - synps edac isr
> + * @irq:	irq number
> + * @dev_id:	device id poniter
> + *
> + * This is the Isr routine called by edac core interrupt thread.

s/[iI]sr/ISR/g

> + * Used to check and post ECC errors.
> + *
> + * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise
> + */
> +static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
> +{
> +	struct mem_ctl_info *mci = dev_id;
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +	int status, regval;
> +
> +	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST) &
> +			(DDR_QOSCE_MASK | DDR_QOSUE_MASK);
> +	if (!(regval & ECC_CE_UE_INTR_MASK))
> +		return IRQ_NONE;

newline.

> +	status = priv->p_data->edac_geterror_info(priv->baseaddr,
> +						  &priv->stat);

Let it stick out.

> +	if (status)
> +		return IRQ_NONE;
> +
> +	priv->ce_cnt += priv->stat.ce_cnt;
> +	priv->ue_cnt += priv->stat.ue_cnt;
> +	synps_edac_handle_error(mci, &priv->stat);
> +
> +	edac_dbg(3, "Total error count ce %d ue %d\n",
> +		 priv->ce_cnt, priv->ue_cnt);
> +	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
> +	return IRQ_HANDLED;
> +}
> +
> +/**
>   * synps_edac_check - Check controller for ECC errors
>   * @mci:	Pointer to the edac memory controller instance
>   *
> @@ -310,6 +490,40 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
>  }
>  
>  /**
> + * synps_enh_edac_get_dtype - Return the controller memory width
> + * @base:	Pointer to the ddr memory controller base address
> + *
> + * Get the EDAC device type width appropriate for the current controller
> + * configuration.
> + *
> + * Return: a device type width enumeration.

"... or unknown."

> + */
> +static enum dev_type synps_enh_edac_get_dtype(const void __iomem *base)
> +{
> +	enum dev_type dt;
> +	u32 width;
> +
> +	width = readl(base + CTRL_OFST);
> +	width = (width & ECC_CTRL_BUSWIDTH_MASK) >>
> +		ECC_CTRL_BUSWIDTH_SHIFT;

Let it stick out - the 80 cols rule is not a hard one.

> +	switch (width) {
> +	case DDRCTL_EWDTH_16:
> +		dt = DEV_X2;

You can save yourself the assignment if you do

		return DEV_X2;

here and below, respectively.

> +		break;
> +	case DDRCTL_EWDTH_32:
> +		dt = DEV_X4;
> +		break;
> +	case DDRCTL_EWDTH_64:
> +		dt = DEV_X8;
> +		break;
> +	default:
> +		dt = DEV_UNKNOWN;
> +	}
> +
> +	return dt;
> +}
> +
> +/**
>   * synps_edac_get_eccstate - Return the controller ecc enable/disable status
>   * @base:	Pointer to the ddr memory controller base address
>   *
> @@ -335,6 +549,32 @@ static bool synps_edac_get_eccstate(void __iomem *base)
>  }
>  
>  /**
> + * synps_enh_edac_get_eccstate - Return the controller ecc enable/disable status

s/ecc/ECC/g

> + * @base:	Pointer to the ddr memory controller base address
> + *
> + * Get the ECC enable/disable status for the controller
> + *
> + * Return: a ecc status boolean i.e true/false - enabled/disabled.
> + */
> +static bool synps_enh_edac_get_eccstate(void __iomem *base)
> +{
> +	enum dev_type dt;
> +	u32 ecctype;
> +	bool state = false;
> +
> +	dt = synps_enh_edac_get_dtype(base);
> +	if (dt == DEV_UNKNOWN)
> +		return state;
> +
> +	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
> +	if ((ecctype == SCRUB_MODE_SECDED) &&
> +	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
> +		state = true;
> +
> +	return state;

Ditto: you don't need the assignment here - just return the boolean value.

> +}
> +
> +/**
>   * synps_edac_get_memsize - reads the size of the attached memory device
>   *
>   * Return: the memory size in bytes
> @@ -373,6 +613,32 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
>  }
>  
>  /**
> + * synps_enh_edac_get_mtype - Returns controller memory type
> + * @base:	pointer to the synopsys ecc status structure
> + *
> + * Get the EDAC memory type appropriate for the current controller
> + * configuration.
> + *
> + * Return: a memory type enumeration.
> + */
> +static enum mem_type synps_enh_edac_get_mtype(const void __iomem *base)
> +{
> +	enum mem_type mt = MEM_UNKNOWN;
> +	u32 memtype;
> +
> +	memtype = readl(base + CTRL_OFST);
> +
> +	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
> +		mt = MEM_DDR3;
> +	else if (memtype & MEM_TYPE_DDR2)
> +		mt = MEM_RDDR2;
> +	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
> +		mt = MEM_DDR4;
> +
> +	return mt;

Ditto.

> +}
> +
> +/**
>   * synps_edac_init_csrows - Initialize the cs row data
>   * @mci:	Pointer to the edac memory controller instance
>   *
> @@ -440,8 +706,12 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
>  	mci->dev_name = SYNPS_EDAC_MOD_STRING;
>  	mci->mod_name = SYNPS_EDAC_MOD_VER;
>  
> -	edac_op_state = EDAC_OPSTATE_POLL;
> -	mci->edac_check = synps_edac_check;
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
> +		edac_op_state = EDAC_OPSTATE_INT;
> +	} else {
> +		edac_op_state = EDAC_OPSTATE_POLL;
> +		mci->edac_check = synps_edac_check;
> +	}
>  	mci->ctl_page_to_phys = NULL;
>  
>  	status = synps_edac_init_csrows(mci);
> @@ -457,8 +727,18 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
>  	.quirks			= 0,
>  };
>  
> +static const struct synps_platform_data zynqmp_enh_edac_def = {
> +	.edac_geterror_info	= synps_enh_edac_geterror_info,
> +	.edac_get_mtype		= synps_enh_edac_get_mtype,
> +	.edac_get_dtype		= synps_enh_edac_get_dtype,
> +	.edac_get_eccstate	= synps_enh_edac_get_eccstate,
> +	.quirks			= DDR_ECC_INTR_SUPPORT,
> +};
> +
>  static const struct of_device_id synps_edac_match[] = {
>  	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
> +	{ .compatible = "xlnx,zynqmp-ddrc-2.40a",
> +				.data = (void *)&zynqmp_enh_edac_def},
>  	{ /* end of table */ }
>  };
>  
> @@ -478,7 +758,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	struct mem_ctl_info *mci;
>  	struct edac_mc_layer layers[2];
>  	struct synps_edac_priv *priv;
> -	int rc;
> +	int rc, irq, status;
>  	struct resource *res;
>  	void __iomem *baseaddr;
>  	const struct of_device_id *match;
> @@ -527,6 +807,23 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  		goto free_edac_mc;
>  	}
>  
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +				    "No irq %d in DT\n", irq);
> +			return -ENODEV;

If you return here, you're leaking memory.

> +		}
> +
> +		status = devm_request_irq(&pdev->dev, irq,
> +					  synps_edac_intr_handler,
> +					  0, dev_name(&pdev->dev), mci);
> +		if (status < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");
> +			goto free_edac_mc;
> +		}
> +	}
> +
>  	rc = edac_mc_add_mc(mci);
>  	if (rc) {
>  		edac_printk(KERN_ERR, EDAC_MC,
> -- 
> 1.9.1
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
