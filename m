From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 08 Dec 2015 11:48:07 +0100
Subject: [PATCH v2 3/3] ARM: dove: convert legacy dove to PMU support
In-Reply-To: <E1a5j6V-00087F-Ju@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Sun, 06 Dec 2015 23:52:31 +0000")
References: <E1a5j6V-00087F-Ju@rmk-PC.arm.linux.org.uk>
Message-ID: <87r3ix8bdk.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
 
 On lun., d?c. 07 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:

> Since Dove has non-DT support for various facilities in the PMU, convert
> the legacy support to use the new PMU driver.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

With this patch I got the following errors:
arch/arm/mach-dove/common.c:398:15: error: ?PMU_PWR_VPU_PWR_DWN_MASK? undeclared here (not in a function)
   .pwr_mask = PMU_PWR_VPU_PWR_DWN_MASK,
               ^
arch/arm/mach-dove/common.c:399:15: error: ?PMU_SW_RST_VIDEO_MASK? undeclared here (not in a function)
   .rst_mask = PMU_SW_RST_VIDEO_MASK,
               ^
arch/arm/mach-dove/common.c:400:15: error: ?PMU_ISO_VIDEO_MASK? undeclared here (not in a function)
   .iso_mask = PMU_ISO_VIDEO_MASK,
               ^
arch/arm/mach-dove/common.c:403:15: error: ?PMU_PWR_GPU_PWR_DWN_MASK? undeclared here (not in a function)
   .pwr_mask = PMU_PWR_GPU_PWR_DWN_MASK,
               ^
arch/arm/mach-dove/common.c:404:15: error: ?PMU_SW_RST_GPU_MASK? undeclared here (not in a function)
   .rst_mask = PMU_SW_RST_GPU_MASK,
               ^
arch/arm/mach-dove/common.c:405:15: error: ?PMU_ISO_GPU_MASK? undeclared here (not in a function)
   .iso_mask = PMU_ISO_GPU_MASK,
               ^

So it seems that these define are missing and I didn't find them in the
kernel sources so it is not a missing include.

Thanks,

Gregory


