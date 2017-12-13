From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 13 Dec 2017 10:47:18 +0100
Subject: [PATCH V4 10/12] boot_constraint: Add support for Hisilicon
 platforms
In-Reply-To: <facf1c5838468c8440240e2828a8e4982003a6f6.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <facf1c5838468c8440240e2828a8e4982003a6f6.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <20171213094718.GE13194@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 07:18:58PM +0530, Viresh Kumar wrote:
> This adds boot constraint support for Hisilicon platforms. Currently
> only one use case is supported: earlycon. One of the UART is enabled by
> the bootloader and is used for early console in the kernel. The boot
> constraint core handles it properly and removes constraints once the
> serial device is probed by its driver.
> 
> This is tested on hi6220-hikey 96board.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/Kconfig.platforms      |   1 +
>  drivers/boot_constraints/Makefile |   2 +
>  drivers/boot_constraints/hikey.c  | 145 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 drivers/boot_constraints/hikey.c
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 6b54ee8c1262..265df4a088ab 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -87,6 +87,7 @@ config ARCH_HISI
>  	select ARM_TIMER_SP804
>  	select HISILICON_IRQ_MBIGEN if PCI
>  	select PINCTRL
> +	select DEV_BOOT_CONSTRAINTS
>  	help
>  	  This enables support for Hisilicon ARMv8 SoC family
>  
> diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
> index 0d4f88bb767c..43c89d2458e9 100644
> --- a/drivers/boot_constraints/Makefile
> +++ b/drivers/boot_constraints/Makefile
> @@ -1,3 +1,5 @@
>  # Makefile for device boot constraints
>  
>  obj-y := clk.o deferrable_dev.o core.o pm.o serial.o supply.o
> +
> +obj-$(CONFIG_ARCH_HISI)			+= hikey.o
> diff --git a/drivers/boot_constraints/hikey.c b/drivers/boot_constraints/hikey.c
> new file mode 100644
> index 000000000000..5f69f9451d93
> --- /dev/null
> +++ b/drivers/boot_constraints/hikey.c
> @@ -0,0 +1,145 @@
> +/*
> + * This takes care of Hisilicon boot time device constraints, normally set by
> + * the Bootloader.
> + *
> + * Copyright (C) 2017 Linaro.
> + * Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * This file is released under the GPLv2.
> + */
> +
> +#include <linux/boot_constraint.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +
> +struct hikey_machine_constraints {
> +	struct dev_boot_constraint_of *dev_constraints;
> +	unsigned int count;
> +};
> +
> +static struct dev_boot_constraint_clk_info uart_iclk_info = {
> +	.name = "uartclk",
> +};
> +
> +static struct dev_boot_constraint_clk_info uart_pclk_info = {
> +	.name = "apb_pclk",
> +};
> +
> +static struct dev_boot_constraint hikey3660_uart_constraints[] = {
> +	{
> +		.type = DEV_BOOT_CONSTRAINT_CLK,
> +		.data = &uart_iclk_info,
> +	}, {
> +		.type = DEV_BOOT_CONSTRAINT_CLK,
> +		.data = &uart_pclk_info,
> +	},
> +};
> +
> +static const char * const uarts_hikey3660[] = {
> +	"serial at fff32000",	/* UART 6 */
> +};
> +
> +static struct dev_boot_constraint_of hikey3660_dev_constraints[] = {
> +	{
> +		.compat = "arm,pl011",
> +		.constraints = hikey3660_uart_constraints,
> +		.count = ARRAY_SIZE(hikey3660_uart_constraints),
> +
> +		.dev_names = uarts_hikey3660,
> +		.dev_names_count = ARRAY_SIZE(uarts_hikey3660),
> +	},
> +};
> +
> +static struct hikey_machine_constraints hikey3660_constraints = {
> +	.dev_constraints = hikey3660_dev_constraints,
> +	.count = ARRAY_SIZE(hikey3660_dev_constraints),
> +};
> +
> +static const char * const uarts_hikey6220[] = {
> +	"uart at f7113000",	/* UART 3 */
> +};
> +
> +static struct dev_boot_constraint_of hikey6220_dev_constraints[] = {
> +	{
> +		.compat = "arm,pl011",
> +		.constraints = hikey3660_uart_constraints,
> +		.count = ARRAY_SIZE(hikey3660_uart_constraints),
> +
> +		.dev_names = uarts_hikey6220,
> +		.dev_names_count = ARRAY_SIZE(uarts_hikey6220),
> +	},
> +};
> +
> +static struct hikey_machine_constraints hikey6220_constraints = {
> +	.dev_constraints = hikey6220_dev_constraints,
> +	.count = ARRAY_SIZE(hikey6220_dev_constraints),
> +};
> +
> +static struct dev_boot_constraint hikey3798cv200_uart_constraints[] = {
> +	{
> +		.type = DEV_BOOT_CONSTRAINT_CLK,
> +		.data = &uart_pclk_info,
> +	},
> +};
> +
> +static const char * const uarts_hikey3798cv200[] = {
> +	"serial at 8b00000",	/* UART 0 */
> +};
> +
> +static struct dev_boot_constraint_of hikey3798cv200_dev_constraints[] = {
> +	{
> +		.compat = "arm,pl011",
> +		.constraints = hikey3798cv200_uart_constraints,
> +		.count = ARRAY_SIZE(hikey3798cv200_uart_constraints),
> +
> +		.dev_names = uarts_hikey3798cv200,
> +		.dev_names_count = ARRAY_SIZE(uarts_hikey3798cv200),
> +	},
> +};
> +
> +static struct hikey_machine_constraints hikey3798cv200_constraints = {
> +	.dev_constraints = hikey3798cv200_dev_constraints,
> +	.count = ARRAY_SIZE(hikey3798cv200_dev_constraints),
> +};
> +
> +static const struct of_device_id machines[] __initconst = {
> +	{ .compatible = "hisilicon,hi3660", .data = &hikey3660_constraints },
> +	{ .compatible = "hisilicon,hi3798cv200", .data = &hikey3798cv200_constraints },
> +	{ .compatible = "hisilicon,hi6220", .data = &hikey6220_constraints },
> +	{ }
> +};
> +
> +static int __init hikey_constraints_init(void)
> +{
> +	const struct hikey_machine_constraints *constraints;
> +	const struct of_device_id *match;
> +	struct device_node *np;
> +
> +	if (!boot_constraint_earlycon_enabled())
> +		return 0;
> +
> +	np = of_find_node_by_path("/");

What is this for?

> +	if (!np)
> +		return -ENODEV;
> +
> +	match = of_match_node(machines, np);
> +	of_node_put(np);
> +
> +	if (!match)
> +		return 0;
> +
> +	constraints = match->data;
> +	BUG_ON(!constraints);

Never crash the device for a driver configuration issue.  That's going
to be bad.

> +	dev_boot_constraint_add_deferrable_of(constraints->dev_constraints,
> +					      constraints->count);
> +
> +	return 0;
> +}
> +
> +/*
> + * The amba-pl011 driver registers itself from arch_initcall level. Setup the
> + * serial boot constraints before that in order not to miss any boot messages.
> + */
> +postcore_initcall_sync(hikey_constraints_init);

Now you have to worry about the bootconstraints earlycon being called
before/after your code.  That's another linking order dependancy you
just created.  It feels more complex for something so "simple" as
looking for the earlycon flag...

thanks,

greg k-h
