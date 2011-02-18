From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Feb 2011 11:29:31 -0000
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <4D5DB193.5010007@codeaurora.org>
References: <AANLkTik-0SaVbtiXZ-iefvvgLq=7KqRTGi7XPLPEKx85@mail.gmail.com>
	<-4413647205110644369@unknownmsgid>
	<AANLkTikaZkRMHH1bUmO0pWYT1FgTC+83F5KxPySasG-S@mail.gmail.com>
	<146267380211262372@unknownmsgid>
	<AANLkTimPDNv+2n2-QHtBq0X+Vkj21yQCPh8iKZkYjfqG@mail.gmail.com>
	<alpine.LFD.2.00.1102162008490.2701@localhost6.localdomain6>
	<20110217091741.GA24627@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102171032580.2701@localhost6.localdomain6>
	<20110217101957.GC24627@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102171136550.2701@localhost6.localdomain6>
	<20110217105611.GE24627@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102171203280.2701@localhost6.localdomain6>
	<001301cbcebf$76925cd0$63b71670$@deacon@arm.com>
	<alpine.LFD.2.00.1102171831520.2701@localhost6.localdomain6>
	<4D5DB193.5010007@codeaurora.org>
Message-ID: <001d01cbcf5f$1cfc9870$56f5c950$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> Right, so to get back to the original discussion about how to handle
> >> chained handlers if the high-level flow type of the IRQ chip is altered
> >> it seems that there are two options:
> >>
> >> 1.) Update all of the chained handlers to use the new flow-control
> >> 2.) Retain backwards compatibility if a chained handler decides to
> >>     use the old method of flow control (specifically, leave an ack
> >>     implementation in the GIC code after moving to fasteoi).
> >>
> >> Obviously, I'd rather go with option (2) and let platforms migrate
> >> over time if they choose to. Now, given that the ack function is really
> >> not something you want to do in a virtualised environment (because it
> >> pokes the distributor), is it worth sticking a
> >> WARN_ON_ONCE(cpu_has_virtualisation()); in the ack code?
> >
> > #2 is less painful and just works. The fasteoi stuff does not use ack
> > IIRC so it wont hurt.
> 
> On an MSM we use handle_percpu_irq for PPIs, if we have ack and eoi we
> will end up EOI ing the interrupt twice so #2 wont work. Also all the
> cascaded handlers would have assumed that the ack function masks the
> interrupt, it is best we fix all of them to use eoi at the end (just
> like handle_fasteoi_irq). Please tell me how you guys locate such
> cascaded handlers?

I don't think the cascaded handlers would have assumed that because ack
just sends EOI - it doesn't do any masking. We do have a problem with
the percpu_irq flow though (the GIC reference manual says that EOIing a
non-active interrupt is UNPREDICTABLE).

Another easy hack is to set IRQ_PER_CPU in the irq_desc->status for PPI
interrupts and then check this in the ack routine. It's pretty ugly, but
it doesn't affect the common case and it at least postpones the platform
changes.
 
Will
