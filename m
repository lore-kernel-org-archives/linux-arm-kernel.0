From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 1 Apr 2015 10:34:24 +0200
Subject: [PATCH 3/5] ARM: mvebu: Allow using the GIC for wakeup in standby
 mode
In-Reply-To: <1427724278-12379-4-git-send-email-gregory.clement@free-electrons.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
 <1427724278-12379-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKdc=DQ9-dm3rm_mbG_sgeWbCZBJ7eML48hFXHQaJm1Pmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

2015-03-30 16:04 GMT+02:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> On the Armada 375/38x/39x SoCs, in standby mode the SoC stay powered
> and it is possible to wake-up from any interrupt sources. This patch
> adds flag to the GIC irqchip driver to let linux know this.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 89a139ed7d5b..61774279a66d 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_fdt.h>
>  #include <linux/of_platform.h>
> +#include <linux/irq.h>
>  #include <linux/io.h>
>  #include <linux/clocksource.h>
>  #include <linux/dma-mapping.h>
> @@ -26,6 +27,7 @@
>  #include <linux/signal.h>
>  #include <linux/slab.h>
>  #include <linux/irqchip.h>
> +#include <linux/irqchip/arm-gic.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -129,6 +131,11 @@ static int armada_375_external_abort_wa(unsigned long addr, unsigned int fsr,
>
>  static void __init mvebu_init_irq(void)
>  {
> +       if (of_machine_is_compatible("marvell,armada375") ||
> +           of_machine_is_compatible("marvell,armada380") ||
> +           of_machine_is_compatible("marvell,armada390"))
> +               gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
> +                                     IRQCHIP_MASK_ON_SUSPEND);

I'm afraid you the patchset may be incomplete:
arch/arm/mach-mvebu/board-v7.c:137:3: error: implicit declaration of
function 'gic_set_irqchip_flags'
[-Werror=implicit-function-declaration]

Best regards,
Marcin
