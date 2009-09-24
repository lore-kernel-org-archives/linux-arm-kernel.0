From: mikpe@it.uu.se (Mikael Pettersson)
Date: Thu, 24 Sep 2009 15:15:21 +0200
Subject: Thecus n2100 uart irq?
In-Reply-To: <20090923130731.GO1773@mail.wantstofly.org>
References: <19130.5692.953257.987602@pilspetsen.it.uu.se>
	<20090923130731.GO1773@mail.wantstofly.org>
Message-ID: <19131.28905.723253.60029@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lennert Buytenhek writes:
 > On Wed, Sep 23, 2009 at 02:36:12PM +0200, Mikael Pettersson wrote:
 > 
 > > The plat_serial8250_port data in mach-iop32x/n2100.c stores
 > > a zero in the .irq field. This causes the 8250 serial driver
 > > to run the serial console in irq-less mode with a high-frequency
 > > polling timer.
 > > 
 > > According to /proc/timer_stats on my n2100, the 8250 polling
 > > timer generates more timeouts than any other timer in my kernel,
 > > and about 10 times more timeouts than the second most active
 > > timer.
 > > 
 > > Apart from the constant CPU overhead, this prevents CONFIG_NO_HZ
 > > (in my pending plat-iop clocksource/clockevents conversion) from
 > > being effective: the frequent timeouts keeps the timer interrupt
 > > rate just as high as in the NO_HZ case.
 > > 
 > > The other mach-iop32x machines use one of the IRQ_IOP32X_XINT[0-3]
 > > interrupts for their uarts. I've tried all four values on the n2100,
 > > but none of them seemed to work: the console would go silent when
 > > the kernel starts init.
 > 
 > The XINT interrupt sources are interrupt sources for external pins on
 > the SoC (GPIO-like).  On the Thecus, the serial port IRQ is not hooked
 > up by default (but see below), so that explains why that wouldn't work.
 > 
 > 
 > > Does anyone know how run the n2100 uart properly with an irq?
 > 
 > If I recall correctly (it's been a while), then on the n2100, there
 > is one XINT line that can either be jumpered to hook up to the serial
 > port IRQ or to the interrupt line of one of the USB controllers, and
 > the default is to connect to the USB controller interrupt line.

I've done some experiments now.

The n2100 has 3 USB controllers, 2 UHCI and 1 EHCI, and 3 USB ports.
The EHCI is on irq 29 shared with the SiL SATA controller, and one
of the UHCIs is on irq 27 shared with the RTL gigaether controller.

With the jumper in the J3 position, irq 28 goes to the second UHCI.
In this configuration each USB port will accept both high-speed and
low-speed devices. The UHCI on irq 28 handles the rear two ports and
the UHCI on irq 27 handles the front port. The serial console has no
irq so runs with a high-frequency polling timer.

With the jumper in the J4 position, irq 28 goes to the UART.
Each USB port will still accept high-speed devices (tested with
a memory stick and an ethernet dongle), but only the front port
will accept low-speed devices (tested with a mouse).
The serial console has an irq so the polling timer is gone.

I'll run my n2100 with the jumper in J4 from now on.

 > I suppose that that's still true, but if the serial and USB controller
 > interrupt output are both open drain or so (please check the datasheets
 > to see if that's true, as I don't know), you could perhaps just tie the
 > three pins together, and have the 8250 and the USB *HCI drivers use the
 > same IRQ number.  (If you're not sure whether they are, then you could
 > test by tying them together with suitably large resistors, and seeing
 > how much current you end up drawing.)

I don't need the second UHCI controller so I'm leaving that experiment
aside for now.

A crude patch to reassign irq 28 to the uart follows below. Is this
something that might be interesting for others? If so, then perhaps
it should be a config option or a command line parameter?

/Mikael

--- linux-2.6.31/arch/arm/mach-iop32x/n2100.c.~1~	2009-09-24 11:57:17.000000000 +0200
+++ linux-2.6.31/arch/arm/mach-iop32x/n2100.c	2009-09-24 12:02:19.000000000 +0200
@@ -94,7 +94,11 @@ n2100_pci_map_irq(struct pci_dev *dev, u
 		irq = IRQ_IOP32X_XINT2;
 	} else if (PCI_SLOT(dev->devfn) == 4 && pin == 1) {
 		/* VT6212 INTA */
+#if 1	/* J4 */
+		irq = -1;
+#else
 		irq = IRQ_IOP32X_XINT1;
+#endif
 	} else if (PCI_SLOT(dev->devfn) == 4 && pin == 2) {
 		/* VT6212 INTB */
 		irq = IRQ_IOP32X_XINT0;
@@ -176,7 +180,11 @@ static struct plat_serial8250_port n2100
 	{
 		.mapbase	= N2100_UART,
 		.membase	= (char *)N2100_UART,
+#if 1	/* J4 */
+		.irq		= IRQ_IOP32X_XINT1,
+#else
 		.irq		= 0,
+#endif
 		.flags		= UPF_SKIP_TEST,
 		.iotype		= UPIO_MEM,
 		.regshift	= 0,
