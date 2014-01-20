From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 20 Jan 2014 15:29:17 +0530
Subject: [PATCH] dma: fix vchan_cookie_complete() debug print
In-Reply-To: <1386344529-25617-1-git-send-email-jonas.jensen@gmail.com>
References: <1386344529-25617-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20140120095917.GZ26823@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 04:42:09PM +0100, Jonas Jensen wrote:
> vd->tx.cookie is set zero on dma_cookie_complete(),
> save to local before printing it.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---
> 
> Notes:
>     dev_vdbg() could also be moved to happen earlier, what do you prefer?
This would be preferred IMHO. Also pls cc dmaengine at vger on this

--
~Vinod
>     
>     Applies to next-20131206
> 
>  drivers/dma/virt-dma.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index 85c19d6..181b9526 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -84,10 +84,12 @@ static inline bool vchan_issue_pending(struct virt_dma_chan *vc)
>  static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
>  {
>  	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
> +	dma_cookie_t cookie;
>  
> +	cookie = vd->tx.cookie;
>  	dma_cookie_complete(&vd->tx);
>  	dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
> -		vd, vd->tx.cookie);
> +		 vd, cookie);
>  	list_add_tail(&vd->node, &vc->desc_completed);
>  
>  	tasklet_schedule(&vc->task);
> -- 
> 1.8.2.1
> 

-- 
