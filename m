From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 May 2011 08:39:54 +0200
Subject: [PATCH] [RFC] USB: fsl_udc_core: fix build-failure for ARM
In-Reply-To: <1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110505135029.0c068b8e@wker>
	<1304672405-1102-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110511063954.GJ29089@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Greg,

On Fri, May 06, 2011 at 11:00:05AM +0200, Uwe Kleine-K?nig wrote:
> Commit
> 
> 	09ba0de (USB: fsl_udc_core: prepare for SoCs with BE registers and descriptors)
> 
> introduced two function pointers _fsl_readl and _fsl_writel in an #ifdef
> CONFIG_PPC32 block and used then unconditionally in fsl_udc_probe.
> To make the driver compile again this use has to be protected by
> an #ifdef, too. Moreover ARM doesn't have flush_dcache_range so this
> is #ifdefed out, too.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I'm unsure about getting rid of the flush_dcache_range. If powerpc needs
> a flush ARM probably does, too, no?
> If so, what it the right thing to do? Implement flush_dcache_range for
> ARM (just wrapping flush_dcache_page?)?
As Russell seem to be OK with the #ifdef, can you please take this
patch?
 
Thanks
Uwe

>  drivers/usb/gadget/fsl_udc_core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
> index 999eafe..47152e0 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -1333,8 +1333,10 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
>  	/* Fill in the reqest structure */
>  	*((u16 *) req->req.buf) = cpu_to_le16(tmp);
>  
> +#ifdef CONFIG_PPC32
>  	/* flush cache for the req buffer */
>  	flush_dcache_range((u32)req->req.buf, (u32)req->req.buf + 8);
> +#endif
>  
>  	req->ep = ep;
>  	req->req.length = 2;
> @@ -2455,6 +2457,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Set accessors only after pdata->init() ! */
> +#ifdef CONFIG_PPC32
>  	if (pdata->big_endian_mmio) {
>  		_fsl_readl = _fsl_readl_be;
>  		_fsl_writel = _fsl_writel_be;
> @@ -2462,6 +2465,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
>  		_fsl_readl = _fsl_readl_le;
>  		_fsl_writel = _fsl_writel_le;
>  	}
> +#endif
>  
>  #ifndef CONFIG_ARCH_MXC
>  	if (pdata->have_sysif_regs)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
