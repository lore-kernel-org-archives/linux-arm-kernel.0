From: robherring2@gmail.com (Rob Herring)
Date: Thu, 25 Oct 2012 08:48:54 -0500
Subject: [PATCH] arm: mvebu: move irq controller driver in drivers/irqchip/
In-Reply-To: <1351168500-11129-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351168500-11129-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <50894346.60507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 07:35 AM, Thomas Petazzoni wrote:
> The new support for the ARM BCM2835 SoC has introduced the
> drivers/irqchip/ directory for IRQ controller drivers. So let's
> conform to this good new approach, and move the IRQ controller driver
> for Marvell Armada 370/XP in this directory.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---

snip

> diff --git a/include/linux/irqchip/armada-370-xp.h b/include/linux/irqchip/armada-370-xp.h
> new file mode 100644
> index 0000000..78876c2
> --- /dev/null
> +++ b/include/linux/irqchip/armada-370-xp.h
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (C) 2012 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __LINUX_IRQCHIP_ARMADA_370_XP_H_
> +#define __LINUX_IRQCHIP_ARMADA_370_XP_H_
> +
> +#include <asm/exception.h>
> +
> +void armada_370_xp_init_irq(void);
> +void armada_370_xp_handle_irq(struct pt_regs *regs);
> +
> +#endif

I don't mean to pick on this specific patch, but this is a common
problem of moving various low-level pieces like irqchips, cpuidle,
timers, etc. to drivers/*. If we, just moving the code as is over, we
still need some hooks between arch/arm and drivers. I think if we keep
adding ARM SOC specific headers to include/linux, that will be the next
thing we get yelled at for and will have to clean-up.

For irqchips, the way I see this working is we would have a single call
to of_irq_init with a match list of all irqchips in drivers/irqchips.
This contains the init function within drivers/irqchips. Then all the
machines can just call a generic irqchip_init.

The handle_irq ptr would also need to be plugged in at runtime.

Rob
