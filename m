From: vkoul@kernel.org (Vinod)
Date: Tue, 24 Jul 2018 18:39:43 +0530
Subject: [PATCH v2 3/4] dma: Add Actions Semi Owl family S900 DMA driver
In-Reply-To: <20180724124614.GB2587@vkoul-mobl>
References: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
 <20180723041743.32024-4-manivannan.sadhasivam@linaro.org>
 <20180724124614.GB2587@vkoul-mobl>
Message-ID: <20180724130943.GD3661@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

somehow this got stuck so sending again...

On 24-07-18, 18:16, Vinod wrote:
> On 23-07-18, 09:47, Manivannan Sadhasivam wrote:
> 
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmapool.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> 
> do you need this?
> 
> > +/* OWL_DMAX_MODE Bits */
> > +#define OWL_DMA_MODE_TS(x)			(((x) & 0x3f) << 0)
> > +#define OWL_DMA_MODE_ST(x)			(((x) & 0x3) << 8)
> > +#define	OWL_DMA_MODE_ST_DEV			OWL_DMA_MODE_ST(0)
> > +#define	OWL_DMA_MODE_ST_DCU			OWL_DMA_MODE_ST(2)
> > +#define	OWL_DMA_MODE_ST_SRAM			OWL_DMA_MODE_ST(3)
> 
> what are you trying to do with this? Generally we would define register
> bits using BIT and GENMASK here..
> 
> > +/* Extract the bit field to new shift */
> > +#define BIT_FIELD(val, width, shift, newshift)	\
> > +		((((val) >> (shift)) & ((BIT(width)) - 1)) << (newshift))
> 
> why new shift? I guess you want to extract bits from a register here and
> use those, right?
> 
> > +struct owl_dma_lli_hw {
> > +	u32	next_lli;	/* physical address of the next link list */
> > +	u32	saddr;		/* source physical address */
> > +	u32	daddr;		/* destination physical address */
> > +	u32	flen:20;	/* frame length */
> > +	u32	fcnt:12;	/* frame count */
> > +	u32	src_stride;	/* source stride */
> > +	u32	dst_stride;	/* destination stride */
> > +	u32	ctrla;		/* dma_mode and linklist ctrl */
> > +	u32	ctrlb;		/* interrupt control */
> > +	u32	const_num;	/* data for constant fill */
> 
> i think you can skip comment here or kernel-doc style, please pick one
> and not both
> 
> > +struct owl_dma_txd {
> > +	struct virt_dma_desc	vd;
> > +	struct list_head	lli_list;
> 
> why do you need this list. vd has its own list as well!
> 
> > +static void pchan_update(void __iomem *reg, u32 val, bool state)
> 
> why does this not use pchan as arg as the name of API implies (you did
> that on the other two)
> 
> > +static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
> > +				  struct owl_dma_lli *lli,
> > +				  dma_addr_t src, dma_addr_t dst,
> > +				  u32 len, enum dma_transfer_direction dir)
> > +{
> > +	struct owl_dma_lli_hw *hw = &lli->hw;
> > +	u32 mode;
> > +
> > +	mode = OWL_DMA_MODE_PW(0);
> > +
> > +	switch (dir) {
> > +	case DMA_MEM_TO_MEM:
> > +		mode |= OWL_DMA_MODE_TS(0) | OWL_DMA_MODE_ST_DCU |
> > +			OWL_DMA_MODE_DT_DCU | OWL_DMA_MODE_SAM_INC |
> > +			OWL_DMA_MODE_DAM_INC;
> > +
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	hw->next_lli = 0; /* One link list by default */
> > +	hw->saddr = src;
> > +	hw->daddr = dst;
> > +
> > +	hw->fcnt = 1; /* Frame count fixed as 1 */
> > +	hw->flen = len; /* Max frame length is 1MB */
> 
> are you checking that somewhere?
> 
> > +static struct owl_dma_pchan *owl_dma_get_pchan(struct owl_dma *od,
> > +					       struct owl_dma_vchan *vchan)
> > +{
> > +	struct owl_dma_pchan *pchan;
> > +	unsigned long flags;
> > +	int i;
> > +
> > +	for (i = 0; i < od->nr_pchans; i++) {
> > +		pchan = &od->pchans[i];
> > +
> > +		spin_lock_irqsave(&pchan->lock, flags);
> > +		if (!pchan->vchan) {
> > +			pchan->vchan = vchan;
> > +			spin_unlock_irqrestore(&pchan->lock, flags);
> > +			break;
> > +		}
> > +
> > +		spin_unlock_irqrestore(&pchan->lock, flags);
> > +	}
> > +
> > +	if (i == od->nr_pchans) {
> > +		/* No physical channel available, cope with it */
> > +		dev_dbg(od->dma.dev, "no physical channel available\n");
> 
> not sure about this. The concept of virt-chan is that you would submit a
> transaction to controller for different channels. If channel is busy the
> txn is simply queued up. You do not need a _free_ channel
> 
> > +static void owl_dma_pause_pchan(struct owl_dma_pchan *pchan)
> > +{
> > +	pchan_writel(pchan, 1, OWL_DMAX_PAUSE);
> > +}
> > +
> > +static void owl_dma_resume_pchan(struct owl_dma_pchan *pchan)
> > +{
> > +	pchan_writel(pchan, 0, OWL_DMAX_PAUSE);
> > +}
> 
> mempcy and pause/resume dont make much sense, are you sure you want that
> here and not later on slave copy
> 
> > +static void owl_dma_free_txd(struct owl_dma *od, struct owl_dma_txd *txd)
> > +{
> > +	struct owl_dma_lli *lli, *_lli;
> > +
> > +	if (unlikely(!txd))
> > +		return;
> > +
> > +	list_for_each_entry_safe(lli, _lli, &txd->lli_list, node) {
> > +		owl_dma_free_lli(od, lli);
> > +	}
> 
> braces not required here
> 
> > +static int owl_dma_remove(struct platform_device *pdev)
> > +{
> > +	struct owl_dma *od = platform_get_drvdata(pdev);
> > +
> > +	of_dma_controller_free(pdev->dev.of_node);
> > +	dma_async_device_unregister(&od->dma);
> > +
> > +	/* Mask all interrupts for this execution environment */
> > +	dma_writel(od, 0x0, OWL_DMA_IRQ_EN0);
> > +	owl_dma_free(od);
> 
> the tasklets are killed but irqs can still run and trigger the irqs :)
> -- 
> ~Vinod

-- 
~Vinod
