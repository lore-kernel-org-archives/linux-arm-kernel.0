From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Mar 2011 15:33:20 -0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use EOI
	in parent chip
In-Reply-To: <alpine.LFD.2.00.1103012133530.2701@localhost6.localdomain6>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
	<20110228140327.GA1937@n2100.arm.linux.org.uk>
	<001401cbd772$a1f93ae0$e5ebb0a0$@deacon@arm.com>
	<alpine.LFD.2.00.1102281949050.2701@localhost6.localdomain6>
	<20110228214445.GD1937@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103011140560.2701@localhost6.localdomain6>
	<20110301201904.GA27107@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1103012133530.2701@localhost6.localdomain6>
Message-ID: <001301cbd8ef$29403c10$7bc0b430$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

> Can you please take the time and explain me the difference of the
> following:
> 
> irqchip1.c
> 
> struct irq_chip1;
> 
> handle_primary_irq(int irq, struct irq_desc *desc)
> {
> 	chip->irq_ack();
> 	desc->demux();
> }
> 
> init()
> {
> 	irq_set_chip(PRIMARY_IRQ, &irq_chip1);
> 	irq_set_primary_handler(PRIMARY_IRQ, handle_primary_irq);
> }

I think with this approach you get the exact opposite problem; that
is the primary irq_chip doesn't know which IRQs are going to be
demuxed so it cannot know at init time which IRQs need their primary 
handler set. Is the idea that you set_primary_handler for all IRQs,
stash that in the descriptor somewhere and then replace handle_irq
with the primary handler when a demux handler is registered?

I guess I'm missing something here,

Cheers,

Will
