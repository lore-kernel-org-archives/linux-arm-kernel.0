From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 28 Apr 2011 09:55:00 +0200
Subject: [PATCH 2/2] ARM: mx5/mx51_babbage: Use gpio_request_one when
	possible
In-Reply-To: <1303951472-22234-2-git-send-email-festevam@gmail.com>
References: <1303951472-22234-1-git-send-email-festevam@gmail.com>
	<1303951472-22234-2-git-send-email-festevam@gmail.com>
Message-ID: <20110428075500.GM31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

ah, this patch makes my review comment to your patch 1 nil.

On Wed, Apr 27, 2011 at 09:44:32PM -0300, Fabio Estevam wrote:
> Instead of using gpio_request followed by gpio_direction_output use gpio_request_one.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 7b919bc..00203fb 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -179,25 +179,25 @@ static int gpio_usbh1_active(void)
>  
>  	/* Set USBH1_STP to GPIO and toggle it */
>  	mxc_iomux_v3_setup_pad(usbh1stp_gpio);
This cannot go into the global list of pins to mux?

> -	ret = gpio_request(BABBAGE_USBH1_STP, "usbh1_stp");
> +	ret = gpio_request_one(BABBAGE_USBH1_STP,
> +					GPIOF_OUT_INIT_LOW, "usbh1_stp");
>  
>  	if (ret) {
>  		pr_debug("failed to get MX51_PAD_USBH1_STP__GPIO_1_27: %d\n", ret);
>  		return ret;
>  	}
> -	gpio_direction_output(BABBAGE_USBH1_STP, 0);
>  	gpio_set_value(BABBAGE_USBH1_STP, 1);
>  	msleep(100);
Why is the sleep between set_value(1) and free? I would have expected it
between request_one(INIT_LOW) and set_value(1)?

>  	gpio_free(BABBAGE_USBH1_STP);
>  
>  	/* De-assert USB PHY RESETB */
> -	ret = gpio_request(BABBAGE_USB_PHY_RESET, "phy_reset");
> +	ret = gpio_request_one(BABBAGE_USB_PHY_RESET,
> +					GPIOF_OUT_INIT_HIGH, "phy_reset");
>  
>  	if (ret) {
>  		pr_debug("failed to get MX51_PAD_EIM_D21__GPIO_2_5: %d\n", ret);
>  		return ret;
>  	}
> -	gpio_direction_output(BABBAGE_USB_PHY_RESET, 1);
>  	return 0;
>  }
>  
> -- 
> 1.6.0.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
