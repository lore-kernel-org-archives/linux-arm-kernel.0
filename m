From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Sun, 6 Sep 2015 16:07:26 +0800
Subject: [RFC PATCH v1 0/4] arm/arm64: fix a migrating irq bug when
 hotplug cpu
In-Reply-To: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <55EBF43E.8070501@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/9/6 12:23, Yang Yingliang wrote:
> Hi All,
> 
> There is a bug:
> 
> When cpu is disabled, all irqs will be migratged to another cpu.
> In some cases, a new affinity is different, it needed to be coppied
> to irq's affinity. But if the type of irq is LPI, it's affinity will
> not be coppied because of irq_set_affinity's return value.
> 
> 
> 
> As Marc and Will suggested, I refactor the arm/arm64 migrating interrupts
> code and fix the migrating irq bug while cpu is offline.
> 
> I'm trying let the core code do the migrating interrupts matter. kernel/irq/migration.c
> depends on CONFIG_GENERIC_PENDING_IRQ, so I make it selected by CONFIG_SMP and
> CONFIG_HOTPLUG_CPU and rename it to CONFIG_GENERIC_IRQ_MIGRATION for more general.
> When CONFIG_GENERIC_IRQ_MIGRATION is enabled, an interrupt whose state_use_accessors
> is not set with IRQD_MOVE_PCNTXT won't be migrated immediately in irq_set_affinity_locked().
> So introduce irq_settings_set_move_pcntxt() helper to set the state in gic_irq_domain_map().
> 
> With the above preparation, move the migrating interrupts code into kernel/irq/migration.c
> and fix the bug by using irq_do_set_affinity().
Hi Yingliang,
	As we are going to move migrate_irqs() to generic kernel
code, and powerpc, metag, xtensa, sh, ia64 mn10300 also defines
 migrate_irqs() too. It would be great if we could consolidate
all these.
	And as we are going to refine these code, there's another
issue need attention. On x86, we need to allocate a CPU vector
if an irq is directed to a CPU. So there's possibility that
we run out of CPU vectors after CPU hot-removal. So we have a
mechanism to detect whether we will run out of CPU vector
after removing a CPU, and reject CPU hot-removal if that will
happen.
	So the key point is, if we a need to allocate some sort
of resource on the target CPUs for an irq, we need two steps
when removing a CPU
1) check whether resources are available after removing the CPU,
   and reject CPU removal request if we ran out of resource
2) fix irqs after hot-removing the CPU.
Thanks!
Gerry

> 
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Yang Yingliang (4):
>   genirq: Introduce irq_settings_set_move_pcntxt() helper
>   irqchip: GICv3: set non-percpu irqs status with _IRQ_MOVE_PCNTXT
>   genirq: rename config GENERIC_PENDING_IRQ to GENERIC_IRQ_MIGRATION
>   arm/arm64: fix a migrating irq bug when hotplug cpu
> 
>  arch/arc/Kconfig               |  2 +-
>  arch/arm/Kconfig               |  1 +
>  arch/arm/include/asm/irq.h     |  1 -
>  arch/arm/kernel/irq.c          | 62 ------------------------------------------
>  arch/arm64/Kconfig             |  1 +
>  arch/arm64/include/asm/irq.h   |  1 -
>  arch/arm64/kernel/irq.c        | 62 ------------------------------------------
>  arch/hexagon/Kconfig           |  2 +-
>  arch/ia64/Kconfig              |  2 +-
>  arch/tile/Kconfig              |  2 +-
>  arch/x86/Kconfig               |  2 +-
>  arch/x86/kernel/apic/io_apic.c |  2 +-
>  drivers/irqchip/irq-gic-v3.c   |  2 ++
>  include/linux/irq.h            |  5 +++-
>  include/linux/irqdesc.h        |  2 +-
>  kernel/irq/Kconfig             |  4 +--
>  kernel/irq/Makefile            |  2 +-
>  kernel/irq/irqdesc.c           | 18 ++++++++++--
>  kernel/irq/manage.c            |  2 +-
>  kernel/irq/migration.c         | 62 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/irq/proc.c              |  2 +-
>  kernel/irq/settings.h          |  5 ++++
>  22 files changed, 102 insertions(+), 142 deletions(-)
> 
