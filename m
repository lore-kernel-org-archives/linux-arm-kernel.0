From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 17 Oct 2009 00:01:30 +0200
Subject: [PATCH v3 0/2] n2100: tweaks for tickless operation
Message-ID: <19160.60730.618133.828578@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the IOP platform converted to use the kernel's generic
clocksource, clockevent, and time-keeping code, the n2100
can operate in tickless aka NOHZ mode.

However, the n2100 has some quirks that cause the clock
tick rate to remain high in idle mode:

1. The power button is sampled via a 10 Hz timer;
   this is addressed by patch 1/2 in this series.
2. XINT1 may be connected to the second UHCI controller,
   forcing the serial driver core to monitor the console
   UART via a high-frequency timer; this is addressed by
   a work-in-progress patch 2/2 in this series.
3. The USB UHCI_HCD driver monitors the root hub via
   interrupts or a medium-frequency (at least 10 Hz
   it seems) timer. To make it disable the timer and
   use interrupts, it is required to enable CONFIG_PM.
   However, CONFIG_PM is disabled in iop32x_defconfig
   and many other arm defconfigs.

Much of this was discovered via /proc/timer_stats.

With these tweaks enabled my n2100 now averages about 2.5
timer interrupts per second in idle.

Patch 1/2 should be ready for the 2.6.33 merge window,
can I get an ACK or NAK for that one?

Overall changes v1 -> v3:
* dropped some config dependencies
* the XINT1 UART changes are still preliminary, reordered
  patch series to put those last
* rebased on 2.6.32-rc5

/Mikael
