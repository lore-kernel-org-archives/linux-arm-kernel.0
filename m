From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 28 Aug 2014 11:32:52 +0200 (CEST)
Subject: [PATCH] arm: use cpu_online_mask when using forced
 irq_set_affinity
In-Reply-To: <53FCA570.1090809@arm.com>
References: <1399653640-21559-1-git-send-email-sudeep.holla@arm.com>
 <20140523121032.GV3693@n2100.arm.linux.org.uk> <537F4453.5000709@arm.com>
 <53A43174.503@arm.com> <20140620151638.GS32514@n2100.arm.linux.org.uk>
 <53C79E43.6040009@arm.com>
 <alpine.DEB.2.10.1408251136380.3323@nanos> <53FCA570.1090809@arm.com>
Message-ID: <alpine.DEB.2.10.1408281130140.23342@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Aug 2014, Sudeep Holla wrote:
> > > Can provide your thoughts on how to solve this issue ?
> > 
> > ffde1de64012 is not about offlining a cpu, it's about onlining where
> > we need to make sure that we assign the affinity to a not yet online
> > marked cpu.
> > 
> > > Is it expected from all the irqchip implementation to use force flag in
> > > irq_set_affinity to ignore cpu_online_mask similar to GIC ?
> > 
> > No, it's only relevant for the cases where we need to route irqs to
> > not yet online cpus.
> > 
> 
> Ok. IIUC Russell's main concern was if irqchip implementation uses force
> flag differently, then we can't change the core code to false. Also
> x86 core code also uses forced irq_set_affinity in arch/x86/kernel/irq.c

Which is pointless as none of the x86 irq chip implementations
actually honours the force argument.

In fact until the point where I implemented it in the GIC driver,
nothing ever used that argument. So the GIC conversion actually added
semantics to the argument. Any driver which will make use of it, has
to follow that now. I'll add documentation to the core code for it ...

Thanks,

	tglx
