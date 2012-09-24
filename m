From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 24 Sep 2012 15:26:29 +0100
Subject: GIC affinity and edge trigger
In-Reply-To: <CC811D74.ECFF%wbarak@gmail.com>
References: <CC811D74.ECFF%wbarak@gmail.com>
Message-ID: <50606D95.8070109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/12 17:22, Barak Wasserstrom wrote:
> Hello,
> I'm currently using linux kernel 2.6.38 with SMP enabled.
> I have an interrupt which is a pulse and therefore I set the trigger to positive edge.
> Due to the fact that each CPU sees its own GIC distributor memory space, only the CPU that executed request_irq has the trigger type set to positive edge, while the others remain level.

This seem to imply that your interrupt is a PPI, and not a SPI. If this
is the case, you cannot use request_irq on such an interrupt. 2.6.38 is
pretty ancient though, and doesn't have any support for
request_percpu_irq and co. How are you configuring/requesting this
interrupt?

> Moreover, gic_set_cpu always defines the GIC distributor target to be CPU0.

For a PPI, the concept of "target" is pretty minimal, and is always the
CPU this PPI is connected to.

> So only CPU0 target is enabled + trigger is set to edge only for one CPU and thus not always do I get the interrupt.
> Can you please help me understand what I'm doing wrong, or misunderstand?

Please clarify whether you're using a PPI or an SPI. The above is not
clear enough to give you a straight answer.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
