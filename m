From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 May 2014 12:44:01 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201405091244.02066.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 May 2014, Linus Walleij wrote:

> diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
> new file mode 100644
> index 000000000000..0eea0f4a7b39
> --- /dev/null
> +++ b/arch/arm/boot/dts/arm-realview-pb1176.dts

Can you split this up into an arm-realview.dtsi file for the common parts and
a pb1176 specific file for the rest?

> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		syscon: syscon at 10000000 {
> +			compatible = "arm,realview-pb1176-syscon", "syscon";
> +			reg = <0x10000000 0x1000>;
> +		};

Hmm, in order to have a proper reset driver, we probably want a separate
node for the reset controller. I believe the x-gene people have just
posted a generic reset driver based on syscon. Let's see if we can share
that.

> +		pb1176_serial0: uart at 1010c000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x1010c000 0x1000>;
> +			interrupt-parent = <&intc_dc1176>;
> +			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&uartclk>, <&pclk>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};

I believe the "official" name for a uart is serial at 1010c000, not uart at 1010c000.
I know we are inconsistent with that.

> +
> +/* Pointer to the system controller */
> +struct regmap *syscon_regmap;
> +u8 syscon_type;
> +
> +static struct map_desc realview_dt_io_desc[] __initdata = {
> +	{
> +		/* FIXME: static map needed for LED driver */
> +		.virtual	= IO_ADDRESS(REALVIEW_SYS_BASE),
> +		.pfn		= __phys_to_pfn(REALVIEW_SYS_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	},
> +};

I've looked at the driver and I don't see why this is required.
The driver does a devm_ioremap_resource(), which should work with
or without a static mapping.

> +/*
> + * We detect the different syscon types from the compatible strings.
> + */
> +enum realview_syscon {
> +	REALVIEW_SYSCON_EB,
> +	REALVIEW_SYSCON_PB1176,
> +	REALVIEW_SYSCON_PB11MP,
> +	REALVIEW_SYSCON_PBA8,
> +	REALVIEW_SYSCON_PBX,
> +};
> +
> +static const struct of_device_id realview_syscon_match[] = {
> +	{
> +		.compatible = "arm,realview-eb-syscon",
> +		.data = (void *)REALVIEW_SYSCON_EB,
> +	},
> +	{
> +		.compatible = "arm,realview-pb1176-syscon",
> +		.data = (void *)REALVIEW_SYSCON_PB1176,
> +	},
> +	{
> +		.compatible = "arm,realview-pb11mp-syscon",
> +		.data = (void *)REALVIEW_SYSCON_PB11MP,
> +	},
> +	{
> +		.compatible = "arm,realview-pba8-syscon",
> +		.data = (void *)REALVIEW_SYSCON_PBA8,
> +	},
> +	{
> +		.compatible = "arm,realview-pbx-syscon",
> +		.data = (void *)REALVIEW_SYSCON_PBX,
> +	},
> +};

If not the generic syscon reset driver, it should at least live in
drivers/power/reset/ rather than here.

> +#if IS_ENABLED(CONFIG_CACHE_L2X0)
> +	if (of_machine_is_compatible("arm,realview-eb"))
> +		/*
> +		 * 1MB (128KB/way), 8-way associativity,
> +		 * evmon/parity/share enabled
> +		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
> +		 */
> +		l2x0_of_init(0x00790000, 0xfe000fff);
> +	else if (of_machine_is_compatible("arm,realview-pb1176"))
> +		/*
> +		 * 128Kb (16Kb/way) 8-way associativity.
> +		 * evmon/parity/share enabled.
> +		 */
> +		l2x0_of_init(0x00730000, 0xfe000fff);
> +	else if (of_machine_is_compatible("arm,realview-pb11mp"))
> +		/*
> +		 * 1MB (128KB/way), 8-way associativity,
> +		 * evmon/parity/share enabled
> +		 * Bits:  .... ...0 0111 1001 0000 .... .... ....
> +		 */
> +		l2x0_of_init(0x00730000, 0xfe000fff);
> +	else if (of_machine_is_compatible("arm,realview-pbx"))
> +		/*
> +		 * 16KB way size, 8-way associativity, parity disabled
> +		 * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... ....
> +		 */
> +		l2x0_of_init(0x02520000, 0xc0000fff);
> +#endif

You wrote that you added the #if IS_ENABLED() here. Why?

l2x0_of_init is already a nop if CONFIG_CACHE_L2X0 is not set. If you want to
skip a bit of dead code here, you could make it an inline function and do

	if (IS_ENABLED(CONFIG_CACHE_L2X0))
		realview_setup_l2x0();

Other than that, I still think we should avoid doing anything platform
specific here at all, and move it all into the l2x0_of_init function,
based on Russell's l2x0 patch series.

> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return;
> +	ret = of_property_read_string(root, "compatible",
> +				      &soc_dev_attr->soc_id);
> +	if (ret)
> +		return;
> +	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
> +        if (ret)
> +		return;
> +	soc_dev_attr->family = "RealView";
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		kfree(soc_dev_attr);
> +		return;
> +	}
> +	parent = soc_device_to_device(soc_dev);
> +	ret = of_platform_populate(root, of_default_bus_match_table,
> +				   NULL, parent);
> +	if (ret) {
> +		pr_crit("could not populate device tree\n");
> +		return;
> +	}

I wonder if there is a way to do this without having code in the platform.
I would hate it if we get to the point where each platform is completely
empty but still requires a copy of this code.

We just faced the same discussion on the exynos chip id patches.

I also noticed that you pass the DT root here, which isn't actually
the intention of the soc device interface: you should pass the DT node
that has the on-chip devices but not the board-level (top-level) nodes
such as your fixed clocks.

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 5bf7c3c3b301..5461c4401ed6 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -928,7 +928,7 @@ config ARM_L1_CACHE_SHIFT
>  config ARM_DMA_MEM_BUFFERABLE
>  	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
>  	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
> -		     MACH_REALVIEW_PB11MP)
> +		     MACH_REALVIEW_PB11MP || REALVIEW_DT)
>  	default y if CPU_V6 || CPU_V6K || CPU_V7
>  	help
>  	  Historically, the kernel has used strongly ordered mappings to

Do you have an explanation for why this is needed? I don't remember seeing
this before, but I guess it gets in the way of multiplatform support.
Is this just a performance optimization on realview, or is it actually
required?


	Arnd
