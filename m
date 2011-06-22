From: balbi@ti.com (Felipe Balbi)
Date: Wed, 22 Jun 2011 16:23:15 +0300
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <1308745217-10883-1-git-send-email-dbaryshkov@gmail.com>
References: <1308745217-10883-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20110622132314.GG23598@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 22, 2011 at 04:20:16PM +0400, Dmitry Eremin-Solenikov wrote:
> Some platforms would like to disable D+ pullup on suspend, to drain as
> low power, as possible. E.g. this was requested by mioa701 board
> maintainers.

I think this makes sense to many platforms, but by doing so, you would
loose connection to the Host PC, so you need to make sure your device
isn't been used before you go down this road.

> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/usb/otg/gpio_vbus.c   |   32 ++++++++++++++++++++++++++++++++
>  include/linux/usb/gpio_vbus.h |    1 +
>  2 files changed, 33 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/otg/gpio_vbus.c b/drivers/usb/otg/gpio_vbus.c
> index 52733d9..44527bd 100644
> --- a/drivers/usb/otg/gpio_vbus.c
> +++ b/drivers/usb/otg/gpio_vbus.c
> @@ -327,6 +327,34 @@ static int __exit gpio_vbus_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int gpio_vbus_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct gpio_vbus_data *gpio_vbus = platform_get_drvdata(pdev);
> +	struct gpio_vbus_mach_info *pdata = gpio_vbus->dev->platform_data;
> +
> +	if (gpio_vbus->otg.gadget && pdata->disconnect_on_suspend) {
> +		/* optionally disable D+ pullup */
> +		if (gpio_is_valid(pdata->gpio_pullup))
> +			gpio_set_value(pdata->gpio_pullup,
> +					pdata->gpio_pullup_inverted);
> +
> +		set_vbus_draw(gpio_vbus, 0);
> +	}
> +	return 0;
> +}
> +
> +static int gpio_vbus_resume(struct platform_device *pdev)
> +{
> +	struct gpio_vbus_data *gpio_vbus = platform_get_drvdata(pdev);
> +
> +	if (gpio_vbus->otg.gadget)
> +		schedule_work(&gpio_vbus->work);
> +
> +	return 0;
> +}

actually, the correct way would be to use dev_pm_ops.

> +#endif
> +
>  /* NOTE:  the gpio-vbus device may *NOT* be hotplugged */
>  
>  MODULE_ALIAS("platform:gpio-vbus");
> @@ -337,6 +365,10 @@ static struct platform_driver gpio_vbus_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.remove  = __exit_p(gpio_vbus_remove),
> +#ifdef CONFIG_PM
> +	.suspend	= gpio_vbus_suspend,
> +	.resume		= gpio_vbus_resume
> +#endif

also, avoid the ifdef on the driver structure.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110622/caa12764/attachment.sig>
