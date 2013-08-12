From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 12 Aug 2013 12:45:23 +0530
Subject: [PATCH v3 01/12] dma: edma: Setup parameters to DMA MAX_NR_SG
 at a time
In-Reply-To: <1375719297-12871-2-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
 <1375719297-12871-2-git-send-email-joelf@ti.com>
Message-ID: <52088B8B.9040000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 August 2013 09:44 PM, Joel Fernandes wrote:
> Changes are made here for configuring existing parameters to support
> DMA'ing them out in batches as needed.
> 
> Also allocate as many as slots as needed by the SG list, but not more
> than MAX_NR_SG. Then these slots will be reused accordingly.
> For ex, if MAX_NR_SG=10, and number of SG entries is 40, still only
> 10 slots will be allocated to DMA the entire SG list of size 40.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>  drivers/dma/edma.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index 5f3e532..7b0853c 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -222,9 +222,9 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>  	enum dma_slave_buswidth dev_width;
>  	u32 burst;
>  	struct scatterlist *sg;
> -	int i;
>  	int acnt, bcnt, ccnt, src, dst, cidx;
>  	int src_bidx, dst_bidx, src_cidx, dst_cidx;
> +	int i, num_slots_needed;

'nslots' is more to my liking. Better keep variable names short.

>  
>  	if (unlikely(!echan || !sgl || !sg_len))
>  		return NULL;
> @@ -262,8 +262,11 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>  
>  	edesc->pset_nr = sg_len;
>  
> -	for_each_sg(sgl, sg, sg_len, i) {
> -		/* Allocate a PaRAM slot, if needed */
> +	/* Allocate a PaRAM slot, if needed */
> +
> +	num_slots_needed = sg_len > MAX_NR_SG ? MAX_NR_SG : sg_len;

nslots = min(MAX_NR_SG, sg_len);

> +
> +	for (i = 0; i < num_slots_needed; i++) {
>  		if (echan->slot[i] < 0) {
>  			echan->slot[i] =
>  				edma_alloc_slot(EDMA_CTLR(echan->ch_num),
> @@ -273,6 +276,10 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>  				return NULL;
>  			}
>  		}
> +	}
> +
> +	/* Configure PaRAM sets for each SG */
> +	for_each_sg(sgl, sg, sg_len, i) {
>  
>  		acnt = dev_width;
>  
> @@ -330,6 +337,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>  		/* Configure A or AB synchronized transfers */
>  		if (edesc->absync)
>  			edesc->pset[i].opt |= SYNCDIM;
> +

Random extra newline.

The patch as such is fine, but I dont think it makes lot of sense
standalone. This needs to be merged into the patch where you actually
handle the entire SG list in batches.

Thanks,
Sekhar
