From: nm@ti.com (Nishanth Menon)
Date: Thu, 8 Jan 2015 10:58:31 -0600
Subject: [PATCH v2 15/21] ARM: exynos4/5: convert pmu wakeup to stacked
 domains
In-Reply-To: <1420652576-22309-16-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
 <1420652576-22309-16-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150108165831.GB19124@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:42-20150107, Marc Zyngier wrote:
> Exynos has been (ab)using the gic_arch_extn to provide
> wakeup from suspend, and it makes a lot of sense to convert
> this code to use stacked domains instead.
> 
> This patch does just this, updating the DT files to actually
> reflect what the HW provides.
> 
> BIG FAT WARNING: because the DTs were so far lying by not
> exposing the fact that the PMU block is actually the first
> interrupt controller in the chain for RTC, kernels with this patch
> applied wont have any suspend-resume facility when booted
> with old DTs, and old kernels with updated DTs may not even boot.
> 
> Also, I stronly suspect that there is more than two wake-up
> interrupts on these platforms, but I leave it to the maintainers
> to fix their mess.
> 

minor checkpatch warnings:

+WARNING: line over 80 characters
+#230: FILE: arch/arm/mach-exynos/suspend.c:208:
++	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+WARNING: line over 80 characters
+#274: FILE: arch/arm/mach-exynos/suspend.c:252:
++#define EXYNOS_PMU_IRQ(symbol,name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
+ERROR: space required after that ',' (ctx:VxV)
+#274: FILE: arch/arm/mach-exynos/suspend.c:252:
++#define EXYNOS_PMU_IRQ(symbol,name)	OF_DECLARE_2(irqchip, symbol, name, exynos_pmu_irq_init)
+                              ^
-- 
Regards,
Nishanth Menon
