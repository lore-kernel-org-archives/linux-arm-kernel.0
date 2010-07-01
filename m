From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Jul 2010 13:24:51 +0100
Subject: [PATCH 2/3] arm: s5pv210: Aquila: add support for MAX8998 PMIC
In-Reply-To: <1277964466-23891-3-git-send-email-m.szyprowski@samsung.com>
References: <1277964466-23891-1-git-send-email-m.szyprowski@samsung.com>
	<1277964466-23891-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100701122451.GA17698@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 08:07:45AM +0200, Marek Szyprowski wrote:

> +static struct regulator_consumer_supply aquila_ldo3_consumers[] = {
> +	{	.supply	= "VMIPI_1.1V",	},
> +};

> +static struct regulator_consumer_supply aquila_ldo8_consumers[] = {
> +	{	.supply	= "VADC_3.3V", },
> +};

Almost all of these regulator supplies should be removed.  Except in
some exceptional cases all supplies should specify a struct device (the
only one that really exists at the minute is CPU core due to lack of
devices for CPUfreq).  In general if you're defining a supply name that
is the same as the rail on the board rather than a pin on a chip you're
not using the API correctly.

If you want to label the supply for userspace do so in the constraints.

> +	.constraints	= {
> +		.name		= "VALIVE_1.1V",
> +		.min_uV		= 1100000,
> +		.max_uV		= 1100000,
> +		.apply_uV	= 1,
> +		.always_on	= 1,
> +		.boot_on	= 0,

No need to explicitly set stuff to zero.
