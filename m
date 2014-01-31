From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 31 Jan 2014 02:14:34 +0100
Subject: [PATCH 03/03] ARM: shmobile: Lager USB0 cable detection workaround
In-Reply-To: <20140129231029.22655.58864.sendpatchset@w520>
References: <20140129230959.22655.55645.sendpatchset@w520>
 <20140129231029.22655.58864.sendpatchset@w520>
Message-ID: <1682649.H5bjffAvcD@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Thursday 30 January 2014 08:10:29 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add Lager board code to check the PWEN GPIO signal and refuse to
> allow probe of the USBHS driver in case of DIP misconfiguration.
> 
> For correct operation Lager DIP switches SW5 and SW6 shall be
> configured in 2-3 position to enable USB Function support.
> 
> If the DIP switch is configured incorrectly then the user can
> simply adjust the hardware and either reboot or use the bind interface
> to try to probe again:
> 
> # echo renesas_usbhs > /sys/bus/platform/drivers/renesas_usbhs/bind

Our of curiosity, and I know you will love the question, have you thought 
about how to implement this on multiplatform kernels without a board file ? 
:-)

This might be one of the valid cases where we won't be able to do without a 
board file. The callback functions in platform data, however, probably need to 
go.

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Depends on "[PATCH 02/03] pinctrl: sh-pfc: r8a7790: Break out USB0
> OVC/VBUS"
> 
>  arch/arm/mach-shmobile/board-lager.c |   25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> --- 0004/arch/arm/mach-shmobile/board-lager.c
> +++ work/arch/arm/mach-shmobile/board-lager.c	2014-01-24 
10:17:20.000000000
> +0900 @@ -406,13 +406,30 @@ static int usbhs_hardware_init(struct pl
>  {
>  	struct usbhs_private *priv = usbhs_get_priv(pdev);
>  	struct usb_phy *phy;
> +	int ret;
> +
> +	/* USB0 Function - use PWEN as GPIO input to detect DIP Switch SW5
> +	 * setting to avoid VBUS short circuit due to wrong cable.
> +	 * PWEN should be pulled up high if USB Function is selected by SW5
> +	 */
> +	gpio_request_one(RCAR_GP_PIN(5, 18), GPIOF_IN, NULL); /* USB0_PWEN */
> +	if (!gpio_get_value(RCAR_GP_PIN(5, 18))) {
> +		pr_warn("Error: USB Function not selected - check SW5 + SW6\n");
> +		ret = -ENOTSUPP;
> +		goto error;
> +	}
> 
>  	phy = usb_get_phy_dev(&pdev->dev, 0);
> -	if (IS_ERR(phy))
> -		return PTR_ERR(phy);
> +	if (IS_ERR(phy)) {
> +		ret = PTR_ERR(phy);
> +		goto error;
> +	}
> 
>  	priv->phy = phy;
>  	return 0;
> + error:
> +	gpio_free(RCAR_GP_PIN(5, 18));
> +	return ret;
>  }
> 
>  static int usbhs_hardware_exit(struct platform_device *pdev)
> @@ -424,6 +441,8 @@ static int usbhs_hardware_exit(struct pl
> 
>  	usb_put_phy(priv->phy);
>  	priv->phy = NULL;
> +
> +	gpio_free(RCAR_GP_PIN(5, 18));
>  	return 0;
>  }
> 
> @@ -534,7 +553,7 @@ static const struct pinctrl_map lager_pi
>  				  "vin1_clk", "vin1"),
>  	/* USB0 */
>  	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7790",
> -				  "usb0", "usb0"),
> +				  "usb0_ovc_vbus", "usb0"),
>  };
> 
>  static void __init lager_add_standard_devices(void)

-- 
Regards,

Laurent Pinchart
