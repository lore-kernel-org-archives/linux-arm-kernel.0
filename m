From: gadiyar@ti.com (Gadiyar, Anand)
Date: Tue, 21 Sep 2010 21:56:22 +0530
Subject: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
In-Reply-To: <1285084993-27683-4-git-send-email-grinberg@compulab.co.il>
References: <1285084993-27683-1-git-send-email-grinberg@compulab.co.il>
	<1285084993-27683-4-git-send-email-grinberg@compulab.co.il>
Message-ID: <AANLkTin+canp9yrE-Jmv=n56dPFByZWU73uaRNBkruP6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 9:33 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> add support for hsusb host ports 1, 2 and on-module usb hub.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> ?arch/arm/mach-omap2/board-cm-t3517.c | ? 50 ++++++++++++++++++++++++++++++++++

...

> @@ -100,6 +102,47 @@ static void __init cm_t3517_init_rtc(void)
> ?static inline void cm_t3517_init_rtc(void) {}
> ?#endif
>
> +#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)

Hi Igor,


Do we really need to make these conditional on the driver being built?

The hardware is present on the board at all times, right?
It should be okay to execute this code independent of whether
the driver is built or not. The device registration can be unconditional
and if there is no driver present, we won't probe anyway.

(I see some similar logic in usb-ehci.c - probably a good idea to remove
it as well).

- Anand

> +#define HSUSB1_RESET_GPIO ? ? ?(146)
> +#define HSUSB2_RESET_GPIO ? ? ?(147)
> +#define USB_HUB_RESET_GPIO ? ? (152)
> +
> +static struct ehci_hcd_omap_platform_data cm_t3517_ehci_pdata __initdata = {
> + ? ? ? .port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
> + ? ? ? .port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
> + ? ? ? .port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
> +
> + ? ? ? .phy_reset ?= true,
> + ? ? ? .reset_gpio_port[0] ?= HSUSB1_RESET_GPIO,
> + ? ? ? .reset_gpio_port[1] ?= HSUSB2_RESET_GPIO,
> + ? ? ? .reset_gpio_port[2] ?= -EINVAL,
> +};
> +
> +static int cm_t3517_init_usbh(void)
> +{
> + ? ? ? int err;
> +
> + ? ? ? err = gpio_request(USB_HUB_RESET_GPIO, "usb hub rst");
> + ? ? ? if (err) {
> + ? ? ? ? ? ? ? pr_err("CM-T3517: usb hub rst gpio request failed: %d\n", err);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? gpio_direction_output(USB_HUB_RESET_GPIO, 0);
> + ? ? ? ? ? ? ? udelay(10);
> + ? ? ? ? ? ? ? gpio_set_value(USB_HUB_RESET_GPIO, 1);
> + ? ? ? ? ? ? ? msleep(1);
> + ? ? ? }
> +
> + ? ? ? usb_ehci_init(&cm_t3517_ehci_pdata);
> +
> + ? ? ? return 0;
> +}
> +#else
> +static inline int cm_t3517_init_usbh(void)
> +{
> + ? ? ? return 0;
> +}
> +#endif
> +
