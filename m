From: agross@codeaurora.org (Andy Gross)
Date: Fri, 13 Mar 2015 17:06:27 -0500
Subject: [Patch v4 2/2] dmaengine: Add ADM driver
In-Reply-To: <20150313085745.GG32000@intel.com>
References: <1423719965-8156-1-git-send-email-agross@codeaurora.org>
 <1423719965-8156-3-git-send-email-agross@codeaurora.org>
 <20150313085745.GG32000@intel.com>
Message-ID: <20150313220627.GB23640@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 02:27:45PM +0530, Vinod Koul wrote:
> On Wed, Feb 11, 2015 at 11:46:05PM -0600, Andy Gross wrote:
> > +++ b/drivers/dma/qcom_adm.c
> > @@ -0,0 +1,901 @@
> > +/*
> > + * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
> shouldn't this be 15 :)

yeah, need to update.

> 
>  +/* ADM registers - calculated from channel number and security domain */
> > +#define HI_CH_CMD_PTR(chan, ee)		(4*chan + 0x20800*ee)
> > +#define HI_CH_RSLT(chan, ee)		(0x40 + 4*chan + 0x20800*ee)
> > +#define HI_CH_FLUSH_STATE0(chan, ee)	(0x80 + 4*chan + 0x20800*ee)
> > +#define HI_CH_FLUSH_STATE1(chan, ee)	(0xc0 + 4*chan + 0x20800*ee)
> > +#define HI_CH_FLUSH_STATE2(chan, ee)	(0x100 + 4*chan + 0x20800*ee)
> > +#define HI_CH_FLUSH_STATE3(chan, ee)	(0x140 + 4*chan + 0x20800*ee)
> > +#define HI_CH_FLUSH_STATE4(chan, ee)	(0x180 + 4*chan + 0x20800*ee)
> > +#define HI_CH_FLUSH_STATE5(chan, ee)	(0x1c0 + 4*chan + 0x20800*ee)
> > +#define HI_CH_STATUS_SD(chan, ee)	(0x200 + 4*chan + 0x20800*ee)
> > +#define HI_CH_CONF(chan)		(0x240 + 4*chan)
> > +#define HI_CH_RSLT_CONF(chan, ee)	(0x300 + 4*chan + 0x20800*ee)
> > +#define HI_SEC_DOMAIN_IRQ_STATUS(ee)	(0x380 + 0x20800*ee)
> > +#define HI_CI_CONF(ci)			(0x390 + 4*ci)
> > +#define HI_CRCI_CONF0			0x3d0
> > +#define HI_CRCI_CONF1			0x3d4
> > +#define HI_GP_CTL			0x3d8
> > +#define HI_CRCI_CTL(crci, ee)		(0x400 + 0x4*crci + 0x20800*ee)
> two things, one the names are quite generic and may cause conflicts so pls
> fix that. Second the values, what is the deal with 4*chan, should that be a
> define as well. Also rather than copy pasting a macros would be better for
> this expansion

Yeah there are sets of registers that have both channel and execution
environment offsets.  It is messy.  I'll try to make it more sane.

> 
> > +
> > +/* channel status */
> > +#define CH_STATUS_VALID	BIT(1)
> > +
> > +/* channel result */
> > +#define CH_RSLT_VALID	BIT(31)
> > +#define CH_RSLT_ERR	BIT(3)
> > +#define CH_RSLT_FLUSH	BIT(2)
> > +#define CH_RSLT_TPD	BIT(1)
> > +
> > +/* channel conf */
> > +#define CH_CONF_MPU_DISABLE	BIT(11)
> > +#define CH_CONF_PERM_MPU_CONF	BIT(9)
> > +#define CH_CONF_FLUSH_RSLT_EN	BIT(8)
> > +#define CH_CONF_FORCE_RSLT_EN	BIT(7)
> > +#define CH_CONF_IRQ_EN		BIT(6)
> > +
> > +/* channel result conf */
> > +#define CH_RSLT_CONF_FLUSH_EN	BIT(1)
> > +#define CH_RSLT_CONF_IRQ_EN	BIT(0)
> > +
> > +/* CRCI CTL */
> > +#define CRCI_CTL_MUX_SEL	BIT(18)
> > +#define CRCI_CTL_RST		BIT(17)
> > +
> > +/* CI configuration */
> > +#define CI_RANGE_END(x)		(x << 24)
> > +#define CI_RANGE_START(x)	(x << 16)
> > +#define CI_BURST_4_WORDS	0x4
> > +#define CI_BURST_8_WORDS	0x8
> shouldn't you be consistent is usage of BIT()

good catch

> > +
> > +/* GP CTL */
> > +#define GP_CTL_LP_EN		BIT(12)
> > +#define GP_CTL_LP_CNT(x)	(x << 8)
> > +
> > +/* Command pointer list entry */
> > +#define CPLE_LP			BIT(31)
> > +#define CPLE_CMD_PTR_LIST	BIT(29)
> > +
> > +/* Command list entry */
> > +#define CMD_LC			BIT(31)
> > +#define CMD_DST_CRCI(n)		(((n) & 0xf) << 7)
> > +#define CMD_SRC_CRCI(n)		(((n) & 0xf) << 3)
> > +
> > +#define CMD_TYPE_SINGLE		0x0
> > +#define CMD_TYPE_BOX		0x3a
> naming issues...

