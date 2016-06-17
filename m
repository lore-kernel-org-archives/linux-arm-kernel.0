From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 17 Jun 2016 18:54:16 +0530
Subject: [PATCH] phy: phy-sun4i-usb: Fix optional gpios failing probe
In-Reply-To: <1465818348-29499-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1465818348-29499-1-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <5763FA00.8030205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 13 June 2016 05:15 PM, Quentin Schulz wrote:
> The interrupt 0 is not a valid interrupt number. In the event where the
> retrieval of the vbus-det gpio would return null, the gpiod_to_irq
> callback would return 0, while the current code makes the assumption
> that it is a valid interrupt, and would go on calling request_irq.
> Obviously, this would fail, preventing the driver from probing properly,
> while the vbus and id gpios are optional.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

applied, thanks.

-Kishon
> ---
>  drivers/phy/phy-sun4i-usb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index bae54f7..45f01d6 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -645,11 +645,11 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  
>  	data->id_det_irq = gpiod_to_irq(data->id_det_gpio);
>  	data->vbus_det_irq = gpiod_to_irq(data->vbus_det_gpio);
> -	if ((data->id_det_gpio && data->id_det_irq < 0) ||
> -	    (data->vbus_det_gpio && data->vbus_det_irq < 0))
> +	if ((data->id_det_gpio && data->id_det_irq <= 0) ||
> +	    (data->vbus_det_gpio && data->vbus_det_irq <= 0))
>  		data->phy0_poll = true;
>  
> -	if (data->id_det_irq >= 0) {
> +	if (data->id_det_irq > 0) {
>  		ret = devm_request_irq(dev, data->id_det_irq,
>  				sun4i_usb_phy0_id_vbus_det_irq,
>  				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> @@ -660,7 +660,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (data->vbus_det_irq >= 0) {
> +	if (data->vbus_det_irq > 0) {
>  		ret = devm_request_irq(dev, data->vbus_det_irq,
>  				sun4i_usb_phy0_id_vbus_det_irq,
>  				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> 
