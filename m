From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 23 Sep 2009 15:07:31 +0200
Subject: Thecus n2100 uart irq?
In-Reply-To: <19130.5692.953257.987602@pilspetsen.it.uu.se>
References: <19130.5692.953257.987602@pilspetsen.it.uu.se>
Message-ID: <20090923130731.GO1773@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2009 at 02:36:12PM +0200, Mikael Pettersson wrote:

> The plat_serial8250_port data in mach-iop32x/n2100.c stores
> a zero in the .irq field. This causes the 8250 serial driver
> to run the serial console in irq-less mode with a high-frequency
> polling timer.
> 
> According to /proc/timer_stats on my n2100, the 8250 polling
> timer generates more timeouts than any other timer in my kernel,
> and about 10 times more timeouts than the second most active
> timer.
> 
> Apart from the constant CPU overhead, this prevents CONFIG_NO_HZ
> (in my pending plat-iop clocksource/clockevents conversion) from
> being effective: the frequent timeouts keeps the timer interrupt
> rate just as high as in the NO_HZ case.
> 
> The other mach-iop32x machines use one of the IRQ_IOP32X_XINT[0-3]
> interrupts for their uarts. I've tried all four values on the n2100,
> but none of them seemed to work: the console would go silent when
> the kernel starts init.

The XINT interrupt sources are interrupt sources for external pins on
the SoC (GPIO-like).  On the Thecus, the serial port IRQ is not hooked
up by default (but see below), so that explains why that wouldn't work.


> Does anyone know how run the n2100 uart properly with an irq?

If I recall correctly (it's been a while), then on the n2100, there
is one XINT line that can either be jumpered to hook up to the serial
port IRQ or to the interrupt line of one of the USB controllers, and
the default is to connect to the USB controller interrupt line.

Note that when I last looked, the 8250 driver had the option to work
in irq-less mode but the USB *HCI drivers didn't, so the only way to
get serial to run irq-less was to break USB.

I suppose that that's still true, but if the serial and USB controller
interrupt output are both open drain or so (please check the datasheets
to see if that's true, as I don't know), you could perhaps just tie the
three pins together, and have the 8250 and the USB *HCI drivers use the
same IRQ number.  (If you're not sure whether they are, then you could
test by tying them together with suitably large resistors, and seeing
how much current you end up drawing.)
