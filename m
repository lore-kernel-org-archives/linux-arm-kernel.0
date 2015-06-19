From: benoar@dolka.fr (Benjamin Cama)
Date: Fri, 19 Jun 2015 14:16:34 +0200
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <5583DD23.90505@arm.com>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <1434446447.4785.7.camel@dolka.fr> <1434593555.13334.14.camel@dolka.fr>
 <558278A8.2050406@arm.com> <1434677895.4767.11.camel@dolka.fr>
 <5583DD23.90505@arm.com>
Message-ID: <1434716194.17448.28.camel@x60s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 19 juin 2015 ? 10:13 +0100, Marc Zyngier a ?crit :
> On 19/06/15 02:38, Benjamin Cama wrote:
> > Le jeudi 18 juin 2015 ? 08:52 +0100, Marc Zyngier a ?crit :
> >> Unfortunately, this is the wrong thing to do. IRQ0 is invalid, has been
> >> for a very long time, and actually represents the lack of interrupt.
> > 
> > OK, sorry for the mistake, I didn't know. Shouldn't the IRQ
> > initialization routine check this and warn the user that it may cause
> > problems? ?Silently? making IRQ0 forbidden doesn't help for the
> > platforms that are not fixed yet.
> 
> Well, this is hardly a new rule. It has been like this for quite a long
> time: http://yarchive.net/comp/linux/zero.html
> 
> As for the checking and warning, this is on a very hot path, for an
> error case that really shouldn't occur.

I was not talking about the irq handler, but the irq initialization
routine (on orion5x, orion_irq_init calls irq_alloc_generic_chip with
0), which takes the starting irq number and may warn when it is zero
(well, it may also start allocating at zero but never use it, so this
may not be a totally correct assumption, but I think this comes close,
and it's just a warning).

> <rant>
> I've also come to the conclusion that people often choose to ignore
> warnings. It boots, so who cares? Funnily enough, they react when their
> toy doesn't work any more.
> </rant>

Well, original Orion support seems to come from Marvell itself?

> > 
> >> The way you can address this is by making sure your favourite platform
> >> does not use IRQ0 at all, which is done by not assuming that Linux IRQ
> >> number (which is always completely virtual) is the same as the number
> >> designating the actual HW interrupt line.
> >>
> >> For example, have a look at 18f3aec (ARM: 8230/1: sa1100: shift IRQs by
> >> one) for an example of such a (very simple) conversion. You'll need to
> >> tweak irq.c too.
> >>
> >> Other commits for sa1100 will hopefully convince you to switch to irq
> >> domains altogether. This will greatly facilitate a possible further
> >> transition to DT if you wish to do so.
> > 
> > I read quite a bit about all this virtual/hardware IRQ stuff, and the
> > irq domains, interesting. I see that orion5x seems to be one of the
> > last platforms not using it (appart from DT-converted boards); is it a
> > bad sign about its durability??
> 
> No, we have platforms that will most probably never be converted to DT,
> and they are very far from rotting in the tree.

Nice to know. One of the reasons for converting my board to DT was fear
that it may one day be mandatory. Is there any particular reason for
keeping some boards non-DT while still being maintained?

Regards,
--
benjamin
