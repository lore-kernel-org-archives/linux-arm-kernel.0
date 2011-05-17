From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 17 May 2011 15:01:33 -0700
Subject: [PATCH] drivers: create a pinmux subsystem v2
In-Reply-To: <1305070783-23193-1-git-send-email-linus.walleij@linaro.org>
References: <1305070783-23193-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A478E6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Tuesday, May 10, 2011 5:40 PM:
> This creates a subsystem for handling of pinmux devices. These are
> devices that enable and disable groups of pins on primarily PGA and
> BGA type of chip packages and common in embedded systems.

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

Rather than defining a custom type (foo_pmx_func) for this array inside
each driver, and then having to implement _list, _get_fname, _get_pins
below, how about:

* pinmux core defines a basic structure containing all the information
  that the core needs from the specific implementation.

* This structure would need a field to point at the implementation-
  specific data.

* We could get rid of _list, _get_fname, _get_pins completely from
  pinmux_ops.

pinmux.h:

struct pinmux_function {
	char *name;
	const unsigned int *pins;
	const unsigned num_pins;
      void *driver_data;
};

driver source:

struct foo_pmx_func {
	int register;
	int mask;
	int value;
};

static struct foo_pmx_func spi0_0_func = {
	FOO_REG_PMX_A,
	0x30,
	0x10,
};
...
static struct pinmux_function myfuncs[] = {
	{
		.name = "spi0-0",
		.pins = spi0_0_pins,
		.num_pins = ARRAY_SIZE(spi0_1_pins),
		.driver_data = &spi0_0_func,
	},
	{
		.name = "i2c0",
		.pins = i2c0_pins,
		.num_pins = ARRAY_SIZE(i2c0_pins),
		.driver_data = &i2c0_func,
	},
	{
		.name = "spi0-1",
		.pins = spi0_1_pins,
		.num_pins = ARRAY_SIZE(spi0_1_pins),
		.driver_data = &spi0_1_func,
	},
};

This would remove some boiler-plate code from the SoC drivers,
although it might be considered a bad breaking of abstraction barriers?

-- 
nvpublic
