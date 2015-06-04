From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 4 Jun 2015 09:37:04 +0200
Subject: [PATCH 1/2] dmaengine: at_xdmac: lock fixes
In-Reply-To: <1433343154-5613-1-git-send-email-ludovic.desroches@atmel.com>
References: <1433343154-5613-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <55700020.5070307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/06/2015 16:52, Ludovic Desroches a ?crit :
> Using _bh variant for spin locks causes this kind of warning:
> Starting logging: ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3 at /ssd_drive/linux/kernel/softirq.c:151
> __local_bh_enable_ip+0xe8/0xf4()
> Modules linked in:
> CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 4.1.0-rc2+ #94
> Hardware name: Atmel SAMA5
> [<c0013c04>] (unwind_backtrace) from [<c00118a4>] (show_stack+0x10/0x14)
> [<c00118a4>] (show_stack) from [<c001bbcc>]
> (warn_slowpath_common+0x80/0xac)
> [<c001bbcc>] (warn_slowpath_common) from [<c001bc14>]
> (warn_slowpath_null+0x1c/0x24)
> [<c001bc14>] (warn_slowpath_null) from [<c001e28c>]
> (__local_bh_enable_ip+0xe8/0xf4)
> [<c001e28c>] (__local_bh_enable_ip) from [<c01fdbd0>]
> (at_xdmac_device_terminate_all+0xf4/0x100)
> [<c01fdbd0>] (at_xdmac_device_terminate_all) from [<c02221a4>]
> (atmel_complete_tx_dma+0x34/0xf4)
> [<c02221a4>] (atmel_complete_tx_dma) from [<c01fe4ac>]
> (at_xdmac_tasklet+0x14c/0x1ac)
> [<c01fe4ac>] (at_xdmac_tasklet) from [<c001de58>]
> (tasklet_action+0x68/0xb4)
> [<c001de58>] (tasklet_action) from [<c001dfdc>]
> (__do_softirq+0xfc/0x238)
> [<c001dfdc>] (__do_softirq) from [<c001e140>] (run_ksoftirqd+0x28/0x34)
> [<c001e140>] (run_ksoftirqd) from [<c0033a3c>]
> (smpboot_thread_fn+0x138/0x18c)
> [<c0033a3c>] (smpboot_thread_fn) from [<c0030e7c>] (kthread+0xdc/0xf0)
> [<c0030e7c>] (kthread) from [<c000f480>] (ret_from_fork+0x14/0x34)
> ---[ end trace b57b14a99c1d8812 ]---
> 
> It comes from the fact that devices can called some code from the DMA

Isn't there a typo in the previous line?

> controller with irq disabled. _bh variant is not intended to be used in
> this case since it can enable irqs. Switch to irqsave/irqrestore variant to
> avoid this situation.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: stable at vger.kernel.org # 4.0 and later

