From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Sep 2011 08:21:17 -0700
Subject: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
In-Reply-To: <CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
	<20110913203616.GG24252@atomide.com>
	<CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
Message-ID: <20110914152116.GM24252@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [110913 22:01]:
> Tony,
> On Wed, Sep 14, 2011 at 2:06 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:23]:
> >> OMAP WakeupGen is the interrupt controller extension used along
> >> with ARM GIC to wake the CPU out from low power states on
> >> external interrupts.
> >>
> >> The WakeupGen unit is responsible for generating wakeup event
> >> from the incoming interrupts and enable bits. It is implemented
> >> in MPU always ON power domain. During normal operation,
> >> WakeupGen delivers external interrupts directly to the GIC.
> > ...
> >
> >> + ? ? /*
> >> + ? ? ?* Override GIC architecture specific functions to add
> >> + ? ? ?* OMAP WakeupGen interrupt controller along with GIC
> >> + ? ? ?*/
> >> + ? ? gic_arch_extn.irq_mask = wakeupgen_mask;
> >> + ? ? gic_arch_extn.irq_unmask = wakeupgen_unmask;
> >> + ? ? gic_arch_extn.irq_set_wake = wakeupgen_set_wake;
> >> + ? ? gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
> >
> > As I've commented before, there should not be any need to tweak
> > the wakeupgen registers for each interrupt during the runtime.
> >
> And I gave you all the reasons why it needs to be done this way.

Hmm, I don't think you ever answered the main question:

Why would you need to write the wakeupgen registers for every
interrupt during the runtime instead of arming them only when
entering idle?
 
> > AFAIK the wakeupgen registers only need to be armed every time
> > before entering idle.
> >
> No that doesn't work and it completely hacky approach.

And how is writing the registers over and over again unnecessarily
a non-hacky approach?

> This problem is for all SOC's using A9 SMP and GIC and every soc
> has an architecture specific interrupt controller extension. And that
> was the reason the GIC arch_extn was proposed.
> It's just another IRQCHIP and works seamlessly being part of the
> framework.  And it will also initialized with primary IRQCHIP( GIC).

Sure, but I don't know if there is really a need for for that?

Regards,

Tony
