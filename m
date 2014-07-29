From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 29 Jul 2014 21:06:12 +0200
Subject: [PATCH 2/7] dmaengine: omap-dma: complete the transfer on
 terminate_all
In-Reply-To: <1406660344-25307-3-git-send-email-bigeasy@linutronix.de>
References: <1406660344-25307-1-git-send-email-bigeasy@linutronix.de>
 <1406660344-25307-3-git-send-email-bigeasy@linutronix.de>
Message-ID: <53D7F0A4.2050301@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2014 08:58 PM, Sebastian Andrzej Siewior wrote:
> diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
> index b19f04f..81ede01 100644
> --- a/drivers/dma/omap-dma.c
> +++ b/drivers/dma/omap-dma.c
> @@ -970,6 +970,12 @@ static int omap_dma_terminate_all(struct omap_chan *c)
>  
>  	/* Prevent this channel being scheduled */
>  	spin_lock(&d->lock);
> +	if (!c->desc && !list_empty(&c->node)) {
> +		struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
> +
> +		if (vd)
> +			dma_cookie_complete(&vd->tx);
> +	}

Why is start of the transfer deferred to the tasklet unless it is a
periodic transfer? Couldn't it be started right away?

>  	list_del_init(&c->node);
>  	spin_unlock(&d->lock);
>  

Sebastian