Yes:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/dma/at_xdmac.c | 85 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 48 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 9b602a6..4a7e9c6 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -421,8 +421,9 @@ static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
>  	struct at_xdmac_desc	*desc = txd_to_at_desc(tx);
>  	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(tx->chan);
>  	dma_cookie_t		cookie;
> +	unsigned long		irqflags;
>  
> -	spin_lock_bh(&atchan->lock);
> +	spin_lock_irqsave(&atchan->lock, irqflags);
>  	cookie = dma_cookie_assign(tx);
>  
>  	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
> @@ -431,7 +432,7 @@ static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
>  	if (list_is_singular(&atchan->xfers_list))
>  		at_xdmac_start_xfer(atchan, desc);
>  
> -	spin_unlock_bh(&atchan->lock);
> +	spin_unlock_irqrestore(&atchan->lock, irqflags);
>  	return cookie;
>  }
>  
> @@ -591,11 +592,13 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		       unsigned int sg_len, enum dma_transfer_direction direction,
>  		       unsigned long flags, void *context)
>  {
> -	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
> -	struct at_xdmac_desc	*first = NULL, *prev = NULL;
> -	struct scatterlist	*sg;
> -	int			i;
> -	unsigned int		xfer_size = 0;
> +	struct at_xdmac_chan		*atchan = to_at_xdmac_chan(chan);
> +	struct at_xdmac_desc		*first = NULL, *prev = NULL;
> +	struct scatterlist		*sg;
> +	int				i;
> +	unsigned int			xfer_size = 0;
> +	unsigned long			irqflags;
> +	struct dma_async_tx_descriptor	*ret = NULL;
>  
>  	if (!sgl)
>  		return NULL;
> @@ -611,7 +614,7 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		 flags);
>  
>  	/* Protect dma_sconfig field that can be modified by set_slave_conf. */
> -	spin_lock_bh(&atchan->lock);
> +	spin_lock_irqsave(&atchan->lock, irqflags);
>  
>  	/* Prepare descriptors. */
>  	for_each_sg(sgl, sg, sg_len, i) {
> @@ -622,8 +625,7 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		mem = sg_dma_address(sg);
>  		if (unlikely(!len)) {
>  			dev_err(chan2dev(chan), "sg data length is zero\n");
> -			spin_unlock_bh(&atchan->lock);
> -			return NULL;
> +			goto spin_unlock;
>  		}
>  		dev_dbg(chan2dev(chan), "%s: * sg%d len=%u, mem=0x%08x\n",
>  			 __func__, i, len, mem);
> @@ -633,8 +635,7 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  			dev_err(chan2dev(chan), "can't get descriptor\n");
>  			if (first)
>  				list_splice_init(&first->descs_list, &atchan->free_descs_list);
> -			spin_unlock_bh(&atchan->lock);
> -			return NULL;
> +			goto spin_unlock;
>  		}
>  
>  		/* Linked list descriptor setup. */
> @@ -673,13 +674,15 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		xfer_size += len;
>  	}
>  
> -	spin_unlock_bh(&atchan->lock);
>  
>  	first->tx_dma_desc.flags = flags;
>  	first->xfer_size = xfer_size;
>  	first->direction = direction;
> +	ret = &first->tx_dma_desc;
>  
> -	return &first->tx_dma_desc;
> +spin_unlock:
> +	spin_unlock_irqrestore(&atchan->lock, irqflags);
> +	return ret;
>  }
>  
>  static struct dma_async_tx_descriptor *
> @@ -692,6 +695,7 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
>  	struct at_xdmac_desc	*first = NULL, *prev = NULL;
>  	unsigned int		periods = buf_len / period_len;
>  	int			i;
> +	unsigned long		irqflags;
>  
>  	dev_dbg(chan2dev(chan), "%s: buf_addr=%pad, buf_len=%zd, period_len=%zd, dir=%s, flags=0x%lx\n",
>  		__func__, &buf_addr, buf_len, period_len,
> @@ -710,16 +714,16 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
>  	for (i = 0; i < periods; i++) {
>  		struct at_xdmac_desc	*desc = NULL;
>  
> -		spin_lock_bh(&atchan->lock);
> +		spin_lock_irqsave(&atchan->lock, irqflags);
>  		desc = at_xdmac_get_desc(atchan);
>  		if (!desc) {
>  			dev_err(chan2dev(chan), "can't get descriptor\n");
>  			if (first)
>  				list_splice_init(&first->descs_list, &atchan->free_descs_list);
> -			spin_unlock_bh(&atchan->lock);
> +			spin_unlock_irqrestore(&atchan->lock, irqflags);
>  			return NULL;
>  		}
> -		spin_unlock_bh(&atchan->lock);
> +		spin_unlock_irqrestore(&atchan->lock, irqflags);
>  		dev_dbg(chan2dev(chan),
>  			"%s: desc=0x%p, tx_dma_desc.phys=%pad\n",
>  			__func__, desc, &desc->tx_dma_desc.phys);
> @@ -1036,6 +1040,7 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  					| AT_XDMAC_CC_SIF(0)
>  					| AT_XDMAC_CC_MBSIZE_SIXTEEN
>  					| AT_XDMAC_CC_TYPE_MEM_TRAN;
> +	unsigned long		irqflags;
>  
>  	dev_dbg(chan2dev(chan), "%s: src=%pad, dest=%pad, len=%zd, flags=0x%lx\n",
>  		__func__, &src, &dest, len, flags);
> @@ -1051,9 +1056,9 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  
>  		dev_dbg(chan2dev(chan), "%s: remaining_size=%zu\n", __func__, remaining_size);
>  
> -		spin_lock_bh(&atchan->lock);
> +		spin_lock_irqsave(&atchan->lock, irqflags);
>  		desc = at_xdmac_get_desc(atchan);
> -		spin_unlock_bh(&atchan->lock);
> +		spin_unlock_irqrestore(&atchan->lock, irqflags);
>  		if (!desc) {
>  			dev_err(chan2dev(chan), "can't get descriptor\n");
>  			if (first)
> @@ -1123,6 +1128,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  	int			residue;
>  	u32			cur_nda, mask, value;
>  	u8			dwidth = 0;
> +	unsigned long		flags;
>  
>  	ret = dma_cookie_status(chan, cookie, txstate);
>  	if (ret == DMA_COMPLETE)
> @@ -1131,7 +1137,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  	if (!txstate)
>  		return ret;
>  
> -	spin_lock_bh(&atchan->lock);
> +	spin_lock_irqsave(&atchan->lock, flags);
>  
>  	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc, xfer_node);
>  
> @@ -1141,8 +1147,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  	 */
>  	if (!desc->active_xfer) {
>  		dma_set_residue(txstate, desc->xfer_size);
> -		spin_unlock_bh(&atchan->lock);
> -		return ret;
> +		goto spin_unlock;
>  	}
>  
>  	residue = desc->xfer_size;
> @@ -1173,14 +1178,14 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
>  	}
>  	residue += at_xdmac_chan_read(atchan, AT_XDMAC_CUBC) << dwidth;
>  
> -	spin_unlock_bh(&atchan->lock);
> -
>  	dma_set_residue(txstate, residue);
>  
>  	dev_dbg(chan2dev(chan),
>  		 "%s: desc=0x%p, tx_dma_desc.phys=%pad, tx_status=%d, cookie=%d, residue=%d\n",
>  		 __func__, desc, &desc->tx_dma_desc.phys, ret, cookie, residue);
>  
> +spin_unlock:
> +	spin_unlock_irqrestore(&atchan->lock, flags);
>  	return ret;
>  }
>  
> @@ -1201,8 +1206,9 @@ static void at_xdmac_remove_xfer(struct at_xdmac_chan *atchan,
>  static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
>  {
>  	struct at_xdmac_desc	*desc;
> +	unsigned long		flags;
>  
> -	spin_lock_bh(&atchan->lock);
> +	spin_lock_irqsave(&atchan->lock, flags);
>  
>  	/*
>  	 * If channel is enabled, do nothing, advance_work will be triggered
> @@ -1217,7 +1223,7 @@ static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
>  			at_xdmac_start_xfer(atchan, desc);
>  	}
>  
> -	spin_unlock_bh(&atchan->lock);
> +	spin_unlock_irqrestore(&atchan->lock, flags);
>  }
>  
>  static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
> @@ -1353,12 +1359,13 @@ static int at_xdmac_device_config(struct dma_chan *chan,
>  {
>  	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
>  	int ret;
> +	unsigned long		flags;
>  
>  	dev_dbg(chan2dev(chan), "%s\n", __func__);
>  
> -	spin_lock_bh(&atchan->lock);
> +	spin_lock_irqsave(&atchan->lock, flags);
>  	ret = at_xdmac_set_slave_config(chan, config);
> -	spin_unlock_bh(&atchan->lock);
> +	spin_unlock_irqrestore(&atchan->lock, flags);
>  
>  	return ret;
>  }
> @@ -1367,18 +1374,19 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
>  {
>  	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
>  	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
> +	unsigned long		flags;
>  
>  	dev_dbg(chan2dev(chan), "%s\n", __func__);
>  
>  	if (test_and_set_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status))
>  		return 0;
>  
> -	spin_lock_bh(&atchan->lock);
> +	spin_lock_irqsave(&atchan->lock, flags);
>  	at_xdmac_write(atxdmac, AT_XDMAC_GRWS, atchan->mask);
>  	while (at_xdmac_chan_read(atchan, AT_XDMAC_CC)
>  	       & (AT_XDMAC_CC_WRIP | AT_XDMAC_CC_RDIP))
>  		cpu_relax();
> -	spin_unlock_bh(&atchan->lock);
> +	spin_unlock_irqrestore(&atchan->lock, flags);
>  
>  	return 0;
>  }
> @@ -1387,18 +1395,19 @@ static int at_xdmac_device_resume(struct dma_chan *chan)
>  {
>  	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
>  	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
> +	unsigned long		flags;
>  
>  	dev_dbg(chan2dev(chan), "%s\n", __func__);
>  
> -	spin_lock_bh(&atchan->lock);
> +	spin_lock_irqsave(&atchan->lock, flags);
>  	if (!at_xdmac_chan_is_paused(atchan)) {
> -		spin_unlock_bh(&atchan->lock);
> +		spin_unlock_irqrestore(&atchan->lock, flags);
>  		return 0;
>  	}
>  
>  	at_xdmac_write(atxdmac, AT_XDMAC_GRWR, atchan->mask);
>  	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
> -	spin_unlock_bh(&atchan->lock);
> +	spin_unlock_irqrestore(&atchan->lock, flags);
>  
>  	return 0;
>  }
> @@ -1408,10 +1417,11 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
>  	struct at_xdmac_desc	*desc, *_desc;
>  	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
>  	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
> +	unsigned long		flags;
>  
>  	dev_dbg(chan2dev(chan), "%s\n", __func__);
>  
> -	spin_lock_bh(&atchan->lock);
> +	spin_lock_irqsave(&atchan->lock, flags);
>  	at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
>  	while (at_xdmac_read(atxdmac, AT_XDMAC_GS) & atchan->mask)
>  		cpu_relax();
> @@ -1421,7 +1431,7 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
>  		at_xdmac_remove_xfer(atchan, desc);
>  
>  	clear_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
> -	spin_unlock_bh(&atchan->lock);
> +	spin_unlock_irqrestore(&atchan->lock, flags);
>  
>  	return 0;
>  }
> @@ -1431,8 +1441,9 @@ static int at_xdmac_alloc_chan_resources(struct dma_chan *chan)
>  	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
>  	struct at_xdmac_desc	*desc;
>  	int			i;
> +	unsigned long		flags;
>  
> -	spin_lock_bh(&atchan->lock);
> +	spin_lock_irqsave(&atchan->lock, flags);
>  
>  	if (at_xdmac_chan_is_enabled(atchan)) {
>  		dev_err(chan2dev(chan),
> @@ -1463,7 +1474,7 @@ static int at_xdmac_alloc_chan_resources(struct dma_chan *chan)
>  	dev_dbg(chan2dev(chan), "%s: allocated %d descriptors\n", __func__, i);
>  
>  spin_unlock:
> -	spin_unlock_bh(&atchan->lock);
> +	spin_unlock_irqrestore(&atchan->lock, flags);
>  	return i;
>  }
>  
> 


-- 
Nicolas Ferre
