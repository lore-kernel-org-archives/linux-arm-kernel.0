From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 01 Jul 2015 17:05:33 +0100
Subject: [PATCH v2 3/4] ARM: mvebu: Allow using the GIC for wakeup in
 standby mode
In-Reply-To: <1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
 <1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <55940FCD.5070901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/06/15 18:18, Gregory CLEMENT wrote:
> On the Armada 375/38x/39x SoCs, in standby mode the SoCs stay powered
> and it is possible to wake-up from any interrupt sources. This patch
> adds flag to the GIC irqchip driver to let linux know this.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>   arch/arm/mach-mvebu/board-v7.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index e5911defccac..f446230e7416 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -18,6 +18,7 @@
>   #include <linux/of_address.h>
>   #include <linux/of_fdt.h>
>   #include <linux/of_platform.h>
> +#include <linux/irq.h>
>   #include <linux/io.h>
>   #include <linux/clocksource.h>
>   #include <linux/dma-mapping.h>
> @@ -26,6 +27,7 @@
>   #include <linux/signal.h>
>   #include <linux/slab.h>
>   #include <linux/irqchip.h>
> +#include <linux/irqchip/arm-gic.h>
>   #include <asm/hardware/cache-l2x0.h>
>   #include <asm/mach/arch.h>
>   #include <asm/mach/map.h>
> @@ -129,6 +131,11 @@ static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
>
>   static void __init mvebu_init_irq(void)
>   {
> +	if (of_machine_is_compatible("marvell,armada375") ||
> +	    of_machine_is_compatible("marvell,armada380") ||
> +	    of_machine_is_compatible("marvell,armada390"))
> +		gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
> +				      IRQCHIP_MASK_ON_SUSPEND);

I am planning to add these flags in the GIC driver itself and remove
this function. I will post the patch next week once merge window closes
next, so based on how that discussion proceeds you may have drop this
patch, just heads up.

Regards,
Sudeep
