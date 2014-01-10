From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 10 Jan 2014 10:22:51 +0000
Subject: [PATCH v5 2/9] mfd: omap-usb-host: Get clocks based on hardware
 revision
In-Reply-To: <1389269303-30465-3-git-send-email-rogerq@ti.com>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
 <1389269303-30465-3-git-send-email-rogerq@ti.com>
Message-ID: <20140110102251.GH28141@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Not all revisions have all the clocks so get the necessary clocks
> based on hardware revision.
> 
> This should avoid un-necessary clk_get failure messages that were
> observed earlier.
> 
> Be more strict and always fail on clk_get() error.
> 
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/mfd/omap-usb-host.c | 93 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 64 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 1c9bca2..7202cc6 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -92,7 +92,6 @@
>  #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
>  #define is_ehci_hsic_mode(x)	(x == OMAP_EHCI_PORT_MODE_HSIC)
>  
> -

Sneaky! ;)

>  struct usbhs_hcd_omap {
>  	int				nports;
>  	struct clk			**utmi_clk;
> @@ -665,22 +664,41 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>  		goto err_mem;
>  	}
>  
> -	need_logic_fck = false;
> +	/* Set all clocks as invalid to begin with */
> +	omap->ehci_logic_fck = omap->init_60m_fclk = ERR_PTR(-EINVAL);
> +	omap->utmi_p1_gfclk = omap->utmi_p2_gfclk = ERR_PTR(-EINVAL);
> +	omap->xclk60mhsp1_ck = omap->xclk60mhsp2_ck = ERR_PTR(-EINVAL);

I don't think this is the correct error code.

-EINVAL means 'invalid parameter'.

You probably want -ENODEV or -ENOSYS ('function not implemented'
probably isn't ideal either tbh, but you get the idea). Perhaps you
can set them as NULL and check for IS_ERR_OR_NULL() instead?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
