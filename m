From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 15:14:17 +0800
Subject: [RFC PATCH] gpio: Add a generic GPIO handling driver
In-Reply-To: <1340961676-25432-1-git-send-email-LW@KARO-electronics.de>
References: <1340961676-25432-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20120703071414.GA22705@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 11:21:16AM +0200, Lothar Wa?mann wrote:
> This driver provides an interface for device drivers that need to
> control some external hardware (e.g. reset or enable signals) for the
> devices they serve.
> 
> Features:
>  - supports sharing a single GPIO between multiple devices.
>  - optionally sets the controlled GPIOs to a predefined state upon
>    suspend/resume.
>  - handles output polarity
> 
> Client API:
> 	cookie = request_gpio_switch(dev, id);
> 	gpio_switch_set(cookie, on|off);
> 	free_gpio_switch(cookie);
> 
> 	gpio_switch_set_suspend_state(cookie, on|off)
> 	gpio_switch_set_resume_state(cookie, on|off)
> 
> request_gpio_switch() always returns a valid cookie (that may be NULL
> if the requested pin is not registered on the current platform), so
> that client drivers do not need to check whether the current platform
> provides a certain pin or not.
> 
> The client drivers only cope with the logical pin states
> (active/inactive, on/off) while the gpio-switch driver takes care of
> the output polarity handling.
> 
> The typical use of this driver in a client driver (e.g. flexcan
> transceiver switch) would be like (with DT):
> 
> in the .dts file:
> 	flexcan_transceiver: gpio-switch at 0 {
> 		compatible = "linux,gpio-switch";

Why not simply "gpio-switch"?

> 		gpio = <&gpio4 21 1>; /* GPIO is active low */
> 		label = "Flexcan Transceiver Enable";
> 		gpio-shared;
> 		init-state = <0>; /* Transceiver will be initially inactive */
> 	};
> 
It looks like the design intends to have every single gpio-switch
probed as a platform_device.  I'm not sure it's a good idea.

Have something like below in .dts:

gpio-switches {
 	compatible = "gpio-switch";

 	can_xcvr_en: can-xcvr-en {
 		label = "Flexcan Transceiver Enable";
 		gpio = <&gpio4 21 1>;
		...
 	};

 	usb_hub_en: usb-hub-en {
 		label = "USB Hub Enable";
 		gpio = <&gpio2 11 0>;
		...
 	};

	...
};
 
We will be able to probe gpio-switch device only once and have the
driver enumerate every sub-nodes as a gpio-switch provider.

Also I'm not sure it's preferable to have such shinny new stuff support
platform probing, which adds much unnecessary complexity, considering
we are on the way to device tree.  If we support device tree only,
a lot of codes like provider API will not be needed.

> in flexcan_probe()
> 	struct gpio_sw *xcvr_switch = NULL;
> 	struct device_node *np = pdev->dev.of_node;
> 
> 	if (np) {
> 		ph = of_get_property(np, "transceiver-switch", NULL);

I would have a fixed property name under client device node
representing the phandle to gpio-switch sub-node, like what we are
doing with clk binding.

> 		if (ph) {
> 			xcvr_switch = request_gpio_switch(&pdev->dev,
> 					be32_to_cpu(*ph));

Then, client driver does not need to look at the phandle property at
all, and gpio-switch driver will look for phandle using the fixed name.

Like clk API, we may need to change the second parameter of
request_gpio_switch to be the name of the switch requested to support
the client devices that have multiple switches.

> 		}
> 	}
> ...
> static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
> {
> 	if (priv->pdata && priv->pdata->transceiver_switch)
> 		priv->pdata->transceiver_switch(on);
> 	else
> 		gpio_switch_set(priv->xcvr_switch, on);
> }
> ...
> flexcan_remove()
>     free_gpio_switch(xcvr_switch);

Can we have a devm_request_gpio_switch to ease the client driver
a little bit?

Regards,
Shawn

> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  .../devicetree/bindings/gpio/gpio-switch.txt       |   36 ++
>  drivers/gpio/Kconfig                               |    9 +
>  drivers/gpio/Makefile                              |    3 +
>  drivers/gpio/gpio-switch.c                         |  389 ++++++++++++++++++++
>  include/linux/gpio-switch.h                        |   47 +++
>  5 files changed, 484 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-switch.txt
>  create mode 100644 drivers/gpio/gpio-switch.c
>  create mode 100644 include/linux/gpio-switch.h
