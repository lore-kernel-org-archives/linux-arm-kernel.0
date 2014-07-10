From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Jul 2014 20:25:38 +0200
Subject: [PATCH 0/3] irqchip: atmel-aic: Add irq RTC fixups
Message-ID: <1405016741-2407-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series introduce the notion of irq fixups for atmel SoCs.

In most at91 SoCs the first interrupt line is shared by several IPs, and
some of these HW blocks might be in an unknown state when booting the
Linux kernel.
Hence these IPs might generate spurious interrupts if they've not masked
their irqs and the shared irq line is requested by another peripheral.

These fixups were previously done in arch/arm/mach-at91/sysirq_mask.c
but as we're trying to use standard implementation (IRQCHIP_DECLARE and
automatic call of irqchip_init within arch/arm/kernel/irq.c) we need to
do those fixups in the irqchip driver.

This series only fix RTC irqs, but other HW blocks (RTT, PMC, ...) will
be added later on.

This series depends on this one [1].

Best Regards,

Boris

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/271413.html

Boris BREZILLON (3):
  irqchip: atmel-aic: Add irq fixup infrastructure
  irqchip: atmel-aic: Implement RTC irq fixup
  irqchip: atmel-aic: Define irq fixups for atmel SoCs

 drivers/irqchip/irq-atmel-aic-common.c | 47 ++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-atmel-aic-common.h |  4 +++
 drivers/irqchip/irq-atmel-aic.c        | 15 +++++++++++
 drivers/irqchip/irq-atmel-aic5.c       | 12 +++++++++
 4 files changed, 78 insertions(+)

-- 
1.8.3.2
