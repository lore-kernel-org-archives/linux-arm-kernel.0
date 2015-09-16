From: yangyingliang@huawei.com (Yang Yingliang)
Date: Wed, 16 Sep 2015 11:58:24 +0800
Subject: [RFC PATCH v3 0/3] arm/arm64: fix a migrating irq bug when hotplug cpu
Message-ID: <1442375907-11496-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----
Changes in v3:
 - introduce config GENERIC_IRQ_MIGRATION for compiling migration.c
 - rename migrate_irqs in arch/ia64/kernel/irq.c to avoid compiling error

Changes in v2:
 - use the exiting helper to set IRQD_MOVE_PCNTXT flag
 - use for_each_active_irq() instead of for_each_irq_desc()
 - add some warn messages when affinity is null or do set affinity failed
----

Hi All,

There is a bug:

When cpu is disabled, all irqs will be migratged to another cpu.
In some cases, a new affinity is different, it needed to be coppied
to irq's affinity. But if the type of irq is LPI, it's affinity will
not be coppied because of irq_set_affinity's return value.



As Marc and Will suggested, I refactor the arm/arm64 migrating interrupts
code and fix the migrating irq bug while cpu is offline.

I'm trying let the core code do the migrating interrupts matter. kernel/irq/migration.c
depends on CONFIG_GENERIC_PENDING_IRQ, so I introduce config GENERIC_IRQ_MIGRATION for
compiling migration.c. On ia64, there is a migrate_irqs() in arch/ia64/kernel/irq.c,
rename it to avoid compiling error.

With the above preparation, move the migrating interrupts code into kernel/irq/migration.c
and fix the bug by using irq_do_set_affinity().

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>

Yang Yingliang (3):
  genirq: introduce CONFIG_GENERIC_IRQ_MIGRATION
  ia64: rename migrate_irqs() to avoid compiling error
  arm/arm64: fix a migrating irq bug when hotplug cpu

 arch/arc/Kconfig             |  1 +
 arch/arm/Kconfig             |  1 +
 arch/arm/include/asm/irq.h   |  1 -
 arch/arm/kernel/irq.c        | 62 ----------------------------------------
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/irq.h |  1 -
 arch/arm64/kernel/irq.c      | 62 ----------------------------------------
 arch/hexagon/Kconfig         |  1 +
 arch/ia64/Kconfig            |  1 +
 arch/ia64/kernel/irq.c       |  4 +--
 arch/tile/Kconfig            |  1 +
 arch/x86/Kconfig             |  1 +
 include/linux/irq.h          |  4 +++
 kernel/irq/Kconfig           |  4 +++
 kernel/irq/Makefile          |  2 +-
 kernel/irq/migration.c       | 68 ++++++++++++++++++++++++++++++++++++++++++++
 16 files changed, 86 insertions(+), 129 deletions(-)

-- 
2.5.0
