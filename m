From: architt@codeaurora.org (Archit Taneja)
Date: Thu, 21 May 2015 14:02:10 +0530
Subject: [Patch v6 2/2] dmaengine: Add ADM driver
In-Reply-To: <1426571172-9711-3-git-send-email-agross@codeaurora.org>
References: <1426571172-9711-1-git-send-email-agross@codeaurora.org>
 <1426571172-9711-3-git-send-email-agross@codeaurora.org>
Message-ID: <555D980A.7030109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/17/2015 11:16 AM, Andy Gross wrote:
> Add the DMA engine driver for the QCOM Application Data Mover (ADM) DMA
> controller found in the MSM8x60 and IPQ/APQ8064 platforms.
>
> The ADM supports both memory to memory transactions and memory
> to/from peripheral device transactions.  The controller also provides flow
> control capabilities for transactions to/from peripheral devices.
>
> The initial release of this driver supports slave transfers to/from peripherals
> and also incorporates CRCI (client rate control interface) flow control.
>
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> ---
>   drivers/dma/Kconfig    |   10 +
>   drivers/dma/Makefile   |    1 +
>   drivers/dma/qcom_adm.c |  900 ++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 911 insertions(+)
>   create mode 100644 drivers/dma/qcom_adm.c
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index a874b6e..6919013 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -473,4 +473,14 @@ config QCOM_BAM_DMA
>   	  Enable support for the QCOM BAM DMA controller.  This controller
>   	  provides DMA capabilities for a variety of on-chip devices.
>
> +config QCOM_ADM
> +	tristate "Qualcomm ADM support"
> +	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	---help---
> +	  Enable support for the Qualcomm ADM DMA controller.  This controller
> +	  provides DMA capabilities for both general purpose and on-chip
> +	  peripheral devices.
> +
>   endif
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index f915f61..7f0fbe6 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -51,3 +51,4 @@ obj-$(CONFIG_INTEL_MIC_X100_DMA) += mic_x100_dma.o
>   obj-$(CONFIG_NBPFAXI_DMA) += nbpfaxi.o
>   obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
>   obj-$(CONFIG_IMG_MDC_DMA) += img-mdc-dma.o
> +obj-$(CONFIG_QCOM_ADM) += qcom_adm.o
> diff --git a/drivers/dma/qcom_adm.c b/drivers/dma/qcom_adm.c
> new file mode 100644
> index 0000000..7f8c119
> --- /dev/null
> +++ b/drivers/dma/qcom_adm.c
> @@ -0,0 +1,900 @@
> +/*
> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/scatterlist.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_dma.h>
> +#include <linux/reset.h>
> +#include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +
> +#include "dmaengine.h"
> +#include "virt-dma.h"
> +
> +/* ADM registers - calculated from channel number and security domain */
> +#define ADM_CHAN_MULTI			0x4
> +#define ADM_CI_MULTI			0x4
> +#define ADM_CRCI_MULTI			0x4
> +#define ADM_EE_MULTI			0x800
> +#define ADM_CHAN_OFFS(chan)		(ADM_CHAN_MULTI * chan)
> +#define ADM_EE_OFFS(ee)			(ADM_EE_MULTI * ee)
> +#define ADM_CHAN_EE_OFFS(chan, ee)	(ADM_CHAN_OFFS(chan) + ADM_EE_OFFS(ee))
> +#define ADM_CHAN_OFFS(chan)		(ADM_CHAN_MULTI * chan)
> +#define ADM_CI_OFFS(ci)			(ADM_CHAN_OFF(ci))
> +#define ADM_CH_CMD_PTR(chan, ee)	(ADM_CHAN_EE_OFFS(chan, ee))
> +#define ADM_CH_RSLT(chan, ee)		(0x40 + ADM_CHAN_EE_OFFS(chan, ee))
> +#define ADM_CH_FLUSH_STATE0(chan, ee)	(0x80 + ADM_CHAN_EE_OFFS(chan, ee))
> +#define ADM_CH_STATUS_SD(chan, ee)	(0x200 + ADM_CHAN_EE_OFFS(chan, ee))
> +#define ADM_CH_CONF(chan)		(0x240 + ADM_CHAN_OFFS(chan))
> +#define ADM_CH_RSLT_CONF(chan, ee)	(0x300 + ADM_CHAN_EE_OFFS(chan, ee))
> +#define ADM_SEC_DOMAIN_IRQ_STATUS(ee)	(0x380 + ADM_EE_OFFS(ee))
> +#define ADM_CI_CONF(ci)			(0x390 + ci * ADM_CI_MULTI)
> +#define ADM_GP_CTL			0x3d8
> +#define ADM_CRCI_CTL(crci, ee)		(0x400 + crci * ADM_CRCI_MULTI + \
> +						ADM_EE_OFFS(ee))
> +
> +/* channel status */
> +#define ADM_CH_STATUS_VALID	BIT(1)
> +
> +/* channel result */
> +#define ADM_CH_RSLT_VALID	BIT(31)
> +#define ADM_CH_RSLT_ERR		BIT(3)
> +#define ADM_CH_RSLT_FLUSH	BIT(2)
> +#define ADM_CH_RSLT_TPD		BIT(1)
> +
> +/* channel conf */
> +#define ADM_CH_CONF_SHADOW_EN		BIT(12)
> +#define ADM_CH_CONF_MPU_DISABLE		BIT(11)
> +#define ADM_CH_CONF_PERM_MPU_CONF	BIT(9)
> +#define ADM_CH_CONF_FORCE_RSLT_EN	BIT(7)
> +#define ADM_CH_CONF_SEC_DOMAIN(ee)	(((ee & 0x3) << 4) | ((ee & 0x4) << 11))
> +
> +/* channel result conf */
> +#define ADM_CH_RSLT_CONF_FLUSH_EN	BIT(1)
> +#define ADM_CH_RSLT_CONF_IRQ_EN		BIT(0)
> +
> +/* CRCI CTL */
> +#define ADM_CRCI_CTL_MUX_SEL	BIT(18)
> +#define ADM_CRCI_CTL_RST	BIT(17)
> +
> +/* CI configuration */
> +#define ADM_CI_RANGE_END(x)	(x << 24)
> +#define ADM_CI_RANGE_START(x)	(x << 16)
> +#define ADM_CI_BURST_4_WORDS	BIT(2)
> +#define ADM_CI_BURST_8_WORDS	BIT(3)
> +
> +/* GP CTL */
> +#define ADM_GP_CTL_LP_EN	BIT(12)
> +#define ADM_GP_CTL_LP_CNT(x)	(x << 8)
> +
> +/* Command pointer list entry */
> +#define ADM_CPLE_LP		BIT(31)
> +#define ADM_CPLE_CMD_PTR_LIST	BIT(29)
> +
> +/* Command list entry */
> +#define ADM_CMD_LC		BIT(31)
> +#define ADM_CMD_DST_CRCI(n)	(((n) & 0xf) << 7)
> +#define ADM_CMD_SRC_CRCI(n)	(((n) & 0xf) << 3)
> +
> +#define ADM_CMD_TYPE_SINGLE	0x0
> +#define ADM_CMD_TYPE_BOX	0x3
> +
> +#define ADM_CRCI_MUX_SEL	BIT(4)
> +#define ADM_DESC_ALIGN		8
> +#define ADM_MAX_XFER		(SZ_64K-1)
> +#define ADM_MAX_ROWS		(SZ_64K-1)
> +#define ADM_MAX_CHANNELS	16
> +
> +struct adm_desc_hw_box {
> +	u32 cmd;
> +	u32 src_addr;
> +	u32 dst_addr;
> +	u32 row_len;
> +	u32 num_rows;
> +	u32 row_offset;
> +};
> +
> +struct adm_desc_hw_single {
> +	u32 cmd;
> +	u32 src_addr;
> +	u32 dst_addr;
> +	u32 len;
> +};
> +
> +struct adm_async_desc {
> +	struct virt_dma_desc vd;
> +	struct adm_device *adev;
> +
> +	size_t length;
> +	enum dma_transfer_direction dir;
> +	dma_addr_t dma_addr;
> +	size_t dma_len;
> +
> +	void *cpl;
> +	dma_addr_t cp_addr;
> +	u32 crci;
> +	u32 mux;
> +	u32 blk_size;
> +};
> +
> +struct adm_chan {
> +	struct virt_dma_chan vc;
> +	struct adm_device *adev;
> +
> +	/* parsed from DT */
> +	u32 id;			/* channel id */
> +
> +	struct adm_async_desc *curr_txd;
> +	struct dma_slave_config slave;
> +	struct list_head node;
> +
> +	int error;
> +	int initialized;
> +};
> +
> +static inline struct adm_chan *to_adm_chan(struct dma_chan *common)
> +{
> +	return container_of(common, struct adm_chan, vc.chan);
> +}
> +
> +struct adm_device {
> +	void __iomem *regs;
> +	struct device *dev;
> +	struct dma_device common;
> +	struct device_dma_parameters dma_parms;
> +	struct adm_chan *channels;
> +
> +	u32 ee;
> +
> +	struct clk *core_clk;
> +	struct clk *iface_clk;
> +
> +	struct reset_control *clk_reset;
> +	struct reset_control *c0_reset;
> +	struct reset_control *c1_reset;
> +	struct reset_control *c2_reset;
> +	int irq;
> +};
> +
> +/**
> + * adm_free_chan - Frees dma resources associated with the specific channel
> + *
> + * Free all allocated descriptors associated with this channel
> + *
> + */
> +static void adm_free_chan(struct dma_chan *chan)
> +{
> +	/* free all queued descriptors */
> +	vchan_free_chan_resources(to_virt_chan(chan));
> +}
> +
> +/**
> + * adm_get_blksize - Get block size from burst value
> + *
> + */
> +static int adm_get_blksize(unsigned int burst)
> +{
> +	int ret;
> +
> +	switch (burst) {
> +	case 16:
> +	case 32:
> +	case 64:
> +	case 128:
> +		ret = ffs(burst>>4) - 1;
> +		break;
> +	case 192:
> +		ret = 4;
> +		break;
> +	case 256:
> +		ret = 5;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * adm_process_fc_descriptors - Process descriptors for flow controlled xfers
> + *
> + * @achan: ADM channel
> + * @desc: Descriptor memory pointer
> + * @sg: Scatterlist entry
> + * @crci: CRCI value
> + * @burst: Burst size of transaction
> + * @direction: DMA transfer direction
> + */
> +static void *adm_process_fc_descriptors(struct adm_chan *achan,
> +	void *desc, struct scatterlist *sg, u32 crci, u32 burst,
> +	enum dma_transfer_direction direction)
> +{
> +	struct adm_desc_hw_box *box_desc;
> +	struct adm_desc_hw_single *single_desc;
> +	u32 remainder = sg_dma_len(sg);
> +	u32 rows, row_offset, crci_cmd;
> +	u32 mem_addr = sg_dma_address(sg);
> +	u32 *incr_addr = &mem_addr;
> +	u32 *src, *dst;
> +
> +	if (direction == DMA_DEV_TO_MEM) {
> +		crci_cmd = ADM_CMD_SRC_CRCI(crci);
> +		row_offset = burst;
> +		src = &achan->slave.src_addr;
> +		dst = &mem_addr;
> +	} else {
> +		crci_cmd = ADM_CMD_DST_CRCI(crci);
> +		row_offset = burst << 16;
> +		src = &mem_addr;
> +		dst = &achan->slave.dst_addr;
> +	}
> +
> +	do {
> +		box_desc = desc;
> +		box_desc->cmd = ADM_CMD_TYPE_BOX | crci_cmd;
> +		box_desc->row_offset = row_offset;
> +		box_desc->src_addr = *src;
> +		box_desc->dst_addr = *dst;
> +
> +		rows = remainder / burst;
> +		rows = min_t(u32, rows, ADM_MAX_ROWS);
> +		box_desc->num_rows = rows << 16 | rows;
> +		box_desc->row_len = burst << 16 | burst;
> +
> +		*incr_addr += burst * rows;
> +		remainder -= burst * rows;
> +		desc += sizeof(*box_desc);
> +	} while (remainder >= burst);

The piece of code doesn't work if sg length is less than burst size. The 
rows would come out as 0, incr_addr and remainder won't change. But the 
desc pointer would be still incremented.

The ADM hardware will see a corrupt box descriptor, followed by a single 
descriptor in the case of sg length < burst.

Other than this, patch looks good to me.

Thanks,
Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
