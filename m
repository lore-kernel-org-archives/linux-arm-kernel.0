From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 19 Jul 2013 04:23:14 +0200
Subject: [PATCH] bcm53xx: initial support for the BCM5301/BCM470X SoC
 with ARM CPU
In-Reply-To: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
References: <1373982727-5492-1-git-send-email-hauke@hauke-m.de>
Message-ID: <20130719022314.GB4941@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hauke,

On Tue, Jul 16, 2013 at 03:52:07PM +0200, Hauke Mehrtens wrote:
> This patch adds support for the BCM5301/BCM470X SoCs with an ARM CPU.
> Currently just booting to a shell is working and nothing else, no
> Ethernet, wifi, flash, ...
> 
> This SoC uses a Dual core CPU, but this is currently not implemented.
> More information about this SoC can be found here:
> http://www.anandtech.com/show/5925/broadcom-announces-bcm4708x-and-bcm5301x-socs-for-80211ac-routers
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

...

> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index e401a76..74e32f6 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -93,6 +93,10 @@ choice
>  		bool "Kernel low-level debugging on BCM2835 PL011 UART"
>  		depends on ARCH_BCM2835
>  
> +	config DEBUG_BCM53XX
> +		bool "Kernel low-level debugging on BCM53XX UART1"
> +		depends on ARCH_BCM53XX
> +
>  	config DEBUG_CLPS711X_UART1
>  		bool "Kernel low-level debugging messages via UART1"
>  		depends on ARCH_CLPS711X
> @@ -762,6 +766,7 @@ endchoice
>  config DEBUG_LL_INCLUDE
>  	string
>  	default "debug/bcm2835.S" if DEBUG_BCM2835
> +	default "debug/bcm53xx.S" if DEBUG_BCM53XX
>  	default "debug/cns3xxx.S" if DEBUG_CNS3XXX
>  	default "debug/exynos.S" if DEBUG_EXYNOS_UART
>  	default "debug/highbank.S" if DEBUG_HIGHBANK_UART

...

> diff --git a/arch/arm/include/debug/bcm53xx.S b/arch/arm/include/debug/bcm53xx.S
> new file mode 100644
> index 0000000..98c836b
> --- /dev/null
> +++ b/arch/arm/include/debug/bcm53xx.S
> @@ -0,0 +1,19 @@
> +/*
> + * Macros used for EARLY_PRINTK, in low-level UART debug console
> + *
> + * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.
> + */
> +
> +#define BCM53XX_UART1_PHYS	0x18000300
> +#define BCM53XX_UART1_VIRT	0xf1000300
> +#define BCM53XX_UART1_SH	0
> +
> +	.macro	addruart, rp, rv, tmp
> +	ldr	\rp, =BCM53XX_UART1_PHYS 	@ MMU off, Physical
> +	ldr	\rv, =BCM53XX_UART1_VIRT 	@ MMU on, Virtual
> +	.endm
> +
> +#define UART_SHIFT	BCM53XX_UART1_SH
> +#include <asm/hardware/debug-8250.S>

don't know if it's worth to add this debug uart support here. there is a
series from Russel to consolidate 8250 and pl01x debug uarts. maybe you
want to delay this.

> diff --git a/arch/arm/mach-bcm53xx/bcm53xx.c b/arch/arm/mach-bcm53xx/bcm53xx.c
> new file mode 100644
> index 0000000..aa5bd397
> --- /dev/null
> +++ b/arch/arm/mach-bcm53xx/bcm53xx.c
> @@ -0,0 +1,68 @@
> +/*
> + * Broadcom BCM47XX / BCM53XX ARM platform code.
> + *
> + * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.
> + */
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/irqchip.h>
> +#include <linux/clocksource.h>
> +#include <linux/clk-provider.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/signal.h>
> +
> +static int bcm53xx_abort_handler(unsigned long addr, unsigned int fsr,
> +				 struct pt_regs *regs)
> +{
> +	/*
> +	 * These happen for no good reason
> +	 * possibly left over from CFE
> +	 */
> +	pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
> +		addr, fsr);
> +
> +	/* Returning non-zero causes fault display and panic */
> +	return 0;
> +}
> +
> +static void bcm53xx_aborts_enable(void)
> +{
> +	/* Install our hook */
> +	hook_fault_code(16 + 6, bcm53xx_abort_handler, SIGBUS, 0,
> +			"imprecise external abort");
> +}
> +
> +static void __init bcm53xx_timer_init(void)
> +{
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +}
> +
> +void __init bcm53xx_map_io(void)
> +{
> +	debug_ll_io_init();
> +	bcm53xx_aborts_enable();
> +}
> +
> +static void __init bcm53xx_dt_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char const *bcm53xx_dt_compat[] = {
> +	"brcm,bcm5301x",
> +	"netgear,r6250v1",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(BCM53XX, "BCM53XX")
> +	.init_machine = bcm53xx_dt_init,
> +	.map_io = bcm53xx_map_io,
> +	.init_irq = irqchip_init,
> +	.init_time = bcm53xx_timer_init,
> +	.dt_compat = bcm53xx_dt_compat,
> +MACHINE_END

the trend is to consolidate machine descriptors.

so .init_irq can go, irqchip_init is picked anyway if .init_irq is NULL.

also .init_time could be dropped, it can be specified using
CLOCKSOURCE_OF_DECLARE(), but I see bcm53xx_timer_init is already quite
minimal here and I'm struggling to see the big picture here. So mine is
actually a question for others... :)

Regards,
Domenico
