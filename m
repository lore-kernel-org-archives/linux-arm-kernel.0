From: balbi@ti.com (Felipe Balbi)
Date: Wed, 14 Jan 2015 11:37:36 -0600
Subject: [PATCH 06/12] usb: gadget: at91_udc: Drop uclk clock
In-Reply-To: <1421252524-24452-7-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421252524-24452-7-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150114173736.GH16533@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 05:21:58PM +0100, Alexandre Belloni wrote:
> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Now that at91 system clocks forward set_rate request to their parent we
> can remove the uclk clock and directly call clk_set_rate on fclk.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/gadget/udc/at91_udc.c | 27 +++------------------------
>  drivers/usb/gadget/udc/at91_udc.h |  2 +-
>  2 files changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
> index 9ff2f7e5c6a7..d33f2994b7c4 100644
> --- a/drivers/usb/gadget/udc/at91_udc.c
> +++ b/drivers/usb/gadget/udc/at91_udc.c
> @@ -895,8 +895,6 @@ static void clk_on(struct at91_udc *udc)
>  		return;
>  	udc->clocked = 1;
>  
> -	if (IS_ENABLED(CONFIG_COMMON_CLK))
> -		clk_enable(udc->uclk);
>  	clk_enable(udc->iclk);
>  	clk_enable(udc->fclk);
>  }
> @@ -909,8 +907,6 @@ static void clk_off(struct at91_udc *udc)
>  	udc->gadget.speed = USB_SPEED_UNKNOWN;
>  	clk_disable(udc->fclk);
>  	clk_disable(udc->iclk);
> -	if (IS_ENABLED(CONFIG_COMMON_CLK))
> -		clk_disable(udc->uclk);
>  }
>  
>  /*
> @@ -1781,25 +1777,17 @@ static int at91udc_probe(struct platform_device *pdev)
>  	/* get interface and function clocks */
>  	udc->iclk = clk_get(dev, "pclk");
>  	udc->fclk = clk_get(dev, "hclk");
> -	if (IS_ENABLED(CONFIG_COMMON_CLK))
> -		udc->uclk = clk_get(dev, "usb_clk");
> -	if (IS_ERR(udc->iclk) || IS_ERR(udc->fclk) ||
> -	    (IS_ENABLED(CONFIG_COMMON_CLK) && IS_ERR(udc->uclk))) {
> +	if (IS_ERR(udc->iclk) || IS_ERR(udc->fclk)) {
>  		DBG("clocks missing\n");
>  		retval = -ENODEV;
>  		goto fail1;
>  	}
>  
>  	/* don't do anything until we have both gadget driver and VBUS */
> -	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
> -		clk_set_rate(udc->uclk, 48000000);
> -		retval = clk_prepare(udc->uclk);
> -		if (retval)
> -			goto fail1;
> -	}
> +	clk_set_rate(udc->fclk, 48000000);
>  	retval = clk_prepare(udc->fclk);
>  	if (retval)
> -		goto fail1a;
> +		goto fail1;
>  
>  	retval = clk_prepare_enable(udc->iclk);
>  	if (retval)
> @@ -1873,12 +1861,7 @@ fail1c:
>  	clk_unprepare(udc->iclk);
>  fail1b:
>  	clk_unprepare(udc->fclk);
> -fail1a:
> -	if (IS_ENABLED(CONFIG_COMMON_CLK))
> -		clk_unprepare(udc->uclk);
>  fail1:
> -	if (IS_ENABLED(CONFIG_COMMON_CLK) && !IS_ERR(udc->uclk))
> -		clk_put(udc->uclk);
>  	if (!IS_ERR(udc->fclk))
>  		clk_put(udc->fclk);
>  	if (!IS_ERR(udc->iclk))
> @@ -1924,15 +1907,11 @@ static int __exit at91udc_remove(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(res->start, resource_size(res));
>  
> -	if (IS_ENABLED(CONFIG_COMMON_CLK))
> -		clk_unprepare(udc->uclk);
>  	clk_unprepare(udc->fclk);
>  	clk_unprepare(udc->iclk);
>  
>  	clk_put(udc->iclk);
>  	clk_put(udc->fclk);
> -	if (IS_ENABLED(CONFIG_COMMON_CLK))
> -		clk_put(udc->uclk);
>  
>  	return 0;
>  }
> diff --git a/drivers/usb/gadget/udc/at91_udc.h b/drivers/usb/gadget/udc/at91_udc.h
> index 017524663381..e647d1c2ada4 100644
> --- a/drivers/usb/gadget/udc/at91_udc.h
> +++ b/drivers/usb/gadget/udc/at91_udc.h
> @@ -126,7 +126,7 @@ struct at91_udc {
>  	unsigned			active_suspend:1;
>  	u8				addr;
>  	struct at91_udc_data		board;
> -	struct clk			*iclk, *fclk, *uclk;
> +	struct clk			*iclk, *fclk;
>  	struct platform_device		*pdev;
>  	struct proc_dir_entry		*pde;
>  	void __iomem			*udp_baseaddr;
> -- 
> 2.1.0
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/ee4ed61a/attachment.sig>
