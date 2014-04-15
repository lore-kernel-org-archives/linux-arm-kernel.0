From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Apr 2014 14:30:55 +0200
Subject: [PATCH 1/5] ARM: Add platform support for LSI AXM55xx SoC
In-Reply-To: <80a2523d3e266ed12d5b70ac5518e963e47b27f4.1397552154.git.anders.berg@lsi.com>
References: <cover.1397552154.git.anders.berg@lsi.com>
 <80a2523d3e266ed12d5b70ac5518e963e47b27f4.1397552154.git.anders.berg@lsi.com>
Message-ID: <6049946.vOU2aBg9qY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 14:06:10 Anders Berg wrote:

> diff --git a/arch/arm/mach-axxia/Kconfig b/arch/arm/mach-axxia/Kconfig
> new file mode 100644
> index 0000000..336426a
> --- /dev/null
> +++ b/arch/arm/mach-axxia/Kconfig
> @@ -0,0 +1,19 @@
> +config ARCH_AXXIA
> +	bool "LSI Axxia platforms" if (ARCH_MULTI_V7 && ARM_LPAE)
> +	select ARM_GIC
> +	select HAVE_SMP
> +	select MFD_SYSCON
> +	select ARM_AMBA
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select HAVE_ARM_ARCH_TIMER
> +	select ARM_TIMER_SP804
> +	select ZONE_DMA
> +	select ARCH_DMA_ADDR_T_64BIT
> +	select ARCH_SUPPORTS_BIG_ENDIAN
> +	select MIGHT_HAVE_PCI
> +	select PCI_DOMAINS if PCI

No need to select HAVE_SMP or ARCH_WANT_OPTIONAL_GPIOLIB any more.

We should rethink the ARCH_SUPPORTS_BIG_ENDIAN option I guess. It makes
little sense to select that from one platform in a multiplatform build
if other platforms don't support it.

> --- /dev/null
> +++ b/arch/arm/mach-axxia/Makefile.boot
> @@ -0,0 +1,2 @@
> +   zreladdr-y	+= 0x00308000
> +params_phys-y	:= 0x00300100

This won't be used, since AUTO_ZRELADDR is set by ARCH_MULTIPLATFORM.

> diff --git a/arch/arm/mach-axxia/axxia.c b/arch/arm/mach-axxia/axxia.c
> new file mode 100644
> index 0000000..8d85926
> --- /dev/null
> +++ b/arch/arm/mach-axxia/axxia.c
> @@ -0,0 +1,117 @@
> +/*
> + * Support for the LSI Axxia SoC devices based on ARM cores.
> + *
> + * Copyright (C) 2012 LSI
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/amba/bus.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +#include <linux/sizes.h>
> +#include <asm/mach/arch.h>
> +#include <asm/pmu.h>
> +#include "axxia.h"
> +
> +/*
> + * The PMU IRQ lines of four cores are wired together into a single interrupt.
> + * Bounce the interrupt to other cores if it's not ours.
> + */
> +static irqreturn_t axxia_pmu_handler(int irq, void *dev, irq_handler_t handler)
> +{
> +	irqreturn_t ret = handler(irq, dev);
> +
> +	if (ret == IRQ_NONE) {
> +		int cpu = smp_processor_id();
> +		int cluster = cpu / CORES_PER_CLUSTER;
> +		int other;
> +
> +		/* Look until we find another cpu that's online. */
> +		do {
> +			other = (++cpu % CORES_PER_CLUSTER) +
> +				(cluster * CORES_PER_CLUSTER);
> +		} while (!cpu_online(other));
> +
> +		irq_set_affinity(irq, cpumask_of(other));
> +	}
> +
> +	/*
> +	 * We should be able to get away with the amount of IRQ_NONEs we give,
> +	 * while still having the spurious IRQ detection code kick in if the
> +	 * interrupt really starts hitting spuriously.
> +	 */
> +	return ret;
> +}
> +
> +static struct arm_pmu_platdata pmu_pdata = {
> +	.handle_irq = axxia_pmu_handler,
> +};
> +
> +static struct of_dev_auxdata axxia_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("arm,cortex-a15-pmu", 0, "pmu", &pmu_pdata),
> +	{}
> +};

This looks similar to what we have in mach-ux500 as db8500_pmu_handler.

To avoid duplication, I'd prefer moving support for this into the
perf_event code itself, and get rid of the auxdata.

