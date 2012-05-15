From: alior@marvell.com (Lior Amsalem)
Date: Tue, 15 May 2012 15:46:57 +0300
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <4FB227CC.8090808@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515092750.GD6820@lunn.ch> <4FB227CC.8090808@codethink.co.uk>
Message-ID: <EE71107DF0D1F24FA2D95041E64AB9E801A56A998C53@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ben Dooks [mailto:ben.dooks at codethink.co.uk]
> Sent: Tuesday, May 15, 2012 12:54 PM
> To: Thomas Petazzoni; Arnd Bergmann; Olof Johansson; Ben Dooks; Jason
> Cooper; Andrew Lunn; Nicolas Pitre; Lior Amsalem; Maen Suleiman; linux-
> arm-kernel at lists.infradead.org; Gregory CLEMENT
> Subject: Re: [PATCH 2/8] arm: mach-armada: add source files
> 
> On 15/05/12 10:27, Andrew Lunn wrote:
> >
> >> diff --git a/arch/arm/mach-armada/irq.c b/arch/arm/mach-armada/irq.c
> >> new file mode 100644 index 0000000..7006429
> >> --- /dev/null
> >> +++ b/arch/arm/mach-armada/irq.c
> >> @@ -0,0 +1,116 @@
> >> +/*
> >> + * Marvall Armada SoC IRQ handling
> >> + *
> >> + * Copyright (C) 2012 Marvell
> >> + *
> >> + * Lior Amsalem<alior@marvell.com>
> >> + * Gregory CLEMENT<gregory.clement@free-electrons.com>
> >> + * Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> >> + *
> >> + * This file is licensed under the terms of the GNU General Public
> >> + * License version 2.  This program is licensed "as is" without any
> >> + * warranty of any kind, whether express or implied.
> >> + */
> >> +
> >> +#include<linux/kernel.h>
> >> +#include<linux/init.h>
> >> +#include<linux/irq.h>
> >> +#include<linux/interrupt.h>
> >> +#include<linux/io.h>
> >> +#include<linux/of_address.h>
> >> +#include<linux/of_irq.h>
> >> +#include<linux/irqdomain.h>
> >> +#include<asm/mach/arch.h>
> >> +#include<asm/exception.h>
> >> +
> >> +/* Interrupt Controller Registers Map */
> >> +#define ARMADA_INT_SET_MASK_OFFS             (0xBC)
> >> +#define ARMADA_INT_CLEAR_MASK_OFFS           (0xB8)
> >> +
> >> +#define ARMADA_INT_SET_ENABLE_OFFS           (0xA30)
> >> +#define ARMADA_INT_CLEAR_ENABLE_OFFS         (0xA34)
> >> +
> >> +#define ARMADA_CPU_INTACK_OFFS               (0xB4)
> >> +
> >> +static void __iomem *per_cpu_int_base; static void __iomem
> >> +*main_int_base; static struct irq_domain *armada_mpic_domain;
> >> +
> >> +static void armada_irq_mask(struct irq_data *d) {
> >> +	writel(d->irq, per_cpu_int_base +
> ARMADA_INT_CLEAR_MASK_OFFS); }
> >> +
> >> +static void armada_irq_unmask(struct irq_data *d) {
> >> +	writel(d->irq, per_cpu_int_base + ARMADA_INT_SET_MASK_OFFS);
> }
> >
> > All the other orion's use the generic-chip interrupt routines. Can
> > this device also use it? It would also allow you to use the generic DT
> > bindings.
> 
> Possibly, but there'll need to be support for setting interrupt affinity added
> at some point, as this is used on multi-core systems.
Exactly, also:
1. we're working on SMP implementation, 
     the interrupt code will also include SMP related changes and additions (affinity and raise_softirq)
2. The generic-chip uses locking in mask/unmask when system is configured for SMP.
     We can avoid it with our HW design, so why not.
3. I've also tried to look into the gic implementation but it seems too far off our HW design.

> 
> --
> Ben Dooks				http://www.codethink.co.uk/
> Senior Engineer				Codethink - Providing Genius

Lior Amsalem
