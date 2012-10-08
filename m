From: linux@prisktech.co.nz (Tony Prisk)
Date: Mon, 08 Oct 2012 20:42:39 +1300
Subject: Devicetree/Interrupts problem
Message-ID: <1349682159.8794.12.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hopefully someone can explain to me what is going wrong with this irq
implementation.

I am trying to convert the irq.c from arch-vt8500 to enable
multiplatform support but have run into a problem I don't quite
understand.

In arch-vt8500/irq.c I have:

vt8500_irq_domain = irq_domain_add_linear(node, 64,
&vt8500_irq_domain_ops, priv);

for (i=0; i<17; i++) {
		irq = irq_create_mapping(vt8500_irq_domain, i);
		printk("%s: create_mapping returned %d for i=%d\n", __func__, irq, i);
		BUGON(i <= 0);
		irq_set_chip_and_handler(irq, &vt8500_irq_chip, handle_level_irq);
		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
}

I am (if I understand it correctly) creating mappings from hwirq to
linux irq numbers. This code is run twice (two interrupt controllers).

The printk spews out a bunch of messages basically indicating that
hwirq(d) was mapped to virq(d+1). virq(0) is invalid I believe so this
all makes sense.

The problem occurs when I set 'i<18' or greater in the for-loop. (It
should be 64 eventually).

When the combined total is >=36 it causes a problem with the timer
(which is on hwirq=36 of the first controller).

in arch-vt8500/timer.c:
timer_irq = irq_of_parse_and_map(np, 0);
...
if (setup_irq(timer_irq, &irq))
		pr_err("%s: setup_irq failed for %s\n", __func__,
							clockevent.name);

timer_irq = 36, which seems to be causing the problem - while trying to
initialize the timer it gives the 'setup_irq failed for ...", the timer
doesn't get setup and the kernel freezes during boot.

If I create a mapping for hwirq=36 before running the for-loop, it maps
hwirq=36 to virq=36, and everything is happy. It seems that if hwirq!
=virq that it causes problems. Same thing happens for every other
irq-generating device.


I guess it must be something obvious - anything jump out to anyone?


Regards
Tony P