> ---
>  arch/arm/Kconfig                     |  1 +
>  arch/arm/mach-dove/common.c          | 25 ++++++++++
>  arch/arm/mach-dove/include/mach/pm.h | 17 -------
>  arch/arm/mach-dove/irq.c             | 88 ------------------------------------
>  4 files changed, 26 insertions(+), 105 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 639411f73ca9..498783f16062 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -514,6 +514,7 @@ config ARCH_DOVE
>  	select PINCTRL
>  	select PINCTRL_DOVE
>  	select PLAT_ORION_LEGACY
> +	select PM_GENERIC_DOMAINS if PM
>  	help
>  	  Support for the Marvell Dove SoC 88AP510
>  
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index 0d1a89298ece..6f3887217674 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_data/dma-mv_xor.h>
>  #include <linux/platform_data/usb-ehci-orion.h>
>  #include <linux/platform_device.h>
> +#include <linux/soc/dove/pmu.h>
>  #include <asm/hardware/cache-tauros2.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -375,6 +376,29 @@ void __init dove_setup_cpu_wins(void)
>  				    DOVE_SCRATCHPAD_SIZE);
>  }
>  
> +static const struct dove_pmu_domain_initdata pmu_domains[] __initconst = {
> +	{
> +		.pwr_mask = PMU_PWR_VPU_PWR_DWN_MASK,
> +		.rst_mask = PMU_SW_RST_VIDEO_MASK,
> +		.iso_mask = PMU_ISO_VIDEO_MASK,
> +		.name = "vpu-domain",
> +	}, {
> +		.pwr_mask = PMU_PWR_GPU_PWR_DWN_MASK,
> +		.rst_mask = PMU_SW_RST_GPU_MASK,
> +		.iso_mask = PMU_ISO_GPU_MASK,
> +		.name = "gpu-domain",
> +	}, {
> +		/* sentinel */
> +	},
> +};
> +
> +static const struct dove_pmu_initdata pmu_data __initconst = {
> +	.pmc_base = DOVE_PMU_VIRT_BASE,
> +	.pmu_base = DOVE_PMU_VIRT_BASE + 0x8000,
> +	.irq = IRQ_DOVE_PMU,
> +	.domains = pmu_domains,
> +};
> +
>  void __init dove_init(void)
>  {
>  	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
> @@ -389,6 +413,7 @@ void __init dove_init(void)
>  	dove_clk_init();
>  
>  	/* internal devices that every board has */
> +	dove_init_pmu_legacy(&pmu_data);
>  	dove_rtc_init();
>  	dove_xor0_init();
>  	dove_xor1_init();
> diff --git a/arch/arm/mach-dove/include/mach/pm.h b/arch/arm/mach-dove/include/mach/pm.h
> index b47f75038686..625a89c15c1f 100644
> --- a/arch/arm/mach-dove/include/mach/pm.h
> +++ b/arch/arm/mach-dove/include/mach/pm.h
> @@ -51,22 +51,5 @@
>  #define  CLOCK_GATING_GIGA_PHY_MASK	(1 << CLOCK_GATING_BIT_GIGA_PHY)
>  
>  #define PMU_INTERRUPT_CAUSE	(DOVE_PMU_VIRT_BASE + 0x50)
> -#define PMU_INTERRUPT_MASK	(DOVE_PMU_VIRT_BASE + 0x54)
> -
> -static inline int pmu_to_irq(int pin)
> -{
> -	if (pin < NR_PMU_IRQS)
> -		return pin + IRQ_DOVE_PMU_START;
> -
> -	return -EINVAL;
> -}
> -
> -static inline int irq_to_pmu(int irq)
> -{
> -	if (IRQ_DOVE_PMU_START <= irq && irq < NR_IRQS)
> -		return irq - IRQ_DOVE_PMU_START;
> -
> -	return -EINVAL;
> -}
>  
>  #endif
> diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
> index bfb3703357c5..7e5a3248b82b 100644
> --- a/arch/arm/mach-dove/irq.c
> +++ b/arch/arm/mach-dove/irq.c
> @@ -7,87 +7,14 @@
>   * License version 2.  This program is licensed "as is" without any
>   * warranty of any kind, whether express or implied.
>   */
> -
> -#include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/irq.h>
> -#include <linux/gpio.h>
>  #include <linux/io.h>
> -#include <asm/mach/arch.h>
>  #include <plat/irq.h>
> -#include <asm/mach/irq.h>
> -#include <mach/pm.h>
>  #include <mach/bridge-regs.h>
>  #include <plat/orion-gpio.h>
>  #include "common.h"
>  
> -static void pmu_irq_mask(struct irq_data *d)
> -{
> -	int pin = irq_to_pmu(d->irq);
> -	u32 u;
> -
> -	u = readl(PMU_INTERRUPT_MASK);
> -	u &= ~(1 << (pin & 31));
> -	writel(u, PMU_INTERRUPT_MASK);
> -}
> -
> -static void pmu_irq_unmask(struct irq_data *d)
> -{
> -	int pin = irq_to_pmu(d->irq);
> -	u32 u;
> -
> -	u = readl(PMU_INTERRUPT_MASK);
> -	u |= 1 << (pin & 31);
> -	writel(u, PMU_INTERRUPT_MASK);
> -}
> -
> -static void pmu_irq_ack(struct irq_data *d)
> -{
> -	int pin = irq_to_pmu(d->irq);
> -	u32 u;
> -
> -	/*
> -	 * The PMU mask register is not RW0C: it is RW.  This means that
> -	 * the bits take whatever value is written to them; if you write
> -	 * a '1', you will set the interrupt.
> -	 *
> -	 * Unfortunately this means there is NO race free way to clear
> -	 * these interrupts.
> -	 *
> -	 * So, let's structure the code so that the window is as small as
> -	 * possible.
> -	 */
> -	u = ~(1 << (pin & 31));
> -	u &= readl_relaxed(PMU_INTERRUPT_CAUSE);
> -	writel_relaxed(u, PMU_INTERRUPT_CAUSE);
> -}
> -
> -static struct irq_chip pmu_irq_chip = {
> -	.name		= "pmu_irq",
> -	.irq_mask	= pmu_irq_mask,
> -	.irq_unmask	= pmu_irq_unmask,
> -	.irq_ack	= pmu_irq_ack,
> -};
> -
> -static void pmu_irq_handler(struct irq_desc *desc)
> -{
> -	unsigned long cause = readl(PMU_INTERRUPT_CAUSE);
> -	unsigned int irq;
> -
> -	cause &= readl(PMU_INTERRUPT_MASK);
> -	if (cause == 0) {
> -		do_bad_IRQ(desc);
> -		return;
> -	}
> -
> -	for (irq = 0; irq < NR_PMU_IRQS; irq++) {
> -		if (!(cause & (1 << irq)))
> -			continue;
> -		irq = pmu_to_irq(irq);
> -		generic_handle_irq(irq);
> -	}
> -}
> -
>  static int __initdata gpio0_irqs[4] = {
>  	IRQ_DOVE_GPIO_0_7,
>  	IRQ_DOVE_GPIO_8_15,
> @@ -143,8 +70,6 @@ __exception_irq_entry dove_legacy_handle_irq(struct pt_regs *regs)
>  
>  void __init dove_init_irq(void)
>  {
> -	int i;
> -
>  	orion_irq_init(1, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
>  	orion_irq_init(33, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
>  
> @@ -163,17 +88,4 @@ void __init dove_init_irq(void)
>  
>  	orion_gpio_init(NULL, 64, 8, DOVE_GPIO2_VIRT_BASE, 0,
>  			IRQ_DOVE_GPIO_START + 64, gpio2_irqs);
> -
> -	/*
> -	 * Mask and clear PMU interrupts
> -	 */
> -	writel(0, PMU_INTERRUPT_MASK);
> -	writel(0, PMU_INTERRUPT_CAUSE);
> -
> -	for (i = IRQ_DOVE_PMU_START; i < NR_IRQS; i++) {
> -		irq_set_chip_and_handler(i, &pmu_irq_chip, handle_level_irq);
> -		irq_set_status_flags(i, IRQ_LEVEL);
> -		irq_clear_status_flags(i, IRQ_NOREQUEST);
> -	}
> -	irq_set_chained_handler(IRQ_DOVE_PMU, pmu_irq_handler);
>  }
> -- 
> 2.1.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
