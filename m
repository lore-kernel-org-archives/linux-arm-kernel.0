From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Mar 2012 12:27:31 +0000
Subject: [PATCH V2 5/7] ARM: SPEAr3xx: Add device-tree support to SPEAr3xx
 architecture
In-Reply-To: <f4ad79023c6155d4de7e87c3cd798aadd493454e.1332926608.git.viresh.kumar@st.com>
References: <cover.1332926608.git.viresh.kumar@st.com>
 <f4ad79023c6155d4de7e87c3cd798aadd493454e.1332926608.git.viresh.kumar@st.com>
Message-ID: <201203281227.32299.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 March 2012, Viresh Kumar wrote:
> This patch adds a generic target for SPEAr3xx machines that can be configured
> via the device-tree. Currently the following devices are supported via the
> devicetree:
> 
> - VIC interrupts
> - PL011 UART
> - PL061 GPIO
> - PL110 CLCD
> - SP805 WDT
> - Synopsys DW I2C
> - Synopsys DW ethernet
> - ST FSMC-NAND
> - ST SPEAR-SMI
> - ST SPEAR-KEYBOARD
> - ST SPEAR-RTC
> - ARASAN SDHCI-SPEAR
> - SPEAR-EHCI
> - SPEAR-OHCI
> 
> Other peripheral devices will follow in later patches.

Hi Viresh,

I found a few small issues here, nothing serious:

> @@ -192,9 +192,9 @@ machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
>  machine-$(CONFIG_ARCH_VT8500)		:= vt8500
>  machine-$(CONFIG_ARCH_W90X900)		:= w90x900
>  machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
> -machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
> -machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
> -machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
> +machine-$(CONFIG_MACH_SPEAR300_DT)	:= spear3xx
> +machine-$(CONFIG_MACH_SPEAR310_DT)	:= spear3xx
> +machine-$(CONFIG_MACH_SPEAR320_DT)	:= spear3xx
>  machine-$(CONFIG_MACH_SPEAR600)		:= spear6xx
>  machine-$(CONFIG_ARCH_ZYNQ)		:= zynq

Since you're actually removing the non-DT support, I don't see a point in
renaming the config symbols. Your patch should become quite a bit smaller
if you leave them the way they are now.

> +/ {
> +	ahb {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges = <0x60000000 0x60000000 0x50000000
> +			  0xd0000000 0xd0000000 0x30000000>;
> +
> +		clcd at 60000000 {
> +			compatible = "arm,clcd-pl110", "arm,primecell";
> +			reg = <0x60000000 0x1000>;
> +			interrupt-parent = <&vic>;
> +			interrupts = <30>;
> +			status = "disabled";
> +		};

You can move the interrupt-parent property that points to vic into the
root node to define vic as the default parent so you don't have to
list it individually in all the nodes using it.

> +
> +			serial at d0000000 {
> +			       status = "okay";
> +			};
> +
> +			serial at b2000000 {
> +			       status = "okay";
> +			};
> +
> +			serial at b2080000 {
> +			       status = "okay";
> +			};
> +
> +			serial at b2100000 {
> +			       status = "okay";
> +			};
> +
> +			serial at b2180000 {
> +			       status = "okay";
> +			};
> +
> +			serial at b2200000 {
> +			       status = "okay";
> +			};

Does spear310-evb really connect all seven serial ports?

> +/* Add SPEAr300 auxdata to pass platform data */
> +static struct of_dev_auxdata spear300_auxdata_lookup[] __initdata = {
> +	SPEAR3XX_AUXDATA_LOOKUP,
> +	{}
> +};

I don't really like the use of macros in this way. Better copy the
contents here, especially if you don't expect to add more stuff to
that macro.

> -/* spear300 routine
> +	if (of_machine_is_compatible("st,spear300-evb")) {
> +		/* pmx initialization */
> +		pmx_driver.mode = &spear300_photo_frame_mode;
> +		pmx_driver.devs = spear300_evb_pmx_devs;
> +		pmx_driver.devs_count = ARRAY_SIZE(spear300_evb_pmx_devs);
> +	} else {
> +		pr_err("Invalid board\n");
> +		return;
> +	}

I would not report the board as invalid if it doesn't match your list.
Just keep going here in the hope that the board does work with its
device tree contents.

> +
> +/* Following will create static virtual/physical mappings */
> +struct map_desc spear3xx_io_desc[] __initdata = {
> +	{
> +		.virtual	= VA_SPEAR3XX_ICM1_UART_BASE,
> +		.pfn		= __phys_to_pfn(SPEAR3XX_ICM1_UART_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE
> +	}, {
> +		.virtual	= VA_SPEAR3XX_ML1_VIC_BASE,
> +		.pfn		= __phys_to_pfn(SPEAR3XX_ML1_VIC_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE
> +	}, {
> +		.virtual	= VA_SPEAR3XX_ICM3_SYS_CTRL_BASE,
> +		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_SYS_CTRL_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE
> +	}, {
> +		.virtual	= VA_SPEAR3XX_ICM3_MISC_REG_BASE,
> +		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_MISC_REG_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE
> +	},
> +};

Note: there no real reason to just map 4K pages here, or to compute the
virtual addresses using the IO_ADDRESS macro. Using larger mappings mean
you have more efficient TLB lookup for any I/O windows that are located
closely together.

I would actually write this something like
struct map_desc spear3xx_io_desc[] __initdata = {
	{
		.virtual = 0xf0000000,
		.pfn	 = __phys_to_pfn(SPEAR3XX_ICM1_2_BASE),
		.length	 = SZ_16M,
		.type	 = MT_DEVICE,
	}, {
		.virtual = 0xf1000000,
		.pfn	 = __phys_to_pfn(SPEAR3XX_ICM4_BASE),
		.length  = 3 * SZ_16M,
		.type	 = MT_DEVICE,
	}, {
		.virtual = 0xf4000000,
		.pfn	 = __phys_to_pfn(SPEAR3XX_ICM3_ML1_2_BASE),
		.length  = 2 * SZ_16M,
		.type	 = MT_DEVICE,
	}, {
		.virtual = 0xf6000000,
		.pfn	 = __phys_to_pfn(SPEAR3XX_ICM3_SMI_CTRL_BASE),
		.length  = SZ_16M,
		.type	 = MT_DEVICE,
	},
};

This would cover almost all of your devices with just seven TLB entries,
and ioremap can now find the right virtual addresses automatically.

	Arnd
