From: srinath@mistralsolutions.com (Srinath R)
Date: Thu, 2 Dec 2010 12:51:16 +0530
Subject: [Patch v3] AM35xx: Craneboard: Add USB EHCI support
In-Reply-To: <20101202062539.GB5645@GLPP-machine>
References: <1291222730-17614-1-git-send-email-srinath@mistralsolutions.com>
	<20101202062539.GB5645@GLPP-machine>
Message-ID: <001b01cb91f1$865da120$9318e360$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manjunath, 

Thanks for the review, Please find my response inline.

With Regards
Srinath

-----Original Message-----
From: G, Manjunath Kondaiah [mailto:manjugk at ti.com] 
Sent: Thursday, December 02, 2010 11:56 AM
To: srinath at mistralsolutions.com
Cc: linux-omap at vger.kernel.org; jdk at ti.com; tony at atomide.com;
linux-kernel at vger.kernel.org; linux at arm.linux.org.uk;
linux-arm-kernel at lists.infradead.org; khilman at deeprootsystems.com;
nm at ti.com; nagendra at mistralsolutions.com; umeshk at mistralsolutions.com
Subject: Re: [Patch v3] AM35xx: Craneboard: Add USB EHCI support

* srinath at mistralsolutions.com <srinath@mistralsolutions.com> [2010-12-01
22:28:50 +0530]:

> From: Srinath <srinath@mistralsolutions.com>
> 
> AM3517/05 Craneboard has one EHCI interface on board using port1.
> 
> GPIO35 is used as power enable.
> GPIO38 is used as port1 PHY reset.
> 
> History:
>
http://marc.info/?l=linux-omap&w=2&r=1&s=Craneboard%3A+Add+USB+EHCI+support&
q=t
> 
> Signed-off-by: Srinath <srinath@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/board-am3517crane.c |   40
+++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517crane.c
b/arch/arm/mach-omap2/board-am3517crane.c
> index 13ead33..6fd5dfe 100644
> --- a/arch/arm/mach-omap2/board-am3517crane.c
> +++ b/arch/arm/mach-omap2/board-am3517crane.c
> @@ -28,8 +28,13 @@
>  
[...]
>  static void __init am3517_crane_init(void)
>  {
> +	int ret;
> +
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap_serial_init();
> +
> +	/* Configure GPIO for EHCI port */
> +	omap_mux_init_gpio(GPIO_USB_POWER, OMAP_PIN_OUTPUT);

This is non void function. You can consider return value for further
processing.

<Srinath> Sure, I will put check and resend patch 
> +
> +	ret = gpio_request(GPIO_USB_POWER, "usb_ehci_enable");
> +	if (ret < 0) {
> +		pr_err("Cannot request GPIO %d\n", GPIO_USB_POWER);
> +		return;
> +	}
> +
> +	ret = gpio_direction_output(GPIO_USB_POWER, 1);
> +	if (ret < 0)
> +		goto err;
> +
> +	omap_mux_init_gpio(GPIO_USB_NRESET, OMAP_PIN_OUTPUT);

-Ditto-
<Srinath> Sure, I will put check and resend patch

Also, why there is no gpio_request for "GPIO_USB_NRESET"

<Srinath> This is taken care by USB driver in drivers/usb/host/ehci-omap.c

-Manjunath

[...]
