From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Jun 2012 16:20:14 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <1340805007-3313-2-git-send-email-dinguyen@altera.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
Message-ID: <20120627162014.1494cdd7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dinh,

Below a few comments from my modest experience on the mach-mvebu SoC
support.

Le Wed, 27 Jun 2012 08:50:06 -0500,
<dinguyen@altera.com> a ?crit :

> +config ARCH_SOCFPGA

Is SOCFPGA a good name? It seems like a very generic name. Shouldn't it
be ARCH_ALTERA_SOCFPGA a better name? I suspect other vendors will
provide a SoC together with a FPGA.

> +choice
> +	prompt "Altera SOCFPGA Platform"
> +	default MACH_SOCFPGA_CYCLONE5
> +	depends on ARCH_SOCFPGA
> +	help
> +		Select SOCFPGA platform type
> +
> +config MACH_SOCFPGA_CYCLONE5
> +	bool "SOCFPGA Cyclone5 platform"
> +	select HAVE_SMP
> +	select PLAT_SOCFPGA_ETH
> +	help
> +	  Include support for the Altera(R) Cyclone5 development platform.
> +endchoice

Why do you need a "choice" here? The code should be able to support
building multiple platforms at once. And even more: for a given SoC
variant, we now generally only want one config options, the board-level
details being abstracted out by the device tree.

> index 0000000..7a1f3c0
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/Makefile.boot
> @@ -0,0 +1,3 @@
> +zreladdr-y	:= 0x00008000
> +params_phys-y	:= 0x00000100
> +initrd_phys-y	:= 0x00800000

With the device tree, the params_phys-y and initrd_phys-y variables are
useless.

> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/clk.h>
> +#include <linux/mutex.h>
> +#include <mach/clkdev.h>
> +
> +int clk_enable(struct clk *clk)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_enable);
> +
> +void clk_disable(struct clk *clk)
> +{
> +}
> +EXPORT_SYMBOL(clk_disable);
> +
> +unsigned long clk_get_rate(struct clk *clk)
> +{
> +	return clk->rate;
> +}
> +EXPORT_SYMBOL(clk_get_rate);
> +
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	long ret = -EIO;
> +	if (clk->ops && clk->ops->round)
> +		ret = clk->ops->round(clk, rate);
> +	return ret;
> +}
> +EXPORT_SYMBOL(clk_round_rate);
> +
> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	int ret = -EIO;
> +	if (clk->ops && clk->ops->set)
> +		ret = clk->ops->set(clk, rate);
> +	return ret;
> +}
> +EXPORT_SYMBOL(clk_set_rate);

I don't think the ARM maintainers want more implementations of the
clock API. New SoCs should instead use the new clock framework in
drivers/clk/. See Documentation/clk.txt for details. You can for
example look at the mxs or spear implementations for examples.

> +extern struct dw_mci_board sdmmc_platform_data;
> +extern struct dma_pl330_platdata dma_platform_data;
> +
> +#define DW_APB_UART_OF_COMPATIBLE			"snps,dw-apb-uart"
> +
> +#define SOCFPGA_MPU_PERIHCLK_FREQ_HZ			(800000000 / 4)
> +#define SOCFPGA_L4_MAIN_CLK					(400000000)
> +
> +static struct clk dummy_apb_pclk;
> +static struct clk dummy_i2c_clk = {
> +	.rate   = 100000000,
> +};
> +static struct clk dummy_spim_clk = {
> +	.rate   = 100000000,
> +};
> +static struct clk mpu_periphclk = {
> +	.rate   = SOCFPGA_MPU_PERIHCLK_FREQ_HZ,
> +};
> +
> +static struct clk l4_main_clk = {
> +	.rate   = SOCFPGA_L4_MAIN_CLK,
> +};
> +
> +static struct clk_lookup lookups[] = {
> +	{	/* Bus clock */
> +		.con_id		= "apb_pclk",
> +		.clk		= &dummy_apb_pclk,
> +	},
> +	{
> +		.dev_id		= "ffc04000.i2c",
> +		.clk		= &dummy_i2c_clk,
> +	},
> +	{
> +		.dev_id		= "ffc05000.i2c",
> +		.clk		= &dummy_i2c_clk,
> +	},
> +	{
> +		.dev_id		= "dw-spi-mmio.0",
> +		.clk		= &dummy_spim_clk,
> +	},
> +	{
> +		.dev_id		= "dw-spi-mmio.1",
> +		.clk		= &dummy_spim_clk,
> +	},
> +	{
> +		.dev_id		= "smp_twd",
> +		.clk		= &mpu_periphclk,
> +	},
> +	{
> +		.dev_id		= "dma-pl330",
> +		.clk		= &l4_main_clk,
> +	}
> +};

These should use the clock framework.

> +struct plat_serial8250_port uart_platform_data[] = {
> +		{
> +		.type		= PORT_16850,
> +		.flags 		= UPF_BOOT_AUTOCONF | UPF_IOREMAP | \
> +				  UPF_FIXED_TYPE,
> +		},
> +};

This sounds strange. Why aren't you using the ns16850 compatible string
to instantiate the UART devices directly from your device tree?

