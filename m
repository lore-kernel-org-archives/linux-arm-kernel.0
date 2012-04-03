From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2012 13:47:34 +0000
Subject: [PATCH] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
References: <a1b7f612544a09989cec80a0318f35b6e48eb1d3.1333453148.git.viresh.kumar@st.com>
Message-ID: <201204031347.35256.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2012, Viresh Kumar wrote:
> This adds pinctrl driver for SPEAr family. Currently it contains machine/SoC
> drivers for SPEAr3xx family only. SPEAr13xx family drivers will follow.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Hi Viresh,

This is quite a lot of data, especially for the spear320. Have you
tried moving some or all of the data into device tree properties?

I can only guess that the spear13xx file would be even larger than
these.

> +
> +static struct of_device_id spear_pinctrl_of_match[] __devinitdata = {
> +#ifdef CONFIG_PINCTRL_SPEAR300
> +	{
> +		.compatible = "st,spear300-pinmux",
> +		.data = spear300_mach_init,
> +	},
> +#endif
> +#ifdef CONFIG_PINCTRL_SPEAR310
> +	{
> +		.compatible = "st,spear310-pinmux",
> +		.data = spear310_mach_init,
> +	},
> +#endif
> +#ifdef CONFIG_PINCTRL_SPEAR320
> +	{
> +		.compatible = "st,spear320-pinmux",
> +		.data = spear320_mach_init,
> +	},
> +#endif
> +	{},
> +};

I would recommend turning the logic around here: instead of having
a common driver that calls into the soc specific drivers, make the
common code a library that just exports a few symbols, and move
each of the socs into its own module with one init function
that calls the generic spear_pinctrl_probe, passing the appropriate
arguments on the code that that differs.

> +static struct platform_driver spear_pinctrl_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table = spear_pinctrl_of_match,
> +	},
> +	.probe = spear_pinctrl_probe,
> +	.remove = __devexit_p(spear_pinctrl_remove),
> +};
> +
> +static int __init spear_pinctrl_init(void)
> +{
> +	return platform_driver_register(&spear_pinctrl_driver);
> +}
> +arch_initcall(spear_pinctrl_init);
> +
> +static void __exit spear_pinctrl_exit(void)
> +{
> +	platform_driver_unregister(&spear_pinctrl_driver);
> +}
> +module_exit(spear_pinctrl_exit);

Does this need to be an arch_initcall? If it becomes a regular
module_init(), you can condense all of this into a single
line using module_platform_driver(), one per soc if you do as
I suggest above.

The initialization order dependencies can now be handled using
the deferred probe mechanism, by returning -EPROBE_DEFER from
the probe() function of any driver that is loaded before its
pins are available.

> +static struct spear_pmx_mode pmx_mode_nand = {
> +	.name = "nand",
> +	.mode = NAND_MODE,
> +	.reg = MODE_CONFIG_REG,
> +	.mask = 0x0000000F,
> +	.val = 0x00,
> +};
> +
> +static struct spear_pmx_mode pmx_mode_nor = {
> +	.name = "nor",
> +	.mode = NOR_MODE,
> +	.reg = MODE_CONFIG_REG,
> +	.mask = 0x0000000F,
> +	.val = 0x01,
> +};
> +
> +static struct spear_pmx_mode pmx_mode_photo_frame = {
> +	.name = "photo frame mode",
> +	.mode = PHOTO_FRAME_MODE,
> +	.reg = MODE_CONFIG_REG,
> +	.mask = 0x0000000F,
> +	.val = 0x02,
> +};

These all look like they can easily get transformed into
device nodes in the device tree.

> +/* pingroups */
> +static struct spear_pingroup *spear310_pingroups[] = {
> +	SPEAR3XX_COMMON_PINGROUPS,
> +	&emi_cs_0_to_5_pingroup,
> +	&uart1_pingroup,
> +	&uart2_pingroup,
> +	&uart3_pingroup,
> +	&uart4_pingroup,
> +	&uart5_pingroup,
> +	&fsmc_pingroup,
> +	&rs485_0_pingroup,
> +	&rs485_1_pingroup,
> +	&tdm_pingroup,
> +};
> +
> +/* functions */
> +static struct spear_function *spear310_functions[] = {
> +	SPEAR3XX_COMMON_FUNCTIONS,
> +	&emi_cs_0_to_5_function,
> +	&uart1_function,
> +	&uart2_function,
> +	&uart3_function,
> +	&uart4_function,
> +	&uart5_function,
> +	&fsmc_function,
> +	&rs485_0_function,
> +	&rs485_1_function,
> +	&tdm_function,
> +};

I believe the macros like SPEAR3XX_COMMON_FUNCTIONS are not
needed any more, you can simply register multiple sets of pingroups
and functions.

	Arnd
