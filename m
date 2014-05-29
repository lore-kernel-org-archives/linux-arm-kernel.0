From: josh.wu@atmel.com (Josh Wu)
Date: Thu, 29 May 2014 18:04:10 +0800
Subject: [RFC PATCH] dma: at_xdmac: creation of the atmel eXtended DMA
 Controller driver
In-Reply-To: <1401179736-8235-1-git-send-email-ludovic.desroches@atmel.com>
References: <1401179736-8235-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <5387061A.50306@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ludovic

Check the comments in below:

On 5/27/2014 4:35 PM, Ludovic Desroches wrote:
> Introduction of a new atmel DMA controller known as xdmac.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>
> Hi,
>
> All comments are welcomed to improve this driver!
>
> Thanks
>
>   .../devicetree/bindings/dma/atmel-xdma.txt         |   44 +
>   drivers/dma/Kconfig                                |    7 +
>   drivers/dma/Makefile                               |    1 +
>   drivers/dma/at_xdmac.c                             | 1053 ++++++++++++++++++++
>   drivers/dma/at_xdmac.h                             |  257 +++++
>   include/dt-bindings/dma/at91.h                     |   46 +
>   6 files changed, 1408 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dma/atmel-xdma.txt
>   create mode 100644 drivers/dma/at_xdmac.c
>   create mode 100644 drivers/dma/at_xdmac.h
[snip]
>
> +
> +static int __init at_xdmac_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct at_xdmac	*atxdmac;
> +	int irq, size, nr_channels, i, ret;
> +	void __iomem	*base;
> +	u32 reg;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	/*
> +	 * Read number of xdmac channels, read helper function can't be used
> +	 * since atxdmac is not yet allocated and we need to know the number
> +	 * of channels to do the allocation.
> +	 */
> +	reg = __raw_readl(base + AT_XDMAC_GTYPE);

readl_relaxed() is better.

