From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 31 May 2016 00:56:36 +0200
Subject: [PATCH v5 4/6] acpi: Add GTDT table parse driver into ACPI driver
In-Reply-To: <1464096633-9309-5-git-send-email-fu.wei@linaro.org>
References: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
 <1464096633-9309-5-git-send-email-fu.wei@linaro.org>
Message-ID: <574CC524.5090601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2016 03:30 PM, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This driver adds support for parsing all kinds of timer in GTDT:
> (1)arch timer: provide a kernel API to parse all the PPIs and
> always-on info in GTDT and export them by filling the structs
> which provided by parameters(pointer of them).
>
> (2)memory-mapped timer: provide a kernel APIs to parse
> GT Block Structure in GTDT, export all the timer info by filling
> the struct which provided by parameter(pointer of the struct).
>
> (3)SBSA Generic Watchdog: parse all info in SBSA Generic Watchdog
> Structure in GTDT, and creating a platform device with that
> information. This allows the operating system to obtain device
> data from the resource of platform device.
> The platform device named "sbsa-gwdt" can be used by the ARM SBSA
> Generic Watchdog driver.
>
> By this driver, we can simplify all the relevant drivers, and
> separate all the ACPI GTDT knowledge from them.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Hi Fu Wei,

the code is better than the previous version but it is still confusing. 
There are global variables accessed several times by different functions 
and modified. This is an encapsulation issue.

This code is a bit hard to follow.

Please split it out into 4 patches:

1. Create a clean base with helper functions and proper encapsulation 
for gtdt.

2. Add gtdt timer based code

3. Add gtdt mem timer based code

4. Add gtdt watchdog based code

Comments below.

Thanks !

   -- Daniel

