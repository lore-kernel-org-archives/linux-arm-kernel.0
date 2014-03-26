From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Mar 2014 11:56:30 +0100
Subject: [PATCH] ARM: realview: basic device tree implementation
In-Reply-To: <1395826060-26662-1-git-send-email-linus.walleij@linaro.org>
References: <1395826060-26662-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4327457.yKTHVHA17K@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 March 2014 10:27:40 Linus Walleij wrote:
> This implements basic device tree boot support for the RealView
> platforms, with a basic device tree for ARM PB1176 as an example.
> 
> The implementation is done with a new DT-specific board file
> using only pre-existing bindings for the basic IRQ, timer and
> serial port drivers. A new compatible type is added to the GIC
> for the ARM1176.
> 
> This implementation uses the MFD syscon handle from day one to
> access the system controller registers, and register the devices
> using the SoC bus.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Ah, very nice!
> +
> +ARM RealView Boards
> +-------------------
> +The RealView boards cover tailored evaluation boards that are used to explore
> +the ARM11 and Cortex A-8 and Cortex A-9 processors.
> +
> +Required properties (in root node):
> +	/* RealView Emulation Baseboard */
> +	compatible = "arm,realview-eb";
> +	 /* RealView Platform Baseboard for ARM1176JZF-S */
> +	compatible = "arm,realview-pb1176";
> +	/* RealView Platform Baseboard for ARM11 MPCore */
> +	compatible = "arm,realview-pb11mp";
> +	/* RealView Platform Baseboard for Cortex A-8 */
> +	compatible = "arm,realview-pba8";
> +	/* RealView Platform Baseboard Explore for Cortex A-9 */
> +	compatible = "arm,realview-pbx";
> +
> +Required nodes:
> +
> +- syscon: the root node of the Integrator platforms must have a

				    Realview
> +		timer01: timer at 10104000 {
> +			compatible = "arm,sp804", "arm,primecell";
> +			reg = <0x10104000 0x1000>;
> +			interrupt-parent = <&intc_dc1176>;
> +			interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>, <0 9 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&timclk>, <&timclk>, <&pclk>;
> +			clock-names = "timclk1", "timclk2", "apb_pclk";
> +		};

In the binding, the clock names are "timer1", "timer2", "apb_pclk".
What is going on here?

> +
> +		pb1176_serial3: uart at 1010f000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x1010f000 0x1000>;
> +			interrupt-parent = <&intc_dc1176>;
> +			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&uartclk>, <&pclk>;
> +			clock-names = "uartclk", "apb_pclk";
> +		};

Here, the binding says:

- clocks:  When present, must refer to exactly one clock named
           "apb_pclk"


> +static void __init realview_dt_init_machine(void)
> +{
> +	struct device_node *root;
> +	struct device_node *syscon;
> +	struct soc_device *soc_dev;
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct device *parent;
> +	u32 coreid;
> +	int ret;
> +
> +#ifdef CONFIG_CACHE_L2X0
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

Russell just posted a long series of l2x0 cleanup patches. One
of the things coming out of that was that we should never need to
pass values like this here. The registers are typically initialized
to a hardwired default that should be ok, and if not, the boot loader
should set them up correctly. Can you print out the boot-time values
to see if realview gets this wrong?

If Linux has to override the register, we should have the correct
setting in DT and make l2x0_of_init do the right thing itself.

> +        /* Here we create an SoC device for the root node */
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return;
> +	syscon = of_find_matching_node(root, realview_syscon_match);
> +	if (!syscon)
> +		return;
> +
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
> +
> +	syscon_regmap = syscon_node_to_regmap(syscon);
> +	if (IS_ERR(syscon_regmap)) {
> +		pr_crit("could not locate syscon regmap\n");
> +		return;
> +	}
> +	ret = regmap_read(syscon_regmap, REALVIEW_SYS_ID_OFFSET, &coreid);
> +	if (ret)
> +		return;
> +	pr_info("RealView Syscon Core ID: 0x%08x\n", coreid);
> +	/* FIXME: add attributes for SoC to sysfs */
> +}


I would not register a "soc" device for the root node, but rather
reorganize the DT to put all soc specific nodes under a combined
soc node. I suppose that could actually be the syscon node itself.

