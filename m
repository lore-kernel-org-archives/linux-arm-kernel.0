From: peter.korsgaard@barco.com (Peter Korsgaard)
Date: Wed, 24 Oct 2012 16:56:43 +0200
Subject: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
In-Reply-To: <1351089624-20794-2-git-send-email-maxime.ripard@free-electrons.com>(Maxime
 Ripard's message of "Wed, 24 Oct 2012 16:40:23 +0200")
References: <1351089624-20794-1-git-send-email-maxime.ripard@free-electrons.com><1351089624-20794-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <873913rk9g.fsf@thor.barco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "MR" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:

Hi,

MR> Allow the i2c-mux-gpio to be used by a device tree enabled device. The
MR> bindings are inspired by the one found in the i2c-mux-pinctrl driver.

MR> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
MR> Reviewed-by: Stephen Warren <swarren@nvidia.com>
MR> ---
MR>  .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   81 +++++++++++
MR>  drivers/i2c/muxes/i2c-mux-gpio.c                   |  146 +++++++++++++++-----
MR>  2 files changed, 196 insertions(+), 31 deletions(-)
MR>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt

MR> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
MR> new file mode 100644
MR> index 0000000..d61726f
MR> --- /dev/null
MR> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
MR> @@ -0,0 +1,81 @@
MR> +GPIO-based I2C Bus Mux
MR> +
MR> +This binding describes an I2C bus multiplexer that uses GPIOs to
MR> +route the I2C signals.
MR> +
MR> +                                  +-----+  +-----+
MR> +                                  | dev |  | dev |
MR> +    +------------+                +-----+  +-----+
MR> +    | SoC        |                   |        |
MR> +    |            |          /--------+--------+
MR> +    |   +------+ |  +------+    child bus A, on GPIO value set to 0
MR> +    |   | I2C  |-|--| Mux  |
MR> +    |   +------+ |  +--+---+    child bus B, on GPIO value set to 1
MR> +    |            |     |    \----------+--------+--------+
MR> +    |   +------+ |     |               |        |        |
MR> +    |   | GPIO |-|-----+            +-----+  +-----+  +-----+
MR> +    |   +------+ |                  | dev |  | dev |  | dev |
MR> +    +------------+                  +-----+  +-----+  +-----+
MR> +
MR> +Required properties:
MR> +- compatible: i2c-mux-gpio
MR> +- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
MR> +  port is connected to.
MR> +- mux-gpios: list of gpios used to control the muxer
MR> +* Standard I2C mux properties. See mux.txt in this directory.
MR> +* I2C child bus nodes. See mux.txt in this directory.
MR> +
MR> +Optional properties:
MR> +- idle-state: value to set to the muxer when idle. When no value is

s/to set to the muxer/to set the muxer to/


MR> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
MR> @@ -16,6 +16,8 @@
MR>  #include <linux/module.h>
MR>  #include <linux/slab.h>
MR>  #include <linux/gpio.h>
MR> +#include <linux/of_i2c.h>
MR> +#include <linux/of_gpio.h>
 
MR>  struct gpiomux {
MR>  	struct i2c_adapter *parent;
MR> @@ -57,29 +59,111 @@ static int __devinit match_gpio_chip_by_label(struct gpio_chip *chip,
MR>  	return !strcmp(chip->label, data);
MR>  }
 
MR> +#ifdef CONFIG_OF
MR> +static int __devinit i2c_mux_gpio_probe_dt(struct gpiomux *mux,
MR> +					struct platform_device *pdev)
MR> +{
MR> +	struct device_node *np = pdev->dev.of_node;
MR> +	struct device_node *adapter_np, *child;
MR> +	struct i2c_adapter *adapter;
MR> +	unsigned *values, *gpios;
MR> +	int i = 0;
MR> +
MR> +	if (!np)
MR> +		return 0;


This should be -ENODEV, otherwise we end up using a zeroed out struct
i2c_mux_gpio_platform_data in case i2c_mux_gpio is used with the
platform bus but the platform forgets to pass the pdata.

With those two minor fixes:

Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>

-- 
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
