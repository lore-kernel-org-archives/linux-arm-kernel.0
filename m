From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 9 Feb 2016 09:06:46 +0530
Subject: [PATCH] dmaengine: pxa_dma: fix the maximum requestor line
In-Reply-To: <1454941131-12308-1-git-send-email-robert.jarzmik@free.fr>
References: <1454941131-12308-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160209033646.GK19598@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 03:18:51PM +0100, Robert Jarzmik wrote:
> The current number of requestor lines is limited to 31. This was an
> error of a previous commit, as this number is platform dependent, and is
> actually :
>  - for pxa25x: 40 requestor lines
>  - for pxa27x: 74 requestor lines
>  - for pxa3xx: 100 requestor lines
> 
> As the driver doesn't need to know the exact number, but only an

and why would that be a good assumption?

Btw shouldn't this data come from DT?

> absolute maximum value above which is it not using any flow control, set
> the maximum to 0x8000 requestor lines, which should never be reached.
> 
> The previous testing did not reveal the faulty constant as on pxa[23]xx
> platforms, only camera, MSL and USB are above requestor 32, and in these
> only the camera has a driver using dma.
> 
> Fixes: e87ffbdf0697 ("dmaengine: pxa_dma: fix the no-requestor case")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/dma/pxa_dma.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index ca6c088edc8a..817a2bdc423d 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -53,6 +53,7 @@
>  
>  #define DRCMR_MAPVLD	BIT(7)	/* Map Valid (read / write) */
>  #define DRCMR_CHLNUM	0x1f	/* mask for Channel Number (read / write) */
> +#define DRCMR_MAXREQST	0x7fff	/* Maximum requestor line */
>  
>  #define DDADR_DESCADDR	0xfffffff0	/* Address of next descriptor (mask) */
>  #define DDADR_STOP	BIT(0)	/* Stop (read / write) */
> @@ -473,7 +474,7 @@ static void pxad_free_phy(struct pxad_chan *chan)
>  		return;
>  
>  	/* clear the channel mapping in DRCMR */
> -	if (chan->drcmr <= DRCMR_CHLNUM) {
> +	if (chan->drcmr <= DRCMR_MAXREQST) {
>  		reg = pxad_drcmr(chan->drcmr);
>  		writel_relaxed(0, chan->phy->base + reg);
>  	}
> @@ -518,7 +519,7 @@ static void phy_enable(struct pxad_phy *phy, bool misaligned)
>  		"%s(); phy=%p(%d) misaligned=%d\n", __func__,
>  		phy, phy->idx, misaligned);
>  
> -	if (phy->vchan->drcmr <= DRCMR_CHLNUM) {
> +	if (phy->vchan->drcmr <= DRCMR_MAXREQST) {
>  		reg = pxad_drcmr(phy->vchan->drcmr);
>  		writel_relaxed(DRCMR_MAPVLD | phy->idx, phy->base + reg);
>  	}
> @@ -922,7 +923,7 @@ static void pxad_get_config(struct pxad_chan *chan,
>  		dev_addr = chan->cfg.src_addr;
>  		*dev_src = dev_addr;
>  		*dcmd |= PXA_DCMD_INCTRGADDR;
> -		if (chan->drcmr <= DRCMR_CHLNUM)
> +		if (chan->drcmr <= DRCMR_MAXREQST)
>  			*dcmd |= PXA_DCMD_FLOWSRC;
>  	}
>  	if (dir == DMA_MEM_TO_DEV) {
> @@ -931,7 +932,7 @@ static void pxad_get_config(struct pxad_chan *chan,
>  		dev_addr = chan->cfg.dst_addr;
>  		*dev_dst = dev_addr;
>  		*dcmd |= PXA_DCMD_INCSRCADDR;
> -		if (chan->drcmr <= DRCMR_CHLNUM)
> +		if (chan->drcmr <= DRCMR_MAXREQST)
>  			*dcmd |= PXA_DCMD_FLOWTRG;
>  	}
>  	if (dir == DMA_MEM_TO_MEM)
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod
