From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 4 Dec 2009 19:05:54 +0100
Subject: [PATCH] mx27: mxt_td60: Add USB Support
In-Reply-To: <1259948719-10008-1-git-send-email-acassis@gmail.com>
References: <1259948719-10008-1-git-send-email-acassis@gmail.com>
Message-ID: <20091204180554.GX14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 03:45:19PM -0200, Alan Carvalho de Assis wrote:
> This patch add USB support on i-MXT TD60 to Host1 and Host2 ports.
> 
> Signed-off-by: Alan Carvalho de Assis <acassis@gmail.com>
> ---
>  arch/arm/mach-mx2/Kconfig                   |    1 +
>  arch/arm/mach-mx2/mxt_td60.c                |  106 +++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/iomux-mx27.h |   14 ++++

Changes to iomux-mx27.h should go in an extra patch, I think.

[...]

> +static int isp1105_init(struct otg_transceiver *otg)
> +{
> +	mxc_gpio_mode(GPIO_PORTB | 23 | GPIO_GPIO | GPIO_OUT);
> +	gpio_set_value(GPIO_PORTB + 23, 1);
> +	mxc_gpio_mode(GPIO_PORTC | 31 | GPIO_GPIO | GPIO_OUT);
> +	gpio_set_value(GPIO_PORTC + 31, 1);
> +	return 0;
> +}

gpio_request() is needed here.

> +static int isp1105_set_vbus(struct otg_transceiver *otg, bool on)
> +{
> +	if (on)
> +		gpio_set_value(GPIO_PORTB + 27, 0);
> +	else
> +		gpio_set_value(GPIO_PORTB + 27, 1);
> +
> +	return 0;
> +}
> +
> +static struct mxc_usbh_platform_data usbh1_pdata = {
> +	.portsc	= MXC_EHCI_MODE_UTMI | MXC_EHCI_SERIAL,
> +	.flags	= MXC_EHCI_POWER_PINS_ENABLED | MXC_EHCI_INTERFACE_SINGLE_UNI,
> +};
> +
> +static int __init usbh1_init(void)
> +{
> +	struct otg_transceiver *otg;
> +
> +	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
> +	if (!otg)
> +		return -ENOMEM;
> +
> +	otg->label	= "ISP1105";
> +	otg->init	= isp1105_init;
> +	otg->set_vbus	= isp1105_set_vbus;
> +
> +	usbh1_pdata.otg = otg;
> +
> +	return mxc_register_device(&mxc_usbh1, &usbh1_pdata);
> +}

Ideally, you would make that a more generic driver of its own, which lives in
drivers/usb/otg/ and is named something like 'transceiver-gpio'. You would
instanciate it by passing a platform data struct to set the gpios you want it
to use. This might sound overdone, but it would make your code reusable.

The calls to mxc_gpio_mode() would remain in your platform code, of course.

Daniel
