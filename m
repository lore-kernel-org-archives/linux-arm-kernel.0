From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 14:31:06 +0100
Subject: [PATCH 0/5] ARM: integrator: cascaded IRQs on IM-PD1
Message-ID: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series alters the VIC driver to allow for cascaded VICs off other
IRQ parents, such as the VIC found on the IM-PD1 daughterboard on the
Integrator/AP.

After this series I can start a fully working console on the UARTs on
the IM-PD1 that report their IRQs in /proc/interrupts like this:

root at integrator:/ cat /proc/interrupts
           CPU0
 17:        111       pic   1  uart-pl010
 18:          7       pic   2  uart-pl010
 22:       5377       pic   6  timer
 24:          0       pic   8  rtc-pl030
 33:          0       pic  17  PCIv3 error
 39:        102       VIC   1  uart-pl011
 40:          7       VIC   2  uart-pl011
Err:          0

(Dumped on the IM-PD1 UART.)

Linus Walleij (5):
  irqchip: vic: update the base IRQ member correctly
  irqchip: support cascaded VICs
  ARM: integrator: use managed resources for the IM-PD1
  ARM: integrator: register the IM-PD1 VIC
  ARM: integrator: select AMBA bus and GPIO block

 arch/arm/mach-integrator/Kconfig |  4 ++
 arch/arm/mach-integrator/impd1.c | 81 +++++++++++++++++++++++-----------------
 arch/arm/mach-versatile/core.c   |  2 +-
 drivers/irqchip/irq-vic.c        | 59 +++++++++++++++++++++++++----
 include/linux/irqchip/arm-vic.h  |  6 ++-
 5 files changed, 107 insertions(+), 45 deletions(-)

-- 
1.8.4.2
