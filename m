From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 18:46:18 +0800
Subject: [PATCH] usb: chipidea: cleanup dma_pool if udc_start() fails
In-Reply-To: <1346149885-3084-1-git-send-email-mkl@pengutronix.de>
References: <1346149885-3084-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20120828104617.GZ4011@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 12:31:25PM +0200, Marc Kleine-Budde wrote:
> If udc_start() fails the qh_pool dma-pool cannot be closed because
> it's still in use. This patch factors out the dma_pool_free() loop
> into destroy_eps() and calls it in the error path of udc_start(),
> too.
> 
> Cc: Richard Zhao <richard.zhao@freescale.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
> 
> Richard, can you please include this patch in your stack. IIRC I think it once
> was, but now it's not anymore.
Sorry for that. I just push it to my topics/usb-driver branch.
Of course, it's better, if Alex can give a ACK and Greg could pick up.

Thanks
Richard
> 
> regards, Marc
> 
>  drivers/usb/chipidea/udc.c |   23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> index 2cb4498..0b18191 100644
> --- a/drivers/usb/chipidea/udc.c
> +++ b/drivers/usb/chipidea/udc.c
> @@ -1507,6 +1507,17 @@ static int init_eps(struct ci13xxx *ci)
>  	return retval;
>  }
>  
> +static void destroy_eps(struct ci13xxx *ci)
> +{
> +	int i;
> +
> +	for (i = 0; i < ci->hw_ep_max; i++) {
> +		struct ci13xxx_ep *mEp = &ci->ci13xxx_ep[i];
> +
> +		dma_pool_free(ci->qh_pool, mEp->qh.ptr, mEp->qh.dma);
> +	}
> +}
> +
>  /**
>   * ci13xxx_start: register a gadget driver
>   * @gadget: our gadget
> @@ -1723,7 +1734,7 @@ static int udc_start(struct ci13xxx *ci)
>  	if (ci->platdata->flags & CI13XXX_REQUIRE_TRANSCEIVER) {
>  		if (ci->transceiver == NULL) {
>  			retval = -ENODEV;
> -			goto free_pools;
> +			goto destroy_eps;
>  		}
>  	}
>  
> @@ -1775,6 +1786,8 @@ unreg_device:
>  put_transceiver:
>  	if (!IS_ERR_OR_NULL(ci->transceiver) && ci->global_phy)
>  		usb_put_phy(ci->transceiver);
> +destroy_eps:
> +	destroy_eps(ci);
>  free_pools:
>  	dma_pool_destroy(ci->td_pool);
>  free_qh_pool:
> @@ -1790,8 +1803,6 @@ free_qh_pool:
>   */
>  static void udc_stop(struct ci13xxx *ci)
>  {
> -	int i;
> -
>  	if (ci == NULL)
>  		return;
>  
> @@ -1800,11 +1811,7 @@ static void udc_stop(struct ci13xxx *ci)
>  
>  	usb_del_gadget_udc(&ci->gadget);
>  
> -	for (i = 0; i < ci->hw_ep_max; i++) {
> -		struct ci13xxx_ep *mEp = &ci->ci13xxx_ep[i];
> -
> -		dma_pool_free(ci->qh_pool, mEp->qh.ptr, mEp->qh.dma);
> -	}
> +	destroy_eps(ci);
>  
>  	dma_pool_destroy(ci->td_pool);
>  	dma_pool_destroy(ci->qh_pool);
> -- 
> 1.7.10.4
> 
> 
