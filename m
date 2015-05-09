From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 16:35:38 +0100
Subject: Versatile Express no-boot with multi-platform kernels
Message-ID: <20150509153537.GR2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been building an OMAP4 + Versatile Express kernel in the build
system as a check that there are no incompatibilities between the
two creeping in.

However, a while back, Versatile Express stopped booting with this
configuration _after_ the resolution of the L2 cache latency issue.

I've been trying to debug it today, but what I find is that if I change
the LL_DEBUG to the Versatile Express option, and put my printascii()
hack into kernel/printk/printk.c, it boots.

I can't say much more than that right now - I tried moving the debug
output to one of the other ports, but it seems that the other ttyAMA
ports aren't actually connected to the 9-pin D connectors on the
chassis (well, the CTS signal appears to be, but not the TX/RX
signals.)  Port 1 appears to be redirected permanently to one of the
on-board micros.  Port 3, when set to 38400 baud, receives random
characters with framing errors from an unknown source.  Port 2 appears
to do nothing both in the TX and RX directions.

Having the printascii hack in place but directed to one of the other
ports also results in a non-booting scenario.

It seems that printascii() on ttyAMA0 (the console) helps the kernel
boot.

I thought maybe it was a result of the recent commits to change the TX
behaviour in the pl011 driver, so I've tried reverting:

48d7ff0eaacb drivers/tty: serial: remove info message
1c9be3101574 drivers/tty: amba: defer DMA probe until the DMA channel is require...
f2ee6dfa0e85 serial/amba-pl011: Leave the TX IRQ alone when the UART is not open...
734745caeb9f serial/amba-pl011: Activate TX IRQ passively

but these seem to have no effect.  Reverting much before that starts
getting quite tricky because of changes which span outside of the
driver.

The final data point is that a kernel built specifically for Versatile
Express /does/ work.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
