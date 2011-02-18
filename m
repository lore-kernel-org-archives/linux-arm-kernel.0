From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Feb 2011 12:09:49 -0000
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <alpine.LFD.2.00.1102181240370.2701@localhost6.localdomain6>
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
	<001d01cbcf5f$1cfc9870$56f5c950$@deacon@arm.com>
	<alpine.LFD.2.00.1102181240370.2701@localhost6.localdomain6>
Message-ID: <002001cbcf64$bdc562a0$395027e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I don't think the cascaded handlers would have assumed that because ack
> > just sends EOI - it doesn't do any masking. We do have a problem with
> > the percpu_irq flow though (the GIC reference manual says that EOIing a
> > non-active interrupt is UNPREDICTABLE).
> >
> > Another easy hack is to set IRQ_PER_CPU in the irq_desc->status for PPI
> > interrupts and then check this in the ack routine. It's pretty ugly, but
> > it doesn't affect the common case and it at least postpones the platform
> > changes.
> 
> Conditionals in irq_chip callbacks are almost always a sign of
> doom. Don't do that.

Ok, that was a hack too far! Let's fix this properly.
 
> How many chained handlers need to be fixed, when the whole gic stuff
> switches to eoi ?

Well, grepping for set_chained_irq_handler yields a whole bunch of platforms
but the set of these which appear to use the gic is only:

mach-msm
mach-s5pv310
mach-shmobile
mach-tegra

I'll have a look through the code there and post some patches next week.
Hopefully if I've missed anybody, they'll shout then.

Cheers,

Will