> ---
>   drivers/acpi/Kconfig                 |   9 +
>   drivers/acpi/Makefile                |   1 +
>   drivers/acpi/acpi_gtdt.c             | 309 +++++++++++++++++++++++++++++++++++
>   include/clocksource/arm_arch_timer.h |  16 ++
>   include/linux/acpi.h                 |   6 +
>   5 files changed, 341 insertions(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index b7e2e77..27a5cf9 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -521,4 +521,13 @@ config XPOWER_PMIC_OPREGION
>
>   endif
>
> +config ACPI_GTDT
> +	bool "ACPI GTDT Support"
> +	depends on ARM64
> +	help
> +	  GTDT (Generic Timer Description Table) provides information
> +	  for per-processor timers and Platform (memory-mapped) timers
> +	  for ARM platforms. Select this option to provide information
> +	  needed for the timers init.

Why not ARM64's Kconfig select ACPI_GTDT ?

This config option assumes an user will manually select this option 
which I believe it makes sense to have always on when ARM64=y. So why 
not create a silent option and select it directly from the ARM64 
platform Kconfig ?

>   endif	# ACPI
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 251ce85..848aa8a 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
>   obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
>   obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
>   obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
> +obj-$(CONFIG_ACPI_GTDT)		+= acpi_gtdt.o
>
>   video-objs			+= acpi_video.o video_detect.o
> diff --git a/drivers/acpi/acpi_gtdt.c b/drivers/acpi/acpi_gtdt.c
> new file mode 100644
> index 0000000..e54fadf
> --- /dev/null
> +++ b/drivers/acpi/acpi_gtdt.c
> @@ -0,0 +1,309 @@
> +/*
> + * ARM Specific GTDT table Support
> + *
> + * Copyright (C) 2015, Linaro Ltd.
> + * Author: Fu Wei <fu.wei@linaro.org>
> + *         Hanjun Guo <hanjun.guo@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <clocksource/arm_arch_timer.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "GTDT: " fmt
> +
> +typedef int (*platform_timer_handler)(void *platform_timer, int index,
> +				      void *data);
> +
> +static void *platform_timer_struct __initdata;
> +static u32 platform_timer_count __initdata;
> +static void *gtdt_end __initdata;

I am pretty sure you can get ride of these global variables with a 
little effort.

> +static int __init for_platform_timer(enum acpi_gtdt_type type,
> +				     platform_timer_handler handler, void *data)

For the clarity of the code, I suggest to use a macro with a name 
similar to what we find in the kernel:

#define gtdt_for_each(type, ...) ...
#define gtdt_for_each_timer gtdt_for_each(ACPI_GTDT_TYPE_TIMER_BLOCK)
#define gtdt_for_each_wd    gtdt_for_each(ACPI_GTDT_TYPE_WATCHDOG)

... and rework this function to clarify its purpose.

What is for ? Count the number of 'type' which succeed to call the handler ?

> +{
> +	struct acpi_gtdt_header *header;
> +	int i, index, ret;
> +	void *platform_timer = platform_timer_struct;
> +
> +	for (i = 0, index = 0; i < platform_timer_count; i++) {
> +		if (platform_timer > gtdt_end) {
> +			pr_err(FW_BUG "subtable pointer overflows.\n");
> +			platform_timer_count = i;

Fix firmware bug in the kernel ? No. Up to the firmware to fix it, "no 
handy, no candy".

> +			break;
> +		}
> +		header = (struct acpi_gtdt_header *)platform_timer;
> +		if (header->type == type) {
> +			ret = handler(platform_timer, index, data);
> +			if (ret)
> +				pr_err("failed to handler subtable %d.\n", i);
> +			else
> +				index++;
> +		}
> +		platform_timer += header->length;

That is not correct. This function is setting the platform_timer pointer 
to the end. Even if that works, it violates the encapsulation paradigm. 
Regarding how are used those global variables, please kill them and use 
proper parameter and structure encapsulation.

> +	}
> +
> +	return index;
> +}
> +
> +/*
> + * Get some basic info from GTDT table, and init the global variables above
> + * for all timers initialization of Generic Timer.
> + * This function does some validation on GTDT table, and will be run only once.
> + */
> +static void __init platform_timer_init(struct acpi_table_header *table,
> +				       struct acpi_table_gtdt *gtdt)
> +{
> +	gtdt_end = (void *)table + table->length;
> +
> +	if (table->revision < 2) {
> +		pr_info("Revision:%d doesn't support Platform Timers.\n",
> +			table->revision);
> +		return;
> +	}

This check should be called much sooner, before entering the gtdt 
subsystems. It is too late here.

> +	platform_timer_count = gtdt->platform_timer_count;
> +	if (!platform_timer_count) {
> +		pr_info("No Platform Timer structures.\n");
> +		return;
> +	}
> +
> +	platform_timer_struct = (void *)gtdt + gtdt->platform_timer_offset;
> +	if (platform_timer_struct < (void *)table +
> +				    sizeof(struct acpi_table_gtdt)) {
> +		pr_err(FW_BUG "Platform Timer pointer error.\n");
> +		platform_timer_struct = NULL;
> +		platform_timer_count = 0;
> +	}

Why this check ?

> +}
> +
> +static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
> +{
> +	int trigger, polarity;
> +
> +	if (!interrupt)
> +		return 0;
> +
> +	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
> +			: ACPI_LEVEL_SENSITIVE;
> +
> +	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
> +			: ACPI_ACTIVE_HIGH;
> +
> +	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
> +}
> +
> +/*
> + * Get the necessary info of arch_timer from GTDT table.
> + */
> +int __init gtdt_arch_timer_init(struct acpi_table_header *table, int *ppi,
> +				bool *c3stop, u32 *timer_count)
> +{
> +	struct acpi_table_gtdt *gtdt;

This API is not correctly separating both subsystems. Moving the code 
from the arch_arm_timer init function here is not the solution.

I suggest the following:

1. Change CLOCKSOURCE_ACPI_DECLARE to pass the init function as:

int __init gtdt_init(struct acpi_table_gtdt *gtdt);

2. Add helpers:

	int gtdt_map_irq(struct acpi_table_gtdt *gtdt, int flags);

	int gtdt_c3stop(struct acpi_table_gtdt *gtdt);

3. Export these helpers

arch_arm_timer.c should see nothing more than:

struct acpi_table_gtdt;

4. Use these helpers in the arch_arm_timer.c

static int __init arch_timer_acpi_init(struct acpi_table_gtdt *gtdt)
{
	arch_timer_ppi[PHYS_SECURE_PPI]    = gtdt_map_irq(gtdt, flags);
	arch_timer_ppi[PHYS_NONSECURE_PPI] = gtdt_map_irq(gtdt, flags);
	arch_timer_ppi[VIRT_PPI]           = gtdt_map_irq(gtdt, flags);
	arch_timer_ppi[HYP_PPI]            = gtdt_map_irq(gtdt, flags);
	arch_timer_c3stop                  = gtdt_c3stop(gtdt);

	arch_timer_init();

	return 0;
}

> +	if (acpi_disabled || !table || !ppi || !c3stop)
> +		return -EINVAL;

Why acpi_disabled is an error here but ok for gtdt_sbsa_gwdt_init() ?

> +	gtdt = container_of(table, struct acpi_table_gtdt, header);
> +	if (!gtdt) {
> +		pr_err("table pointer error.\n");
> +		return -EINVAL;
> +	}
> +
> +	ppi[PHYS_SECURE_PPI] =
> +		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
> +					    gtdt->secure_el1_flags);
> +
> +	ppi[PHYS_NONSECURE_PPI] =
> +		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
> +					    gtdt->non_secure_el1_flags);
> +
> +	ppi[VIRT_PPI] =
> +		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
> +					    gtdt->virtual_timer_flags);
> +
> +	ppi[HYP_PPI] =
> +		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
> +					    gtdt->non_secure_el2_flags);
> +
> +	*c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
> +
> +	platform_timer_init(table, gtdt);
> +	if (timer_count)
> +		*timer_count = platform_timer_count;

