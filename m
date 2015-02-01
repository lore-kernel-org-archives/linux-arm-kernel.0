From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 01 Feb 2015 12:01:12 +0100
Subject: [PATCH] ARM: pxa: fix pxa interrupts handling in DT
In-Reply-To: <1422743581-31548-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sat, 31 Jan 2015 23:33:01 +0100")
References: <1422743581-31548-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <878ughuc93.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The commit "ARM: pxa: arbitrarily set first interrupt number" changed
> the first pxa interrupt to 16.
>
> As a consequence, device-tree builds got broken, because :
>  - pxa_mask_irq() and pxa_unmask_irq() are using IRQ_BIT()
>  - IRQ_BIT(x) calculates the interrupts as : x - PXA_IRQ(0)
>
> Before the commit, the first interrupt shift, PXA_IRQ(0) was 0,
> therefore IRQ_BIT(x) was x. After the change, it is necessary that the
> same shift of 16 is applied between the virtual interrupt number and the
> hardware irq number.
>
> This situation comes from the common irq_chip shared between legacy
> platform builds and device-tree builds.
>
> Fix the broken interrupts in DT case by adding this shift in the DT case
> too.

Actually, this work should be pushed a bit more for the irq_chip functions, so
that they're freed from the IRQ_BIT(x) macro. A more complete work would be to
use BIT(irqd_to_hwirq(d)) instead of IRQ_BIT(d->irq) in :
 - pxa_mask_irq()
 - pxa_unmask_irq()
And add the legacy irq_domain in pxa_init_irq().

--
Robert
