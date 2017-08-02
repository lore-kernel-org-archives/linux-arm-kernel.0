From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 2 Aug 2017 11:01:34 +0530
Subject: [PATCH v1 2/6] arm: linux: fsl: dma: add qdma command queue mode
In-Reply-To: <1501553651-7203-3-git-send-email-jiaheng.fan@nxp.com>
References: <1501553651-7203-1-git-send-email-jiaheng.fan@nxp.com>
 <1501553651-7203-3-git-send-email-jiaheng.fan@nxp.com>
Message-ID: <20170802053134.GY3053@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 10:14:07AM +0800, jiaheng.fan wrote:

> +#define FSL_QDMA_DMR			0x0
> +#define FSL_QDMA_DSR			0x4
> +#define FSL_QDMA_DEIER			0xe00
> +#define FSL_QDMA_DEDR			0xe04
> +#define FSL_QDMA_DECFDW0R		0xe10
> +#define FSL_QDMA_DECFDW1R		0xe14
> +#define FSL_QDMA_DECFDW2R		0xe18
> +#define FSL_QDMA_DECFDW3R		0xe1c
> +#define FSL_QDMA_DECFQIDR		0xe30
> +#define FSL_QDMA_DECBR			0xe34
> +
> +#define FSL_QDMA_BCQMR(x)		(0xc0 + 0x100 * (x))
> +#define FSL_QDMA_BCQSR(x)		(0xc4 + 0x100 * (x))
> +#define FSL_QDMA_BCQEDPA_SADDR(x)	(0xc8 + 0x100 * (x))
> +#define FSL_QDMA_BCQDPA_SADDR(x)	(0xcc + 0x100 * (x))
> +#define FSL_QDMA_BCQEEPA_SADDR(x)	(0xd0 + 0x100 * (x))
> +#define FSL_QDMA_BCQEPA_SADDR(x)	(0xd4 + 0x100 * (x))
> +#define FSL_QDMA_BCQIER(x)		(0xe0 + 0x100 * (x))
> +#define FSL_QDMA_BCQIDR(x)		(0xe4 + 0x100 * (x))
> +
> +#define FSL_QDMA_SQDPAR			0x80c
> +#define FSL_QDMA_SQEPAR			0x814
> +#define FSL_QDMA_BSQMR			0x800
> +#define FSL_QDMA_BSQSR			0x804
> +#define FSL_QDMA_BSQICR			0x828
> +#define FSL_QDMA_CQMR			0xa00
> +#define FSL_QDMA_CQDSCR1		0xa08
> +#define FSL_QDMA_CQDSCR2                0xa0c
> +#define FSL_QDMA_CQIER			0xa10
> +#define FSL_QDMA_CQEDR			0xa14
> +
> +#define FSL_QDMA_SQICR_ICEN
> +
> +#define FSL_QDMA_CQIDR_CQT		0xff000000
> +#define FSL_QDMA_CQIDR_SQPE		0x800000
> +#define FSL_QDMA_CQIDR_SQT		0x8000
> +
> +#define FSL_QDMA_BCQIER_CQTIE		0x8000
> +#define FSL_QDMA_BCQIER_CQPEIE		0x800000
> +#define FSL_QDMA_BSQICR_ICEN		0x80000000
> +#define FSL_QDMA_BSQICR_ICST(x)		((x) << 16)
> +#define FSL_QDMA_CQIER_MEIE		0x80000000
> +#define FSL_QDMA_CQIER_TEIE		0x1
> +
> +#define FSL_QDMA_QUEUE_MAX		8
> +
> +#define FSL_QDMA_BCQMR_EN		0x80000000
> +#define FSL_QDMA_BCQMR_EI		0x40000000
> +#define FSL_QDMA_BCQMR_CD_THLD(x)	((x) << 20)
> +#define FSL_QDMA_BCQMR_CQ_SIZE(x)	((x) << 16)
> +
> +#define FSL_QDMA_BCQSR_QF		0x10000
> +
> +#define FSL_QDMA_BSQMR_EN		0x80000000
> +#define FSL_QDMA_BSQMR_DI		0x40000000
> +#define FSL_QDMA_BSQMR_CQ_SIZE(x)	((x) << 16)
> +
> +#define FSL_QDMA_BSQSR_QE		0x20000
> +
> +#define FSL_QDMA_DMR_DQD		0x40000000
> +#define FSL_QDMA_DSR_DB			0x80000000
> +
> +#define FSL_QDMA_BASE_BUFFER_SIZE	96
> +#define FSL_QDMA_EXPECT_SG_ENTRY_NUM	16
> +#define FSL_QDMA_CIRCULAR_DESC_SIZE_MIN	64
> +#define FSL_QDMA_CIRCULAR_DESC_SIZE_MAX	16384
> +#define FSL_QDMA_QUEUE_NUM_MAX		8
> +
> +#define FSL_QDMA_CMD_RWTTYPE		0x4
> +#define FSL_QDMA_CMD_LWC                0x2
> +
> +#define FSL_QDMA_CMD_RWTTYPE_OFFSET	28
> +#define FSL_QDMA_CMD_NS_OFFSET		27
> +#define FSL_QDMA_CMD_DQOS_OFFSET	24
> +#define FSL_QDMA_CMD_WTHROTL_OFFSET	20
> +#define FSL_QDMA_CMD_DSEN_OFFSET	19
> +#define FSL_QDMA_CMD_LWC_OFFSET		16
> +
> +#define FSL_QDMA_E_SG_TABLE		1
> +#define FSL_QDMA_E_DATA_BUFFER		0
> +#define FSL_QDMA_F_LAST_ENTRY		1

