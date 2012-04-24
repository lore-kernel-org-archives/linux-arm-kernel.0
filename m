From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 24 Apr 2012 16:05:29 +0530
Subject: [PATCH 3/8] dmaengine: split out virtual channel DMA support
 from sa11x0 driver
In-Reply-To: <E1SKRr2-0004bC-8a@rmk-PC.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRr2-0004bC-8a@rmk-PC.arm.linux.org.uk>
Message-ID: <4F9681F1.2090408@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012 03:41 PM, Russell King wrote:
> +/**
> + * vchan_cookie_complete - report completion of a descriptor
> + * vd: virtual descriptor to update
> + *
> + * vc.lock must be held by caller
> + */
> +static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
> +{
> +       struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
> +
> +       dma_cookie_complete(&vd->tx);
> +       dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
> +               vd, vd->tx.cookie);
> +       list_add_tail(&vd->node,&vc->desc_completed);
> +
> +       tasklet_schedule(&vc->task);
> +}

For cyclic case, we will not like to call the  dma_cookie_complete() but 
want to put the desc in callback list.
So can we have one more arg on this function which byspass the call of 
dma_cookie_complete()
