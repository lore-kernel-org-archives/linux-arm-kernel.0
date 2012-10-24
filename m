From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Oct 2012 10:37:57 +0200
Subject: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
In-Reply-To: <87liexrmoz.fsf@thor.barco.com>
References: <1350910413-23925-1-git-send-email-maxime.ripard@free-electrons.com><1350910413-23925-2-git-send-email-maxime.ripard@free-electrons.com>
 <87liexrmoz.fsf@thor.barco.com>
Message-ID: <5087A8E5.8050103@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Le 23/10/2012 21:51, Peter Korsgaard a ?crit :
>>>>>> "MR" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:
> 
> Hi Maxime,
> 
> I'm fine with the idea, but a few comments:
> 
> 
> MR> Allow the i2c-mux-gpio to be used by a device tree enabled device. The
> MR> bindings are inspired by the one found in the i2c-mux-pinctrl driver.
> 
> MR> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> MR> ---
> MR>  .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   81 ++++++++++
> MR>  drivers/i2c/muxes/i2c-mux-gpio.c                   |  169 +++++++++++++++-----
> MR>  2 files changed, 211 insertions(+), 39 deletions(-)
> MR>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
> 
> MR> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
> MR> new file mode 100644
> MR> index 0000000..335fc4e
> MR> --- /dev/null
> MR> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
> MR> @@ -0,0 +1,81 @@
> MR> +GPIO-based I2C Bus Mux
> MR> +
> MR> +This binding describes an I2C bus multiplexer that uses GPIOs to
> MR> +route the I2C signals.
> MR> +
> MR> +                                  +-----+  +-----+
> MR> +                                  | dev |  | dev |
> MR> +    +------------+                +-----+  +-----+
> MR> +    | SoC        |                   |        |
> MR> +    |            |          /--------+--------+
> MR> +    |   +------+ |  +------+    child bus A, on GPIO value set to 0
> MR> +    |   | I2C  |-|--| Mux  |
> MR> +    |   +------+ |  +--+---+    child bus B, on GPIO value set to 1
> MR> +    |            |     |    \----------+--------+--------+
> MR> +    |   +------+ |     |               |        |        |
> MR> +    |   | GPIO |-|-----+            +-----+  +-----+  +-----+
> MR> +    |   +------+ |                  | dev |  | dev |  | dev |
> MR> +    +------------+                  +-----+  +-----+  +-----+
> MR> +
> MR> +Required properties:
> MR> +- compatible: i2c-mux-gpio
> MR> +- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
> MR> +  port is connected to.
> MR> +- mux-gpios: list of gpios to use to control the muxer
> 
> s/to use to/used to/
> 
> 
> MR> +* Standard I2C mux properties. See mux.txt in this directory.
> MR> +* I2C child bus nodes. See mux.txt in this directory.
> MR> +
> MR> +Optional properties:
> MR> +- idle-state: value to set to the muxer when idle. When no value is
> 
> How about 'bitmask defining mux state when idle' instead?

Since the array documented as using the bitmasks in the platform_data
and described as an array of bitmasks is called "values", and the file
mux.txt talks about "numbers" to put into reg, won't this be confusing
to have three names for the exact same thing?

> MR> +  given, it defaults to the last value used.
> MR> +
> MR> +For each i2c child node, an I2C child bus will be created. They will
> MR> +be numbered based on the reg property of each node.
> 
> As far as I can see they are dynamically assigned numbers in the order
> they are listed in the dt.

Ah, yes.

> MR> +
> MR> +Whenever an access is made to a device on a child bus, the value set
> MR> +in the revelant node's reg property will be output using the list of
> MR> +GPIOs, the first in the list holding the most-significant value.
> 
> Isn't it the other way around, E.G. first gpio in mux-gpios controlled
> by LSB of reg property, next gpio by lsb+1,  ..?

True indeed.

> MR> +
> MR> +If an idle state is defined, using the idle-state (optional) property,
> MR> +whenever an access is not being made to a device on a child bus, the
> MR> +idle value will be programmed into the GPIOs.
> 
> s/idle value will be programmed into the GPIOS/GPIOS set according to
> the idle value bitmask/

Once again, I'm really not fond of the term "bitmask".

[..]

> MR> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> MR> index 566a675..7ebef01 100644
> MR> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> MR> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> MR> @@ -16,11 +16,13 @@
> MR>  #include <linux/module.h>
> MR>  #include <linux/slab.h>
> MR>  #include <linux/gpio.h>
> MR> +#include <linux/of_i2c.h>
> MR> +#include <linux/of_gpio.h>
>  
> MR>  struct gpiomux {
> MR>  	struct i2c_adapter *parent;
> MR>  	struct i2c_adapter **adap; /* child busses */
> MR> -	struct i2c_mux_gpio_platform_data data;
> MR> +	struct i2c_mux_gpio_platform_data *data;
> 
> 
> Why this change? I don't see why it is needed and the patch would be a
> lot easier to review without all the s/.data/->data/ noise.

Ah yes, since mux is already allocated using kcalloc, we don't need to
do it for data as well. I will remove it.

Thanks,
Maxime




-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
