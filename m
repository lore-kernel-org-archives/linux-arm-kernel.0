From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 4 Feb 2014 10:53:29 +0530
Subject: [PATCH] dma: mv_xor: Silence a bunch of LPAE-related warnings
In-Reply-To: <1391476403-26099-1-git-send-email-olof@lixom.net>
References: <1391476403-26099-1-git-send-email-olof@lixom.net>
Message-ID: <20140204052329.GN10628@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 05:13:23PM -0800, Olof Johansson wrote:
> Enabling some of the mvebu platforms in the multiplatform config for ARM
> enabled these drivers, which also triggered a bunch of warnings when LPAE
> is enabled (thus making phys_addr_t 64-bit).
> 
> Most changes are switching printk formats, but also a bit of changes to what
> used to be array-based pointer arithmetic that could just be done with the
> address types instead.
> 
> The warnings were:
> 
> drivers/dma/mv_xor.c: In function 'mv_xor_tx_submit':
> drivers/dma/mv_xor.c:500:3: warning: format '%x' expects argument of type
>     'unsigned int', but argument 4 has type 'dma_addr_t' [-Wformat]
> drivers/dma/mv_xor.c: In function 'mv_xor_alloc_chan_resources':
> drivers/dma/mv_xor.c:553:13: warning: cast to pointer from integer of
>     different size [-Wint-to-pointer-cast]
> drivers/dma/mv_xor.c:555:4: warning: cast from pointer to integer of
>     different size [-Wpointer-to-int-cast]
> drivers/dma/mv_xor.c: In function 'mv_xor_prep_dma_memcpy':
> drivers/dma/mv_xor.c:584:2: warning: format '%x' expects argument of type
>     'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat]
> drivers/dma/mv_xor.c:584:2: warning: format '%x' expects argument of type
>     'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat]
> drivers/dma/mv_xor.c: In function 'mv_xor_prep_dma_xor':
> drivers/dma/mv_xor.c:628:2: warning: format '%u' expects argument of type
>     'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat]
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod

> ---
>  drivers/dma/mv_xor.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 53fb0c8365b0..766b68ed505c 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -497,8 +497,8 @@ mv_xor_tx_submit(struct dma_async_tx_descriptor *tx)
>  		if (!mv_can_chain(grp_start))
>  			goto submit_done;
>  
> -		dev_dbg(mv_chan_to_devp(mv_chan), "Append to last desc %x\n",
> -			old_chain_tail->async_tx.phys);
> +		dev_dbg(mv_chan_to_devp(mv_chan), "Append to last desc %pa\n",
> +			&old_chain_tail->async_tx.phys);
>  
>  		/* fix up the hardware chain */
>  		mv_desc_set_next_desc(old_chain_tail, grp_start->async_tx.phys);
> @@ -527,7 +527,8 @@ submit_done:
>  /* returns the number of allocated descriptors */
>  static int mv_xor_alloc_chan_resources(struct dma_chan *chan)
>  {
> -	char *hw_desc;
> +	void *virt_desc;
> +	dma_addr_t dma_desc;
>  	int idx;
>  	struct mv_xor_chan *mv_chan = to_mv_xor_chan(chan);
>  	struct mv_xor_desc_slot *slot = NULL;
> @@ -542,17 +543,16 @@ static int mv_xor_alloc_chan_resources(struct dma_chan *chan)
>  				" %d descriptor slots", idx);
>  			break;
>  		}
> -		hw_desc = (char *) mv_chan->dma_desc_pool_virt;
> -		slot->hw_desc = (void *) &hw_desc[idx * MV_XOR_SLOT_SIZE];
> +		virt_desc = mv_chan->dma_desc_pool_virt;
> +		slot->hw_desc = virt_desc + idx * MV_XOR_SLOT_SIZE;
>  
>  		dma_async_tx_descriptor_init(&slot->async_tx, chan);
>  		slot->async_tx.tx_submit = mv_xor_tx_submit;
>  		INIT_LIST_HEAD(&slot->chain_node);
>  		INIT_LIST_HEAD(&slot->slot_node);
>  		INIT_LIST_HEAD(&slot->tx_list);
> -		hw_desc = (char *) mv_chan->dma_desc_pool;
> -		slot->async_tx.phys =
> -			(dma_addr_t) &hw_desc[idx * MV_XOR_SLOT_SIZE];
> +		dma_desc = mv_chan->dma_desc_pool;
> +		slot->async_tx.phys = dma_desc + idx * MV_XOR_SLOT_SIZE;
>  		slot->idx = idx++;
>  
>  		spin_lock_bh(&mv_chan->lock);
> @@ -582,8 +582,8 @@ mv_xor_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  	int slot_cnt;
>  
>  	dev_dbg(mv_chan_to_devp(mv_chan),
> -		"%s dest: %x src %x len: %u flags: %ld\n",
> -		__func__, dest, src, len, flags);
> +		"%s dest: %pad src %pad len: %u flags: %ld\n",
> +		__func__, &dest, &src, len, flags);
>  	if (unlikely(len < MV_XOR_MIN_BYTE_COUNT))
>  		return NULL;
>  
> @@ -626,8 +626,8 @@ mv_xor_prep_dma_xor(struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
>  	BUG_ON(len > MV_XOR_MAX_BYTE_COUNT);
>  
>  	dev_dbg(mv_chan_to_devp(mv_chan),
> -		"%s src_cnt: %d len: dest %x %u flags: %ld\n",
> -		__func__, src_cnt, len, dest, flags);
> +		"%s src_cnt: %d len: %u dest %pad flags: %ld\n",
> +		__func__, src_cnt, len, &dest, flags);
>  
>  	spin_lock_bh(&mv_chan->lock);
>  	slot_cnt = mv_chan_xor_slot_count(len, src_cnt);
> -- 
> 1.8.4.1.601.g02b3b1d
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
