From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 17:32:13 +0100
Subject: [PATCH 04/17] irqchip: irq-armada-370-xp: suspend/resume support
In-Reply-To: <5457BD82.3090309@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <5457BD82.3090309@free-electrons.com>
Message-ID: <20141113173213.3cc93792@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Mon, 03 Nov 2014 18:38:10 +0100, Gregory CLEMENT wrote:

> > It is worth mentioning that the affinity is lost during a
> > suspend/resume cycle, because when a secondary CPU is brought
> > off-line, all interrupts that are assigned to this CPU in terms of
> > affinity gets re-assigned to a still running CPU. Therefore, right
> > before entering suspend, all interrupts are assigned to the boot CPU.
> 
> So what about /proc/irq/*/smp_affinity ?
> 
> Do this files still represent accurate information?

See migrate_irqs() in arch/arm/kernel/irq.c. Basically, when you do a
suspend, the kernel hot unplugs the non-boot CPUs: in our case CPU1,
CPU2 and CPU3. The migrate_irqs() function above makes sure that the
affinity used for each interrupt continue to contain at least one
online CPU. Therefore, it modifies the affinity information across
suspend/resume.

For example, let's say you initially have an affinity of 0xf (i.e all
CPUs can receive the interrupt) and you modify it to 0x2 (i.e only CPU1
can take the interrupt).

Then, when migrate_irqs() is called when CPU1 is brought offline, it
will realize that the interrupt will no longer be affine to any CPU,
and it will re-assign the affinity to the current cpu_online_mask
(which will be 0xd, i.e all CPUs except CPU1). Therefore, when you get
out of suspend, the affinity for this interrupt will be 0xd.

Note that in this case, a message is displayed during the suspend
procedure:

	IRQ19 no longer affine to CPU1

On the other hand, if you leave the affinity to its default of 0xf, it
remains to 0xf, because there's always at least one online CPU in the
affinity (the boot CPU). Same thing if you change the affinity to 0x3
for example, since 0x3 is an affinity that contains the boot CPU (of
course, assuming the boot CPU is CPU0).

That's not a logic that is controlled in the irqchip driver, it's
entirely handled by the kernel core. I hope this explanation clarifies
the situation.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
