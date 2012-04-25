From: neilb@suse.de (NeilBrown)
Date: Wed, 25 Apr 2012 13:05:23 +1000
Subject: [PATCH 0/3] Ensure twl4030 interrupts are lost during suspend.
Message-ID: <20120425025637.7832.14013.stgit@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the scatter-gun list of email address, but while each of
these patches only touches one subsystem, they really needed each
other to provide proper context.

The goal is to ensure that an interrupt that arrives on a TWL4030
connected to an OMAP3, during the 'late-suspend' stage will
cause the suspend to abort (if the interrupt is properly configured).
(e.g. power button, RTC alarm, USB plug/unplug)

The interrupt as seen by the OMAP3 is a level-triggered interrupt so
if it arrives at this time, it is masked.  With the current code it
remains masked and so cannot wake the device from suspend.

To fix this:
  The twl4030 drivers must mark the interrupt for wakeup
  The OMAP interrupt handler must allow the interrupt to be
     marked for wakeup
  The core interrupt/PM code must allow masked level-triggered
     interrupts to abort a suspend.

I'm least sure about that last one.  My patch unmasks any masked
interrupt that is suppose to support wakeup.  I suspect that is
correct but I don't know enough about general IRQ handling to be sure.
Maybe there could be cases where a driver has explicitly masked the
interrupt without cleaning the 'wakeup' setting.  Is that allowed?


---

NeilBrown (3):
      twl4030: enable wakeup on twl4030 IRQ.
      IRQ: allow check_wakeup_irqs to notice level-triggered interrupts.
      ARM: omap2+: set IRQCHIP_SKIP_SET_WAKE for INTC interrupts.


 arch/arm/mach-omap2/irq.c |    1 +
 drivers/mfd/twl4030-irq.c |    1 +
 kernel/irq/pm.c           |    6 ++++++
 3 files changed, 8 insertions(+)

-- 
Signature
