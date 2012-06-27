From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Jun 2012 16:25:48 +0200
Subject: [RFC PATCHv1 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA Cyclone 5 HW
In-Reply-To: <1340805007-3313-3-git-send-email-dinguyen@altera.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-3-git-send-email-dinguyen@altera.com>
Message-ID: <20120627162548.01adc769@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dinh,

Le Wed, 27 Jun 2012 08:50:07 -0500,
<dinguyen@altera.com> a ?crit :

> +CONFIG_CMDLINE="console=ttyS0,57600 mem=256M at 0x0"

Why do you need to specify the memory map here, since it's already
passed in the device tree?

> diff --git a/arch/arm/mach-socfpga/include/mach/clkdev.h b/arch/arm/mach-socfpga/include/mach/clkdev.h
> new file mode 100644
> index 0000000..1eeecc4
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/include/mach/clkdev.h
> @@ -0,0 +1,16 @@
> +#ifndef __ASM_MACH_CLKDEV_H
> +#define __ASM_MACH_CLKDEV_H
> +
> +#include <mach/clock.h>
> +
> +struct clk {
> +	unsigned long		rate;
> +	const struct clk_ops	*ops;
> +	const struct icst_params *params;
> +	void __iomem		*vcoreg;
> +};
> +
> +#define __clk_get(clk) ({ 1; })
> +#define __clk_put(clk) do { } while (0)

Why is this in this patch? It should have been in the previous one
(adding the SoC support). But anyway, it shouldn't be there at all, you
should use the clock framework in drivers/clk/ instead.

> +#define SOCFPGA_LWFPGASLAVES_BASE 	(0xff200000)
> +#define SOCFPGA_LWHPS2FPGAREGS_BASE (0xff400000)
> +#define SOCFPGA_HPS2FPGAREGS_BASE	(0xff500000)
> +#define SOCFPGA_FPGA2HPSREGS_BASE 	(0xff600000)
> +#define SOCFPGA_EMAC0_BASE 		(0xff700000)
> +#define SOCFPGA_EMAC1_BASE 		(0xff702000)
> +#define SOCFPGA_SDMMC_BASE 		(0xff704000)
> +#define SOCFPGA_QSPIREGS_BASE 	(0xff705000)
> +#define SOCFPGA_FPGAMGRREGS_BASE 	(0xff706000)
> +#define SOCFPGA_ACPIDMAP_BASE 	(0xff707000)
> +#define SOCFPGA_GPIO0_BASE 		(0xff708000)
> +#define SOCFPGA_GPIO1_BASE 		(0xff709000)
> +#define SOCFPGA_GPIO2_BASE 		(0xff70a000)
> +#define SOCFPGA_L3REGS_BASE 	(0xff800000)
> +#define SOCFPGA_NANDDATA_BASE 	(0xff900000)
> +#define SOCFPGA_QSPIDATA_BASE 	(0xffa00000)
> +#define SOCFPGA_USB0_BASE 		(0xffb00000)
> +#define SOCFPGA_USB1_BASE 		(0xffb40000)
> +#define SOCFPGA_NANDREGS_BASE 	(0xffb80000)
> +#define SOCFPGA_FPGAMGRDATA_BASE 	(0xffb90000)
> +#define SOCFPGA_CAN0_BASE 		(0xffc00000)
> +#define SOCFPGA_CAN1_BASE 		(0xffc01000)
> +#define SOCFPGA_UART0_BASE 		(0xffc02000)
> +#define SOCFPGA_UART1_BASE 		(0xffc03000)
> +#define SOCFPGA_I2C0_BASE 		(0xffc04000)
> +#define SOCFPGA_I2C1_BASE 		(0xffc05000)
> +#define SOCFPGA_I2C2MDIO0_BASE 	(0xffc06000)
> +#define SOCFPGA_I2C3MDIO1_BASE 	(0xffc07000)
> +#define SOCFPGA_SPTIMER0_BASE 	(0xffc08000)
> +#define SOCFPGA_SPTIMER1_BASE 	(0xffc09000)
> +#define SOCFPGA_SDR_BASE 		(0xffc20000)
> +#define SOCFPGA_OSC1TIMER0_BASE 	(0xffd00000)
> +#define SOCFPGA_OSC1TIMER1_BASE 	(0xffd01000)
> +#define SOCFPGA_L4WD0_BASE 		(0xffd02000)
> +#define SOCFPGA_L4WD1_BASE 		(0xffd03000)
> +#define SOCFPGA_CLKMGR_BASE 	(0xffd04000)
> +#define SOCFPGA_RSTMGR_BASE 	(0xffd05000)
> +#define SOCFPGA_SYSMGR_BASE 	(0xffd08000)
> +#define SOCFPGA_DMANONSECURE_BASE 	(0xffe00000)
> +#define SOCFPGA_DMASECURE_BASE 	(0xffe01000)
> +#define SOCFPGA_SPIS0_BASE 		(0xffe02000)
> +#define SOCFPGA_SPIS1_BASE 		(0xffe03000)
> +#define SOCFPGA_SPIM0_BASE 		(0xfff00000)
> +#define SOCFPGA_SPIM1_BASE 		(0xfff01000)
> +#define SOCFPGA_SCANMGR_BASE 	(0xfff02000)
> +#define SOCFPGA_ROM_BASE 		(0xfffd0000)
> +#define SOCFPGA_MPUSCU_BASE 	(0xfffec000)
> +#define SOCFPGA_MPUL2_BASE 		(0xfffef000)
> +#define SOCFPGA_OCRAM_BASE 		(0xffff0000)
> +
> +#define SOCFPGA_GIC_CPU_BASE	(SOCFPGA_MPUSCU_BASE + 0x100)
> +#define SOCFPGA_TWD_BASE		(SOCFPGA_MPUSCU_BASE + 0x600)
> +#define SOCFPGA_GIC_DIST_BASE	(SOCFPGA_MPUSCU_BASE + 0x1000)
> +
> +/* System Manager */
> +#define SOCFPGA_SMP_FLAG		(SOCFPGA_SYSMGR_BASE + 0x10)
> +#define SOCFPGA_SYSMGR_SDMMCGRP_CTR	(SOCFPGA_SYSMGR_BASE + 0x108)
> +
> +/* Clock Manager */
> +#define SOCFPGA_CLKMGR_PERPLLGRP_EN	(SOCFPGA_CLKMGR_BASE + 0xA0)

Just like the IRQ numbers, those defines for I/O registers are no
longer needed with the device tree.

> +/*
> + * Lookup table for attaching a specific name and platform_data pointer to
> + * devices as they get created by of_platform_populate().  Ideally this table
> + * would not exist, but the current clock implementation depends on some devices
> + * having a specific name.
> + */
> +static const struct of_dev_auxdata cyclone5_auxdata_lookup[] __initconst = {
> +	OF_DEV_AUXDATA("snps,dw-spi-mmio", SOCFPGA_SPIM0_BASE, "dw-spi-mmio.0", NULL),
> +	OF_DEV_AUXDATA("snps,dw-spi-mmio", SOCFPGA_SPIM1_BASE, "dw-spi-mmio.1", NULL),
> +	OF_DEV_AUXDATA("arm,pl330", SOCFPGA_DMASECURE_BASE, "dma-pl330", NULL),
> +	{ /* sentinel */ }
> +};

Huh? I'm not sure to understand what this is useful for.

> +const static struct of_device_id irq_match[] = {
> +	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
> +	{}
> +};
> +
> +static struct map_desc cyclone5_io_desc[] __initdata = {
> +	{
> +		.virtual	= IO_ADDRESS(SOCFPGA_SPTIMER0_BASE),
> +		.pfn		= __phys_to_pfn(SOCFPGA_SPTIMER0_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= IO_ADDRESS(SOCFPGA_SPTIMER1_BASE),
> +		.pfn		= __phys_to_pfn(SOCFPGA_SPTIMER1_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= IO_ADDRESS(SOCFPGA_OSC1TIMER0_BASE),
> +		.pfn		= __phys_to_pfn(SOCFPGA_OSC1TIMER0_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= IO_ADDRESS(SOCFPGA_OSC1TIMER1_BASE),
> +		.pfn		= __phys_to_pfn(SOCFPGA_OSC1TIMER1_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= IO_ADDRESS(SOCFPGA_MPUSCU_BASE),
> +		.pfn		= __phys_to_pfn(SOCFPGA_MPUSCU_BASE),
> +		.length		= SZ_8K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= IO_ADDRESS(SOCFPGA_SYSMGR_BASE),
> +		.pfn		= __phys_to_pfn(SOCFPGA_SYSMGR_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= IO_ADDRESS(SOCFPGA_MPUL2_BASE),
> +		.pfn		= __phys_to_pfn(SOCFPGA_MPUL2_BASE),
> +		.length		= SZ_8K,
> +		.type		= MT_DEVICE,
> +	}, {
> +		.virtual	= IO_ADDRESS(SOCFPGA_CLKMGR_BASE),
> +		.pfn		= __phys_to_pfn(SOCFPGA_CLKMGR_BASE),
> +		.length		= SZ_4K,
> +		.type		= MT_DEVICE,
> +	},
> +};

Most of those static mappings should instead be turned into dynamic
mappings created with ioremap(), at least for the timers.

> +static const char *altera_dt_match[] = {
> +	"altr,socfpga-cyclone5",
> +	NULL
> +};
> +
> +MACHINE_START(SOCFPGA_CYCLONE5, "Altera SOCFPGA Cyclone V")
> +	.atag_offset    = 0x100,
> +	.fixup		= socfpga_fixup,
> +	.map_io		= cyclone5_map_io,
> +	.init_early	= socfpga_init_early,
> +	.init_irq	= gic_init_irq,
> +	.handle_irq     = gic_handle_irq,
> +	.timer		= &socfpga_cyclone5_timer,
> +	.init_machine	= socfpga_cyclone5_init,
> +	.restart	= socfpga_cyclone5_restart,
> +	.dt_compat	= altera_dt_match,
> +MACHINE_END

You should use DT_MACHINE_START and not MACHINE_START, since new SoC
should only use the Device Tree now. So the .atag_offset and .fixup
should no longer be necessary.

> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 2997e56..c6ed4b1 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -1206,3 +1206,4 @@ baileys			MACH_BAILEYS		BAILEYS			4169
>  familybox		MACH_FAMILYBOX		FAMILYBOX		4170
>  ensemble_mx35		MACH_ENSEMBLE_MX35	ENSEMBLE_MX35		4171
>  sc_sps_1		MACH_SC_SPS_1		SC_SPS_1		4172
> +socfpga_cyclone5	MACH_SOCFPGA_CYCLONE5	SOCFPGA_CYCLONE5	4251

A machine ID is no longer needed with the Device Tree.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