> +	nr_channels = AT_XDMAC_NB_CH(reg);
> +	if (nr_channels > AT_XDMAC_MAX_CHAN) {
> +		dev_err(&pdev->dev, "invalid number of channels (%u)\n",
> +			nr_channels);
> +		return -EINVAL;
> +	}
> +
> +	size = sizeof(*atxdmac);
> +	size += nr_channels * sizeof(struct at_xdmac_chan);
> +	atxdmac = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +	if (!atxdmac) {
> +		dev_err(&pdev->dev, "can't allocate at_xdmac structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	atxdmac->regs = base;
> +
> +	ret = devm_request_irq(&pdev->dev, irq, at_xdmac_interrupt, 0,
> +			       "at_xdmac", atxdmac);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't request irq\n");
> +		return ret;
> +	}
> +
> +	atxdmac->clk = devm_clk_get(&pdev->dev, "dma_clk");
> +	if (IS_ERR(atxdmac->clk)) {
> +		dev_err(&pdev->dev, "can't get dma_clk\n");
> +		return PTR_ERR(atxdmac->clk);
> +	}
> +
> +	ret = clk_prepare_enable(atxdmac->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't prepare or enable clock\n");
> +		return ret;
> +	}
> +
> +	atxdmac->at_xdmac_desc_pool =
> +		dmam_pool_create(dev_name(&pdev->dev), &pdev->dev,
> +				sizeof(struct at_xdmac_desc), 4, 0);
> +	if (!atxdmac->at_xdmac_desc_pool) {
> +		dev_err(&pdev->dev, "no memory for descriptors dma pool\n");
> +		ret = -ENOMEM;
> +		goto err_clk_disable;
> +	}
> +
> +	dma_cap_set(DMA_CYCLIC, atxdmac->dma.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, atxdmac->dma.cap_mask);
> +	dma_cap_set(DMA_SLAVE, atxdmac->dma.cap_mask);
> +	atxdmac->dma.dev				= &pdev->dev;
> +	atxdmac->dma.device_alloc_chan_resources	= at_xdmac_alloc_chan_resources;
> +	atxdmac->dma.device_free_chan_resources		= at_xdmac_free_chan_resources;
> +	atxdmac->dma.device_tx_status			= at_xdmac_tx_status;
> +	atxdmac->dma.device_issue_pending		= at_xdmac_issue_pending;
> +	atxdmac->dma.device_prep_dma_cyclic		= at_xdmac_prep_dma_cyclic;
> +	atxdmac->dma.device_prep_dma_memcpy		= at_xdmac_prep_dma_memcpy;
> +	atxdmac->dma.device_prep_slave_sg		= at_xdmac_prep_slave_sg;
> +	atxdmac->dma.device_control			= at_xdmac_control;
> +	atxdmac->dma.chancnt				= nr_channels;
> +
> +	/* Disable all chans and interrupts. */
> +	at_xdmac_off(atxdmac);
> +
> +	/* Init channels. */
> +	INIT_LIST_HEAD(&atxdmac->dma.channels);
> +	for (i = 0; i < nr_channels; i++) {
> +		struct at_xdmac_chan *atchan = &atxdmac->chan[i];
> +
> +		atchan->chan.device = &atxdmac->dma;
> +		list_add_tail(&atchan->chan.device_node,
> +			      &atxdmac->dma.channels);
> +
> +		atchan->ch_regs = at_xdmac_chan_reg_base(atxdmac, i);
> +		atchan->mask = 1 << i;
> +
> +		spin_lock_init(&atchan->lock);
> +		INIT_LIST_HEAD(&atchan->xfers_list);
> +		INIT_LIST_HEAD(&atchan->free_descs_list);
> +		tasklet_init(&atchan->tasklet, at_xdmac_tasklet,
> +			     (unsigned long)atchan);
> +
> +		/* Clear pending interrupts. */
> +		while (at_xdmac_chan_read(atchan, AT_XDMAC_CIS))
> +			cpu_relax();
> +	}
> +	platform_set_drvdata(pdev, atxdmac);
> +
> +	ret = dma_async_device_register(&atxdmac->dma);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register DMA engine device\n");
> +		goto err_clk_disable;
> +	}
> +
> +	ret = of_dma_controller_register(pdev->dev.of_node,
> +					 at_xdmac_xlate, atxdmac);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not register of dma controller\n");
> +		goto err_dma_unregister;
> +	}
> +
> +	dev_info(&pdev->dev, "%d channels, mapped at 0x%p\n",
> +		 nr_channels, atxdmac->regs);
> +
> +	return 0;
> +
> +err_dma_unregister:
> +	dma_async_device_unregister(&atxdmac->dma);
> +err_clk_disable:
> +	clk_disable_unprepare(atxdmac->clk);
> +	return ret;
> +}
> +
> +static int at_xdmac_remove(struct platform_device *pdev)
> +{
> +	struct at_xdmac	*atxdmac = (struct at_xdmac *)platform_get_drvdata(pdev);
> +	int		i;
> +
> +	at_xdmac_off(atxdmac);
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&atxdmac->dma);
> +	clk_disable_unprepare(atxdmac->clk);
> +
> +	for (i = 0; i < atxdmac->dma.chancnt; i++) {
> +		struct at_xdmac_chan *atchan = &atxdmac->chan[i];
> +
> +		tasklet_kill(&atchan->tasklet);
> +		at_xdmac_free_chan_resources(&atchan->chan);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id atmel_xdmac_dt_ids[] = {
> +	{
> +		.compatible = "atmel,sama5d4-dma",
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, atmel_xdmac_dt_ids);
> +
> +static struct platform_driver at_xdmac_driver = {
> +	.probe		= at_xdmac_probe,

This line can be removed. Otherwise you will get section mismatch warning.

> +	.remove		= at_xdmac_remove,
> +	.driver = {
> +		.name		= "at_xdmac",
> +		.of_match_table	= of_match_ptr(atmel_xdmac_dt_ids),
> +	}
> +};
> +
> +static int __init at_xdmac_init(void)
> +{
> +	return platform_driver_probe(&at_xdmac_driver, at_xdmac_probe);
> +}
> +subsys_initcall(at_xdmac_init);
> +
> +MODULE_DESCRIPTION("Atmel Extended DMA Controller driver");
> +MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@atmel.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/dma/at_xdmac.h b/drivers/dma/at_xdmac.h
> new file mode 100644
> index 0000000..79e5ad8
> --- /dev/null
> +++ b/drivers/dma/at_xdmac.h
> @@ -0,0 +1,257 @@
> +#ifndef __AT_XDMAC_H__
> +#define __AT_XDMAC_H__
> +
> +#include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dmapool.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +
> +#include "dmaengine.h"
> +
> +/* Global registers */
> +#define AT_XDMAC_GTYPE		0x00	/* Global Type Register */
> +#define		AT_XDMAC_NB_CH(i)	(((i) & 0x1F) + 1)		/* Number of Channels Minus One */
> +#define		AT_XDMAC_FIFO_SZ(i)	(((i) >> 5) & 0x7FF)		/* Number of Bytes */
> +#define		AT_XDMAC_NB_REQ(i)	((((i) >> 16) & 0x3F) + 1)	/* Number of Peripheral Requests Minus One */
> +#define AT_XDMAC_GCFG		0x04	/* Global Configuration Register */
> +#define AT_XDMAC_GWAC		0x08	/* Global Weighted Arbiter Configuration Register */
> +#define AT_XDMAC_GIE		0x0C	/* Global Interrupt Enable Register */
> +#define AT_XDMAC_GID		0x10	/* Global Interrupt Disable Register */
> +#define AT_XDMAC_GIM		0x14	/* Global Interrupt Mask Register */
> +#define AT_XDMAC_GIS		0x18	/* Global Interrupt Status Register */
> +#define AT_XDMAC_GE		0x1C	/* Global Channel Enable Register */
> +#define AT_XDMAC_GD		0x20	/* Global Channel Disable Register */
> +#define AT_XDMAC_GS		0x24	/* Global Channel Status Register */
> +#define AT_XDMAC_GRS		0x28	/* Global Channel Read Suspend Register */
> +#define AT_XDMAC_GWS		0x2C	/* Global Write Suspend Register */
> +#define AT_XDMAC_GRWS		0x30	/* Global Channel Read Write Suspend Register */
> +#define AT_XDMAC_GRWR		0x34	/* Global Channel Read Write Resume Register */
> +#define AT_XDMAC_GSWR		0x38	/* Global Channel Software Request Register */
> +#define AT_XDMAC_GSWS		0x3C	/* Global channel Software Request Status Register */
> +#define AT_XDMAC_GSWF		0x40	/* Global Channel Software Flush Request Register */
> +#define AT_XDMAC_VERSION	0xFFC	/* XDMAC Version Register */
> +
> +/* Channel relative registers offsets */
> +#define AT_XDMAC_CIE		0x00	/* Channel Interrupt Enable Register */
> +#define		AT_XDMAC_CIE_BIE	(0x1 << 0)	/* End of Block Interrupt Enable Bit */
> +#define		AT_XDMAC_CIE_LIE	(0x1 << 1)	/* End of Linked List Interrupt Enable Bit */
> +#define		AT_XDMAC_CIE_DIE	(0x1 << 2)	/* End of Disable Interrupt Enable Bit */
> +#define		AT_XDMAC_CIE_FIE	(0x1 << 3)	/* End of Flush Interrupt Enable Bit */
> +#define		AT_XDMAC_CIE_RBEIE	(0x1 << 4)	/* Read Bus Error Interrupt Enable Bit */
> +#define		AT_XDMAC_CIE_WBEIE	(0x1 << 5)	/* Write Bus Error Interrupt Enable Bit */
> +#define		AT_XDMAC_CIE_ROIE	(0x1 << 6)	/* Request Overflow Interrupt Enable Bit */
> +#define AT_XDMAC_CID		0x04	/* Channel Interrupt Disable Register */
> +#define		AT_XDMAC_CID_BID	(0x1 << 0)	/* End of Block Interrupt Disable Bit */
> +#define		AT_XDMAC_CID_LID	(0x1 << 1)	/* End of Linked List Interrupt Disable Bit */
> +#define		AT_XDMAC_CID_DID	(0x1 << 2)	/* End of Disable Interrupt Disable Bit */
> +#define		AT_XDMAC_CID_FID	(0x1 << 3)	/* End of Flush Interrupt Disable Bit */
> +#define		AT_XDMAC_CID_RBEID	(0x1 << 4)	/* Read Bus Error Interrupt Disable Bit */
> +#define		AT_XDMAC_CID_WBEID	(0x1 << 5)	/* Write Bus Error Interrupt Disable Bit */
> +#define		AT_XDMAC_CID_ROID	(0x1 << 6)	/* Request Overflow Interrupt Disable Bit */
> +#define AT_XDMAC_CIM		0x08	/* Channel Interrupt Mask Register */
> +#define		AT_XDMAC_CIM_BIM	(0x1 << 0)	/* End of Block Interrupt Mask Bit */
> +#define		AT_XDMAC_CIM_LIM	(0x1 << 1)	/* End of Linked List Interrupt Mask Bit */
> +#define		AT_XDMAC_CIM_DIM	(0x1 << 2)	/* End of Disable Interrupt Mask Bit */
> +#define		AT_XDMAC_CIM_FIM	(0x1 << 3)	/* End of Flush Interrupt Mask Bit */
> +#define		AT_XDMAC_CIM_RBEIM	(0x1 << 4)	/* Read Bus Error Interrupt Mask Bit */
> +#define		AT_XDMAC_CIM_WBEIM	(0x1 << 5)	/* Write Bus Error Interrupt Mask Bit */
> +#define		AT_XDMAC_CIM_ROIM	(0x1 << 6)	/* Request Overflow Interrupt Mask Bit */
> +#define AT_XDMAC_CIS		0x0C	/* Channel Interrupt Status Register */
> +#define		AT_XDMAC_CIS_BIS	(0x1 << 0)	/* End of Block Interrupt Status Bit */
> +#define		AT_XDMAC_CIS_LIS	(0x1 << 1)	/* End of Linked List Interrupt Status Bit */
> +#define		AT_XDMAC_CIS_DIS	(0x1 << 2)	/* End of Disable Interrupt Status Bit */
> +#define		AT_XDMAC_CIS_FIS	(0x1 << 3)	/* End of Flush Interrupt Status Bit */
> +#define		AT_XDMAC_CIS_RBEIS	(0x1 << 4)	/* Read Bus Error Interrupt Status Bit */
> +#define		AT_XDMAC_CIS_WBEIS	(0x1 << 5)	/* Write Bus Error Interrupt Status Bit */
> +#define		AT_XDMAC_CIS_ROIS	(0x1 << 6)	/* Request Overflow Interrupt Status Bit */
> +#define AT_XDMAC_CSA		0x10	/* Channel Source Address Register */
> +#define AT_XDMAC_CDA		0x14	/* Channel Destination Address Register */
> +#define AT_XDMAC_CNDA		0x18	/* Channel Next Descriptor Address Register */
> +#define		AT_XDMAC_CNDA_NDAIF(i)	((i) & 0x1)			/* Channel x Next Descriptor Interface */
> +#define		AT_XDMAC_CNDA_NDA(i)	((i) & 0xfffffffc)		/* Channel x Next Descriptor Address */
> +#define AT_XDMAC_CNDC		0x1C	/* Channel Next Descriptor Control Register */
> +#define		AT_XDMAC_CNDC_NDE		(0x1 << 0)		/* Channel x Next Descriptor Enable */
> +#define		AT_XDMAC_CNDC_NDSUP		(0x1 << 1)		/* Channel x Next Descriptor Source Update */
> +#define		AT_XDMAC_CNDC_NDDUP		(0x1 << 2)		/* Channel x Next Descriptor Destination Update */
> +#define		AT_XDMAC_CNDC_NDVIEW_NDV0	(0x0 << 3)		/* Channel x Next Descriptor View 0 */
> +#define		AT_XDMAC_CNDC_NDVIEW_NDV1	(0x1 << 3)		/* Channel x Next Descriptor View 1 */
> +#define		AT_XDMAC_CNDC_NDVIEW_NDV2	(0x2 << 3)		/* Channel x Next Descriptor View 2 */
> +#define		AT_XDMAC_CNDC_NDVIEW_NDV3	(0x3 << 3)		/* Channel x Next Descriptor View 3 */
> +#define AT_XDMAC_CUBC		0x20	/* Channel Microblock Control Register */
> +#define AT_XDMAC_CBC		0x24	/* Channel Block Control Register */
> +#define AT_XDMAC_CC		0x28	/* Channel Configuration Register */
> +#define		AT_XDMAC_CC_TYPE	(0x1 << 0)	/* Channel Transfer Type */
> +#define			AT_XDMAC_CC_TYPE_MEM_TRAN	(0x0 << 0)	/* Memory to Memory Transfer */
> +#define			AT_XDMAC_CC_TYPE_PER_TRAN	(0x1 << 0)	/* Peripheral to Memory or Memory to Peripheral Transfer */
> +#define		AT_XDMAC_CC_MBSIZE_MASK	(0x3 << 1)
> +#define			AT_XDMAC_CC_MBSIZE_SINGLE	(0x0 << 1)
> +#define			AT_XDMAC_CC_MBSIZE_FOUR		(0x1 << 1)
> +#define			AT_XDMAC_CC_MBSIZE_EIGHT	(0x2 << 1)
> +#define			AT_XDMAC_CC_MBSIZE_SIXTEEN	(0x3 << 1)
> +#define		AT_XDMAC_CC_DSYNC	(0x1 << 4)	/* Channel Synchronization */
> +#define			AT_XDMAC_CC_DSYNC_PER2MEM	(0x0 << 4)
> +#define			AT_XDMAC_CC_DSYNC_MEM2PER	(0x1 << 4)
> +#define		AT_XDMAC_CC_PROT	(0x1 << 5)	/* Channel Protection */
> +#define			AT_XDMAC_CC_PROT_SEC		(0x0 << 5)
> +#define			AT_XDMAC_CC_PROT_UNSEC		(0x1 << 5)
> +#define		AT_XDMAC_CC_SWREQ	(0x1 << 6)	/* Channel Software Request Trigger */
> +#define			AT_XDMAC_CC_SWREQ_HWR_CONNECTED	(0x0 << 6)
> +#define			AT_XDMAC_CC_SWREQ_SWR_CONNECTED	(0x1 << 6)
> +#define		AT_XDMAC_CC_MEMSET	(0x1 << 7)	/* Channel Fill Block of memory */
> +#define			AT_XDMAC_CC_MEMSET_NORMAL_MODE	(0x0 << 7)
> +#define			AT_XDMAC_CC_MEMSET_HW_MODE	(0x1 << 7)
> +#define		AT_XDMAC_CC_CSIZE_MASK	(0x7 << 8)	/* Channel Chunk Size */
> +#define			AT_XDMAC_CC_CSIZE_CHK_1		(0x0 << 8)
> +#define			AT_XDMAC_CC_CSIZE_CHK_2		(0x1 << 8)
> +#define			AT_XDMAC_CC_CSIZE_CHK_4		(0x2 << 8)
> +#define			AT_XDMAC_CC_CSIZE_CHK_8		(0x3 << 8)
> +#define			AT_XDMAC_CC_CSIZE_CHK_16	(0x4 << 8)
> +#define		AT_XDMAC_CC_DWIDTH(i)	((i) << 11)	/* Channel Data Width */
> +#define			AT_XDMAC_CC_DWIDTH_BYTE		0x0
> +#define			AT_XDMAC_CC_DWIDTH_HALFWORD	0x1
> +#define			AT_XDMAC_CC_DWIDTH_WORD		0x2
> +#define			AT_XDMAC_CC_DWIDTH_DWORD	0x3
> +#define		AT_XDMAC_CC_SIF(i)	((0x1 & (i)) << 13)	/* Channel Source Interface Identifier */
> +#define		AT_XDMAC_CC_DIF(i)	((0x1 & (i)) << 14)	/* Channel Destination Interface Identifier */
> +#define		AT_XDMAC_CC_SAM_MASK	(0x3 << 16)	/* Channel Source Addressing Mode */
> +#define			AT_XDMAC_CC_SAM_FIXED_AM	(0x0 << 16)
> +#define			AT_XDMAC_CC_SAM_INCREMENTED_AM	(0x1 << 16)
> +#define			AT_XDMAC_CC_SAM_UBS_AM		(0x2 << 16)
> +#define			AT_XDMAC_CC_SAM_UBS_DS_AM	(0x3 << 16)
> +#define		AT_XDMAC_CC_DAM_MASK	(0x3 << 18)	/* Channel Source Addressing Mode */
> +#define			AT_XDMAC_CC_DAM_FIXED_AM	(0x0 << 18)
> +#define			AT_XDMAC_CC_DAM_INCREMENTED_AM	(0x1 << 18)
> +#define			AT_XDMAC_CC_DAM_UBS_AM		(0x2 << 18)
> +#define			AT_XDMAC_CC_DAM_UBS_DS_AM	(0x3 << 18)
> +#define		AT_XDMAC_CC_INITD	(0x1 << 21)	/* Channel Initialization Terminated (read only) */
> +#define			AT_XDMAC_CC_INITD_TERMINATED	(0x0 << 21)
> +#define			AT_XDMAC_CC_INITD_IN_PROGRESS	(0x1 << 21)
> +#define		AT_XDMAC_CC_RDIP	(0x1 << 22)	/* Read in Progress (read only) */
> +#define			AT_XDMAC_CC_RDIP_DONE		(0x0 << 22)
> +#define			AT_XDMAC_CC_RDIP_IN_PROGRESS	(0x1 << 22)
> +#define		AT_XDMAC_CC_WDIP	(0x1 << 23)	/* Write in Progress (read only) */
> +#define			AT_XDMAC_CC_WDIP_DONE		(0x0 << 23)
> +#define			AT_XDMAC_CC_WDIP_IN_PROGRESS	(0x1 << 23)
> +#define		AT_XDMAC_CC_PERID(i)	(0x7f & (h) << 24)	/* Channel Peripheral Identifier */
> +#define AT_XDMAC_CDS_MSP	0x2C	/* Channel Data Stride Memory Set Pattern */
> +#define AT_XDMAC_CSUS		0x30	/* Channel Source Microblock Stride */
> +#define AT_XDMAC_CDUS		0x34	/* Channel Destination Microblock Stride */
> +
> +#define AT_XDMAC_CHAN_REG_BASE	0x50	/* Channel registers base address */
> +
> +/* Microblock control members */
> +#define AT_XDMAC_MBR_UBC_UBLEN_MAX	0xFFFFFFUL	/* Maximum Microblock Length */
> +#define AT_XDMAC_MBR_UBC_NDE		(0x1 << 24)	/* Next Descriptor Enable */
> +#define AT_XDMAC_MBR_UBC_NSEN		(0x1 << 25)	/* Next Descriptor Source Update */
> +#define AT_XDMAC_MBR_UBC_NDEN		(0x1 << 26)	/* Next Descriptor Destination Update */
> +#define AT_XDMAC_MBR_UBC_NDV0		(0x0 << 27)	/* Next Descriptor View 0 */
> +#define AT_XDMAC_MBR_UBC_NDV1		(0x1 << 27)	/* Next Descriptor View 1 */
> +#define AT_XDMAC_MBR_UBC_NDV2		(0x2 << 27)	/* Next Descriptor View 2 */
> +#define AT_XDMAC_MBR_UBC_NDV3		(0x3 << 27)	/* Next Descriptor View 3 */
> +
> +#define AT_XDMAC_MAX_CHAN	0x20
> +
> +enum atc_status {
> +	AT_XDMAC_CHAN_IS_CYCLIC = 0,
> +};
> +
> +/* ----- Channels ----- */
> +struct at_xdmac_chan {
> +	struct dma_chan	chan;
> +	void __iomem	*ch_regs;
> +	u32		mask;		/* Channel Mask */
> +	u32		cfg;		/* Channel Configuration Register */
> +	u8		perid;		/* Peripheral ID */
> +	u8		dwidth;		/* Data Width */
> +	u8		csize;		/* Chunk Size */
> +	u8		mbsize;		/* Memory Burst Size */
> +	u8		perif;		/* Peripheral Interface */
> +	u8		memif;		/* Memory Interface */
> +	unsigned long	status;
> +	struct tasklet_struct	tasklet;
> +	struct dma_slave_config	dma_sconfig;
> +
> +	spinlock_t		lock;
> +
> +	struct list_head	xfers_list;
> +	struct list_head	free_descs_list;
> +};
> +
> +
> +/* ----- Controller ----- */
> +struct at_xdmac {
> +	struct dma_device	dma;
> +	void __iomem		*regs;
> +	struct clk		*clk;
> +	struct dma_pool		*at_xdmac_desc_pool;
> +	struct at_xdmac_chan	chan[0];
> +};
> +
> +
> +/* ----- Descriptors ----- */
> +
> +/* Linked List Descriptor */
> +struct at_xdmac_lld {
> +	dma_addr_t	mbr_nda;	/* Next Descriptor Member */
> +	u32		mbr_ubc;	/* Microblock Control Member */
> +	dma_addr_t	mbr_sa;		/* Source Address Member */
> +	dma_addr_t	mbr_da;		/* Destination Address Member */
> +	u32		mbr_cfg;	/* Configuration Register */
> +};
> +
> +
> +struct at_xdmac_desc {
> +	struct at_xdmac_lld		lld;
> +	enum dma_transfer_direction	direction;
> +	struct dma_async_tx_descriptor	tx_dma_desc;
> +	struct list_head		desc_node;
> +	/* Following members are only used by the first descriptor */
> +	bool				active_xfer;
> +	unsigned int			xfer_size;
> +	struct list_head		descs_list;
> +	struct list_head		xfer_node;
> +};
> +
> +static inline void __iomem *at_xdmac_chan_reg_base(struct at_xdmac *atxdmac, unsigned int chan_nb)
> +{
> +	return (void __iomem *)(atxdmac->regs + (AT_XDMAC_CHAN_REG_BASE + chan_nb * 0x40));
> +}
> +
> +#define at_xdmac_read(atxdmac, reg) __raw_readl((atxdmac)->regs + (reg))
> +#define at_xdmac_write(atxdmac, reg, value) \
> +	__raw_writel((value), (atxdmac)->regs + (reg))
> +
> +#define at_xdmac_chan_read(atchan, reg) __raw_readl((atchan)->ch_regs + (reg))
> +#define at_xdmac_chan_write(atchan, reg, value) __raw_writel((value), (atchan)->ch_regs + (reg))

It's better to use readl_relaxed/writel_relaxed for the register access.
The xxx_relaxed() can be optimized, such like put to different CPU to 
execute parallely,  If you don't want that happen, you can use writel() 
instead, not __raw_writel().

Best Regards,
Josh Wu

> +
> +static inline struct at_xdmac_chan *to_at_xdmac_chan(struct dma_chan *dchan)
> +{
> +	return container_of(dchan, struct at_xdmac_chan, chan);
> +}
> +
> +static struct device *chan2dev(struct dma_chan *chan)
> +{
> +	return &chan->dev->device;
> +}
> +
> +static inline struct at_xdmac *to_at_xdmac(struct dma_device *ddev)
> +{
> +	return container_of(ddev, struct at_xdmac, dma);
> +}
> +
> +static inline struct at_xdmac_desc *txd_to_at_desc(struct dma_async_tx_descriptor *txd)
> +{
> +	return container_of(txd, struct at_xdmac_desc, tx_dma_desc);
> +}
> +
> +static inline int at_xdmac_chan_is_cyclic(struct at_xdmac_chan *atchan)
> +{
> +	return test_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
> +}
> +
> +#endif /* __AT_XDMAC_H__ */
> diff --git a/include/dt-bindings/dma/at91.h b/include/dt-bindings/dma/at91.h
> index e835037..bef5b68 100644
> --- a/include/dt-bindings/dma/at91.h
> +++ b/include/dt-bindings/dma/at91.h
> @@ -9,6 +9,8 @@
>   #ifndef __DT_BINDINGS_AT91_DMA_H__
>   #define __DT_BINDINGS_AT91_DMA_H__
>   
> +/* ---------- HDMAC ---------- */
> +
>   /*
>    * Source and/or destination peripheral ID
>    */
> @@ -24,4 +26,48 @@
>   #define AT91_DMA_CFG_FIFOCFG_ALAP	(0x1 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* largest defined AHB burst */
>   #define AT91_DMA_CFG_FIFOCFG_ASAP	(0x2 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* single AHB access */
>   
> +
> +/* ---------- XDMAC ---------- */
> +#define AT91_XDMAC_DT_MEM_IF_MASK	(0x1)
> +#define AT91_XDMAC_DT_MEM_IF_OFFSET	(16)
> +#define AT91_XDMAC_DT_MEM_IF(mem_if)	(((mem_if) & AT91_XDMAC_DT_MEM_IF_MASK) \
> +					<< AT91_XDMAC_DT_MEM_IF_OFFSET)
> +#define AT91_XDMAC_DT_GET_MEM_IF(cfg)	(((cfg) >> AT91_XDMAC_DT_MEM_IF_OFFSET) \
> +					& AT91_XDMAC_DT_MEM_IF_MASK)
> +
> +#define AT91_XDMAC_DT_PER_IF_MASK	(0x1)
> +#define AT91_XDMAC_DT_PER_IF_OFFSET	(0)
> +#define AT91_XDMAC_DT_PER_IF(per_if)	(((per_if) & AT91_XDMAC_DT_PER_IF_MASK) \
> +					<< AT91_XDMAC_DT_PER_IF_OFFSET)
> +#define AT91_XDMAC_DT_GET_PER_IF(cfg)	(((cfg) >> AT91_XDMAC_DT_PER_IF_OFFSET) \
> +					& AT91_XDMAC_DT_PER_IF_MASK)
> +
> +#define AT91_XDMAC_DT_PERID_MASK	(0x7f)
> +#define AT91_XDMAC_DT_PERID_OFFSET	(24)
> +#define AT91_XDMAC_DT_PERID(perid)	(((perid) & AT91_XDMAC_DT_PERID_MASK) \
> +					<< AT91_XDMAC_DT_PERID_OFFSET)
> +#define AT91_XDMAC_DT_GET_PERID(cfg)	(((cfg) >> AT91_XDMAC_DT_PERID_OFFSET) \
> +					& AT91_XDMAC_DT_PERID_MASK)
> +
> +#define AT91_XDMAC_DT_DWIDTH_MASK	(0x3)
> +#define AT91_XDMAC_DT_DWIDTH_OFFSET	(11)
> +#define AT91_XDMAC_DT_DWIDTH(dwidth)	(((dwidth) & AT91_XDMAC_DT_DWIDTH_MASK) \
> +					<< AT91_XDMAC_DT_DWIDTH_OFFSET)
> +#define AT91_XDMAC_DT_GET_DWIDTH(cfg)	(((cfg) >> AT91_XDMAC_DT_DWIDTH_OFFSET) \
> +					& AT91_XDMAC_DT_DWIDTH_MASK)
> +
> +#define AT91_XDMAC_DT_CSIZE_MASK	(0x7)
> +#define AT91_XDMAC_DT_CSIZE_OFFSET	(8)
> +#define AT91_XDMAC_DT_CSIZE(csize)	(((csize) & AT91_XDMAC_DT_CSIZE_MASK)  \
> +					<< AT91_XDMAC_DT_CSIZE_OFFSET)
> +#define AT91_XDMAC_DT_GET_CSIZE(cfg)	(((cfg) >> AT91_XDMAC_DT_CSIZE_OFFSET) \
> +					& AT91_XDMAC_DT_CSIZE_MASK)
> +
> +#define AT91_XDMAC_DT_MBSIZE_MASK	(0x3)
> +#define AT91_XDMAC_DT_MBSIZE_OFFSET	(1)
> +#define AT91_XDMAC_DT_MBSIZE(mbsize)	(((mbsize) & AT91_XDMAC_DT_MBSIZE_MASK) \
> +					<< AT91_XDMAC_DT_MBSIZE_OFFSET)
> +#define AT91_XDMAC_DT_GET_MBSIZE(cfg)	(((cfg) >> AT91_XDMAC_DT_MBSIZE_OFFSET) \
> +					& AT91_XDMAC_DT_MBSIZE_MASK)
> +
>   #endif /* __DT_BINDINGS_AT91_DMA_H__ */
