From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 20 Sep 2010 16:48:30 +0200
Subject: [PATCH] [RFC][ARM] pxa: rework pxa3xx-ulpi driver calls for
	ohci-pxa27x
In-Reply-To: <1283868849-7079-1-git-send-email-grinberg@compulab.co.il>
References: <1283868849-7079-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <4C97743E.7080707@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 ping

On 09/07/10 17:14, Igor Grinberg wrote:
> This patch reworks Marek's quick fix for pxa3xx-u2d crash when ULPI not
> used by:
> 1) Introducing the struct u2d_hc_ops for start/stop the U2DC Host mode.
> 2) Enabling the Host functionality only when ULPI is used.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-pxa/cm-x300.c                 |    1 +
>  arch/arm/mach-pxa/include/mach/ohci.h       |    2 +
>  arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h |   12 +++--
>  arch/arm/mach-pxa/pxa3xx-ulpi.c             |   66 +++++++++++++++++++--------
>  drivers/usb/host/ohci-pxa27x.c              |    8 ++--
>  5 files changed, 62 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index 8e0b562..952b475 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -566,6 +566,7 @@ static struct pxaohci_platform_data cm_x300_ohci_platform_data = {
>  
>  static void __init cm_x300_init_ohci(void)
>  {
> +	cm_x300_ohci_platform_data.u2d_hc_ops = pxa3xx_get_u2d_hc_ops();
>  	pxa_set_ohci_info(&cm_x300_ohci_platform_data);
>  }
>  #else
> diff --git a/arch/arm/mach-pxa/include/mach/ohci.h b/arch/arm/mach-pxa/include/mach/ohci.h
> index 95b6e2a..0924e26 100644
> --- a/arch/arm/mach-pxa/include/mach/ohci.h
> +++ b/arch/arm/mach-pxa/include/mach/ohci.h
> @@ -29,6 +29,8 @@ struct pxaohci_platform_data {
>  #define PMM_PERPORT_MODE       3
>  
>  	int power_budget;
> +
> +	struct pxa3xx_u2d_hc_ops *u2d_hc_ops;
>  };
>  
>  extern void pxa_set_ohci_info(struct pxaohci_platform_data *info);
> diff --git a/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h b/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
> index 9d82cb6..6f37f43 100644
> --- a/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
> +++ b/arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
> @@ -25,10 +25,14 @@ struct pxa3xx_u2d_platform_data {
>  };
>  
>  
> -/* Start PXA3xx U2D host */
> -int pxa3xx_u2d_start_hc(struct usb_bus *host);
> -/* Stop PXA3xx U2D host */
> -void pxa3xx_u2d_stop_hc(struct usb_bus *host);
> +struct pxa3xx_u2d_hc_ops {
> +	/* Start PXA3xx U2D host */
> +	int (*start_hc)(struct usb_bus *host);
> +	/* Stop PXA3xx U2D host */
> +	void (*stop_hc)(struct usb_bus *host);
> +};
> +
> +struct pxa3xx_u2d_hc_ops *pxa3xx_get_u2d_hc_ops(void);
>  
>  extern void pxa3xx_set_u2d_info(struct pxa3xx_u2d_platform_data *info);
>  
> diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> index ce7168b..7e76cbe 100644
> --- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
> +++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> @@ -234,27 +234,18 @@ static void pxa310_otg_exit(void)
>  {
>  	kfree(u2d->otg);
>  }
> -#else
> -static inline void pxa310_u2d_setup_otg_hc(void) {}
> -static inline int pxa310_start_otg_hc(struct usb_bus *host)
> -{
> -	return 0;
> -}
> -static inline void pxa310_stop_otg_hc(void) {}
> -static inline int pxa310_otg_init(struct pxa3xx_u2d_platform_data *pdata)
> -{
> -	return 0;
> -}
> -static inline void pxa310_otg_exit(void) {}
> -#endif /* CONFIG_PXA310_ULPI */
>  
> -int pxa3xx_u2d_start_hc(struct usb_bus *host)
> +static int pxa3xx_u2d_start_hc(struct usb_bus *host)
>  {
>  	int err = 0;
>  
> -	/* In case the PXA3xx ULPI isn't used, do nothing. */
> -	if (!u2d)
> +	if (!u2d) {
> +		pr_err("%s: Error: u2d struct is not initialized! "
> +		       "ULPI enabed, but pxa3xx-u2d device not registered?",
> +		       __func__);
> +
>  		return 0;
> +	}
>  
>  	clk_enable(u2d->clk);
>  
> @@ -266,11 +257,15 @@ int pxa3xx_u2d_start_hc(struct usb_bus *host)
>  	return err;
>  }
>  
> -void pxa3xx_u2d_stop_hc(struct usb_bus *host)
> +static void pxa3xx_u2d_stop_hc(struct usb_bus *host)
>  {
> -	/* In case the PXA3xx ULPI isn't used, do nothing. */
> -	if (!u2d)
> +	if (!u2d) {
> +		pr_err("%s: Error: u2d struct is not initialized! "
> +		       "ULPI enabed, but pxa3xx-u2d device not registered?",
> +		       __func__);
> +
>  		return;
> +	}
>  
>  	if (cpu_is_pxa310())
>  		pxa310_stop_otg_hc();
> @@ -278,6 +273,39 @@ void pxa3xx_u2d_stop_hc(struct usb_bus *host)
>  	clk_disable(u2d->clk);
>  }
>  
> +static struct pxa3xx_u2d_hc_ops u2d_hc_ops = {
> +	.start_hc	= pxa3xx_u2d_start_hc,
> +	.stop_hc	= pxa3xx_u2d_stop_hc,
> +};
> +
> +struct pxa3xx_u2d_hc_ops *pxa3xx_get_u2d_hc_ops(void)
> +{
> +	return &u2d_hc_ops;
> +}
> +#else
> +static inline void pxa310_u2d_setup_otg_hc(void) {}
> +static inline int pxa310_start_otg_hc(struct usb_bus *host)
> +{
> +	return 0;
> +}
> +static inline void pxa310_stop_otg_hc(void) {}
> +static inline int pxa310_otg_init(struct pxa3xx_u2d_platform_data *pdata)
> +{
> +	return 0;
> +}
> +static inline void pxa310_otg_exit(void) {}
> +static inline int pxa3xx_u2d_start_hc(struct usb_bus *host)
> +{
> +	return 0;
> +}
> +static inline void pxa3xx_u2d_stop_hc(struct usb_bus *host) {}
> +
> +struct pxa3xx_u2d_hc_ops *pxa3xx_get_u2d_hc_ops(void)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_PXA310_ULPI */
> +
>  static int pxa3xx_u2d_probe(struct platform_device *pdev)
>  {
>  	struct pxa3xx_u2d_platform_data *pdata = pdev->dev.platform_data;
> diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
> index afef7b0..61ff775 100644
> --- a/drivers/usb/host/ohci-pxa27x.c
> +++ b/drivers/usb/host/ohci-pxa27x.c
> @@ -236,8 +236,8 @@ static int pxa27x_start_hc(struct pxa27x_ohci *ohci, struct device *dev)
>  	if (retval < 0)
>  		return retval;
>  
> -	if (cpu_is_pxa3xx())
> -		pxa3xx_u2d_start_hc(&ohci_to_hcd(&ohci->ohci)->self);
> +	if (cpu_is_pxa3xx() && inf->u2d_hc_ops)
> +		inf->u2d_hc_ops->start_hc(&ohci_to_hcd(&ohci->ohci)->self);
>  
>  	uhchr = __raw_readl(ohci->mmio_base + UHCHR) & ~UHCHR_SSE;
>  	__raw_writel(uhchr, ohci->mmio_base + UHCHR);
> @@ -255,8 +255,8 @@ static void pxa27x_stop_hc(struct pxa27x_ohci *ohci, struct device *dev)
>  
>  	inf = dev->platform_data;
>  
> -	if (cpu_is_pxa3xx())
> -		pxa3xx_u2d_stop_hc(&ohci_to_hcd(&ohci->ohci)->self);
> +	if (cpu_is_pxa3xx() && inf->u2d_hc_ops)
> +		inf->u2d_hc_ops->stop_hc(&ohci_to_hcd(&ohci->ohci)->self);
>  
>  	if (inf->exit)
>  		inf->exit(dev);

-- 
Regards,
Igor.
