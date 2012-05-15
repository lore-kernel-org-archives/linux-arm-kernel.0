From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 May 2012 11:27:50 +0200
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120515092750.GD6820@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> diff --git a/arch/arm/mach-armada/irq.c b/arch/arm/mach-armada/irq.c
> new file mode 100644
> index 0000000..7006429
> --- /dev/null
> +++ b/arch/arm/mach-armada/irq.c
> @@ -0,0 +1,116 @@
> +/*
> + * Marvall Armada SoC IRQ handling
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Lior Amsalem <alior@marvell.com>
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqdomain.h>
> +#include <asm/mach/arch.h>
> +#include <asm/exception.h>
> +
> +/* Interrupt Controller Registers Map */
> +#define ARMADA_INT_SET_MASK_OFFS             (0xBC)
> +#define ARMADA_INT_CLEAR_MASK_OFFS           (0xB8)
> +
> +#define ARMADA_INT_SET_ENABLE_OFFS           (0xA30)
> +#define ARMADA_INT_CLEAR_ENABLE_OFFS         (0xA34)
> +
> +#define ARMADA_CPU_INTACK_OFFS               (0xB4)
> +
> +static void __iomem *per_cpu_int_base;
> +static void __iomem *main_int_base;
> +static struct irq_domain *armada_mpic_domain;
> +
> +static void armada_irq_mask(struct irq_data *d)
> +{
> +	writel(d->irq, per_cpu_int_base + ARMADA_INT_CLEAR_MASK_OFFS);
> +}
> +
> +static void armada_irq_unmask(struct irq_data *d)
> +{
> +	writel(d->irq, per_cpu_int_base + ARMADA_INT_SET_MASK_OFFS);
> +}

All the other orion's use the generic-chip interrupt routines. Can
this device also use it? It would also allow you to use the generic DT
bindings.

	Andrew