> +static void realview_dt_fixup(struct tag *tags, char **from,
> +				struct meminfo *meminfo)
> +{
> +	/*
> +	 * RealView PB1176 only has 128MB of RAM mapped at 0.
> +	 */
> +	if (of_machine_is_compatible("arm,realview-pb1176")) {
> +		meminfo->bank[0].start = 0;
> +		meminfo->bank[0].size = SZ_128M;
> +		meminfo->nr_banks = 1;
> +	}

This one should come right from DT I think.

> +#ifdef CONFIG_SPARSEMEM
> +	/*
> +	 * Memory configuration with SPARSEMEM enabled on RealView PBX (see
> +	 * asm/mach/memory.h for more information).
> +	 */
> +	else if (of_machine_is_compatible("arm,realview-pbx")) {
> +		meminfo->bank[0].start = 0;
> +		meminfo->bank[0].size = SZ_256M;
> +		meminfo->bank[1].start = 0x20000000;
> +		meminfo->bank[1].size = SZ_512M;
> +		meminfo->bank[2].start = 0x80000000;
> +		meminfo->bank[2].size = SZ_256M;
> +		meminfo->nr_banks = 3;
> +	}
> +#endif

This one too, but I'm not completely sure about it. Do you see a reason
for the kernel to override the memory location on PBX?

> +	/*
> +	 * Generic RealView fixup
> +	 * Most RealView platforms have 512MB contiguous RAM at 0x70000000.
> +	 * Half of this is mirrored at 0.
> +	 */
> +	else {
> +#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> +		meminfo->bank[0].start = 0x70000000;
> +		meminfo->bank[0].size = SZ_512M;
> +		meminfo->nr_banks = 1;
> +#else
> +		meminfo->bank[0].start = 0;
> +		meminfo->bank[0].size = SZ_256M;
> +		meminfo->nr_banks = 1;
> +#endif
> +	}
> +}

And this one is where it gets tricky. We don't have a good way
to describe memory aliases in DT, but we need the start of memory
to match PHYS_OFFSET if CONFIG_SPARSEMEM is set (which implies
!CONFIG_REALVIEW_HIGH_PHYS_OFFSET), or if we are running a no-MMU
kernel. I have to think about this some more.

> +static void realview_dt_restart(enum reboot_mode mode, const char *cmd)
> +{
> +	if (IS_ERR(syscon_regmap))
> +		return;
> +
> +	/* Unlock the reset register */
> +	regmap_write(syscon_regmap, REALVIEW_SYS_LOCK_OFFSET,
> +		     REALVIEW_SYS_LOCK_VAL);
> +	/* Then hit reset on the different machines */
> +	if (of_machine_is_compatible("arm,realview-eb")) {
> +		regmap_write(syscon_regmap,
> +			     REALVIEW_SYS_RESETCTL_OFFSET, 0x0008);
> +	} else if (of_machine_is_compatible("arm,realview-pb1176")) {
> +		regmap_write(syscon_regmap,
> +			     REALVIEW_SYS_RESETCTL_OFFSET, 0x0100);
> +	} else if (of_machine_is_compatible("arm,realview-pb11mp") ||
> +		   of_machine_is_compatible("arm,realview-pba8")) {
> +		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
> +			     0x0000);
> +		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
> +			     0x0004);
> +	} else if (of_machine_is_compatible("arm,realview-pbx")) {
> +		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
> +			     0x00f0);
> +		regmap_write(syscon_regmap, REALVIEW_SYS_RESETCTL_OFFSET,
> +			     0x00f4);
> +	}
> +	dsb();
> +}

I'd be much happier if we had a separate device node to match against,
rather than using of_machine_is_compatible(). That would allow us to
later move this code out into a separate driver. Note that I'd still
hope to one day have an empty directory for all the ARM reference
platforms.

> +DT_MACHINE_START(REALVIEW_DT, "ARM RealView Machine (Device Tree Support)")
> +	.fixup		= realview_dt_fixup,
> +	.map_io		= realview_dt_map_io,
> +	.init_machine	= realview_dt_init_machine,
> +#ifdef CONFIG_ZONE_DMA
> +	.dma_zone_size	= SZ_256M,
> +#endif
> +	.dt_compat	= realview_dt_platform_compat,
> +	.restart	= realview_dt_restart,

This isn't specific to the DT version of realview, but what happens if
CONFIG_ZONE_DMA is disabled? 

	Arnd