ok. will try to come up with something better

> > +static int adm_alloc_chan(struct dma_chan *chan)
> > +{
> > +	return 0;
> > +}
> This is no longer mandatory, so can be dropped

will remove

> 
> > +static int adm_get_blksize(unsigned int burst)
> > +{
> > +	int ret;
> > +
> > +	switch (burst) {
> > +	case 16:
> > +		ret = 0;
> > +		break;
> > +	case 32:
> > +		ret = 1;
> > +		break;
> > +	case 64:
> > +		ret = 2;
> > +		break;
> > +	case 128:
> > +		ret = 3;
> > +		break;
> > +	case 192:
> > +		ret = 4;
> > +		break;
> > +	case 256:
> > +		ret = 5;
> > +		break;
> ffs(burst>>4) ?

that should work nicely.  thanks.

> > +static struct dma_async_tx_descriptor *adm_prep_slave_sg(struct dma_chan *chan,
> > +	struct scatterlist *sgl, unsigned int sg_len,
> > +	enum dma_transfer_direction direction, unsigned long flags,
> > +	void *context)
> > +{
> > +	struct adm_chan *achan = to_adm_chan(chan);
> > +	struct adm_device *adev = achan->adev;
> > +	struct adm_async_desc *async_desc;
> > +	struct scatterlist *sg;
> > +	u32 i;
> > +	u32 single_count = 0, box_count = 0, desc_offset = 0, crci = 0;
> > +	struct adm_desc_hw_box *box_desc;
> > +	struct adm_desc_hw_single *single_desc;
> > +	void *desc;
> > +	u32 *cple, *last_cmd;
> > +	u32 burst;
> > +	int blk_size = 0;
> > +
> > +
> > +	if (!is_slave_direction(direction)) {
> > +		dev_err(adev->dev, "invalid dma direction\n");
> > +		return NULL;
> > +	}
> > +
> > +	/*
> > +	 * get burst value from slave configuration
> > +	 * If zero, default to maximum burst size
> > +	 * If larger than the max transfer size, set to ADM_MAX_XFER
> > +	 */
> > +	burst = (direction == DMA_MEM_TO_DEV) ?
> > +		achan->slave.dst_maxburst :
> > +		achan->slave.src_maxburst;
> > +
> > +	if (!burst || burst > ADM_MAX_XFER)
> > +		burst = ADM_MAX_XFER;
> For slave, we should send error here. The DMA settings are matched with
> slave FIFO, so any change here can cause issues

ok.  I was trying to unify the flow control use case with the non flow control
use case.  the slave config burst is only used in the case of flow control.

> 
> > +
> > +	/* if using flow control, validate burst and crci values */
> > +	if (achan->slave.device_fc) {
> > +
> > +		blk_size = adm_get_blksize(burst);
> > +		if (blk_size < 0) {
> > +			dev_err(adev->dev, "invalid burst value w/ crci: %d\n",
> > +				burst);
> > +			return ERR_PTR(-EINVAL);
> > +		}
> > +
> > +		crci = achan->slave.slave_id & 0xf;
> > +		if (!crci || achan->slave.slave_id > 0x1f) {
> > +			dev_err(adev->dev, "invalid crci value\n");
> > +			return ERR_PTR(-EINVAL);
> > +		}
> > +	}
> > +
> > +	/* iterate through sgs and compute allocation size of structures */
> > +	for_each_sg(sgl, sg, sg_len, i)
> > +		if (sg_dma_len(sg) % burst)

i used it here to bust up the dma buffer into burstable chunks

> > +			single_count += DIV_ROUND_UP(sg_dma_len(sg), burst);
> > +		else
> > +			box_count += DIV_ROUND_UP(sg_dma_len(sg) / burst,
> > +							ADM_MAX_ROWS);
> > +

<snip>

> > +			} else {
> > +				box_desc = desc + desc_offset;
> > +				last_cmd = &box_desc->cmd;
> > +				box_desc->cmd = CMD_TYPE_BOX;
> > +				box_desc->row_offset = 0;
> > +
> > +				if (direction == DMA_DEV_TO_MEM) {
> > +					box_desc->dst_addr =
> > +						sg_dma_address(sg) + offset;
> > +					box_desc->src_addr =
> > +						achan->slave.src_addr;
> > +					box_desc->cmd |= CMD_SRC_CRCI(crci);
> > +					box_desc->row_offset = burst;
> > +
> > +				} else {
> > +					box_desc->src_addr =
> > +						sg_dma_address(sg) + offset;
> > +					box_desc->dst_addr =
> > +						achan->slave.dst_addr;
> > +					box_desc->cmd |= CMD_DST_CRCI(crci);
> > +					box_desc->row_offset = burst << 16;
> > +				}
> till this both look quite similar, also you are way deeply nested. I would
> split this up to make it look better as well try reusing common parts for
> both here

Ok.  I'll rework this.

> 
> > +static int adm_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> > +	unsigned long arg)
> > +{
> this is removed, so you need to rebase this

Will do.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
