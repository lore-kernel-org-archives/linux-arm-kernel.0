From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 25 May 2015 22:20:22 +0530
Subject: [PATCH v3 3/6] dmaengine: pxa: add pxa dmaengine driver
In-Reply-To: <1431626006-1708-3-git-send-email-robert.jarzmik@free.fr>
References: <1431626006-1708-1-git-send-email-robert.jarzmik@free.fr>
 <1431626006-1708-3-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150525165022.GH3140@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 07:53:23PM +0200, Robert Jarzmik wrote:

> +#define DCSR(n)		(0x0000 + ((n) << 2))
> +#define DALGN(n)	0x00a0
> +#define DINT		0x00f0
> +#define DDADR(n)	(0x0200 + ((n) << 4))
> +#define DSADR(n)	(0x0204 + ((n) << 4))
> +#define DTADR(n)	(0x0208 + ((n) << 4))
> +#define DCMD(n)		(0x020c + ((n) << 4))
> +
> +#define DCSR_RUN	BIT(31)	/* Run Bit (read / write) */
> +#define DCSR_NODESC	BIT(30)	/* No-Descriptor Fetch (read / write) */
> +#define DCSR_STOPIRQEN	BIT(29)	/* Stop Interrupt Enable (read / write) */
> +#define DCSR_REQPEND	BIT(8)	/* Request Pending (read-only) */
> +#define DCSR_STOPSTATE	BIT(3)	/* Stop State (read-only) */
> +#define DCSR_ENDINTR	BIT(2)	/* End Interrupt (read / write) */
> +#define DCSR_STARTINTR	BIT(1)	/* Start Interrupt (read / write) */
> +#define DCSR_BUSERR	BIT(0)	/* Bus Error Interrupt (read / write) */
> +
> +#define DCSR_EORIRQEN	BIT(28)	/* End of Receive Interrupt Enable (R/W) */
> +#define DCSR_EORJMPEN	BIT(27)	/* Jump to next descriptor on EOR */
> +#define DCSR_EORSTOPEN	BIT(26)	/* STOP on an EOR */
> +#define DCSR_SETCMPST	BIT(25)	/* Set Descriptor Compare Status */
> +#define DCSR_CLRCMPST	BIT(24)	/* Clear Descriptor Compare Status */
> +#define DCSR_CMPST	BIT(10)	/* The Descriptor Compare Status */
> +#define DCSR_EORINTR	BIT(9)	/* The end of Receive */
would help if these are PXA_xxx
> +
> +/*
> + * Requestor lines are mapped as :
> + *  - lines 0 to 63   : DRCMR(line) = 0x100 + line * 4
> + *  - lines 64 to +oo : DRCMR(line) = 0x1000 + line * 4
> + */
> +#define DRCMR(n)	((((n) < 64) ? 0x0100 : 0x1100) + (((n) & 0x3f) << 2))
This is hard to read, why not make this a function?

> +static int pxad_alloc_chan_resources(struct dma_chan *dchan)
> +{
> +	struct pxad_chan *chan = to_pxad_chan(dchan);
> +	struct pxad_device *pdev = to_pxad_dev(chan->vc.chan.device);
> +
> +	if (chan->desc_pool)
> +		return 1;
> +
> +	chan->desc_pool = dma_pool_create(dma_chan_name(dchan),
> +					  pdev->slave.dev,
> +					  sizeof(struct pxad_desc_hw),
> +					  __alignof__(struct pxad_desc_hw),
why __alignof__ and why not simple say sizeof(struct pxad_desc_hw) to align
the pool for this struct. Also you have given the descriptor size here for
pool size, which sounds odd and ideally you would like to request a large
pool for channel for allocating multiple desc


> +static struct pxad_desc_sw *
> +pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
> +{
> +	struct pxad_desc_sw *sw_desc;
> +	dma_addr_t dma;
> +	int i;
> +
> +	sw_desc = kzalloc(sizeof(*sw_desc) +
> +			  nb_hw_desc * sizeof(struct pxad_desc_hw *),
> +			  GFP_ATOMIC);
GFP_NOWAIT
> +	if (!sw_desc)
> +		return NULL;
> +	sw_desc->desc_pool = chan->desc_pool;
> +
> +	for (i = 0; i < nb_hw_desc; i++) {
> +		sw_desc->hw_desc[i] = dma_pool_alloc(sw_desc->desc_pool,
> +						     GFP_ATOMIC, &dma);
GFP_NOWAIT

-- 
~Vinod