> +static int
> +axxia_bus_notifier(struct notifier_block *nb, unsigned long event, void *obj)
> +{
> +	struct device *dev = obj;
> +
> +	if (event != BUS_NOTIFY_ADD_DEVICE)
> +		return NOTIFY_DONE;
> +
> +	if (!of_property_read_bool(dev->of_node, "dma-coherent"))
> +		return NOTIFY_DONE;
> +
> +	set_dma_ops(dev, &arm_coherent_dma_ops);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block axxia_platform_nb = {
> +	.notifier_call = axxia_bus_notifier,
> +};
> +
> +static struct notifier_block axxia_amba_nb = {
> +	.notifier_call = axxia_bus_notifier,
> +};

And we definitely want to do this in a generic fashion. That should not be in
platform specific code.

> +static const char *axxia_dt_match[] __initconst = {
> +	"lsi,axm55xx",
> +	"lsi,axm55xx-sim",
> +	"lsi,axm55xx-emu",
> +	NULL
> +};

Please no 'xx' in compatible strings. You can list all the relevant
model numbers here, or require that machines list a specific model
as compatible, e.g.

	compatible = "lsi,axm5510-sim", "lsi,axm5510", "lsi,axm5502";

> +
> +DT_MACHINE_START(AXXIA_DT, "LSI Axxia AXM55XX")
> +	.dt_compat	= axxia_dt_match,
> +	.smp		= smp_ops(axxia_smp_ops),
> +	.init_machine	= axxia_dt_init,
> +MACHINE_END

Please have a look at how smp ops are hooked up in mach-qcom and see
if you can do it that way as well.

> diff --git a/arch/arm/mach-axxia/axxia.h b/arch/arm/mach-axxia/axxia.h
> new file mode 100644
> index 0000000..594dd97
> --- /dev/null
> +++ b/arch/arm/mach-axxia/axxia.h
> @@ -0,0 +1,42 @@
> +/*
> + * Prototypes for platform functions.
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef __AXXIA_H
> +#define __AXXIA_H
> +
> +#define CORES_PER_CLUSTER      4
> +
> +#define AXXIA_PERIPH_PHYS      0x2000000000ULL
> +#define AXXIA_SYSCON_PHYS      0x2010030000ULL

Remove these -- they have to come from DT.

> +#if 0
> +#define AXXIA_UART0_PHYS       0x2010080000ULL
> +#define AXXIA_UART1_PHYS       0x2010081000ULL
> +#define AXXIA_UART2_PHYS       0x2010082000ULL
> +#define AXXIA_UART3_PHYS       0x2010083000ULL
> +
> +#ifdef CONFIG_DEBUG_LL
> +#define AXXIA_DEBUG_UART_VIRT  0xf0080000
> +#define AXXIA_DEBUG_UART_PHYS  AXXIA_UART0_PHYS
> +#endif
> +#endif

You can put these constants directly into debug code.


> diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
> new file mode 100644
> index 0000000..fd7f507
> --- /dev/null
> +++ b/arch/arm/mach-axxia/platsmp.c
> @@ -0,0 +1,183 @@
> +/*
> + *  linux/arch/arm/mach-axxia/platsmp.c
> + *
> + *  Copyright (C) 2012 LSI Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Have you considered using PSCI to bring up the secondary CPUs?

> +static int axxia_boot_secondary(unsigned int cpu,
> +					  struct task_struct *idle)
> +{
> +	unsigned long timeout;
> +
> +	/* Release the specified core */
> +	write_pen_release(cpu_logical_map(cpu));
> +
> +	/* Send a wakeup event to get the idled cpu out of WFE state */
> +	dsb_sev();
> +
> +	/* Wait for so long, then give up if nothing happens ... */
> +	timeout = jiffies + (1 * HZ);
> +	while (time_before(jiffies, timeout)) {
> +		/* Make sure stores to pen_release have completed */
> +		smp_rmb();
> +		if (pen_release == -1)
> +			break;
> +		udelay(1);
> +	}
> +
> +	return pen_release != -1 ? -ENOSYS : 0;
> +}

This is pretty sad. No hardware support for waking up CPUs?

> +static void __init axxia_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	void __iomem *syscon;
> +	int cpu_count = 0;
> +	int cpu;
> +
> +	syscon = ioremap(AXXIA_SYSCON_PHYS, SZ_64K);
> +	if (WARN_ON(!syscon))
> +		return;
> +
> +	check_fixup_sev(syscon);

Please use the syscon driver and regmap. That driver might need a little
help to get syscon_node_to_regmap() to work before driver initialization,
but other people need the same thing, and we should just implement it.

> diff --git a/drivers/clk/clk-axxia.c b/drivers/clk/clk-axxia.c
> new file mode 100644
> index 0000000..996b8f2
> --- /dev/null
> +++ b/drivers/clk/clk-axxia.c
> @@ -0,0 +1,281 @@
> +/*
> + * arch/arm/mach-axxia/clock.c

This should be a separate patch, and get merged by the clk maintainer.

	Arnd