BIT() and GENMASK() please for all of these..

> +
> +struct fsl_qdma_ccdf {
> +	u8 status;
> +	u32 rev1:22;
> +	u32 ser:1;
> +	u32 rev2:1;
> +	u32 rev3:20;
> +	u32 offset:9;
> +	u32 format:3;
> +	union {
> +		struct {
> +			u32 addr_lo;	/* low 32-bits of 40-bit address */
> +			u32 addr_hi:8;	/* high 8-bits of 40-bit address */
> +			u32 rev4:16;
> +			u32 queue:3;
> +			u32 rev5:3;
> +			u32 dd:2;	/* dynamic debug */
> +		};
> +		struct {
> +			u64 addr:40;
> +			/* More efficient address accessor */

been there done that, I think accessing registers using MASKS is much better
implementation and code looks cleaner than using unions like this :)

> +struct fsl_qdma_chan {
> +	struct virt_dma_chan		vchan;
> +	struct virt_dma_desc		vdesc;
> +	enum dma_status			status;
> +	u32				slave_id;
> +	struct fsl_qdma_engine		*qdma;
> +	struct fsl_qdma_queue		*queue;
> +	struct list_head		qcomp;

what does this list do?

> +};
> +
> +struct fsl_qdma_queue {
> +	struct fsl_qdma_ccdf	*virt_head;
> +	struct fsl_qdma_ccdf	*virt_tail;
> +	struct list_head	comp_used;
> +	struct list_head	comp_free;

whats a comp ?

> +	struct dma_pool		*comp_pool;
> +	struct dma_pool		*sg_pool;
> +	spinlock_t		queue_lock;
> +	dma_addr_t		bus_addr;
> +	u32                     n_cq;
> +	u32			id;
> +	struct fsl_qdma_ccdf	*cq;
> +};
> +
> +struct fsl_qdma_sg {
> +	dma_addr_t		bus_addr;
> +	void			*virt_addr;

why do you need both?

> +};
> +
> +struct fsl_qdma_comp {
> +	dma_addr_t              bus_addr;
> +	void			*virt_addr;
> +	struct fsl_qdma_chan	*qchan;
> +	struct fsl_qdma_sg	*sg_block;

and you duplicate these here and inside the sg_block, why would you do
that??

So somewise guys told me once "Data structre design is essential element of
overall design, bad data structure eventually leads to bad code

Bad data structure -> Bad code.."

> +static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp *fsl_comp,
> +					dma_addr_t dst, dma_addr_t src, u32 len)
> +{
> +	struct fsl_qdma_ccdf *ccdf;
> +	struct fsl_qdma_csgf *csgf_desc, *csgf_src, *csgf_dest;
> +	struct fsl_qdma_sdf *sdf;
> +	struct fsl_qdma_ddf *ddf;
> +
> +	ccdf = (struct fsl_qdma_ccdf *)fsl_comp->virt_addr;
> +	csgf_desc = (struct fsl_qdma_csgf *)fsl_comp->virt_addr + 1;
> +	csgf_src = (struct fsl_qdma_csgf *)fsl_comp->virt_addr + 2;
> +	csgf_dest = (struct fsl_qdma_csgf *)fsl_comp->virt_addr + 3;
> +	sdf = (struct fsl_qdma_sdf *)fsl_comp->virt_addr + 4;
> +	ddf = (struct fsl_qdma_ddf *)fsl_comp->virt_addr + 5;

why do you need all these casts? I think these are void, cast to and away
from void * are not required..

> +static void fsl_qdma_comp_fill_sg(
> +		struct fsl_qdma_comp *fsl_comp,
> +		struct scatterlist *dst_sg, unsigned int dst_nents,
> +		struct scatterlist *src_sg, unsigned int src_nents)
> +{
> +	struct fsl_qdma_ccdf *ccdf;
> +	struct fsl_qdma_csgf *csgf_desc, *csgf_src, *csgf_dest, *csgf_sg;
> +	struct fsl_qdma_sdf *sdf;
> +	struct fsl_qdma_ddf *ddf;
> +	struct fsl_qdma_sg *sg_block, *temp;
> +	struct scatterlist *sg;
> +	u64 total_src_len = 0;
> +	u64 total_dst_len = 0;
> +	u32 i;
> +
> +	ccdf = (struct fsl_qdma_ccdf *)fsl_comp->virt_addr;
> +	csgf_desc = (struct fsl_qdma_csgf *)fsl_comp->virt_addr + 1;
> +	csgf_src = (struct fsl_qdma_csgf *)fsl_comp->virt_addr + 2;
> +	csgf_dest = (struct fsl_qdma_csgf *)fsl_comp->virt_addr + 3;
> +	sdf = (struct fsl_qdma_sdf *)fsl_comp->virt_addr + 4;
> +	ddf = (struct fsl_qdma_ddf *)fsl_comp->virt_addr + 5;

Here as well, pls fix all these instance...

> +/*
> + * Prei-request full command descriptor for enqueue.

Prei?

> + */
> +static int fsl_qdma_pre_request_enqueue_desc(struct fsl_qdma_queue *queue)
> +{
> +	struct fsl_qdma_comp *comp_temp;
> +	int i;
> +
> +	for (i = 0; i < queue->n_cq; i++) {
> +		comp_temp = kzalloc(sizeof(*comp_temp), GFP_KERNEL);
> +		if (!comp_temp)
> +			return -1;

Why are you returning -1, we have kernel standard error codes available in
errno.h and ENOMEM fits brilliantly for this :)

> +		comp_temp->virt_addr = dma_pool_alloc(queue->comp_pool,
> +						      GFP_NOWAIT,
> +						      &comp_temp->bus_addr);
> +		if (!comp_temp->virt_addr)
> +			return -1;

here and other places, we don't return -1 for errors...

> +static struct fsl_qdma_comp *fsl_qdma_request_enqueue_desc(
> +					struct fsl_qdma_chan *fsl_chan,
> +					unsigned int dst_nents,
> +					unsigned int src_nents)
> +{
> +	struct fsl_qdma_comp *comp_temp;
> +	struct fsl_qdma_sg *sg_block;
> +	struct fsl_qdma_queue *queue = fsl_chan->queue;
> +	unsigned long flags;
> +	unsigned int dst_sg_entry_block, src_sg_entry_block, sg_entry_total, i;
> +
> +	spin_lock_irqsave(&queue->queue_lock, flags);
> +	if (list_empty(&queue->comp_free)) {
> +		spin_unlock_irqrestore(&queue->queue_lock, flags);
> +		comp_temp = kzalloc(sizeof(*comp_temp), GFP_KERNEL);

GFP_NOWAIT please.. Please read the dmaengine documentation which explains
why..

> +		if (!comp_temp)
> +			return NULL;
> +		comp_temp->virt_addr = dma_pool_alloc(queue->comp_pool,
> +						      GFP_NOWAIT,

Looks like you have read that :)

> +						      &comp_temp->bus_addr);
> +		if (!comp_temp->virt_addr)

and you leak memory here..

> +			return NULL;
> +	} else {
> +		comp_temp = list_first_entry(&queue->comp_free,
> +					     struct fsl_qdma_comp,
> +					     list);
> +		list_del(&comp_temp->list);
> +		spin_unlock_irqrestore(&queue->queue_lock, flags);
> +	}
> +
> +	if (dst_nents != 0)
> +		dst_sg_entry_block = dst_nents /
> +					(FSL_QDMA_EXPECT_SG_ENTRY_NUM - 1) + 1;

DIV_ROUND_UP perhaps??

> +	else
> +		dst_sg_entry_block = 0;
> +
> +	if (src_nents != 0)
> +		src_sg_entry_block = src_nents /
> +					(FSL_QDMA_EXPECT_SG_ENTRY_NUM - 1) + 1;
> +	else
> +		src_sg_entry_block = 0;
> +
> +	sg_entry_total = dst_sg_entry_block + src_sg_entry_block;
> +	if (sg_entry_total) {
> +		sg_block = kzalloc(sizeof(*sg_block) *
> +					      sg_entry_total,
> +					      GFP_KERNEL);
> +		if (!sg_block)
> +			return NULL;

more leaks...

> +		comp_temp->sg_block = sg_block;
> +		for (i = 0; i < sg_entry_total; i++) {
> +			sg_block->virt_addr = dma_pool_alloc(queue->sg_pool,
> +							GFP_NOWAIT,
> +							&sg_block->bus_addr);

no err checks here?

> +static struct platform_driver fsl_qdma_driver = {
> +	.driver		= {
> +		.name	= "fsl-qdma",
> +		.owner  = THIS_MODULE,

this is not required as core sets this

> +		.of_match_table = fsl_qdma_dt_ids,
> +	},
> +	.probe          = fsl_qdma_probe,
> +	.remove		= fsl_qdma_remove,
> +};
> +
> +static int __init fsl_qdma_init(void)
> +{
> +	return platform_driver_register(&fsl_qdma_driver);
> +}
> +subsys_initcall(fsl_qdma_init);
> +
> +static void __exit fsl_qdma_exit(void)
> +{
> +	platform_driver_unregister(&fsl_qdma_driver);
> +}
> +module_exit(fsl_qdma_exit);

module_platform_driver() ?

-- 
~Vinod
