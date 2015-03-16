From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 Mar 2015 09:52:05 -0700
Subject: [PATCH] ARM: BCM5301X: Implement SMP support
In-Reply-To: <1424385148-15026-1-git-send-email-zajec5@gmail.com>
References: <1423600375-18665-1-git-send-email-zajec5@gmail.com>
 <1424385148-15026-1-git-send-email-zajec5@gmail.com>
Message-ID: <55070A35.4040804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/15 14:32, Rafa? Mi?ecki wrote:
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---

[snip]

> +Optional sub-node properties:
> +
> +compatible = "brcm,bcm4708-sysram" SYSRAM for SMP bringup.
> +		SMP-capable SoCs use part of the SYSRAM for storing
> +		location of code to be executed by the extra cores.

Is this a regular kind of SRAM? If so, can you use "mmio-sram" as a
compatible fallback?

[snip]

> +
> +	/*
> +	 * In case L1 cache has unpredictable contents at power-up
> +	 * clean its contents without flushing.
> +	 */
> +	/* bl	v7_l1_cache_invalidate */

You can remove that comment now

> +	bl      v7_invalidate_l1
> +
> +	mov	r0,#0
> +	mcr	p15,0,r0,c7,c5,0	/* Invalidate icache */

For consistency with the previous lines, you would want to space operands.

> +	dsb
> +	isb
> +
> +	/*
> +	 * we've been released from the holding pen: secondary_stack
> +	 * should now contain the SVC stack for this core
> +	 */
> +	b	secondary_startup
> +ENDPROC(bcm5301x_secondary_startup)
> +
> +	.align 2
> +1:	.long	.
> +	.long	pen_release
> diff --git a/arch/arm/mach-bcm/bcm5301x_smp.c b/arch/arm/mach-bcm/bcm5301x_smp.c
> new file mode 100644
> index 0000000..903cc0d
> --- /dev/null
> +++ b/arch/arm/mach-bcm/bcm5301x_smp.c
> @@ -0,0 +1,160 @@
> +/*
> + * Broadcom BCM470X / BCM5301X ARM platform code.
> + *
> + * Copyright (C) 2002 ARM Ltd.
> + * Copyright (C) 2015 Rafa? Mi?ecki <zajec5@gmail.com>
> + *
> + * Licensed under the GNU/GPL. See COPYING for details.
> + */
> +
> +#include <asm/cacheflush.h>
> +#include <asm/delay.h>
> +#include <asm/smp_plat.h>
> +#include <asm/smp_scu.h>
> +
> +#include <linux/clockchips.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#define SOC_ROM_LUT_OFF		0x400
> +
> +extern void bcm5301x_secondary_startup(void);
> +
> +static void __cpuinit write_pen_release(int val)
> +{
> +	pen_release = val;
> +	smp_wmb();
> +	sync_cache_w(&pen_release);
> +}
> +
> +static DEFINE_SPINLOCK(boot_lock);
> +
> +static void __init bcm5301x_smp_secondary_set_entry(void (*entry_point)(void))
> +{
> +	void __iomem *sysram_base_addr = NULL;
> +	struct device_node *node;
> +
> +	for_each_compatible_node(node, NULL, "brcm,bcm4708-sysram") {
> +		if (!of_device_is_available(node))
> +			continue;
> +		sysram_base_addr = of_iomap(node, 0);
> +		break;
> +	}

How about of_find_compatible()? Do you expect more than one sysram node
in a DTS?
-- 
Florian
