From: balbi@ti.com (Felipe Balbi)
Date: Fri, 17 Dec 2010 08:22:05 +0200
Subject: [Patch v4] AM35xx: Craneboard: Add USB EHCI support
In-Reply-To: <1292513112-12471-1-git-send-email-srinath@mistralsolutions.com>
References: <[PATCH]AM35xx-Craneboard-Add-USB-EHCI-support>
	<1292513112-12471-1-git-send-email-srinath@mistralsolutions.com>
Message-ID: <20101217062205.GD2759@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 16, 2010 at 08:55:12PM +0530, srinath at mistralsolutions.com wrote:
> static void __init am3517_crane_init(void)
> {
>+	int ret;
>+
> 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> 	omap_serial_init();
>+
>+	/* Configure GPIO for EHCI port */
>+	if (omap_mux_init_gpio(GPIO_USB_NRESET, OMAP_PIN_OUTPUT)) {
>+		pr_err("Can not cofigure mux for GPIO_USB_NRESET %d\n",

typo: configure

>+			GPIO_USB_NRESET);
>+		return;
>+	}
>+
>+	if (omap_mux_init_gpio(GPIO_USB_POWER, OMAP_PIN_OUTPUT)) {
>+		pr_err("Can not cofigure mux for GPIO_USB_POWER %d\n",

typo: configure

>+			GPIO_USB_POWER);
>+		return;
>+	}
>+
>+	ret = gpio_request(GPIO_USB_POWER, "usb_ehci_enable");
>+	if (ret < 0) {
>+		pr_err("Cannot request GPIO %d\n", GPIO_USB_POWER);

Keep consistency, either use Can not or Cannot.

>+		return;
>+	}
>+
>+	ret = gpio_direction_output(GPIO_USB_POWER, 1);
>+	if (ret < 0)
>+		goto err;
>+
>+
>+	usb_ehci_init(&ehci_pdata);
>+	return;
>+
>+err:
>+	gpio_free(GPIO_USB_POWER);
>+	pr_err("Unable to initialize EHCI power\n");
>+	return;

this return is unnecessary

-- 
balbi
