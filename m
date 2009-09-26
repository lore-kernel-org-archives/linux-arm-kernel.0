From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sat, 26 Sep 2009 21:52:45 +0200
Subject: [PATCH 0/2] n2100: tweaks for tickless operation
Message-ID: <19134.28941.973482.178035@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the IOP platform converted to use the kernel's generic
clocksource, clockevent, and time-keeping code, the n2100
can operate in tickless aka NOHZ mode.

However, the n2100 has some quirks that cause the clock
tick rate to remain high in idle mode:

1. XINT1 may be connected to the second UHCI controller,
   forcing the serial driver core to monitor the console
   UART via a high-frequency timer; this is addressed by
   patch 1/2 in this series.
2. The power button is sampled via a 10 Hz timer;
   this is addressed by patch 2/2 in this series.
3. The USB UHCI_HCD driver monitors the root hub via
   interrupts or a medium-frequency (at least 10 Hz
   it seems) timer. To make it disable the timer and
   use interrupts, it is required to enable CONFIG_PM.
   However, CONFIG_PM is disabled in iop32x_defconfig
   and many other arm defconfigs.

Much of this was discovered via /proc/timer_stats.

With these tweaks enabled my n2100 averages about 3.1
timer interrupts per second in idle.

/Mikael
