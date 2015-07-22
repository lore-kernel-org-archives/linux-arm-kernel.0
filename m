From: slash.tmp@free.fr (Mason)
Date: Wed, 22 Jul 2015 16:46:07 +0200
Subject: Write to memory-mapped register has actually reached the device
Message-ID: <55AFACAF.7020004@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I'm using an ARMv7 platform (Cortex A9).

The hardware designer said something that confused me: he said
that when a driver writes to a device memory-mapped register,
there is no way to "know" when the write has actually reached
the device, other than to read the value back.

I had been using this kind of code:

  static void __iomem *device_base;

  device_base = ioremap(DEVICE_ADDR, RANGE);
  writel_relaxed(val, device_base + N);


The situation where he said this would bite me is:

  write to a device register to clear an interrupt notification
  unmask interrupts

The interrupt might fire because the interrupt bit has
not been cleared yet. Does that make any sense?

Should I use writel instead of writel_relaxed in that
situation? Do I really have to read-after-write?

Regards.
