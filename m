From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 23 Sep 2009 14:36:12 +0200
Subject: Thecus n2100 uart irq?
Message-ID: <19130.5692.953257.987602@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The plat_serial8250_port data in mach-iop32x/n2100.c stores
a zero in the .irq field. This causes the 8250 serial driver
to run the serial console in irq-less mode with a high-frequency
polling timer.

According to /proc/timer_stats on my n2100, the 8250 polling
timer generates more timeouts than any other timer in my kernel,
and about 10 times more timeouts than the second most active
timer.

Apart from the constant CPU overhead, this prevents CONFIG_NO_HZ
(in my pending plat-iop clocksource/clockevents conversion) from
being effective: the frequent timeouts keeps the timer interrupt
rate just as high as in the NO_HZ case.

The other mach-iop32x machines use one of the IRQ_IOP32X_XINT[0-3]
interrupts for their uarts. I've tried all four values on the n2100,
but none of them seemed to work: the console would go silent when
the kernel starts init.

Does anyone know how run the n2100 uart properly with an irq?

/Mikael
