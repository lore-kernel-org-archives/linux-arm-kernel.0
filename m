From: yangyingliang@huawei.com (Yang Yingliang)
Date: Thu, 24 Sep 2015 17:32:12 +0800
Subject: [RFC PATCH v6 0/3] arm/arm64: fix a migrating irq bug when hotplug cpu
Message-ID: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----
Changes in v6:
 - Don't touch the existing file kernel/irq/migration.c and add
   migrating interrupts code to a new file kernel/irq/cpuhotplug.c
   suggested by Thomas.
 - Change some comments in patch #2 and #3.

Changes in v5:
 - remove the macro that guard move_irqs()
 - use name irq_migrate_all_off_this_cpu instead of move_irqs

Changes in v4:
 - select GENERIC_IRQ_MIGRATION when config GENERIC_IRQ_MIGRATION is enabled
 - add move_irqs() into kerne/irq/migration.c for cpu hotplug
 - use move_irqs() to migrate interrupts on arm/arm64 when cpu is going to down
 - split bugfix patch into seperate patches for arm and arm64

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
code and fix the migrating irq bug before cpu is offline.

I'm trying let the core code do the migrating interrupts matter. Add the migrating code
to a new file kernel/irq/cpuhotplug.c and make it depend on GENERIC_IRQ_MIGRATION. Fix
the bug by using irq_do_set_affinity. And use the new code to migrate interrupts before
cpu is offline on arm and arm64.


Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>

Yang Yingliang (3):
  genirq: introduce CONFIG_GENERIC_IRQ_MIGRATION and
    kernel/irq/cpuhotplug.c
  arm64: fix a migrating irq bug when hotplug cpu
  arm: fix a migrating irq bug when hotplug cpu

 arch/arm/Kconfig             |  1 +
 arch/arm/include/asm/irq.h   |  1 -
 arch/arm/kernel/irq.c        | 62 ----------------------------------------
 arch/arm/kernel/smp.c        |  2 +-
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/irq.h |  1 -
 arch/arm64/kernel/irq.c      | 62 ----------------------------------------
 arch/arm64/kernel/smp.c      |  2 +-
 include/linux/irq.h          |  2 ++
 kernel/irq/Kconfig           |  4 +++
 kernel/irq/Makefile          |  1 +
 kernel/irq/cpuhotplug.c      | 68 ++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 79 insertions(+), 128 deletions(-)
 create mode 100644 kernel/irq/cpuhotplug.c

-- 
2.5.0
