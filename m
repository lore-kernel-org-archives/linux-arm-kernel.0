From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 20 Jan 2016 10:38:13 +0800
Subject: A problem about SPI Interrupt Configuration
Message-ID: <569EF315.2060203@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Marc

I got some error messages "RWP timeout, gone fishing".

The case is :

			CPU0												CPU1
													acquire desc->lock in __setup_irq()
															enable irq in __setup_irq()
read iar in gic_handle_irq()
waiting for desc->lock in handle_fasteoi_irq()
												call gic_set_affinity() from setup_affinity()
												waiting for the irq deactive in gic_do_wait_for_rwp()


The hardware will not clear GICD_CTLR.RWP until the interrupt is not
active. The interrupt is keeping active while it's waiting for
desc->lock on cpu0. But the lock is hold by cpu1 while it's waiting for
the interrupt is not active. It causes a deadlock here in 1s.


And the GICv3 SPEC says:

4.5.5 SPI Interrupt Configuration
To configure an SPI interrupt, to ensure that interrupts are never 
distributed using partially updated configuration
information, software must:
o Ensure the interrupt is not active
o Ensure that the interrupt is disabled
o This might be done either by writing to GICD_CTLR to clear the enables 
for a group, or
o By writing to GICD_ICENABLERn to clear the Enable bit of the interrupt 
(see section 5.3.11).
o In both cases, software must poll GICD_CTLR.RWP to ensure the effects 
are visible (see section
5.3.20).
o Program the routing (if appropriate), priority and group
o Enable the interrupt (if required)

Because it says "Ensure the interrupt is not active", so I can not tell
it is a hardware or software problem.

Can you please give some advice?

Thanks,
Yang
