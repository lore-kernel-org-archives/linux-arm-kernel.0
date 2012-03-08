From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Thu, 08 Mar 2012 11:55:13 +0100
Subject: Regression in 3.2.9 for omap-serial (at least)
Message-ID: <lyk42vxsz2.fsf@ensc-virt.intern.sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the commit "genirq: Unmask oneshot irqs when thread was not woken"[1]
breaks at least the omap-serial driver which requests a shared interrupt
as

 --- arch/arm/mach-omap2/serial.c ---
	ret = request_threaded_irq(uart->irq, NULL, omap_uart_interrupt,
				   IRQF_SHARED, "serial idle", (void *)uart);

 --- drivers/tty/serial/omap-serial.c
	retval = request_irq(up->port.irq, serial_omap_irq, up->port.irqflags,
				up->name, up);


(note the missing IRQF_ONESHOT in the first piece of code)


Where previously 

  if (!irqd_irq_disabled(&desc->irq_data) && !(desc->istate & IRQS_ONESHOT))
          unmask_irq(desc);

was checked in kernel/irq/chip.c, now

  if (!irqd_irq_disabled(&desc->irq_data) &&
  	    irqd_irq_masked(&desc->irq_data) && !desc->threads_oneshot)
  		unmask_irq(desc);

will be done.

Because the threaded irq was requested without IRQF_ONESHOT, IRQS_ONESHOT
is not set but 'desc->threads_oneshot' is 1 due to the threaded irq. So,
irq was unmasked with old code but stays masked with the new one.  The new
behavior renders systems unusable because console becomes disfunctional.




Enrico

Footnotes: 
[1]  aa0eb3474beae8f6d9dcc2311dc02bea50cfd7b7
