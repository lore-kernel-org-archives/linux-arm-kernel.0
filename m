From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 15:42:14 +0100
Subject: [PATCH 6/8] arm: initial machine port for artpec-6 SoC
In-Reply-To: <fa3483f1a388e443245084c3b5e9aa1ad2f61392.1455107681.git.larper@axis.com>
References: <cover.1455107681.git.larper@axis.com>
 <fa3483f1a388e443245084c3b5e9aa1ad2f61392.1455107681.git.larper@axis.com>
Message-ID: <2600190.zvDdb99M2V@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 February 2016 13:41:55 Lars Persson wrote:
> @@ -0,0 +1,22 @@
> +menuconfig ARCH_ARTPEC
> +	bool "Axis Communications ARM based ARTPEC SoCs" if ARCH_MULTI_V7
> +
> +if ARCH_ARTPEC
> +
> +config MACH_ARTPEC6
> +	bool "Axis ARTPEC-6 ARM Cortex A9 Platform" if ARCH_MULTI_V7

Change both to use

	depends on ARCH_MULTI_V7

like we changed all other platforms in 4.5

> +	select ARM_AMBA
> +	select ARM_GIC
> +	select ARM_GLOBAL_TIMER
> +	select ARM_PSCI
> +	select COMMON_CLK
> +	select GENERIC_CLOCKEVENTS
> +	select HAVE_ARM_ARCH_TIMER
> +	select HAVE_ARM_SCU
> +	select HAVE_ARM_TWD if SMP
> +	select SPARSE_IRQ
> +	select USE_OF

No need for GENERIC_CLOCKEVENTS, COMMON_CLK, USE_OF or SPARSE_IRQ to be selected, they
are always enabled with ARCH_MULTIPLATFORM. Check the others as well to see if 
you can drop more of them.

> +
> +#define ARTPEC6_DMACFG 0xf8000010
> +#define ARTPEC6_DMACFG_UARTS_BURST 0xff
> +
> +#define SECURE_OP_L2C_WRITEREG 0xb4000001
> +
> +static void __init artpec6_init_machine(void)
> +{
> +	void __iomem *dmacfg;
> +
> +	/* Use PL011 DMA Burst Request signal instead of DMA Single Request */
> +	dmacfg = ioremap(ARTPEC6_DMACFG, 4);
> +	if (dmacfg) {
> +		__raw_writel(ARTPEC6_DMACFG_UARTS_BURST, dmacfg);
> +		iounmap(dmacfg);
> +	}

Can you do this in the bootloader?

If not, please use a DT node to pass the address rather than hardcoding it,
and use writel() instead of __raw_writel() so it works with on big-endian kernels.

> +DT_MACHINE_START(ARTPEC6, "Axis ARTPEC-6 Platform")
> +	.l2c_aux_val	= 0x0C000000,
> +	.l2c_aux_mask	= 0xF3FFFFFF,
> +	.l2c_write_sec  = artpec6_l2c310_write_sec,
> +	.init_irq	= irqchip_init,
> +	.init_machine	= artpec6_init_machine,
> +	.dt_compat	= artpec6_dt_match,
> +MACHINE_END
> 

You can drop the irqchip_init.

	Arnd