> +/*
> + * Set up the clock source and clock events devices
> + */
> +
> +void __init socfpga_timer_init(void __iomem *src_timer_base,
> +				void __iomem *event_timer_base,
> +				unsigned int event_timer_irq)
> +{
> +	/*
> +	 * Initialise to a known state (all timers off)
> +	 */
> +	writel(0, sp_timer0_va_base + TIMER_CTRL);
> +	writel(0, sp_timer1_va_base + TIMER_CTRL);
> +	writel(0, osc_timer0_va_base + TIMER_CTRL);
> +	writel(0, osc_timer1_va_base + TIMER_CTRL);

Shouldn't this be done within the timer driver itself?

> +/*
> + * Setup the memory banks.
> + */
> +void socfpga_fixup(struct tag *tags, char **from, struct meminfo *meminfo)
> +{
> +	meminfo->bank[0].start = 0x0;
> +	meminfo->bank[0].size = SZ_256M;
> +	meminfo->nr_banks = 1;
> +}

Looks strange. Those informations are now normally passed in the device
tree.

> +int socfpga_notifier(struct device *device)
> +{
> +	struct device_node *dn = device->of_node;
> +
> +	if (of_device_is_compatible(dn, DW_APB_UART_OF_COMPATIBLE))
> +		device->platform_data = &uart_platform_data;
> +	return 0;
> +}

If using the ns16850 device tree compatible string works to instantiate
your UART, you could remove this.

> +++ b/arch/arm/mach-socfpga/dw_apb_timer.c

The clocksource/clockevents driver now go into drivers/clocksource/,
and the corresponding maintainers should be CC'ed (Thomas Gleixner and
John Stultz.

> +/*
> + * SOCFPGA interrupt sources
> + */
> +#define IRQ_SOCFPGA_CPU0_PARITY	(IRQ_SOCFPGA_GIC_START + 0)		/* CPU0 parity */
> +#define IRQ_SOCFPGA_CPU0_PARITY_BTAG	(IRQ_SOCFPGA_GIC_START + 1)		/* CPU0 parity BTAG		*/
> +#define IRQ_SOCFPGA_CPU0_PARITY_GHB		(IRQ_SOCFPGA_GIC_START + 2)		/* CPU0 parity GHB		*/
> +#define IRQ_SOCFPGA_CPU0_PARITY_ITAG	(IRQ_SOCFPGA_GIC_START + 3)		/* CPU0 parity ITAG		*/
> +#define IRQ_SOCFPGA_CPU0_PARITY_IDATA	(IRQ_SOCFPGA_GIC_START + 4)		/* CPU0 parity IDATA	*/
> +#define IRQ_SOCFPGA_CPU0_PARITY_TLB		(IRQ_SOCFPGA_GIC_START + 5)		/* CPU0 parity TLB		*/
> +#define IRQ_SOCFPGA_CPU0_PARITY_DOUTER	(IRQ_SOCFPGA_GIC_START + 6)		/* CPU0 parity DOUTER	*/
> +#define IRQ_SOCFPGA_CPU0_PARITY_DTAG	(IRQ_SOCFPGA_GIC_START + 7)		/* CPU0 parity DTAG		*/
> +#define IRQ_SOCFPGA_CPU0_PARITY_DDATA	(IRQ_SOCFPGA_GIC_START + 8)		/* CPU0 parity DDATA	*/
> +#define IRQ_SOCFPGA_CPU0_DEFLAGS0	(IRQ_SOCFPGA_GIC_START + 9)			/* CPU0 deflasg 0 */
> +#define IRQ_SOCFPGA_CPU0_DEFLAGS1	(IRQ_SOCFPGA_GIC_START + 10)		/* CPU0 deflags 1 */
> +#define IRQ_SOCFPGA_CPU0_DEFLAGS2	(IRQ_SOCFPGA_GIC_START + 11)		/* CPU0 deflags 2 */
> +#define IRQ_SOCFPGA_CPU0_DEFLAGS3	(IRQ_SOCFPGA_GIC_START + 12)		/* CPU0 deflags 3 */
> +#define IRQ_SOCFPGA_CPU0_DEFLAGS4	(IRQ_SOCFPGA_GIC_START + 13)		/* CPU0 deflags 4 */
> +#define IRQ_SOCFPGA_CPU0_DEFLAGS5	(IRQ_SOCFPGA_GIC_START + 14)		/* CPU0 deflags 5 */
> +#define IRQ_SOCFPGA_CPU0_DEFLAGS6	(IRQ_SOCFPGA_GIC_START + 15)		/* CPU0 deflags 6 */
> +#define IRQ_SOCFPGA_CPU1_PARITY		(IRQ_SOCFPGA_GIC_START + 16)		/* CPU1 parity */
> +#define IRQ_SOCFPGA_CPU1_PARITY_BTAG	(IRQ_SOCFPGA_GIC_START + 17)	/* CPU1 parity BTAG		*/
> +#define IRQ_SOCFPGA_CPU1_PARITY_GHB		(IRQ_SOCFPGA_GIC_START + 18)	/* CPU1 parity GHB		*/
> +#define IRQ_SOCFPGA_CPU1_PARITY_ITAG	(IRQ_SOCFPGA_GIC_START + 19)	/* CPU1 parity ITAG		*/
> +#define IRQ_SOCFPGA_CPU1_PARITY_IDATA	(IRQ_SOCFPGA_GIC_START + 20)	/* CPU1 parity IDATA	*/
> +#define IRQ_SOCFPGA_CPU1_PARITY_TLB		(IRQ_SOCFPGA_GIC_START + 21)	/* CPU1 parity TLB		*/
> +#define IRQ_SOCFPGA_CPU1_PARITY_DOUTER	(IRQ_SOCFPGA_GIC_START + 22)	/* CPU1 parity DOUTER	*/
> +#define IRQ_SOCFPGA_CPU1_PARITY_DTAG	(IRQ_SOCFPGA_GIC_START + 23)	/* CPU1 parity DTAG		*/
> +#define IRQ_SOCFPGA_CPU1_PARITY_DDATA	(IRQ_SOCFPGA_GIC_START + 24)	/* CPU1 parity DDATA	*/
> +#define IRQ_SOCFPGA_CPU1_DEFLAGS0	(IRQ_SOCFPGA_GIC_START + 25)		/* CPU1 deflags 0 */
> +#define IRQ_SOCFPGA_CPU1_DEFLAGS1	(IRQ_SOCFPGA_GIC_START + 26)	/* CPU1 deflags 1 */
> +#define IRQ_SOCFPGA_CPU1_DEFLAGS2	(IRQ_SOCFPGA_GIC_START + 27)	/* CPU1 deflags 2 */
> +#define IRQ_SOCFPGA_CPU1_DEFLAGS3	(IRQ_SOCFPGA_GIC_START + 28)	/* CPU1 deflags 3 */
> +#define IRQ_SOCFPGA_CPU1_DEFLAGS4	(IRQ_SOCFPGA_GIC_START + 29)	/* CPU1 deflags 4 */
> +#define IRQ_SOCFPGA_CPU1_DEFLAGS5	(IRQ_SOCFPGA_GIC_START + 30)	/* CPU1 deflags 5 */
> +#define IRQ_SOCFPGA_CPU1_DEFLAGS6	(IRQ_SOCFPGA_GIC_START + 31)	/* CPU1 deflags 6 */
> +#define IRQ_SOCFPGA_SCU0_PARITY	(IRQ_SOCFPGA_GIC_START + 32)	/* SCU0 parity */
> +#define IRQ_SOCFPGA_SCU1_PARITY	(IRQ_SOCFPGA_GIC_START + 33)	/* SCU1 parity */
> +#define IRQ_SOCFPGA_SCU_EV_ABORT	(IRQ_SOCFPGA_GIC_START + 34)	/* SCU EV abort */
> +#define IRQ_SOCFPGA_L2_ECC_WRITE	(IRQ_SOCFPGA_GIC_START + 35)	/* L2 ECC write */
> +#define IRQ_SOCFPGA_L2_ECC_CERR	(IRQ_SOCFPGA_GIC_START + 36)	/* L2 ECC error corrected */
> +#define IRQ_SOCFPGA_L2_ECC_UERR	(IRQ_SOCFPGA_GIC_START + 37)	/* L2 ECC error uncorrected */
> +#define IRQ_SOCFPGA_L2		(IRQ_SOCFPGA_GIC_START + 38)	/* L2 combined interrupts */
> +#define IRQ_SOCFPGA_DDR_ECC_ERR	(IRQ_SOCFPGA_GIC_START + 39)	/* DDR ECC error */
> +#define IRQ_SOCFPGA_F2S_FPGA0 	(IRQ_SOCFPGA_GIC_START + 40) 	/* FPGA IRQ 0 */
> +#define IRQ_SOCFPGA_F2S_FPGA1 	(IRQ_SOCFPGA_GIC_START + 41) 	/* FPGA IRQ 1 */
> +#define IRQ_SOCFPGA_F2S_FPGA2 	(IRQ_SOCFPGA_GIC_START + 42) 	/* FPGA IRQ 2 */
> +#define IRQ_SOCFPGA_F2S_FPGA3 	(IRQ_SOCFPGA_GIC_START + 43) 	/* FPGA IRQ 3 */
> +#define IRQ_SOCFPGA_F2S_FPGA4 	(IRQ_SOCFPGA_GIC_START + 44) 	/* FPGA IRQ 4 */
> +#define IRQ_SOCFPGA_F2S_FPGA5 	(IRQ_SOCFPGA_GIC_START + 45) 	/* FPGA IRQ 5 */
> +#define IRQ_SOCFPGA_F2S_FPGA6 	(IRQ_SOCFPGA_GIC_START + 46) 	/* FPGA IRQ 6 */
> +#define IRQ_SOCFPGA_F2S_FPGA7 	(IRQ_SOCFPGA_GIC_START + 47) 	/* FPGA IRQ 7 */
> +#define IRQ_SOCFPGA_F2S_FPGA8 	(IRQ_SOCFPGA_GIC_START + 48) 	/* FPGA IRQ 8 */
> +#define IRQ_SOCFPGA_F2S_FPGA9 	(IRQ_SOCFPGA_GIC_START + 49) 	/* FPGA IRQ 9 */
> +#define IRQ_SOCFPGA_F2S_FPGA10 	(IRQ_SOCFPGA_GIC_START + 50) 	/* FPGA IRQ 10 */
> +#define IRQ_SOCFPGA_F2S_FPGA11 	(IRQ_SOCFPGA_GIC_START + 51) 	/* FPGA IRQ 11 */
> +#define IRQ_SOCFPGA_F2S_FPGA12 	(IRQ_SOCFPGA_GIC_START + 52) 	/* FPGA IRQ 12 */
> +#define IRQ_SOCFPGA_F2S_FPGA13 	(IRQ_SOCFPGA_GIC_START + 53) 	/* FPGA IRQ 13 */
> +#define IRQ_SOCFPGA_F2S_FPGA14 	(IRQ_SOCFPGA_GIC_START + 54) 	/* FPGA IRQ 14 */
> +#define IRQ_SOCFPGA_F2S_FPGA15 	(IRQ_SOCFPGA_GIC_START + 55) 	/* FPGA IRQ 15 */
> +#define IRQ_SOCFPGA_F2S_FPGA16 	(IRQ_SOCFPGA_GIC_START + 56) 	/* FPGA IRQ 16 */
> +#define IRQ_SOCFPGA_F2S_FPGA17 	(IRQ_SOCFPGA_GIC_START + 57) 	/* FPGA IRQ 17 */
> +#define IRQ_SOCFPGA_F2S_FPGA18 	(IRQ_SOCFPGA_GIC_START + 58) 	/* FPGA IRQ 18 */
> +#define IRQ_SOCFPGA_F2S_FPGA19 	(IRQ_SOCFPGA_GIC_START + 59) 	/* FPGA IRQ 19 */
> +#define IRQ_SOCFPGA_F2S_FPGA20 	(IRQ_SOCFPGA_GIC_START + 60) 	/* FPGA IRQ 20 */
> +#define IRQ_SOCFPGA_F2S_FPGA21 	(IRQ_SOCFPGA_GIC_START + 61) 	/* FPGA IRQ 21 */
> +#define IRQ_SOCFPGA_F2S_FPGA22 	(IRQ_SOCFPGA_GIC_START + 62) 	/* FPGA IRQ 22 */
> +#define IRQ_SOCFPGA_F2S_FPGA23 	(IRQ_SOCFPGA_GIC_START + 63) 	/* FPGA IRQ 23 */
> +#define IRQ_SOCFPGA_F2S_FPGA24 	(IRQ_SOCFPGA_GIC_START + 64) 	/* FPGA IRQ 24 */
> +#define IRQ_SOCFPGA_F2S_FPGA25 	(IRQ_SOCFPGA_GIC_START + 65) 	/* FPGA IRQ 25 */
> +#define IRQ_SOCFPGA_F2S_FPGA26 	(IRQ_SOCFPGA_GIC_START + 66) 	/* FPGA IRQ 26 */
> +#define IRQ_SOCFPGA_F2S_FPGA27 	(IRQ_SOCFPGA_GIC_START + 67) 	/* FPGA IRQ 27 */
> +#define IRQ_SOCFPGA_F2S_FPGA28 	(IRQ_SOCFPGA_GIC_START + 68) 	/* FPGA IRQ 28 */
> +#define IRQ_SOCFPGA_F2S_FPGA29 	(IRQ_SOCFPGA_GIC_START + 69) 	/* FPGA IRQ 29 */
> +#define IRQ_SOCFPGA_F2S_FPGA30 	(IRQ_SOCFPGA_GIC_START + 70) 	/* FPGA IRQ 30 */
> +#define IRQ_SOCFPGA_F2S_FPGA31 	(IRQ_SOCFPGA_GIC_START + 71) 	/* FPGA IRQ 31 */
> +#define IRQ_SOCFPGA_F2S_FPGA32 	(IRQ_SOCFPGA_GIC_START + 72) 	/* FPGA IRQ 32 */
> +#define IRQ_SOCFPGA_F2S_FPGA33 	(IRQ_SOCFPGA_GIC_START + 73) 	/* FPGA IRQ 33 */
> +#define IRQ_SOCFPGA_F2S_FPGA34 	(IRQ_SOCFPGA_GIC_START + 74) 	/* FPGA IRQ 34 */
> +#define IRQ_SOCFPGA_F2S_FPGA35 	(IRQ_SOCFPGA_GIC_START + 75) 	/* FPGA IRQ 35 */
> +#define IRQ_SOCFPGA_F2S_FPGA36 	(IRQ_SOCFPGA_GIC_START + 76) 	/* FPGA IRQ 36 */
> +#define IRQ_SOCFPGA_F2S_FPGA37 	(IRQ_SOCFPGA_GIC_START + 77) 	/* FPGA IRQ 37 */
> +#define IRQ_SOCFPGA_F2S_FPGA38 	(IRQ_SOCFPGA_GIC_START + 78) 	/* FPGA IRQ 38 */
> +#define IRQ_SOCFPGA_F2S_FPGA39 	(IRQ_SOCFPGA_GIC_START + 79) 	/* FPGA IRQ 39 */
> +#define IRQ_SOCFPGA_F2S_FPGA40 	(IRQ_SOCFPGA_GIC_START + 80) 	/* FPGA IRQ 40 */
> +#define IRQ_SOCFPGA_F2S_FPGA41 	(IRQ_SOCFPGA_GIC_START + 81) 	/* FPGA IRQ 41 */
> +#define IRQ_SOCFPGA_F2S_FPGA42 	(IRQ_SOCFPGA_GIC_START + 82) 	/* FPGA IRQ 42 */
> +#define IRQ_SOCFPGA_F2S_FPGA43 	(IRQ_SOCFPGA_GIC_START + 83) 	/* FPGA IRQ 43 */
> +#define IRQ_SOCFPGA_F2S_FPGA44 	(IRQ_SOCFPGA_GIC_START + 84) 	/* FPGA IRQ 44 */
> +#define IRQ_SOCFPGA_F2S_FPGA45 	(IRQ_SOCFPGA_GIC_START + 85) 	/* FPGA IRQ 45 */
> +#define IRQ_SOCFPGA_F2S_FPGA46 	(IRQ_SOCFPGA_GIC_START + 86) 	/* FPGA IRQ 46 */
> +#define IRQ_SOCFPGA_F2S_FPGA47 	(IRQ_SOCFPGA_GIC_START + 87) 	/* FPGA IRQ 47 */
> +#define IRQ_SOCFPGA_F2S_FPGA48 	(IRQ_SOCFPGA_GIC_START + 88) 	/* FPGA IRQ 48 */
> +#define IRQ_SOCFPGA_F2S_FPGA49 	(IRQ_SOCFPGA_GIC_START + 89) 	/* FPGA IRQ 49 */
> +#define IRQ_SOCFPGA_F2S_FPGA50 	(IRQ_SOCFPGA_GIC_START + 90) 	/* FPGA IRQ 50 */
> +#define IRQ_SOCFPGA_F2S_FPGA51 	(IRQ_SOCFPGA_GIC_START + 91) 	/* FPGA IRQ 51 */
> +#define IRQ_SOCFPGA_F2S_FPGA52 	(IRQ_SOCFPGA_GIC_START + 92) 	/* FPGA IRQ 52 */
> +#define IRQ_SOCFPGA_F2S_FPGA53 	(IRQ_SOCFPGA_GIC_START + 93) 	/* FPGA IRQ 53 */
> +#define IRQ_SOCFPGA_F2S_FPGA54 	(IRQ_SOCFPGA_GIC_START + 94) 	/* FPGA IRQ 54 */
> +#define IRQ_SOCFPGA_F2S_FPGA55 	(IRQ_SOCFPGA_GIC_START + 95) 	/* FPGA IRQ 55 */
> +#define IRQ_SOCFPGA_F2S_FPGA56 	(IRQ_SOCFPGA_GIC_START + 96) 	/* FPGA IRQ 56 */
> +#define IRQ_SOCFPGA_F2S_FPGA57 	(IRQ_SOCFPGA_GIC_START + 97) 	/* FPGA IRQ 57 */
> +#define IRQ_SOCFPGA_F2S_FPGA58 	(IRQ_SOCFPGA_GIC_START + 98) 	/* FPGA IRQ 58 */
> +#define IRQ_SOCFPGA_F2S_FPGA59 	(IRQ_SOCFPGA_GIC_START + 99) 	/* FPGA IRQ 59 */
> +#define IRQ_SOCFPGA_F2S_FPGA60 	(IRQ_SOCFPGA_GIC_START + 100)	/* FPGA IRQ 60 */
> +#define IRQ_SOCFPGA_F2S_FPGA61 	(IRQ_SOCFPGA_GIC_START + 101)	/* FPGA IRQ 61 */
> +#define IRQ_SOCFPGA_F2S_FPGA62 	(IRQ_SOCFPGA_GIC_START + 102)	/* FPGA IRQ 62 */
> +#define IRQ_SOCFPGA_F2S_FPGA63 	(IRQ_SOCFPGA_GIC_START + 103)	/* FPGA IRQ 63 */
> +#define IRQ_SOCFPGA_DMA0		(IRQ_SOCFPGA_GIC_START + 104)	/* DMA Channel 0 */
> +#define IRQ_SOCFPGA_DMA1		(IRQ_SOCFPGA_GIC_START + 105)	/* DMA Channel 1 */
> +#define IRQ_SOCFPGA_DMA2		(IRQ_SOCFPGA_GIC_START + 106)	/* DMA Channel 2 */
> +#define IRQ_SOCFPGA_DMA3		(IRQ_SOCFPGA_GIC_START + 107)	/* DMA Channel 3 */
> +#define IRQ_SOCFPGA_DMA4		(IRQ_SOCFPGA_GIC_START + 108)	/* DMA Channel 3 */
> +#define IRQ_SOCFPGA_DMA5		(IRQ_SOCFPGA_GIC_START + 109)	/* DMA Channel 5 */
> +#define IRQ_SOCFPGA_DMA6		(IRQ_SOCFPGA_GIC_START + 110)	/* DMA Channel 6 */
> +#define IRQ_SOCFPGA_DMA7		(IRQ_SOCFPGA_GIC_START + 111)	/* DMA Channel 7 */
> +#define IRQ_SOCFPGA_DMA_ABORT	(IRQ_SOCFPGA_GIC_START + 112)	/* DMA abort */
> +#define IRQ_SOCFPGA_DMA_CECC	(IRQ_SOCFPGA_GIC_START + 113)	/* DMA ECC corrected */
> +#define IRQ_SOCFPGA_DMA_UECC	(IRQ_SOCFPGA_GIC_START + 114)	/* DMA ECC uncorrected */
> +#define IRQ_SOCFPGA_EMAC0		(IRQ_SOCFPGA_GIC_START + 115)	/* Gb-Ethernet MAC0 */
> +#define IRQ_SOCFPGA_EMAC0_TX_CECC	(IRQ_SOCFPGA_GIC_START + 116)	/* Gb-Ethernet MAC0 ECC corrected */
> +#define IRQ_SOCFPGA_EMAC0_TX_UECC	(IRQ_SOCFPGA_GIC_START + 117)	/* Gb-Ethernet MAC0 ECC uncorrected */
> +#define IRQ_SOCFPGA_EMAC0_RX_CECC	(IRQ_SOCFPGA_GIC_START + 118)	/* Gb-Ethernet MAC0 ECC corrected */
> +#define IRQ_SOCFPGA_EMAC0_RX_UECC	(IRQ_SOCFPGA_GIC_START + 119)	/* Gb-Ethernet MAC0 ECC uncorrected */
> +#define IRQ_SOCFPGA_EMAC1		(IRQ_SOCFPGA_GIC_START + 120)	/* Gb-Ethernet MAC1 */
> +#define IRQ_SOCFPGA_EMAC1_TX_CECC	(IRQ_SOCFPGA_GIC_START + 121)	/* Gb-Ethernet MAC1 ECC corrected */
> +#define IRQ_SOCFPGA_EMAC1_TX_UECC	(IRQ_SOCFPGA_GIC_START + 122)	/* Gb-Ethernet MAC1 ECC uncorrected */
> +#define IRQ_SOCFPGA_EMAC1_RX_CECC	(IRQ_SOCFPGA_GIC_START + 123)	/* Gb-Ethernet MAC1 ECC corrected */
> +#define IRQ_SOCFPGA_EMAC1_RX_UECC	(IRQ_SOCFPGA_GIC_START + 124)	/* Gb-Ethernet MAC1 ECC uncorrected */
> +#define IRQ_SOCFPGA_USB0		(IRQ_SOCFPGA_GIC_START + 125)	/* USB 0 generic */
> +#define IRQ_SOCFPGA_USB0_CECC	(IRQ_SOCFPGA_GIC_START + 126)	/* USB 0 ECC corrected */
> +#define IRQ_SOCFPGA_USB0_UECC	(IRQ_SOCFPGA_GIC_START + 127)	/* USB 0 ECC uncorrected */
> +#define IRQ_SOCFPGA_USB1		(IRQ_SOCFPGA_GIC_START + 128)	/* USB 1 generic */
> +#define IRQ_SOCFPGA_USB1_CECC	(IRQ_SOCFPGA_GIC_START + 129)	/* USB 1 ECC corrected */
> +#define IRQ_SOCFPGA_USB1_UECC	(IRQ_SOCFPGA_GIC_START + 130)	/* USB 1 ECC uncorrected */
> +#define IRQ_SOCFPGA_CAN0_STS	(IRQ_SOCFPGA_GIC_START + 131)	/* CAN0 interrupt 0 */
> +#define IRQ_SOCFPGA_CAN0_MO		(IRQ_SOCFPGA_GIC_START + 132)	/* CAN0 interrupt 1 */
> +#define IRQ_SOCFPGA_CAN0_CECC	(IRQ_SOCFPGA_GIC_START + 133)	/* CAN0 ECC corrected */
> +#define IRQ_SOCFPGA_CAN0_UECC	(IRQ_SOCFPGA_GIC_START + 134)	/* CAN0 ECC uncorrected */
> +#define IRQ_SOCFPGA_CAN1_STS	(IRQ_SOCFPGA_GIC_START + 135)	/* CAN1 interrupt 0 */
> +#define IRQ_SOCFPGA_CAN1_MO		(IRQ_SOCFPGA_GIC_START + 136)	/* CAN1 interrupt 1 */
> +#define IRQ_SOCFPGA_CAN1_CECC	(IRQ_SOCFPGA_GIC_START + 137)	/* CAN1 ECC corrected */
> +#define IRQ_SOCFPGA_CAN1_UECC	(IRQ_SOCFPGA_GIC_START + 138)	/* CAN1 ECC uncorrected */
> +#define IRQ_SOCFPGA_SDMMC		(IRQ_SOCFPGA_GIC_START + 139)	/* SD/MMC */
> +#define IRQ_SOCFPGA_SDMMC_PA_CECC	(IRQ_SOCFPGA_GIC_START + 140)	/* SD/MMC PortA ECC corrected */
> +#define IRQ_SOCFPGA_SDMMC_PA_UECC	(IRQ_SOCFPGA_GIC_START + 141)	/* SD/MMC PortA ECC uncorrected */
> +#define IRQ_SOCFPGA_SDMMC_PB_CECC	(IRQ_SOCFPGA_GIC_START + 142)	/* SD/MMC PortB ECC corrected */
> +#define IRQ_SOCFPGA_SDMMC_PB_UECC	(IRQ_SOCFPGA_GIC_START + 143)	/* SD/MMC PortB ECC uncorrected */
> +#define IRQ_SOCFPGA_NAND		(IRQ_SOCFPGA_GIC_START + 144)	/* NAND */
> +#define IRQ_SOCFPGA_NAND_R_CECC	(IRQ_SOCFPGA_GIC_START + 145)	/* NAND read ECC corrected */
> +#define IRQ_SOCFPGA_NAND_R_UECC	(IRQ_SOCFPGA_GIC_START + 146)	/* NAND read ECC uncorrected */
> +#define IRQ_SOCFPGA_NAND_W_CECC	(IRQ_SOCFPGA_GIC_START + 147)	/* NAND write ECC corrected */
> +#define IRQ_SOCFPGA_NAND_W_UECC	(IRQ_SOCFPGA_GIC_START + 148)	/* NAND write ECC uncorrected */
> +#define IRQ_SOCFPGA_NAND_E_CECC	(IRQ_SOCFPGA_GIC_START + 149)	/* NAND error ECC corrected */
> +#define IRQ_SOCFPGA_NAND_E_UECC	(IRQ_SOCFPGA_GIC_START + 150)	/* NAND error ECC uncorrected */
> +#define IRQ_SOCFPGA_QSPI		(IRQ_SOCFPGA_GIC_START + 151)	/* Quad-SPI */
> +#define IRQ_SOCFPGA_QSPI_CECC	(IRQ_SOCFPGA_GIC_START + 152)	/* Quad-SPI ECC corrected */
> +#define IRQ_SOCFPGA_QSPI_UECC	(IRQ_SOCFPGA_GIC_START + 153)	/* Quad-SPI ECC uncorrected */
> +#define IRQ_SOCFPGA_SPI0		(IRQ_SOCFPGA_GIC_START + 154)	/* SPI 0 */
> +#define IRQ_SOCFPGA_SPI1		(IRQ_SOCFPGA_GIC_START + 155)	/* SPI 1 */
> +#define IRQ_SOCFPGA_SPI2		(IRQ_SOCFPGA_GIC_START + 156)	/* SPI 2 */
> +#define IRQ_SOCFPGA_SPI3		(IRQ_SOCFPGA_GIC_START + 157)	/* SPI 3 */
> +#define IRQ_SOCFPGA_I2C0		(IRQ_SOCFPGA_GIC_START + 158)	/* I2C 0 */
> +#define IRQ_SOCFPGA_I2C1		(IRQ_SOCFPGA_GIC_START + 159)	/* I2C 1 */
> +#define IRQ_SOCFPGA_I2C2		(IRQ_SOCFPGA_GIC_START + 160)	/* I2C 2 */
> +#define IRQ_SOCFPGA_I2C3		(IRQ_SOCFPGA_GIC_START + 161)	/* I2C 3 */
> +#define IRQ_SOCFPGA_UART0		(IRQ_SOCFPGA_GIC_START + 162)	/* UART 0 */
> +#define IRQ_SOCFPGA_UART1		(IRQ_SOCFPGA_GIC_START + 163)	/* UART 1 */
> +#define IRQ_SOCFPGA_GPIO0		(IRQ_SOCFPGA_GIC_START + 164)	/* GPIO 0 */
> +#define IRQ_SOCFPGA_GPIO1		(IRQ_SOCFPGA_GIC_START + 165)	/* GPIO 1 */
> +#define IRQ_SOCFPGA_GPIO2		(IRQ_SOCFPGA_GIC_START + 166)	/* GPIO 2 */
> +#define IRQ_SOCFPGA_L4_SP_TIMER0	(IRQ_SOCFPGA_GIC_START + 167)	/* L4 SP timer 0 */
> +#define IRQ_SOCFPGA_L4_SP_TIMER1	(IRQ_SOCFPGA_GIC_START + 168)	/* L4 SP timer 1 */
> +#define IRQ_SOCFPGA_L4_OSC1_TIMER0	(IRQ_SOCFPGA_GIC_START + 169)	/* L4 OSC1 timer 0 */
> +#define IRQ_SOCFPGA_L4_OSC1_TIMER1	(IRQ_SOCFPGA_GIC_START + 170)	/* L4 OSC1 timer 1 */
> +#define IRQ_SOCFPGA_WD0		(IRQ_SOCFPGA_GIC_START + 171)	/* Watchdog timer 0 */
> +#define IRQ_SOCFPGA_WD1		(IRQ_SOCFPGA_GIC_START + 172)	/* Watchdog timer 1 */
> +#define IRQ_SOCFPGA_CLK_MAN		(IRQ_SOCFPGA_GIC_START + 173)	/* Clock manager */
> +#define IRQ_SOCFPGA_MPU_WAKE	(IRQ_SOCFPGA_GIC_START + 174)	/* MPU wake */
> +#define IRQ_SOCFPGA_FPGA_MON	(IRQ_SOCFPGA_GIC_START + 175)	/* FPGA monitor */
> +#define IRQ_SOCFPGA_CPU0_CTI	(IRQ_SOCFPGA_GIC_START + 176)	/* Coresight CPU0 CTI */
> +#define IRQ_SOCFPGA_CPU1_CTI	(IRQ_SOCFPGA_GIC_START + 177)	/* Coresight CPU1 CTI */
> +#define IRQ_SOCFPGA_OCRAM_CECC	(IRQ_SOCFPGA_GIC_START + 178)	/* on-chip RAM ECC corrected */
> +#define IRQ_SOCFPGA_OCRAM_UECC	(IRQ_SOCFPGA_GIC_START + 179)	/* on-chip RAM ECC uncorrected */
> +
> +/* Soft IRQ */
> +#define SOFTIRQ_SOCFPGA_DMADEV 	(IRQ_SOCFPGA_GIC_START + 180)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_0	(IRQ_SOCFPGA_GIC_START + 181)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_1	(IRQ_SOCFPGA_GIC_START + 182)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_2	(IRQ_SOCFPGA_GIC_START + 183)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_3	(IRQ_SOCFPGA_GIC_START + 184)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_4	(IRQ_SOCFPGA_GIC_START + 185)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_5	(IRQ_SOCFPGA_GIC_START + 186)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_6	(IRQ_SOCFPGA_GIC_START + 187)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_7	(IRQ_SOCFPGA_GIC_START + 188)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_8	(IRQ_SOCFPGA_GIC_START + 189)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_9	(IRQ_SOCFPGA_GIC_START + 190)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_10	(IRQ_SOCFPGA_GIC_START + 191)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_11	(IRQ_SOCFPGA_GIC_START + 192)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_12	(IRQ_SOCFPGA_GIC_START + 193)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_13	(IRQ_SOCFPGA_GIC_START + 194)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_14	(IRQ_SOCFPGA_GIC_START + 195)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_15	(IRQ_SOCFPGA_GIC_START + 196)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_16	(IRQ_SOCFPGA_GIC_START + 197)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_17	(IRQ_SOCFPGA_GIC_START + 198)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_18	(IRQ_SOCFPGA_GIC_START + 199)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_19	(IRQ_SOCFPGA_GIC_START + 200)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_20	(IRQ_SOCFPGA_GIC_START + 201)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_21	(IRQ_SOCFPGA_GIC_START + 202)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_22	(IRQ_SOCFPGA_GIC_START + 203)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_23	(IRQ_SOCFPGA_GIC_START + 204)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_24	(IRQ_SOCFPGA_GIC_START + 205)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_25	(IRQ_SOCFPGA_GIC_START + 206)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_26	(IRQ_SOCFPGA_GIC_START + 207)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_27	(IRQ_SOCFPGA_GIC_START + 208)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_28	(IRQ_SOCFPGA_GIC_START + 209)
> +#define SOFTIRQ_SOCFPGA_GPIO_0_29	(IRQ_SOCFPGA_GIC_START + 210)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_0	(IRQ_SOCFPGA_GIC_START + 211)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_1	(IRQ_SOCFPGA_GIC_START + 212)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_2	(IRQ_SOCFPGA_GIC_START + 213)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_3	(IRQ_SOCFPGA_GIC_START + 214)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_4	(IRQ_SOCFPGA_GIC_START + 215)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_5	(IRQ_SOCFPGA_GIC_START + 216)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_6	(IRQ_SOCFPGA_GIC_START + 217)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_7	(IRQ_SOCFPGA_GIC_START + 218)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_8	(IRQ_SOCFPGA_GIC_START + 219)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_9	(IRQ_SOCFPGA_GIC_START + 220)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_10	(IRQ_SOCFPGA_GIC_START + 221)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_11	(IRQ_SOCFPGA_GIC_START + 222)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_12	(IRQ_SOCFPGA_GIC_START + 223)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_13	(IRQ_SOCFPGA_GIC_START + 224)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_14	(IRQ_SOCFPGA_GIC_START + 225)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_15	(IRQ_SOCFPGA_GIC_START + 226)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_16	(IRQ_SOCFPGA_GIC_START + 227)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_17	(IRQ_SOCFPGA_GIC_START + 228)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_18	(IRQ_SOCFPGA_GIC_START + 229)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_19	(IRQ_SOCFPGA_GIC_START + 230)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_20	(IRQ_SOCFPGA_GIC_START + 231)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_21	(IRQ_SOCFPGA_GIC_START + 232)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_22	(IRQ_SOCFPGA_GIC_START + 233)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_23	(IRQ_SOCFPGA_GIC_START + 234)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_24	(IRQ_SOCFPGA_GIC_START + 235)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_25	(IRQ_SOCFPGA_GIC_START + 236)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_26	(IRQ_SOCFPGA_GIC_START + 237)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_27	(IRQ_SOCFPGA_GIC_START + 238)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_28	(IRQ_SOCFPGA_GIC_START + 239)
> +#define SOFTIRQ_SOCFPGA_GPIO_1_29	(IRQ_SOCFPGA_GIC_START + 240)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_0	(IRQ_SOCFPGA_GIC_START + 241)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_1	(IRQ_SOCFPGA_GIC_START + 242)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_2	(IRQ_SOCFPGA_GIC_START + 243)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_3	(IRQ_SOCFPGA_GIC_START + 244)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_4	(IRQ_SOCFPGA_GIC_START + 245)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_5	(IRQ_SOCFPGA_GIC_START + 246)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_6	(IRQ_SOCFPGA_GIC_START + 247)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_7	(IRQ_SOCFPGA_GIC_START + 248)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_8	(IRQ_SOCFPGA_GIC_START + 249)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_9	(IRQ_SOCFPGA_GIC_START + 250)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_10	(IRQ_SOCFPGA_GIC_START + 251)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_11	(IRQ_SOCFPGA_GIC_START + 252)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_12	(IRQ_SOCFPGA_GIC_START + 253)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_13	(IRQ_SOCFPGA_GIC_START + 254)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_14	(IRQ_SOCFPGA_GIC_START + 255)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_15	(IRQ_SOCFPGA_GIC_START + 256)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_16	(IRQ_SOCFPGA_GIC_START + 257)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_17	(IRQ_SOCFPGA_GIC_START + 258)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_18	(IRQ_SOCFPGA_GIC_START + 259)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_19	(IRQ_SOCFPGA_GIC_START + 260)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_20	(IRQ_SOCFPGA_GIC_START + 261)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_21	(IRQ_SOCFPGA_GIC_START + 262)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_22	(IRQ_SOCFPGA_GIC_START + 263)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_23	(IRQ_SOCFPGA_GIC_START + 264)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_24	(IRQ_SOCFPGA_GIC_START + 265)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_25	(IRQ_SOCFPGA_GIC_START + 266)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_26	(IRQ_SOCFPGA_GIC_START + 267)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_27	(IRQ_SOCFPGA_GIC_START + 268)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_28	(IRQ_SOCFPGA_GIC_START + 269)
> +#define SOFTIRQ_SOCFPGA_GPIO_2_29	(IRQ_SOCFPGA_GIC_START + 270)

Those huge lists of IRQs are no longer useful with the device tree, you
can get rid of them.

> +#define NR_IRQS			512

You should be looking at using SPARSE_IRQ to avoid having a maximum
number of irqs. See for example mach-highbank/.

> +++ b/arch/arm/mach-socfpga/include/mach/system.h
> @@ -0,0 +1,31 @@
> +/*
> + *  Copyright (C) 2012 Altera Corporation
> + *
> + * Modified from arch/arm/mach-realview/include/mach/system.h
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +*/
> +#ifndef __ASM_ARCH_SYSTEM_H
> +#define __ASM_ARCH_SYSTEM_H
> +
> +static inline void arch_idle(void)
> +{
> +	/*
> +	 * This should do all the clock switching
> +	 * and wait for interrupt tricks
> +	 */
> +	cpu_do_idle();
> +}
> +
> +#endif

This isn't used anywhere, and the system.h header is being removed
from sub-architectures, if I understood correctly.

> index 101b968..2f9a81e 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -381,7 +381,7 @@ config CPU_V6K
>  
>  # ARMv7
>  config CPU_V7
> -	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> +	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_SOCFPGA
>  	select CPU_32v6K
>  	select CPU_32v7
>  	select CPU_ABRT_EV7

Apparently, your SoC is ARMv7 only at the moment, so you don't need to
do this. Just keep the "select CPU_V7" in your ARCH_SOCFPGA option.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
