From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 30 Jun 2014 11:39:19 -0700
Subject: timers & suspend
Message-ID: <f270ad9c-9906-445d-9e9a-4d3618787455@BY2FFO11FD039.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm currently working on suspend for Zynq and try to track down some
spurious wakes. It looks like the spurious wakes are caused by timers,
hence I was wondering whether there are any special requirements for
timer drivers when it comes to suspend support or if I just missed
something.

Zynq sets the 'IRQCHIP_MASK_ON_SUSPEND' flag, which should mask all
interrupts but the wake source. Reading through kernel/irq/pm.c
indicates, that timer interrupts get some special treatment though.
Therefore I implemented some suspend/resume callbacks for the
cadence_ttc which disable and clear the timer's interrupts when going
into suspend. That seems to mitigate the issue quite a bit, but I still
saw spurious wakes - just a lot less often.
Digging a little deeper revealed, the spurious wakes are caused by the
ARM's smp_twd timer now. Given that that driver is probably used by a few
more ARM platforms, I get the feeling that I'm missing something.

It's probably worth mentioning that the suspend state in Zynq does not
power off the CPU cores. It just asserts the resets on secondary cores
and the primary one waits in wfi.

	Thanks,
	S?ren
