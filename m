From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 23 Feb 2015 22:41:57 +0100
Subject: [PATCH v3] ARM: pxa: fix pxa interrupts handling in DT
In-Reply-To: <1423950116-23856-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sat, 14 Feb 2015 22:41:56 +0100")
References: <1423950116-23856-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87wq384862.fsf@free.fr>
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
>
> As a consequence of the IRQ_BIT() is removed alltogether from interrupts
> handling, even in the platform data types of platforms :
>  - a legacy irq domain is used
>  - the irq_chip handles hardware interrupts
>  - the virtual to hardware interrupt conversion is fully handled by irq
>    domain mechanics
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Queued in pxa/fixes.

--
Robert
