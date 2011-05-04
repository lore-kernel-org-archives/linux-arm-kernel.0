From: rvaswani@codeaurora.org (Rohit Vaswani)
Date: Wed, 04 May 2011 15:48:27 -0700
Subject: [PATCH 1/4] drivers: create a pinmux subsystem
In-Reply-To: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4DC1D7BB.3010503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 5/2/2011 12:16 PM, Linus Walleij wrote:
> From: Linus Walleij<linus.walleij@linaro.org>
>
> This creates a subsystem for handling of pinmux devices. These are
> devices that enable and disable groups of pins on primarily PGA and
> BGA type of chip packages and common in embedded systems.
>
> This is being done to depopulate the arch/arm/* directory of such
> custom drivers and try to abstract the infrastructure they all
> need. See the Documentation/pinmux.txt file that is part of this
> patch for more details.
>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
>   Documentation/ABI/testing/sysfs-class-pinmux |   11 +
>   Documentation/pinmux.txt                     |  306 +++++++++++
>   MAINTAINERS                                  |    5 +
>   drivers/Kconfig                              |    4 +
>   drivers/Makefile                             |    2 +
>   drivers/pinmux/Kconfig                       |   26 +
>   drivers/pinmux/Makefile                      |    5 +
>   drivers/pinmux/core.c                        |  740 ++++++++++++++++++++++++++
>   include/linux/pinmux.h                       |  224 ++++++++
>   9 files changed, 1323 insertions(+), 0 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-pinmux
>   create mode 100644 Documentation/pinmux.txt
>   create mode 100644 drivers/pinmux/Kconfig
>   create mode 100644 drivers/pinmux/Makefile
>   create mode 100644 drivers/pinmux/core.c
>   create mode 100644 include/linux/pinmux.h
>
> diff --git a/Documentation/ABI/testing/sysfs-class-pinmux b/Documentation/ABI/testing/sysfs-class-pinmux
> new file mode 100644
> index 0000000..f2a0ba8
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-pinmux
> @@ -0,0 +1,11 @@
> +What:		/sys/class/pinmux/.../name
> +Date:		May 2011
> +KernelVersion:	2.6.40
> +Contact:	Linus Walleij<linus.walleij@linaro.org>
> +Description:
> +		Each pinmux directory will contain a field called
> +		name. This holds a string identifying the pinmux for
> +		display purposes.
> +
> +		NOTE: this will be empty if no suitable name is provided
> +		by platform or pinmux drivers.
> diff --git a/Documentation/pinmux.txt b/Documentation/pinmux.txt
> new file mode 100644
> index 0000000..d9850db
> --- /dev/null
> +++ b/Documentation/pinmux.txt
> @@ -0,0 +1,306 @@
> +PINMUX interfaces
> +
> +This document outlines the pin muliplexer (pinmux) subsystem in Linux
> +
> +These calls use the pinmux_* naming prefix.  No other calls should use that
> +prefix.
> +
> +
> +What is pinmuxing?
> +==================
> +
> +Pinmux, also known as padmux, ballmux or alternate functions, is a way for
> +chip vendors producing mainly PGA (pin grid array) and BGA (ball grid array)
> +packages of using a certain physical bin (ball, pad) for multiple mutually
> +exclusive functions, depending on the application.
> +
> +Here is an example of a chip seen from underneath:
> +
> +        A   B   C   D   E   F   G   H
> +      +---+
> +   8  | o | o   o   o   o   o   o   o
> +      |   |
> +   7  | o | o   o   o   o   o   o   o
> +      |   |
> +   6  | o | o   o   o   o   o   o   o
> +      +---+---+
> +   5  | o | o | o   o   o   o   o   o
> +      +---+---+               +---+
> +   4    o   o   o   o   o   o | o | o
> +                              |   |
> +   3    o   o   o   o   o   o | o | o
> +                              |   |
> +   2    o   o   o   o   o   o | o | o
> +                              |   |
> +   1    o   o   o   o   o   o | o | o
> +                              +---+
> +
> +This is not tetris. The game to think of is chess. Not all PGA/BGA packages
> +are chessboard-like, big ones have "holes" in some arrangement according to
> +different design patterns, but we're using this as a simple example. Of the
> +pins you see some will be taken by things like a few VCC and GND to feed power
> +to the chip, and quite a few will be taken by large ports like an external
> +memory interface. The remaining pins will often be subject to pin multiplexing.
> +
> +In this 8x8 BGA package the pins { A8, A7, A6, A5 } can be used as an SPI port
> +(these are four pins: CLK, RXD, TXD, FRM). In that case, pin B5 can be used as
> +some general-purpose GPIO pin. However, in another setting, pins { A5, B5 } can
> +be used as an I2C port (these are just two pins: SCL, SDA). Needless to say,
> +we cannot use the SPI port and I2C port at the same time. However in the inside
> +of the package the silicon performing the SPI logic can alternatively be routed
> +out on pins { G4, G3, G2, G1 }.
> +
> +This way the silicon blocks present inside the chip can be multiplexed "muxed"
> +out on different pin ranges. Often contemporary SoC (systems on chip) will
> +contain several I2C, SPI, SDIO/MMC, etc silicon blocks that can be routed to
> +different pins by pinmux settings.
> +
> +Since general-purpose I/O pins (GPIO) are typically always in shortage, it is
> +common to be able to use almost any pin as a GPIO pin if it is not currently
> +in use by some other I/O port.
> +
> +
> +Pinmux conventions
> +==================
> +
> +The purpose of the pinmux subsystem is to abstract and provide pinmux settings
> +to the devices you choose to instantiate in your machine configuration. It is
> +inspired by the clk, GPIO and regulator subsystems, so devices will request
> +their mux setting, but it's also possible to request a single pin for e.g.
> +GPIO.
> +
> +The mux settings are:
> +
> +- Oriented around enumerated physical pins or pads denoted by unsigned
> +  integers in the range 0..MAX_INT. Every pin on your system (or atleast
> +  every pin that can be muxed) should have a unique number. The numberspace
> +  can span several chips if you have more chips on your system that can be
> +  subject to muxing. The example 8x8 array above will have pin numbers 0 thru
> +  63 assigned to its physical pins.
> +
> +- Switched in and out by a driver residing with the pinmux subsystem in the
> +  drivers/pinmux/* directory of the kernel. The pinmux driver knows the
> +  possible function settings. In the example above you can identify three
> +  pinmux functions, two for spi and one for i2c.
> +
> +- Assumed to be enumerable from zero in a one-dimensional array. In this
> +  case the array could be something like: { spi0-0, spi0-1, i2c0-0 } for
> +  the three available settings. The knowledge of this one-dimensional array
> +  and it's machine-specific particulars is kept inside the pinmux driver,
> +  from the outside only these enumerators are known, and the driver core
> +  can request the name or the list of pins belonging to a certain enumerator.
> +
> +- Mapped to a certain device by the board file, device tree or similar
> +  machine setup configuration mechanism, similar to how regulators are
> +  connected to devices, usually by name. In the example case we can define
> +  that this particular machine shall use device spi0 with pinmux setting
> +  spi0-1 and i2c0 on i2c0-1, something like the two-tuple:
> +  { {spi0, spi0-1}, {i2c0, i2c0-1}}
> +
> +- Provided on a first-come first-serve basis, so if some other device mux
> +  setting or GPIO pin request has already taken your physical pin, you will
> +  be denied the use of it. To get (activate) a new setting, the old one has
> +  to be put (deactivated) first.
> +
> +Sometimes the documentation and hardware registers will be oriented around
> +pads (or "fingers") rather than pins - these are the soldering surfaces on the
> +silicon inside the package, and may or may not match the actual number of
> +pins/balls underneath the capsule. Pick some enumeration that makes sense to
> +you. Define enumerators only for the pins you can control if that makes sense.
> +
> +
> +Pinmux drivers
> +==============
> +
> +The driver will for all calls be provided an offset pin number into its own
> +pin range. If you have 2 chips with 8x8 pins, the first chips pins will have
> +numbers 0 thru 63 and the second one pins 64 thru 127, but the driver for the
> +second chip will be passed numbers in the range 0 thru 63 anyway, base offset
> +subtracted.
> +
> +Pinmux drivers are required to supply a few callback functions, some are
> +optional. Usually the enable() and disable() functions are implemented,
> +writing values into some certain registers to activate a certain mux setting
> +for a certain pin.
> +
> +A simple driver for the above example will work by setting bits 0, 1 or 2
> +into some register mamed MUX, so it enumerates its available settings and
> +their pin assignments, and expose them like this:
> +
> +struct foo_pmx_func {
> +	char *name;
> +	const unsigned int *pins;
> +	const unsigned num_pins;
> +};
> +
> +static unsigned int spi0_0_pins[] = { 0, 8, 16, 24 };
> +static unsigned int i2c0_pins[] = { 24, 25 };
> +static unsigned int spi0_1_pins[] = { 38, 46, 54, 62 };
> +
> +static struct foo_pmx_func myfuncs[] = {
> +	{
> +		.name = "spi0-0",
> +		.pins = spi0_0_pins,
> +		.num_pins = ARRAY_SIZE(spi0_1_pins),
> +	},
> +	{
> +		.name = "i2c0",
> +		.pins = i2c0_pins,
> +		.num_pins = ARRAY_SIZE(i2c0_pins),
> +	},
> +	{
> +		.name = "spi0-1",
> +		.pins = spi0_1_pins,
> +		.num_pins = ARRAY_SIZE(spi0_1_pins),
> +	},
> +};
> +
> +int foo_list(struct pinmux_dev *pmxdev, unsigned selector)
> +{
> +	if (selector>= ARRAY_SIZE(myfuncs))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +const char *foo_get_fname(struct pinmux_dev *pmxdev, unsigned selector)
> +{
> +	if (selector>= ARRAY_SIZE(myfuncs))
> +		return NULL;
> +	return myfuncs[selector].name;
> +}
> +
> +static int foo_get_pins(struct pinmux_dev *pmxdev, unsigned selector,
> +	   		unsigned ** const pins, unsigned * const num_pins)
> +{
> +	if (selector>= ARRAY_SIZE(myfuncs))
> +		return -EINVAL;
> +	*pins = myfuncs[selector].pins;
> +	*num_pins = myfuncs[selector].num_pins;
> +	return 0;
> +}
> +
> +
> +int foo_enable(struct pinmux_dev *pmxdev, unsigned selector)
> +{
> +	if (selector<  ARRAY_SIZE(myfuncs))
> +		write((read(MUX)|(1<<selector)), MUX)
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +int foo_disable(struct pinmux_dev *pmxdev, unsigned selector)
> +{
> +	if (selector<  ARRAY_SIZE(myfuncs))
> +		write((read(MUX)&  ~(1<<selector)), MUX)
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
> +struct pinmux_ops ops = {
> +	.list_functions = foo_list,
> +	.get_function_name = foo_get_fname,
> +	.get_function_pins = foo_get_pins,
> +	.enable = foo_enable,
> +	.disable = foo_disable,
> +};
> +
> +Now the able reader will say: "wait - the driver needs to make sure it
> +can set this and that bit at the same time, because else it will collide
> +and wreak havoc in my electronics, and make sure noone else is using the
> +other setting that it's incompatible with".
> +
> +In the example activating muxing 0 and 1 at the same time setting bits
> +0 and 1, uses one pin in common so they would collide.
> +
> +The beauty of the pinmux subsystem is that since it keeps track of all
> +pins and who is using them, it will already have denied an impossible
> +request like that, so the driver does not need to worry about such
> +things - when it gets a selector passed in, the pinmux subsystem makes
> +sure no other device or GPIO assignment is already using the selected
> +pins.
> +
> +The above functions are mandatory to implement for a pinmux driver.
> +
> +The function list can become long, especially if you can convert every
> +individual pin into a GPIO pin independent of any other pins, then your
> +function array can become 64 entries for each GPIO setting and then the
> +device functions. For this reason there is an additional function you
> +can implement to enable only GPIO on an individual pin: gpio_enable().
> +
> +
> +Board/machine configuration
> +===========================
> +
> +Boards and machines define how a certain complete running system is put
> +together, including how GPIOs and devices are muxed, how regulators are
> +constrained and how the clock tree looks. Of course pinmux settings are also
> +part of this.
> +
> +A pinmux config for a machine looks pretty much like a simple regulator
> +configuration, so for the example array above we want to enable i2c and
> +spi on the second function mapping:
> +
> +static struct pinmux_map pmx_mapping[] = {
> +	{
> +		.function = "spi0-1",
> +		.dev_name = "foo-spi.0",
> +	},
> +	{
> +		.function = "i2c0",
> +		.dev_name = "foo-i2c.0",
> +	},
> +};
> +
> +Since the above construct is pretty common there is a helper macro to make
> +it even more compact:
> +
> +static struct pinmux_map pmx_mapping[] = {
> +       PINMUX_MAP("spi0-1", "foo-spi.0"),
> +       PINMUX_MAP("i2c0", "foo-i2c.0"),
> +};
> +
This is great effort and provides a meaningful way for drivers to 
request for an entire group of pin configs rather than individual pin 
settings.
But, the msm tree has a bit more configurations options.
1) For power management we need to specify multiple configs for a 
particular pin. When we boot we have these low power settings for each pin.
     Once the driver needs to use a particular device - it can call to 
install the active/enable settings for that pin.
     Also,  sometimes a pin needs to be configured for alternate usage. 
How can we use this patch to have multiple configs that can be stored in 
the pinmux_map and apply it as needed?
     From your previous gpio_config patch - we could pass in a setting 
for a pin and have it routed through gpiolib.

2) Currently writing the settings (map) for each pin involves just a 
register address and the bits to be toggled.
     But for the msm - we have different options and possibly different 
register bits to be toggled for selecting a FUNC_SEL , changing the 
Drive Strength and the PULL and for setting the pin as an output line etc.
Is there a way we can accomplish this using this patch ?

3) Each board has upto 200 pins - and with a slight modification to each 
board in hardware, our pinmuxes are modified. So, most likely our pin 
configurations originate (maintained) at the board level. Would it stay 
same in this implementation or we would have to migrate all the config 
information into drivers/pinmux ?

Attached are the patches that we had submitted upstream for this effort. 
Going forward, we would like to use this generic library, but is there a 
way we can bridge this gap?

> +The dev_name here matches to the unique device name that can be used to look
> +up the device struct (just like with clockdev or regulators). The function name
> +must match a function provided by the pinmux driver handling this pin range.
> +You register this pinmux mapping to the pinmux subsystem by simply:
> +
> +       ret = pinmux_register_mappings(&pmx_mapping, ARRAY_SIZE(pmx_mapping));
> +

Thanks,
Rohit Vaswani

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

-------------- next part --------------
An embedded message was scrubbed...
From: Rohit Vaswani <rvaswani@codeaurora.org>
Subject: [PATCH] msm: gpiomux: decentralize and modularize gpiomux init.
Date: Thu, 10 Feb 2011 15:45:00 -0800
Size: 18771
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110504/76b3bc0f/attachment-0002.mht>
-------------- next part --------------
An embedded message was scrubbed...
From: Rohit Vaswani <rvaswani@codeaurora.org>
Subject: [PATCH] msm: gpiomux: Remove GPIOMUX_VALID and merge config enums
Date: Fri, 25 Feb 2011 12:19:58 -0800
Size: 21313
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110504/76b3bc0f/attachment-0003.mht>
