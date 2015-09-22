From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Sep 2015 19:34:07 +0100
Subject: [RFC PATCH v5 0/4] arm/arm64: fix a migrating irq bug when
 hotplug cpu
In-Reply-To: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <20150922183407.GP7356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 19, 2015 at 04:05:55AM +0100, Yang Yingliang wrote:
> ----
> Changes in v5:
>  - remove the macro that guard move_irqs()
>  - use name irq_migrate_all_off_this_cpu instead of move_irqs
> 
> Changes in v4:
>  - select GENERIC_IRQ_MIGRATION when config GENERIC_IRQ_MIGRATION is enabled
>  - add move_irqs() into kerne/irq/migration.c for cpu hotplug
>  - use move_irqs() to migrate interrupts on arm/arm64 when cpu is going to down
>  - split bugfix patch into seperate patches for arm and arm64
> 
> Changes in v3:
>  - introduce config GENERIC_IRQ_MIGRATION for compiling migration.c
>  - rename migrate_irqs in arch/ia64/kernel/irq.c to avoid compiling error
> 
> Changes in v2:
>  - use the exiting helper to set IRQD_MOVE_PCNTXT flag
>  - use for_each_active_irq() instead of for_each_irq_desc()
>  - add some warn messages when affinity is null or do set affinity failed
> ----
> 
> Hi All,
> 
> There is a bug:
> 
> When cpu is disabled, all irqs will be migratged to another cpu.
> In some cases, a new affinity is different, it needed to be coppied
> to irq's affinity. But if the type of irq is LPI, it's affinity will
> not be coppied because of irq_set_affinity's return value.

This series looks good to me:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Marc: once you're happy with the irq/core changes, feel free to include
the arm64 patch in your tree.

Will
