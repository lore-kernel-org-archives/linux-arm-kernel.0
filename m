From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Jun 2015 10:14:50 +0200
Subject: [PATCH] Re: Linkstation Mini and __machine_arch_type problem,
 not booting since 3.8
In-Reply-To: <558278A8.2050406@arm.com>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <1434593555.13334.14.camel@dolka.fr> <558278A8.2050406@arm.com>
Message-ID: <1478246.OrbqF8cmmQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 June 2015 08:52:08 Marc Zyngier wrote:
> 
> On 18/06/15 03:12, Benjamin Cama wrote:
> 
> Unfortunately, this is the wrong thing to do. IRQ0 is invalid, has been
> for a very long time, and actually represents the lack of interrupt.
> 
> The way you can address this is by making sure your favourite platform
> does not use IRQ0 at all, which is done by not assuming that Linux IRQ
> number (which is always completely virtual) is the same as the number
> designating the actual HW interrupt line.
> 
> For example, have a look at 18f3aec (ARM: 8230/1: sa1100: shift IRQs by
> one) for an example of such a (very simple) conversion. You'll need to
> tweak irq.c too.
> 
> Other commits for sa1100 will hopefully convince you to switch to irq
> domains altogether. This will greatly facilitate a possible further
> transition to DT if you wish to do so.
> 
> Looking forward to reviewing your patches,

Converting to DT should indeed solve the problem, as that uses
a more modern irqchip driver that does not use IRQ0.

Thomas Petazzoni has worked on converting orion5x machines to DT
in the past, I've cc'd him and the mvebu maintainers here, they
should be able to comment on what is actually required to do the
conversion. It's possible that all drivers you need have already
been converted and you just need to add a new dts files similar to
the other arch/arm/boot/dts/orion5x-*.dts files and can remove
that other board file.

	Arnd
