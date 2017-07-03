From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Jul 2017 15:03:22 +0200
Subject: [PATCH 8/8] EDAC: Add driver for the Marvell Armada XP SDRAM and
 L2 cache ECC
In-Reply-To: <20170630145106.29820-9-jlu@pengutronix.de> (Jan Luebbe's message
 of "Fri, 30 Jun 2017 16:51:06 +0200")
References: <20170630145106.29820-1-jlu@pengutronix.de>
 <20170630145106.29820-9-jlu@pengutronix.de>
Message-ID: <87bmp1vfj9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,
 
 On ven., juin 30 2017, Jan Luebbe <jlu@pengutronix.de> wrote:

> Add support for the ECC functionality as found in the DDR RAM and L2
> cache controllers on the MV78230/MV78x60 SoCs. This driver has been
> tested on the MV78460 (on a custom board with a DDR3 ECC DIMM).
>
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  MAINTAINERS                                     |   6 +
>  arch/arm/include/asm/hardware/cache-aurora-l2.h |  48 ++

you could maybe move the cache-aurora-l2.h change in a separate patch and
put it at the beginning of the series just after the 2nd patch.

Gregory

>  drivers/edac/Kconfig                            |   7 +
>  drivers/edac/Makefile                           |   1 +
>  drivers/edac/armada_xp_edac.c                   | 639 ++++++++++++++++++++++++
>  5 files changed, 701 insertions(+)
>  create mode 100644 drivers/edac/armada_xp_edac.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 767e9d202adf..758cce9c2315 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4766,6 +4766,12 @@ L:	linux-edac at vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/amd64_edac*
>  
> +EDAC-ARMADA
> +M:	Jan Luebbe <jlu@pengutronix.de>
> +L:	linux-edac at vger.kernel.org
> +S:	Maintained
> +F:	drivers/edac/armada_xp_*
> +
>  EDAC-CALXEDA
>  M:	Robert Richter <rric@kernel.org>
>  L:	linux-edac at vger.kernel.org
> diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
> index dc5c479ec4c3..c32be689d1f6 100644
> --- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
> +++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
> @@ -31,6 +31,9 @@
>  #define AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU \
>  	(3 << AURORA_ACR_REPLACEMENT_OFFSET)
>  
> +#define AURORA_ACR_PARITY_EN	(1 << 21)
> +#define AURORA_ACR_ECC_EN	(1 << 20)
> +
>  #define AURORA_ACR_FORCE_WRITE_POLICY_OFFSET	0
>  #define AURORA_ACR_FORCE_WRITE_POLICY_MASK	\
>  	(0x3 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
> @@ -41,6 +44,51 @@
>  #define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
>  	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
>  
> +#define AURORA_ERR_CNT_REG          0x600
> +#define AURORA_ERR_ATTR_CAP_REG     0x608
> +#define AURORA_ERR_ADDR_CAP_REG     0x60c
> +#define AURORA_ERR_WAY_CAP_REG      0x610
> +#define AURORA_ERR_INJECT_CTL_REG   0x614
> +#define AURORA_ERR_INJECT_MASK_REG  0x618
> +
> +#define AURORA_ERR_CNT_CLR_OFFSET         31
> +#define AURORA_ERR_CNT_CLR		   \
> +	(0x1 << AURORA_ERR_CNT_CLR_OFFSET)
> +#define AURORA_ERR_CNT_UE_OFFSET          16
> +#define AURORA_ERR_CNT_UE_MASK             \
> +	(0x7fff << AURORA_ERR_CNT_UE_OFFSET)
> +#define AURORA_ERR_CNT_CE_OFFSET            0
> +#define AURORA_ERR_CNT_CE_MASK              \
> +	(0xffff << AURORA_ERR_CNT_CE_OFFSET)
> +
> +#define AURORA_ERR_ATTR_CAP_ERR_SOURCE_OFFSET       16
> +#define AURORA_ERR_ATTR_CAP_ERR_SOURCE_MASK          \
> +	(0x7 << AURORA_ERR_ATTR_CAP_ERR_SOURCE_OFFSET)
> +#define AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET       12
> +#define AURORA_ERR_ATTR_CAP_TRANS_TYPE_MASK          \
> +	(0xf << AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET)
> +#define AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET          8
> +#define AURORA_ERR_ATTR_CAP_ERR_TYPE_MASK            \
> +	(0x3 << AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET)
> +#define AURORA_ERR_ATTR_CAP_VALID_OFFSET             0
> +#define AURORA_ERR_ATTR_CAP_VALID                    \
> +	(0x1 << AURORA_ERR_ATTR_CAP_VALID_OFFSET)
> +
> +#define AURORA_ERR_ADDR_CAP_ADDR_MASK 0xffffffe0
> +
> +#define AURORA_ERR_WAY_CAP_INDEX_OFFSET          8
> +#define AURORA_ERR_WAY_CAP_INDEX_MASK            \
> +	(0xfff << AURORA_ERR_WAY_CAP_INDEX_OFFSET)
> +#define AURORA_ERR_WAY_CAP_WAY_OFFSET          1
> +#define AURORA_ERR_WAY_CAP_WAY_MASK            \
> +	(0xf << AURORA_ERR_WAY_CAP_WAY_OFFSET)
> +
> +#define AURORA_ERR_INJECT_CTL_ADDR_MASK 0xfffffff0
> +#define AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET   12
> +#define AURORA_ERR_INJECT_CTL_EN_MASK          0x3
> +#define AURORA_ERR_INJECT_CTL_EN_PARITY        0x2
> +#define AURORA_ERR_INJECT_CTL_EN_ECC           0x1
> +
>  #define AURORA_MAX_RANGE_SIZE	1024
>  
>  #define AURORA_WAY_SIZE_SHIFT	2
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 96afb2aeed18..4e123ec94a4a 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -443,6 +443,13 @@ config EDAC_ALTERA_SDMMC
>  	  Support for error detection and correction on the
>  	  Altera SDMMC FIFO Memory for Altera SoCs.
>  
> +config EDAC_ARMADA_XP
> +	bool "Marvell Armada XP DDR and L2 Cache ECC"
> +	depends on ARCH_MVEBU
> +	help
> +	  Support for error correction and detection on the Marvell Aramada XP
> +	  DDR RAM and L2 cache controllers.
> +
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
>  	depends on ARCH_ZYNQ
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 0fd9ffa63299..70a093cc976e 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -76,5 +76,6 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
>  obj-$(CONFIG_EDAC_THUNDERX)		+= thunderx_edac.o
>  
>  obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
> +obj-$(CONFIG_EDAC_ARMADA_XP)		+= armada_xp_edac.o
>  obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
> diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
> new file mode 100644
> index 000000000000..68e88b180928
> --- /dev/null
> +++ b/drivers/edac/armada_xp_edac.c
> @@ -0,0 +1,639 @@
> +/*
> + * Copyright (C) 2017 Pengutronix, Jan Luebbe <kernel@pengutronix.de>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/edac.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/hardware/cache-l2x0.h>
> +#include <asm/hardware/cache-aurora-l2.h>
> +
> +#include "edac_mc.h"
> +#include "edac_device.h"
> +#include "edac_module.h"
> +
> +/************************ EDAC MC (DDR RAM) ********************************/
> +
> +#define SDRAM_NUM_CS 4
> +
> +#define SDRAM_CONFIG_REG 0x0
> +#define SDRAM_CONFIG_ECC_MASK        BIT(18)
> +#define SDRAM_CONFIG_REGISTERED_MASK BIT(17)
> +#define SDRAM_CONFIG_BUS_WIDTH_MASK  BIT(15)
> +
> +#define SDRAM_ADDR_CTRL_REG 0x10
> +#define SDRAM_ADDR_CTRL_SIZE_HIGH_OFFSET(cs)   (20+cs)
> +#define SDRAM_ADDR_CTRL_SIZE_HIGH_MASK(cs)           \
> +	(0x1 << SDRAM_ADDR_CTRL_SIZE_HIGH_OFFSET(cs))
> +#define SDRAM_ADDR_CTRL_ADDR_SEL_MASK(cs)   BIT(16+cs)
> +#define SDRAM_ADDR_CTRL_SIZE_LOW_OFFSET(cs)   (cs*4+2)
> +#define SDRAM_ADDR_CTRL_SIZE_LOW_MASK(cs)            \
> +	(0x3 << SDRAM_ADDR_CTRL_SIZE_LOW_OFFSET(cs))
> +#define SDRAM_ADDR_CTRL_STRUCT_OFFSET(cs)       (cs*4)
> +#define SDRAM_ADDR_CTRL_STRUCT_MASK(cs)              \
> +	(0x3 << SDRAM_ADDR_CTRL_STRUCT_OFFSET(cs))
> +
> +#define SDRAM_ERR_DATA_H_REG 0x40
> +#define SDRAM_ERR_DATA_L_REG 0x44
> +
> +#define SDRAM_ERR_RECV_ECC_REG 0x48
> +#define SDRAM_ERR_RECV_ECC_VALUE_MASK 0xff
> +
> +#define SDRAM_ERR_CALC_ECC_REG 0x4c
> +#define SDRAM_ERR_CALC_ECC_ROW_OFFSET             8
> +#define SDRAM_ERR_CALC_ECC_ROW_MASK               \
> +	(0xffff << SDRAM_ERR_CALC_ECC_ROW_OFFSET)
> +#define SDRAM_ERR_CALC_ECC_VALUE_MASK          0xff
> +
> +#define SDRAM_ERR_ADDR_REG 0x50
> +#define SDRAM_ERR_ADDR_BANK_OFFSET           23
> +#define SDRAM_ERR_ADDR_BANK_MASK              \
> +	(0x7 << SDRAM_ERR_ADDR_BANK_OFFSET)
> +#define SDRAM_ERR_ADDR_COL_OFFSET             8
> +#define SDRAM_ERR_ADDR_COL_MASK               \
> +	(0x7fff << SDRAM_ERR_ADDR_COL_OFFSET)
> +#define SDRAM_ERR_ADDR_CS_OFFSET              1
> +#define SDRAM_ERR_ADDR_CS_MASK                \
> +	(0x3 << SDRAM_ERR_ADDR_CS_OFFSET)
> +#define SDRAM_ERR_ADDR_TYPE_MASK         BIT(0)
> +
> +#define SDRAM_ERR_CTRL_REG 0x54
> +#define SDRAM_ERR_CTRL_ERR_THR_OFFSET          16
> +#define SDRAM_ERR_CTRL_ERR_THR_MASK             \
> +	(0xff << SDRAM_ERR_CTRL_ERR_THR_OFFSET)
> +#define SDRAM_ERR_CTRL_ERR_PROP_MASK       BIT(9)
> +
> +#define SDRAM_ERR_SBE_COUNT_REG 0x58
> +#define SDRAM_ERR_DBE_COUNT_REG 0x5c
> +
> +#define SDRAM_ERR_CAUSE_ERR_REG 0xd0
> +#define SDRAM_ERR_CAUSE_MSG_REG 0xd8
> +#define SDRAM_ERR_CAUSE_DBE_MASK BIT(1)
> +#define SDRAM_ERR_CAUSE_SBE_MASK BIT(0)
> +
> +#define SDRAM_RANK_CTRL_REG 0x1e0
> +#define SDRAM_RANK_CTRL_EXIST_MASK(cs) BIT(cs)
> +
> +struct armada_xp_mc_edac_drvdata {
> +	void __iomem *base;
> +
> +	unsigned int width; /* width in bytes */
> +	bool cs_addr_sel[SDRAM_NUM_CS]; /* bank interleaving */
> +
> +	char msg[128];
> +};
> +
> +/* derived from "DRAM Address Multiplexing" in the ARAMDA XP Functional Spec */
> +static uint32_t armada_xp_mc_edac_calc_address(struct armada_xp_mc_edac_drvdata
> +					       *drvdata, uint8_t cs,
> +					       uint8_t bank, uint16_t row,
> +					       uint16_t col)
> +{
> +	if (drvdata->width == 4) { /* 64 bit */
> +		if (drvdata->cs_addr_sel[cs]) /* bank interleaved */
> +			return (((row & 0xfff8) << 16) |
> +				((bank & 0x7) << 16) |
> +				((row & 0x7) << 13) |
> +				((col & 0x3ff) << 3));
> +		else
> +			return (((row & 0xffff << 16) |
> +				 ((bank & 0x7) << 13) |
> +				 ((col & 0x3ff)) << 3));
> +	} else if (drvdata->width == 2) { /* 32 bit */
> +		if (drvdata->cs_addr_sel[cs]) /* bank interleaved */
> +			return (((row & 0xfff0) << 15) |
> +				((bank & 0x7) << 16) |
> +				((row & 0xf) << 12) |
> +				((col & 0x3ff) << 2));
> +		else
> +			return (((row & 0xffff << 15) |
> +				 ((bank & 0x7) << 12) |
> +				 ((col & 0x3ff)) << 2));
> +	} else { /* 16 bit */
> +		if (drvdata->cs_addr_sel[cs]) /* bank interleaved */
> +			return (((row & 0xffe0) << 14) |
> +				((bank & 0x7) << 16) |
> +				((row & 0x1f) << 11) |
> +				((col & 0x3ff) << 1));
> +		else
> +			return (((row & 0xffff << 14) |
> +				 ((bank & 0x7) << 11) |
> +				 ((col & 0x3ff)) << 1));
> +	}
> +}
> +
> +static void armada_xp_mc_edac_check(struct mem_ctl_info *mci)
> +{
> +	struct armada_xp_mc_edac_drvdata *drvdata = mci->pvt_info;
> +	uint32_t data_h, data_l, recv_ecc, calc_ecc, addr;
> +	uint32_t cnt_sbe, cnt_dbe, cause_err, cause_msg;
> +	uint32_t row_val, col_val, bank_val, addr_val;
> +	uint8_t syndrome_val, cs_val;
> +	char *msg = drvdata->msg;
> +
> +	data_h = readl(drvdata->base + SDRAM_ERR_DATA_H_REG);
> +	data_l = readl(drvdata->base + SDRAM_ERR_DATA_L_REG);
> +	recv_ecc = readl(drvdata->base + SDRAM_ERR_RECV_ECC_REG);
> +	calc_ecc = readl(drvdata->base + SDRAM_ERR_CALC_ECC_REG);
> +	addr = readl(drvdata->base + SDRAM_ERR_ADDR_REG);
> +	cnt_sbe = readl(drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
> +	cnt_dbe = readl(drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
> +	cause_err = readl(drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
> +	cause_msg = readl(drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
> +
> +	/* clear cause registers */
> +	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
> +	       drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
> +	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
> +	       drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
> +
> +	/* clear error counter registers */
> +	if (cnt_sbe)
> +		writel(0, drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
> +	if (cnt_dbe)
> +		writel(0, drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
> +
> +	if (!cnt_sbe && !cnt_dbe)
> +		return;
> +
> +	if ((addr & SDRAM_ERR_ADDR_TYPE_MASK) == 0) {
> +		if (cnt_sbe)
> +			cnt_sbe--;
> +		else
> +			dev_warn(mci->pdev, "inconsistent SBE count detected");
> +	} else {
> +		if (cnt_dbe)
> +			cnt_dbe--;
> +		else
> +			dev_warn(mci->pdev, "inconsistent DBE count detected");
> +	}
> +
> +	/* report earlier errors */
> +	if (cnt_sbe)
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +				     cnt_sbe, /* error count */
> +				     0, 0, 0, /* pfn, offset, syndrome */
> +				     -1, -1, -1, /* top, mid, low layer */
> +				     mci->ctl_name,
> +				     "details unavailable (multiple errors)");
> +	if (cnt_dbe)
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +				     cnt_sbe, /* error count */
> +				     0, 0, 0, /* pfn, offset, syndrome */
> +				     -1, -1, -1, /* top, mid, low layer */
> +				     mci->ctl_name,
> +				     "details unavailable (multiple errors)");
> +
> +	/* report details for most recent error */
> +	cs_val = (addr & SDRAM_ERR_ADDR_CS_MASK)
> +	    >> SDRAM_ERR_ADDR_CS_OFFSET;
> +	bank_val = (addr & SDRAM_ERR_ADDR_BANK_MASK)
> +	    >> SDRAM_ERR_ADDR_BANK_OFFSET;
> +	row_val = (calc_ecc & SDRAM_ERR_CALC_ECC_ROW_MASK)
> +	    >> SDRAM_ERR_CALC_ECC_ROW_OFFSET;
> +	col_val = (addr & SDRAM_ERR_ADDR_COL_MASK)
> +	    >> SDRAM_ERR_ADDR_COL_OFFSET;
> +	syndrome_val = (recv_ecc ^ calc_ecc) & 0xff;
> +	addr_val = armada_xp_mc_edac_calc_address(drvdata, cs_val, bank_val,
> +						  row_val, col_val);
> +	msg += sprintf(msg, "row=0x%04x ", row_val); /* 11 chars */
> +	msg += sprintf(msg, "bank=0x%x ", bank_val); /*  9 chars */
> +	msg += sprintf(msg, "col=0x%04x ", col_val); /* 11 chars */
> +	msg += sprintf(msg, "cs=%d", cs_val);	     /*  4 chars */
> +
> +	if ((addr & SDRAM_ERR_ADDR_TYPE_MASK) == 0) {
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +				     1,	/* error count */
> +				     addr_val >> PAGE_SHIFT,
> +				     addr_val & ~PAGE_MASK,
> +				     syndrome_val,
> +				     cs_val, -1, -1, /* top, mid, low layer */
> +				     mci->ctl_name, drvdata->msg);
> +	} else {
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +				     1,	/* error count */
> +				     addr_val >> PAGE_SHIFT,
> +				     addr_val & ~PAGE_MASK,
> +				     syndrome_val,
> +				     cs_val, -1, -1, /* top, mid, low layer */
> +				     mci->ctl_name, drvdata->msg);
> +	}
> +}
> +
> +static int armada_xp_mc_edac_read_config(struct mem_ctl_info *mci)
> +{
> +	struct armada_xp_mc_edac_drvdata *drvdata = mci->pvt_info;
> +	struct dimm_info *dimm;
> +	unsigned int i, cs_struct, cs_size;
> +	uint32_t config, addr_ctrl, rank_ctrl;
> +
> +	config = readl(drvdata->base + SDRAM_CONFIG_REG);
> +	if (!(config & SDRAM_CONFIG_ECC_MASK))
> +		dev_warn(mci->pdev, "SDRAM ECC is not enabled");
> +
> +	if (mci->tot_dimms != SDRAM_NUM_CS) {
> +		dev_err(mci->pdev, "Invaild number of DIMMs");
> +		return -EINVAL;
> +	}
> +
> +	if (config & SDRAM_CONFIG_BUS_WIDTH_MASK)
> +		drvdata->width = 4; /* 64 bit */
> +	else
> +		drvdata->width = 2; /* 32 bit */
> +
> +	addr_ctrl = readl(drvdata->base + SDRAM_ADDR_CTRL_REG);
> +	rank_ctrl = readl(drvdata->base + SDRAM_RANK_CTRL_REG);
> +	for (i = 0; i < SDRAM_NUM_CS; i++) {
> +		dimm = mci->dimms[i];
> +
> +		if (!(rank_ctrl & SDRAM_RANK_CTRL_EXIST_MASK(i)))
> +			continue;
> +
> +		drvdata->cs_addr_sel[i] =
> +			!!(addr_ctrl & SDRAM_ADDR_CTRL_ADDR_SEL_MASK(i));
> +
> +		cs_struct = (addr_ctrl & SDRAM_ADDR_CTRL_STRUCT_MASK(i)) >>
> +			SDRAM_ADDR_CTRL_STRUCT_OFFSET(i);
> +		cs_size = ((addr_ctrl & SDRAM_ADDR_CTRL_SIZE_HIGH_MASK(i)) >>
> +			   (SDRAM_ADDR_CTRL_SIZE_HIGH_OFFSET(i) - 2) |
> +			   ((addr_ctrl & SDRAM_ADDR_CTRL_SIZE_LOW_MASK(i)) >>
> +			    SDRAM_ADDR_CTRL_SIZE_LOW_OFFSET(i)));
> +		switch (cs_size) {
> +		case 0: /* 2GBit */
> +			dimm->nr_pages = (0x80000000ULL >> PAGE_SHIFT);
> +			break;
> +		case 1: /* 256MBit */
> +			dimm->nr_pages = (0x10000000ULL >> PAGE_SHIFT);
> +			break;
> +		case 2: /* 512MBit */
> +			dimm->nr_pages = (0x20000000ULL >> PAGE_SHIFT);
> +			break;
> +		case 3: /* 1GBit */
> +			dimm->nr_pages = (0x40000000ULL >> PAGE_SHIFT);
> +			break;
> +		case 4: /* 4GBit */
> +			dimm->nr_pages = (0x100000000ULL >> PAGE_SHIFT);
> +			break;
> +		case 5: /* 8GBit */
> +			dimm->nr_pages = (0x200000000ULL >> PAGE_SHIFT);
> +			break;
> +		}
> +		dimm->grain = 8;
> +		dimm->dtype = cs_struct ? DEV_X16 : DEV_X8;
> +		dimm->mtype = (config & SDRAM_CONFIG_REGISTERED_MASK) ?
> +			MEM_RDDR3 : MEM_DDR3;
> +		dimm->edac_mode = EDAC_SECDED;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id armada_xp_mc_edac_of_match[] = {
> +	{.compatible = "marvell,armada-xp-sdram-controller",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, armada_xp_mc_edac_of_match);
> +
> +static int armada_xp_mc_edac_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *id;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[1];
> +	struct armada_xp_mc_edac_drvdata *drvdata;
> +	struct resource *r;
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = SDRAM_NUM_CS;
> +	layers[0].is_virt_csrow = true;
> +
> +	mci = devm_edac_mc_alloc(&pdev->dev, 0, ARRAY_SIZE(layers), layers,
> +				 sizeof(*drvdata));
> +	if (!mci)
> +		return -ENOMEM;
> +
> +	drvdata = mci->pvt_info;
> +	mci->pdev = &pdev->dev;
> +	platform_set_drvdata(pdev, mci);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		dev_err(&pdev->dev, "Unable to get mem resource\n");
> +		return -ENODEV;
> +	}
> +
> +	drvdata->base = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(drvdata->base)) {
> +		dev_err(&pdev->dev, "Unable to map regs\n");
> +		return PTR_ERR(drvdata->base);
> +	}
> +
> +	id = of_match_device(armada_xp_mc_edac_of_match, &pdev->dev);
> +	mci->edac_check = armada_xp_mc_edac_check;
> +	mci->mtype_cap = MEM_FLAG_DDR3;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->mod_name = pdev->dev.driver->name;
> +	mci->ctl_name = id ? id->compatible : "unknown";
> +	mci->dev_name = dev_name(&pdev->dev);
> +	mci->scrub_mode = SCRUB_NONE;
> +
> +	if (armada_xp_mc_edac_read_config(mci))
> +		return -EINVAL;
> +
> +	/* configure SBE threshold */
> +	/* it seems that SBEs are not captured otherwise */
> +	writel(1 << SDRAM_ERR_CTRL_ERR_THR_OFFSET,
> +	       drvdata->base + SDRAM_ERR_CTRL_REG);
> +
> +	/* clear cause registers */
> +	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
> +	       drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
> +	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
> +	       drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
> +
> +	/* clear counter registers */
> +	writel(0, drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
> +	writel(0, drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
> +
> +	if (devm_edac_mc_add_mc(&pdev->dev, mci))
> +		return -EINVAL;
> +	edac_op_state = EDAC_OPSTATE_POLL;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver armada_xp_mc_edac_driver = {
> +	.probe = armada_xp_mc_edac_probe,
> +	.driver = {
> +		.name = "armada_xp_mc_edac",
> +		.of_match_table = of_match_ptr(armada_xp_mc_edac_of_match),
> +	},
> +};
> +
> +/************************ EDAC Device (L2 Cache) ***************************/
> +
> +struct aurora_l2_edac_drvdata {
> +	void __iomem *base;
> +
> +	char msg[128];
> +
> +	/* error injection via debugfs */
> +	uint32_t inject_addr;
> +	uint32_t inject_mask;
> +	uint8_t inject_ctl;
> +
> +	struct dentry *debugfs;
> +};
> +
> +static void aurora_l2_edac_inject(struct aurora_l2_edac_drvdata *drvdata)
> +{
> +	drvdata->inject_addr &= AURORA_ERR_INJECT_CTL_ADDR_MASK;
> +	drvdata->inject_ctl &= AURORA_ERR_INJECT_CTL_EN_MASK;
> +	writel(0, drvdata->base + AURORA_ERR_INJECT_CTL_REG);
> +	writel(drvdata->inject_mask,
> +	       drvdata->base + AURORA_ERR_INJECT_MASK_REG);
> +	writel(drvdata->inject_addr | drvdata->inject_ctl,
> +	       drvdata->base + AURORA_ERR_INJECT_CTL_REG);
> +}
> +
> +static void aurora_l2_edac_check(struct edac_device_ctl_info *dci)
> +{
> +	struct aurora_l2_edac_drvdata *drvdata = dci->pvt_info;
> +	uint32_t cnt, attr_cap, addr_cap, way_cap;
> +	unsigned int cnt_ce, cnt_ue;
> +
> +	cnt = readl(drvdata->base + AURORA_ERR_CNT_REG);
> +	attr_cap = readl(drvdata->base + AURORA_ERR_ATTR_CAP_REG);
> +	addr_cap = readl(drvdata->base + AURORA_ERR_ADDR_CAP_REG);
> +	way_cap = readl(drvdata->base + AURORA_ERR_WAY_CAP_REG);
> +
> +	cnt_ce = (cnt & AURORA_ERR_CNT_CE_MASK) >> AURORA_ERR_CNT_CE_OFFSET;
> +	cnt_ue = (cnt & AURORA_ERR_CNT_UE_MASK) >> AURORA_ERR_CNT_UE_OFFSET;
> +	/* clear error counter registers */
> +	if (cnt_ce || cnt_ue)
> +		writel(AURORA_ERR_CNT_CLR, drvdata->base + AURORA_ERR_CNT_REG);
> +
> +	if (attr_cap & AURORA_ERR_ATTR_CAP_VALID) {
> +		char *msg = drvdata->msg;
> +		size_t size = sizeof(drvdata->msg);
> +		size_t len = 0;
> +
> +		switch ((attr_cap & AURORA_ERR_ATTR_CAP_ERR_SOURCE_MASK)
> +			>> AURORA_ERR_ATTR_CAP_ERR_SOURCE_OFFSET) {
> +		case 0:
> +			len += snprintf(msg+len, size-len, "src=CPU0 ");
> +			break;
> +		case 1:
> +			len += snprintf(msg+len, size-len, "src=CPU1 ");
> +			break;
> +		case 2:
> +			len += snprintf(msg+len, size-len, "src=CPU2 ");
> +			break;
> +		case 3:
> +			len += snprintf(msg+len, size-len, "src=CPU3 ");
> +			break;
> +		case 7:
> +			len += snprintf(msg+len, size-len, "src=IO ");
> +			break;
> +		}
> +		switch ((attr_cap & AURORA_ERR_ATTR_CAP_TRANS_TYPE_MASK)
> +			>> AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET) {
> +		case 0:
> +			len += snprintf(msg+len, size-len, "txn=Data-Read ");
> +			break;
> +		case 1:
> +			len += snprintf(msg+len, size-len, "txn=Isn-Read ");
> +			break;
> +		case 2:
> +			len += snprintf(msg+len, size-len, "txn=Clean-Flush ");
> +			break;
> +		case 3:
> +			len += snprintf(msg+len, size-len, "txn=Eviction ");
> +			break;
> +		case 4:
> +			len += snprintf(msg+len, size-len,
> +					"txn=Read-Modify-Write ");
> +			break;
> +		}
> +		switch ((attr_cap & AURORA_ERR_ATTR_CAP_ERR_TYPE_MASK)
> +			>> AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET) {
> +		case 0:
> +			len += snprintf(msg+len, size-len, "err=CorrECC ");
> +			break;
> +		case 1:
> +			len += snprintf(msg+len, size-len, "err=UnCorrECC ");
> +			break;
> +		case 2:
> +			len += snprintf(msg+len, size-len, "err=TagParity ");
> +			break;
> +		}
> +		len += snprintf(msg+len, size-len, "addr=0x%x ",
> +			    addr_cap & AURORA_ERR_ADDR_CAP_ADDR_MASK);
> +		len += snprintf(msg+len, size-len, "index=0x%x ",
> +			    (way_cap & AURORA_ERR_WAY_CAP_INDEX_MASK)
> +			    >> AURORA_ERR_WAY_CAP_INDEX_OFFSET);
> +		len += snprintf(msg+len, size-len, "way=0x%x",
> +			    (way_cap & AURORA_ERR_WAY_CAP_WAY_MASK)
> +			    >> AURORA_ERR_WAY_CAP_WAY_OFFSET);
> +		/* clear error capture registers */
> +		writel(AURORA_ERR_ATTR_CAP_VALID,
> +		       drvdata->base + AURORA_ERR_ATTR_CAP_REG);
> +		if ((attr_cap & AURORA_ERR_ATTR_CAP_ERR_TYPE_MASK)
> +		    >> AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET) {
> +			/* UnCorrECC or TagParity */
> +			if (cnt_ue)
> +				cnt_ue--;
> +			edac_device_handle_ue(dci, 0, 0, drvdata->msg);
> +		} else {
> +			if (cnt_ce)
> +				cnt_ce--;
> +			edac_device_handle_ce(dci, 0, 0, drvdata->msg);
> +		}
> +	}
> +
> +	/* report remaining errors */
> +	while (cnt_ue--)
> +		edac_device_handle_ue(dci, 0, 0,
> +				      "details unavailable (multiple errors)");
> +	while (cnt_ce--)
> +		edac_device_handle_ue(dci, 0, 0,
> +				      "details unavailable (multiple errors)");
> +}
> +
> +static void aurora_l2_edac_poll(struct edac_device_ctl_info *dci)
> +{
> +	struct aurora_l2_edac_drvdata *drvdata = dci->pvt_info;
> +
> +	aurora_l2_edac_check(dci);
> +	aurora_l2_edac_inject(drvdata);
> +}
> +
> +static const struct of_device_id aurora_l2_edac_of_match[] = {
> +	{.compatible = "marvell,aurora-system-cache",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, aurora_l2_edac_of_match);
> +
> +static int aurora_l2_edac_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *id;
> +	struct edac_device_ctl_info *dci;
> +	struct aurora_l2_edac_drvdata *drvdata;
> +	struct resource *r;
> +	uint32_t l2x0_aux_ctrl;
> +
> +	dci = devm_edac_device_alloc_ctl_info(&pdev->dev, sizeof(*drvdata),
> +					      "cpu", 1, "L", 1, 2, NULL, 0, 0);
> +	if (!dci)
> +		return -ENOMEM;
> +
> +	drvdata = dci->pvt_info;
> +	dci->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, dci);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		dev_err(&pdev->dev, "Unable to get mem resource\n");
> +		return -ENODEV;
> +	}
> +
> +	drvdata->base = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(drvdata->base)) {
> +		dev_err(&pdev->dev, "Unable to map regs\n");
> +		return PTR_ERR(drvdata->base);
> +	}
> +
> +	l2x0_aux_ctrl = readl(drvdata->base + L2X0_AUX_CTRL);
> +	if (!(l2x0_aux_ctrl & AURORA_ACR_PARITY_EN))
> +		dev_warn(&pdev->dev, "tag parity is not enabled");
> +	if (!(l2x0_aux_ctrl & AURORA_ACR_ECC_EN))
> +		dev_warn(&pdev->dev, "data ECC is not enabled");
> +
> +	id = of_match_device(aurora_l2_edac_of_match, &pdev->dev);
> +	dci->edac_check = aurora_l2_edac_poll;
> +	dci->mod_name = pdev->dev.driver->name;
> +	dci->ctl_name = id ? id->compatible : "unknown";
> +	dci->dev_name = dev_name(&pdev->dev);
> +
> +	/* clear registers */
> +	writel(AURORA_ERR_CNT_CLR, drvdata->base + AURORA_ERR_CNT_REG);
> +	writel(AURORA_ERR_ATTR_CAP_VALID,
> +	       drvdata->base + AURORA_ERR_ATTR_CAP_REG);
> +
> +	if (devm_edac_device_add_device(&pdev->dev, dci))
> +		return -EINVAL;
> +
> +	drvdata->debugfs = edac_debugfs_create_dir(dev_name(&pdev->dev));
> +	if (drvdata->debugfs) {
> +		edac_debugfs_create_x32("inject_addr", 0644,
> +					drvdata->debugfs,
> +					&drvdata->inject_addr);
> +		edac_debugfs_create_x32("inject_mask", 0644,
> +					drvdata->debugfs,
> +					&drvdata->inject_mask);
> +		edac_debugfs_create_x8("inject_ctl", 0644,
> +				       drvdata->debugfs, &drvdata->inject_ctl);
> +	}
> +
> +	return 0;
> +}
> +
> +static int aurora_l2_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
> +	struct aurora_l2_edac_drvdata *drvdata = dci->pvt_info;
> +
> +	edac_debugfs_remove_recursive(drvdata->debugfs);
> +	return 0;
> +}
> +
> +static struct platform_driver aurora_l2_edac_driver = {
> +	.probe = aurora_l2_edac_probe,
> +	.remove = aurora_l2_edac_remove,
> +	.driver = {
> +		.name = "aurora_l2_edac",
> +		.of_match_table = of_match_ptr(aurora_l2_edac_of_match),
> +	},
> +};
> +
> +/************************ Driver registration ******************************/
> +
> +static struct platform_driver * const drivers[] = {
> +	&armada_xp_mc_edac_driver,
> +	&aurora_l2_edac_driver,
> +};
> +
> +static int __init armada_xp_edac_init(void)
> +{
> +	int res = 0;
> +
> +	/* only polling is supported */
> +	edac_op_state = EDAC_OPSTATE_POLL;
> +
> +	res = platform_register_drivers(drivers, ARRAY_SIZE(drivers));
> +	if (res)
> +		pr_warn("Aramda XP EDAC drivers fail to register\n");
> +
> +	return 0;
> +}
> +module_init(armada_xp_edac_init);
> +
> +static void __exit armada_xp_edac_exit(void)
> +{
> +	platform_unregister_drivers(drivers, ARRAY_SIZE(drivers));
> +}
> +module_exit(armada_xp_edac_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Pengutronix");
> +MODULE_DESCRIPTION("EDAC Drivers for Marvell Armada XP SDRAM and L2 Cache Controller");
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
