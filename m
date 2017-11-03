From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Nov 2017 09:58:06 +0100
Subject: [PATCH V4 11/12] boot_constraint: Add support for IMX platform
In-Reply-To: <154e4d17ab6b848fb3ba240d9e2349278a16442a.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <154e4d17ab6b848fb3ba240d9e2349278a16442a.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <20171103085806.pbnuytylni56jwh2@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 07:18:59PM +0530, Viresh Kumar wrote:
> This adds boot constraint support for IMX platforms. Currently only one
> use case is supported: earlycon. Some of the UARTs are enabled by the
> bootloader and are used for early console in the kernel. The boot
> constraint core handles them properly and removes them once the serial
> device is probed by its driver.
> 
> This gets rid of lots of hacky code in the clock drivers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-imx/Kconfig         |   1 +
>  drivers/boot_constraints/Makefile |   1 +
>  drivers/boot_constraints/imx.c    | 113 ++++++++++++++++++++++++++++++++++++++
>  drivers/clk/imx/clk-imx25.c       |  12 ----
>  drivers/clk/imx/clk-imx27.c       |  13 -----
>  drivers/clk/imx/clk-imx31.c       |  12 ----
>  drivers/clk/imx/clk-imx35.c       |  10 ----
>  drivers/clk/imx/clk-imx51-imx53.c |  16 ------
>  drivers/clk/imx/clk-imx6q.c       |   8 ---
>  drivers/clk/imx/clk-imx6sl.c      |   8 ---
>  drivers/clk/imx/clk-imx6sx.c      |   8 ---
>  drivers/clk/imx/clk-imx7d.c       |  14 -----
>  drivers/clk/imx/clk.c             |  38 -------------
>  drivers/clk/imx/clk.h             |   1 -
>  14 files changed, 115 insertions(+), 140 deletions(-)
>  create mode 100644 drivers/boot_constraints/imx.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 782699e67600..9ea1fe32b280 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -4,6 +4,7 @@ menuconfig ARCH_MXC
>  	select ARCH_SUPPORTS_BIG_ENDIAN
>  	select CLKSRC_IMX_GPT
>  	select GENERIC_IRQ_CHIP
> +	select DEV_BOOT_CONSTRAINTS
>  	select GPIOLIB
>  	select PINCTRL
>  	select PM_OPP if PM
> diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
> index 43c89d2458e9..3b5a87fcf099 100644
> --- a/drivers/boot_constraints/Makefile
> +++ b/drivers/boot_constraints/Makefile
> @@ -3,3 +3,4 @@
>  obj-y := clk.o deferrable_dev.o core.o pm.o serial.o supply.o
>  
>  obj-$(CONFIG_ARCH_HISI)			+= hikey.o
> +obj-$(CONFIG_ARCH_MXC)			+= imx.o
> +
> +static const struct of_device_id machines[] __initconst = {
> +	{ .compatible = "fsl,imx25", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx27", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx31", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx35", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx50", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx51", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx53", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx6dl", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx6q", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx6qp", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx6sl", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx6sx", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx6ul", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx6ull", .data = &imx_constraints },
> +	{ .compatible = "fsl,imx7d", .data = &imx7_constraints },
> +	{ .compatible = "fsl,imx7s", .data = &imx7_constraints },
> +	{ }
> +};
> +
> +static int __init imx_constraints_init(void)
> +{
> +	const struct imx_machine_constraints *constraints;
> +	const struct of_device_id *match;
> +	struct device_node *np;
> +
> +	if (!boot_constraint_earlycon_enabled())
> +		return 0;
> +
> +	np = of_find_node_by_path("/");
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
> +
> +	dev_boot_constraint_add_deferrable_of(constraints->dev_constraints,
> +					      constraints->count);
> +
> +	return 0;
> +}
> +subsys_initcall(imx_constraints_init);

As said to Viresh privately: I would pretty much prefer this code being
hooked up to some SoC specific code which already knows the SoC type rather
than looping around the compatible array for all enabled machines (which
may even not only be i.MX for multi SoC kernels).
Vireshs response was that adding more SoC specific code may not be
wanted after we've finally got rid of most of it. So basically we need
a third opinion ;)

Other than that I tested an earlier version of this patch on i.MX6 and
it worked as expected.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