come on !

> +
> +	return 0;
> +}
> +
> +/*
> + * Helper function for getting the pointer of a timer frame in GT block.
> + */
> +static void __init *gtdt_gt_timer_frame(struct acpi_gtdt_timer_block *gt_block,
> +					int index)
> +{
> +	void *timer_frame = (void *)gt_block + gt_block->timer_offset +
> +			    sizeof(struct acpi_gtdt_timer_entry) * index;
> +
> +	if (timer_frame <= (void *)gt_block + gt_block->header.length -
> +			   sizeof(struct acpi_gtdt_timer_entry))
> +		return timer_frame;
> +
> +	return NULL;
> +}
> +
> +static int __init gtdt_parse_gt_block(void *platform_timer, int index,
> +				      void *data)
> +{
> +	struct acpi_gtdt_timer_block *block;
> +	struct acpi_gtdt_timer_entry *frame;
> +	struct gt_block_data *block_data;
> +	int i, j;
> +
> +	if (!platform_timer || !data)
> +		return -EINVAL;
> +
> +	block = platform_timer;
> +	block_data = data + sizeof(struct gt_block_data) * index;
> +
> +	if (!block->block_address || !block->timer_count) {
> +		pr_err(FW_BUG "invalid GT Block data.\n");
> +		return -EINVAL;
> +	}
> +	block_data->cntctlbase_phy = (phys_addr_t)block->block_address;
> +	block_data->timer_count = block->timer_count;
> +
> +	/*
> +	 * Get the GT timer Frame data for every GT Block Timer
> +	 */
> +	for (i = 0, j = 0; i < block->timer_count; i++) {
> +		frame = gtdt_gt_timer_frame(block, i);
> +		if (!frame || !frame->base_address || !frame->timer_interrupt) {
> +			pr_err(FW_BUG "invalid GT Block Timer data, skip.\n");
> +			continue;
> +		}
> +		block_data->timer[j].frame_nr = frame->frame_number;
> +		block_data->timer[j].cntbase_phy = frame->base_address;
> +		block_data->timer[j].irq = map_generic_timer_interrupt(
> +						   frame->timer_interrupt,
> +						   frame->timer_flags);
> +		if (frame->virtual_timer_interrupt)
> +			block_data->timer[j].virt_irq =
> +				map_generic_timer_interrupt(
> +					frame->virtual_timer_interrupt,
> +					frame->virtual_timer_flags);
> +		j++;
> +	}
> +
> +	if (j)
> +		return 0;
> +
> +	block_data->cntctlbase_phy = (phys_addr_t)NULL;
> +	block_data->timer_count = 0;
> +
> +	return -EINVAL;
> +}
> +
> +/*
> + * Get the GT block info for memory-mapped timer from GTDT table.
> + * Please make sure we have called gtdt_arch_timer_init, because it helps to
> + * init the global variables.
> + */
> +int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
> +{
> +	int ret = for_platform_timer(ACPI_GTDT_TYPE_TIMER_BLOCK,
> +				     gtdt_parse_gt_block, (void *)data);

(void *) explicit cast is not needed.

> +	pr_info("found %d memory-mapped timer block.\n", ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * Initialize a SBSA generic Watchdog platform device info from GTDT
> + */
> +static int __init gtdt_import_sbsa_gwdt(void *platform_timer,
> +					int index, void *data)
> +{
> +	struct platform_device *pdev;
> +	struct acpi_gtdt_watchdog *wd = platform_timer;
> +	int irq = map_generic_timer_interrupt(wd->timer_interrupt,
> +					      wd->timer_flags);
> +	int no_irq = 1;
> +
> +	/*
> +	 * According to SBSA specification the size of refresh and control
> +	 * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 ? 0xFFF).
> +	 */
> +	struct resource res[] = {
> +		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
> +		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
> +		DEFINE_RES_IRQ(irq),
> +	};
> +
> +	pr_debug("a Watchdog GT(0x%llx/0x%llx gsi:%u flags:0x%x).\n",
> +		 wd->refresh_frame_address, wd->control_frame_address,
> +		 wd->timer_interrupt, wd->timer_flags);
> +
> +	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
> +		pr_err(FW_BUG "failed getting the Watchdog GT frame addr.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!wd->timer_interrupt)
> +		pr_warn(FW_BUG "failed getting the Watchdog GT GSIV.\n");
> +	else if (irq <= 0)
> +		pr_warn("failed to map the Watchdog GT GSIV.\n");
> +	else
> +		no_irq = 0;
> +
> +	/*
> +	 * Add a platform device named "sbsa-gwdt" to match the platform driver.
> +	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
> +	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get device
> +	 * info below by matching this name.
> +	 */
> +	pdev = platform_device_register_simple("sbsa-gwdt", index, res,
> +					       ARRAY_SIZE(res) - no_irq);
> +	if (IS_ERR(pdev)) {
> +		acpi_unregister_gsi(wd->timer_interrupt);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init gtdt_sbsa_gwdt_init(void)
> +{
> +	struct acpi_table_header *table;
> +	struct acpi_table_gtdt *gtdt;
> +	int ret;
> +
> +	if (acpi_disabled)
> +		return 0;
> +
> +	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
> +		return -EINVAL;
> +
> +	/* global variables initialization */
> +	gtdt_end = (void *)table + table->length;

That is prone to bug. The end of the table is computed here and stored 
in the global variable and then computed again in platform_timer_init 
and also stored in the global variable.

Kill this global variable.

> +	gtdt = container_of(table, struct acpi_table_gtdt, header);
> +	platform_timer_struct = (void *)gtdt + gtdt->platform_timer_offset;
> +
> +	ret = for_platform_timer(ACPI_GTDT_TYPE_WATCHDOG,
> +				 gtdt_import_sbsa_gwdt, NULL);
> +	pr_info("found %d SBSA generic Watchdog.\n", ret);
> +
> +	return 0;
> +}
> +
> +device_initcall(gtdt_sbsa_gwdt_init);

Do you really have to call device_initcall ?


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
