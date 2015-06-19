From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Jun 2015 14:13:15 +0100
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <1434716194.17448.28.camel@x60s>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <1434446447.4785.7.camel@dolka.fr>
 <1434593555.13334.14.camel@dolka.fr> <558278A8.2050406@arm.com>
 <1434677895.4767.11.camel@dolka.fr> <5583DD23.90505@arm.com>
 <1434716194.17448.28.camel@x60s>
Message-ID: <20150619131315.GR7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 02:16:34PM +0200, Benjamin Cama wrote:
> Le vendredi 19 juin 2015 ? 10:13 +0100, Marc Zyngier a ?crit :
> > On 19/06/15 02:38, Benjamin Cama wrote:
> > > Le jeudi 18 juin 2015 ? 08:52 +0100, Marc Zyngier a ?crit :
> > >> Unfortunately, this is the wrong thing to do. IRQ0 is invalid, has been
> > >> for a very long time, and actually represents the lack of interrupt.
> > > 
> > > OK, sorry for the mistake, I didn't know. Shouldn't the IRQ
> > > initialization routine check this and warn the user that it may cause
> > > problems? ?Silently? making IRQ0 forbidden doesn't help for the
> > > platforms that are not fixed yet.
> > 
> > Well, this is hardly a new rule. It has been like this for quite a long
> > time: http://yarchive.net/comp/linux/zero.html
> > 
> > As for the checking and warning, this is on a very hot path, for an
> > error case that really shouldn't occur.
> 
> I was not talking about the irq handler, but the irq initialization
> routine (on orion5x, orion_irq_init calls irq_alloc_generic_chip with
> 0), which takes the starting irq number and may warn when it is zero
> (well, it may also start allocating at zero but never use it, so this
> may not be a totally correct assumption, but I think this comes close,
> and it's just a warning).

It needs fixing nevertheless - arguments along the lines of "this used
to work" don't work for this topic.

The simple answer is to adjust the initialisation to bump the IRQ
numbers up by one, and them adjust the interrupt numbers in
arch/arm/mach-whatever/include/asm/irqs.h also up by one.  That's
far easier to do than spending ages trying to argue against the
"IRQ0 is not valid" issue, only to ultimately get nowhere, and end
up with that as the only way forward anyway.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
