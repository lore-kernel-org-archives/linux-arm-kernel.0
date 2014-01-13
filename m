From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jan 2014 14:18:30 -0800
Subject: [PATCH RFC 05/26] dmaengine: omap-dma: control start/stop directly
In-Reply-To: <E1Vyju0-0005EE-6a@rmk-PC.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <E1Vyju0-0005EE-6a@rmk-PC.arm.linux.org.uk>
Message-ID: <20140113221830.GE7993@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140102 07:14]:
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -570,20 +695,27 @@ static int omap_dma_terminate_all(struct omap_chan *c)
>  
>  	/*
>  	 * Stop DMA activity: we assume the callback will not be called
> -	 * after omap_stop_dma() returns (even if it does, it will see
> +	 * after omap_dma_stop() returns (even if it does, it will see
>  	 * c->desc is NULL and exit.)
>  	 */
>  	if (c->desc) {
>  		c->desc = NULL;
>  		/* Avoid stopping the dma twice */
>  		if (!c->paused)
> -			omap_stop_dma(c->dma_ch);
> +			omap_dma_stop(c);
>  	}
>  
>  	if (c->cyclic) {
>  		c->cyclic = false;
>  		c->paused = false;
> -		omap_dma_unlink_lch(c->dma_ch, c->dma_ch);
> +
> +		if (__dma_omap15xx(od->plat->dma_attr)) {
> +			uint32_t val;
> +
> +			val = c->plat->dma_read(CCR, c->dma_ch);
> +			val &= ~(3 << 8);
> +			c->plat->dma_write(val, CCR, c->dma_ch);
> +		}
>  	}
>  
>  	vchan_get_all_descriptors(&c->vc, &head);

This won't build for omap1 as od is just d in this function. Something
like the following needs to be folded in.

Tony

8< -----------------------
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -682,16 +682,16 @@ static int omap_dma_slave_config(struct omap_chan *c, struct dma_slave_config *c
 
 static int omap_dma_terminate_all(struct omap_chan *c)
 {
-	struct omap_dmadev *d = to_omap_dma_dev(c->vc.chan.device);
+	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
 	unsigned long flags;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&c->vc.lock, flags);
 
 	/* Prevent this channel being scheduled */
-	spin_lock(&d->lock);
+	spin_lock(&od->lock);
 	list_del_init(&c->node);
-	spin_unlock(&d->lock);
+	spin_unlock(&od->lock);
 
 	/*
 	 * Stop DMA activity: we assume the callback will not be called
