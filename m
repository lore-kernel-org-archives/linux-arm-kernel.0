From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sun, 6 Sep 2015 12:23:37 +0800
Subject: [RFC PATCH v1 0/4] arm/arm64: fix a migrating irq bug when hotplug cpu
Message-ID: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

There is a bug:

When cpu is disabled, all irqs will be migratged to another cpu.
In some cases, a new affinity is different, it needed to be coppied
to irq's affinity. But if the type of irq is LPI, it's affinity will
not be coppied because of irq_set_affinity's return value.



As Marc and Will suggested, I refactor the arm/arm64 migrating interrupts
code and fix the migrating irq bug while cpu is offline.

I'm trying let the core code do the migrating interrupts matter. kernel/irq/migration.c
depends on CONFIG_GENERIC_PENDING_IRQ, so I make it selected by CONFIG_SMP and
CONFIG_HOTPLUG_CPU and rename it to CONFIG_GENERIC_IRQ_MIGRATION for more general.
When CONFIG_GENERIC_IRQ_MIGRATION is enabled, an interrupt whose state_use_accessors
is not set with IRQD_MOVE_PCNTXT won't be migrated immediately in irq_set_affinity_locked().
So introduce irq_settings_set_move_pcntxt() helper to set the state in gic_irq_domain_map().

With the above preparation, move the migrating interrupts code into kernel/irq/migration.c
and fix the bug by using irq_do_set_affinity().

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>

Yang Yingliang (4):
  genirq: Introduce irq_settings_set_move_pcntxt() helper
  irqchip: GICv3: set non-percpu irqs status with _IRQ_MOVE_PCNTXT
  genirq: rename config GENERIC_PENDING_IRQ to GENERIC_IRQ_MIGRATION
  arm/arm64: fix a migrating irq bug when hotplug cpu

 arch/arc/Kconfig               |  2 +-
 arch/arm/Kconfig               |  1 +
 arch/arm/include/asm/irq.h     |  1 -
 arch/arm/kernel/irq.c          | 62 ------------------------------------------
 arch/arm64/Kconfig             |  1 +
 arch/arm64/include/asm/irq.h   |  1 -
 arch/arm64/kernel/irq.c        | 62 ------------------------------------------
 arch/hexagon/Kconfig           |  2 +-
 arch/ia64/Kconfig              |  2 +-
 arch/tile/Kconfig              |  2 +-
 arch/x86/Kconfig               |  2 +-
 arch/x86/kernel/apic/io_apic.c |  2 +-
 drivers/irqchip/irq-gic-v3.c   |  2 ++
 include/linux/irq.h            |  5 +++-
 include/linux/irqdesc.h        |  2 +-
 kernel/irq/Kconfig             |  4 +--
 kernel/irq/Makefile            |  2 +-
 kernel/irq/irqdesc.c           | 18 ++++++++++--
 kernel/irq/manage.c            |  2 +-
 kernel/irq/migration.c         | 62 ++++++++++++++++++++++++++++++++++++++++++
 kernel/irq/proc.c              |  2 +-
 kernel/irq/settings.h          |  5 ++++
 22 files changed, 102 insertions(+), 142 deletions(-)

-- 
2.5.0
