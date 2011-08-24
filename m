From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 24 Aug 2011 10:21:18 +0900
Subject: [PATCH 1/3] DMA: PL330: Infer transfer direction from transfer
	request instead of platform data
In-Reply-To: <1314050385-9617-2-git-send-email-thomas.abraham@linaro.org>
References: <1314050385-9617-1-git-send-email-thomas.abraham@linaro.org>
	<1314050385-9617-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <000601cc61fc$201ac560$60505020$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> Sent: Tuesday, August 23, 2011 7:00 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org; kgene.kim at samsung.com;
> vinod.koul at intel.com; Jassi Brar; Boojin Kim
> Subject: [PATCH 1/3] DMA: PL330: Infer transfer direction from
> transfer request instead of platform data
>
> The transfer direction for a channel can be inferred from the transfer
> request and the need for specifying transfer direction in platfrom
> data
> can be eliminated. So the structure definition 'struct dma_pl330_peri'
> is no longer required.
>
> With the 'struct dma_pl330_peri' removed, the dma controller transfer
> capabilities cannot be inferred any longer. Hence, the dma controller
> capabilities is specified using platforme data.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  drivers/dma/pl330.c        |   56 ++++++++------------------------------
> ------
>  include/linux/amba/pl330.h |   14 +++--------
>  2 files changed, 14 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 3a0baac..6592b9a 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -507,7 +507,7 @@ pluck_desc(struct dma_pl330_dmac *pdmac)
>  static struct dma_pl330_desc *pl330_get_desc(struct dma_pl330_chan
> *pch)
>  {
>  	struct dma_pl330_dmac *pdmac = pch->dmac;
> -	struct dma_pl330_peri *peri = pch->chan.private;
> +	u8 *peri_id = pch->chan.private;
>  	struct dma_pl330_desc *desc;
>
>  	/* Pluck one desc from the pool of DMAC */
> @@ -531,14 +531,7 @@ static struct dma_pl330_desc
> *pl330_get_desc(struct dma_pl330_chan *pch)
>  	desc->pchan = pch;
>  	desc->txd.cookie = 0;
>  	async_tx_ack(&desc->txd);
> -
> -	if (peri) {
> -		desc->req.rqtype = peri->rqtype;
> -		desc->req.peri = pch->chan.chan_id;
> -	} else {
> -		desc->req.rqtype = MEMTOMEM;
> -		desc->req.peri = 0;
> -	}
> +	desc->req.peri = (peri_id) ? pch->chan.chan_id : 0;
>
>  	dma_async_tx_descriptor_init(&desc->txd, &pch->chan);
>
> @@ -625,12 +618,14 @@ static struct dma_async_tx_descriptor
> *pl330_prep_dma_cyclic(
>  	case DMA_TO_DEVICE:
>  		desc->rqcfg.src_inc = 1;
>  		desc->rqcfg.dst_inc = 0;
> +		desc->req.rqtype = MEMTODEV;
>  		src = dma_addr;
>  		dst = pch->fifo_addr;
>  		break;
>  	case DMA_FROM_DEVICE:
>  		desc->rqcfg.src_inc = 0;
>  		desc->rqcfg.dst_inc = 1;
> +		desc->req.rqtype = DEVTOMEM;
>  		src = pch->fifo_addr;
>  		dst = dma_addr;
>  		break;
> @@ -657,16 +652,12 @@ pl330_prep_dma_memcpy(struct dma_chan *chan,
> dma_addr_t dst,
>  {
>  	struct dma_pl330_desc *desc;
>  	struct dma_pl330_chan *pch = to_pchan(chan);
> -	struct dma_pl330_peri *peri = chan->private;
>  	struct pl330_info *pi;
>  	int burst;
>
>  	if (unlikely(!pch || !len))
>  		return NULL;
>
> -	if (peri && peri->rqtype != MEMTOMEM)
> -		return NULL;
> -
>  	pi = &pch->dmac->pif;
>
>  	desc = __pl330_prep_dma_memcpy(pch, dst, src, len);
> @@ -675,6 +666,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan,
> dma_addr_t dst,
>
>  	desc->rqcfg.src_inc = 1;
>  	desc->rqcfg.dst_inc = 1;
> +	desc->req.rqtype = MEMTOMEM;
>
>  	/* Select max possible burst size */
>  	burst = pi->pcfg.data_bus_width / 8;
> @@ -703,25 +695,14 @@ pl330_prep_slave_sg(struct dma_chan *chan,
> struct scatterlist *sgl,
>  {
>  	struct dma_pl330_desc *first, *desc = NULL;
>  	struct dma_pl330_chan *pch = to_pchan(chan);
> -	struct dma_pl330_peri *peri = chan->private;
>  	struct scatterlist *sg;
>  	unsigned long flags;
>  	int i;
>  	dma_addr_t addr;
>
> -	if (unlikely(!pch || !sgl || !sg_len || !peri))
> +	if (unlikely(!pch || !sgl || !sg_len))
>  		return NULL;
>
> -	/* Make sure the direction is consistent */
> -	if ((direction == DMA_TO_DEVICE &&
> -				peri->rqtype != MEMTODEV) ||
> -			(direction == DMA_FROM_DEVICE &&
> -				peri->rqtype != DEVTOMEM)) {
> -		dev_err(pch->dmac->pif.dev, "%s:%d Invalid Direction\n",
> -				__func__, __LINE__);
> -		return NULL;
> -	}
> -
>  	addr = pch->fifo_addr;
>
>  	first = NULL;
> @@ -761,11 +742,13 @@ pl330_prep_slave_sg(struct dma_chan *chan,
> struct scatterlist *sgl,
>  		if (direction == DMA_TO_DEVICE) {
>  			desc->rqcfg.src_inc = 1;
>  			desc->rqcfg.dst_inc = 0;
> +			desc->req.rqtype = MEMTODEV;
>  			fill_px(&desc->px,
>  				addr, sg_dma_address(sg), sg_dma_len(sg));
>  		} else {
>  			desc->rqcfg.src_inc = 0;
>  			desc->rqcfg.dst_inc = 1;
> +			desc->req.rqtype = DEVTOMEM;
>  			fill_px(&desc->px,
>  				sg_dma_address(sg), addr, sg_dma_len(sg));
>  		}
> @@ -872,27 +855,7 @@ pl330_probe(struct amba_device *adev, const
> struct amba_id *id)
>
>  	for (i = 0; i < num_chan; i++) {
>  		pch = &pdmac->peripherals[i];
> -		if (pdat) {
> -			struct dma_pl330_peri *peri = &pdat->peri[i];
> -
> -			switch (peri->rqtype) {
> -			case MEMTOMEM:
> -				dma_cap_set(DMA_MEMCPY, pd->cap_mask);
> -				break;
> -			case MEMTODEV:
> -			case DEVTOMEM:
> -				dma_cap_set(DMA_SLAVE, pd->cap_mask);
> -				dma_cap_set(DMA_CYCLIC, pd->cap_mask);
> -				break;
If remove capabilities setting, dmaengine() doesn't search the channel that
client requests with specific capability.
So, I think dma_request_channel() would fail.

> -			default:
> -				dev_err(&adev->dev, "DEVTODEV Not
> Supported\n");
> -				continue;
> -			}
> -			pch->chan.private = peri;
> -		} else {
> -			dma_cap_set(DMA_MEMCPY, pd->cap_mask);
> -			pch->chan.private = NULL;
> -		}
> +		pch->chan.private = (pdat) ? &pdat->peri_id[i] : NULL;
>
>  		INIT_LIST_HEAD(&pch->work_list);
>  		spin_lock_init(&pch->lock);
> @@ -907,6 +870,7 @@ pl330_probe(struct amba_device *adev, const struct
> amba_id *id)
>  	}
>
>  	pd->dev = &adev->dev;
> +	pd->cap_mask = pdat->cap_mask;
>
>  	pd->device_alloc_chan_resources = pl330_alloc_chan_resources;
>  	pd->device_free_chan_resources = pl330_free_chan_resources;
> diff --git a/include/linux/amba/pl330.h b/include/linux/amba/pl330.h
> index d12f077..0b87300 100644
> --- a/include/linux/amba/pl330.h
> +++ b/include/linux/amba/pl330.h
> @@ -13,15 +13,7 @@
>  #define	__AMBA_PL330_H_
>
>  #include <asm/hardware/pl330.h>
> -
> -struct dma_pl330_peri {
> -	/*
> -	 * Peri_Req i/f of the DMAC that is
> -	 * peripheral could be reached from.
> -	 */
> -	u8 peri_id; /* specific dma id */
> -	enum pl330_reqtype rqtype;
> -};
> +#include <linux/dmaengine.h>
>
>  struct dma_pl330_platdata {
>  	/*
> @@ -33,7 +25,9 @@ struct dma_pl330_platdata {
>  	 */
>  	u8 nr_valid_peri;
>  	/* Array of valid peripherals */
> -	struct dma_pl330_peri *peri;
> +	u8 *peri_id;
> +	/* Operational capabilities */
> +	dma_cap_mask_t cap_mask;
>  	/* Bytes to allocate for MC buffer */
>  	unsigned mcbuf_sz;
>  };
> --
> 1.6.6.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
