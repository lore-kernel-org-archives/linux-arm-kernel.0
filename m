From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Fri, 3 Sep 2010 12:08:28 +0530
Subject: [PATCH 05/74] ST SPEAr13XX: Adding machine specific src files
In-Reply-To: <20100902090441.GG26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<eb082b464d0443940a4ba55e48f69f018f6761b6.1283161023.git.viresh.kumar@st.com>
	<20100902090441.GG26319@n2100.arm.linux.org.uk>
Message-ID: <4C8097E4.2090304@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On 9/2/2010 2:34 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 30, 2010 at 04:08:36PM +0530, Viresh KUMAR wrote:
>> diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
>> new file mode 100644
>> index 0000000..8b75d1b
>> --- /dev/null
>> +++ b/arch/arm/mach-spear13xx/platsmp.c
>> @@ -0,0 +1,203 @@
>> +/*
>> + * arch/arm/mach-spear13xx/platsmp.c
>> + *
>> + * based upon linux/arch/arm/mach-realview/platsmp.c
>> + *
>> + * Copyright (C) 2010 ST Microelectronics Ltd.
>> + * Shiraz Hashim <shiraz.hashim@st.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <asm/cacheflush.h>
>> +#include <asm/hardware/gic.h>
>> +#include <asm/localtimer.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/smp_scu.h>
>> +#include <asm/unified.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/smp.h>
>> +#include <mach/generic.h>
>> +#include <mach/hardware.h>
> 
> linux/ before asm/ before mach/ please. 

OK. Would check it across.

>> +
>> +/*
>> + * control for which core is the next to come out of the secondary
>> + * boot "holding pen"
>> + */
>> +volatile int __cpuinitdata pen_release = -1;
>> +static DEFINE_SPINLOCK(boot_lock);
>> +
>> +static void __iomem *scu_base_addr(void)
>> +{
>> +     return __io_address(SPEAR13XX_SCU_BASE);
>> +}
>> +
>> +static inline unsigned int get_core_count(void)
>> +{
>> +     void __iomem *scu_base = scu_base_addr();
>> +
>> +     if (scu_base)
>> +             return scu_get_core_count(scu_base);
>> +     return 1;
>> +}
>> +
>> +void __cpuinit platform_secondary_init(unsigned int cpu)
>> +{
>> +     trace_hardirqs_off();
>> +
>> +     /*
>> +      * if any interrupts are already enabled for the primary
>> +      * core (e.g. timer irq), then they will not have been enabled
>> +      * for us: do so
>> +      */
>> +     gic_cpu_init(0, __io_address(SPEAR13XX_GIC_CPU_BASE));
>> +
>> +     /*
>> +      * let the primary processor know we're out of the
>> +      * pen, then head off into the C entry point
>> +      */
>> +     pen_release = -1;
>> +     smp_wmb();
>> +
>> +     /*
>> +      * Synchronise with the boot thread.
>> +      */
>> +     spin_lock(&boot_lock);
>> +     spin_unlock(&boot_lock);
>> +}
>> +
>> +int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>> +{
>> +     unsigned long timeout;
>> +
>> +     /*
>> +      * set synchronisation state between this boot processor
>> +      * and the secondary one
>> +      */
>> +     spin_lock(&boot_lock);
>> +
>> +     /*
>> +      * The secondary processor is waiting to be released from
>> +      * the holding pen - release it, then wait for it to flag
>> +      * that it has been released by resetting pen_release.
>> +      *
>> +      * Note that "pen_release" is the hardware CPU ID, whereas
>> +      * "cpu" is Linux's internal ID.
>> +      */
>> +
>> +     /*
>> +      * Note: Following is important otherwise cpu2 doesn't come up
>> +      * as secondary_data must be flushed before pen_release also
>> +      */
>> +
>> +     flush_cache_all();
> 
> You don't need this.  secondary_data is already taken care of as of a
> few kernel releases ago.
> 

OK.

>> +     pen_release = cpu;
>> +     flush_cache_all();
>> +
>> +     timeout = jiffies + (1 * HZ);
>> +     while (time_before(jiffies, timeout)) {
>> +             smp_rmb();
>> +             if (pen_release == -1)
>> +                     break;
>> +
>> +             udelay(10);
>> +     }
>> +
>> +     /*
>> +      * now the secondary core is starting up let it run its
>> +      * calibrations, then wait for it to finish
>> +      */
>> +     spin_unlock(&boot_lock);
>> +
>> +     return pen_release != -1 ? -ENOSYS : 0;
>> +}
>> +
>> +static void __init poke_milo(void)
>> +{
>> +     /* nobody is to be released from the pen yet */
>> +     pen_release = -1;
>> +
>> +     /*
>> +      * Write the address of secondary startup into the system-wide
>> +      * location (presently it is in SRAM). The BootMonitor waits
>> +      * for this register to become non-zero.
>> +      */
>> +     __raw_writel(BSYM(virt_to_phys(spear13xx_secondary_startup)),
>> +                     __io_address(SPEAR13XX_SYS_LOCATION));
>> +
>> +     mb();
> 
> Please get rid of this function.  You don't have milo, and milo is pretty
> much dead anyway.  Please read the Versatile Express SMP code and base
> your version off that (cleaned up) version instead.
> 

OK. I would refer the code.

>> +}
>> +
>> +/*
>> + * Initialise the CPU possible map early - this describes the CPUs
>> + * which may be present or become present in the system.
>> + */
>> +void __init smp_init_cpus(void)
>> +{
>> +     unsigned int i, ncores = get_core_count();
>> +
>> +     for (i = 0; i < ncores; i++)
>> +             set_cpu_possible(i, true);
>> +}
>> +
>> +void __init smp_prepare_cpus(unsigned int max_cpus)
>> +{
>> +     unsigned int ncores = get_core_count();
>> +     unsigned int cpu = smp_processor_id();
>> +     int i;
>> +
>> +     /* sanity check */
>> +     if (ncores == 0) {
>> +             pr_err("Realview: strange CM count of 0? Default to 1\n");
>> +
>> +             ncores = 1;
>> +     }
>> +
>> +     if (ncores > num_possible_cpus()) {
>> +             ncores = num_possible_cpus();
>> +             pr_err(
>> +                    "spear13xx: no. of cores (%d) greater than configured "
>> +                    "maximum of %d - clipping\n",
>> +                    ncores, ncores);
>> +     }
>> +
>> +     smp_store_cpu_info(cpu);
>> +
>> +     /*
>> +      * are we trying to boot more cores than exist?
>> +      */
>> +     if (max_cpus > ncores)
>> +             max_cpus = ncores;
>> +
>> +     /*
>> +      * Initialise the present map, which describes the set of CPUs
>> +      * actually populated at the present time.
>> +      */
>> +     for (i = 0; i < max_cpus; i++)
>> +             set_cpu_present(i, true);
>> +
>> +     /*
>> +      * Initialise the SCU if there are more than one CPU and let
>> +      * them know where to start. Note that, on modern versions of
>> +      * MILO, the "poke" doesn't actually do anything until each
>> +      * individual core is sent a soft interrupt to get it out of
>> +      * WFI
>> +      */
>> +     if (max_cpus > 1) {
>> +             /*
>> +              * Enable the local timer or broadcast device for the
>> +              * boot CPU, but only if we have more than one CPU.
>> +              */
>> +             percpu_timer_setup();
>> +
>> +             scu_enable(scu_base_addr());
>> +             poke_milo();
>> +     }
>> +}
>> diff --git a/arch/arm/mach-spear13xx/spear1300.c b/arch/arm/mach-spear13xx/spear1300.c
>> new file mode 100644
>> index 0000000..c1b82f1
>> --- /dev/null
>> +++ b/arch/arm/mach-spear13xx/spear1300.c
>> @@ -0,0 +1,23 @@
>> +/*
>> + * arch/arm/mach-spear13xx/spear1300.c
>> + *
>> + * SPEAr1300 machine source file
>> + *
>> + * Copyright (C) 2010 ST Microelectronics
>> + * Shiraz Hashim <shiraz.hashim@st.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <mach/generic.h>
>> +#include <mach/spear.h>
>> +
>> +/* Add spear1300 specific devices here */
>> +
>> +void __init spear1300_init(void)
>> +{
>> +     /* call spear13xx family common init function */
>> +     spear13xx_init();
>> +}
>> diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
>> new file mode 100644
>> index 0000000..d72c8a8
>> --- /dev/null
>> +++ b/arch/arm/mach-spear13xx/spear1300_evb.c
>> @@ -0,0 +1,48 @@
>> +/*
>> + * arch/arm/mach-spear13xx/spear1300_evb.c
>> + *
>> + * SPEAr1300 evaluation board source file
>> + *
>> + * Copyright (C) 2010 ST Microelectronics
>> + * Shiraz Hashim <shiraz.hashim@st.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach-types.h>
>> +#include <mach/generic.h>
>> +#include <mach/spear.h>
>> +
>> +static struct amba_device *amba_devs[] __initdata = {
>> +     &uart_device,
>> +};
>> +
>> +static struct platform_device *plat_devs[] __initdata = {
>> +};
>> +
>> +static void __init spear1300_evb_init(void)
>> +{
>> +     unsigned int i;
>> +
>> +     /* call spear1300 machine init function */
>> +     spear1300_init();
>> +
>> +     /* Add Platform Devices */
>> +     platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
>> +
>> +     /* Add Amba Devices */
>> +     for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
>> +             amba_device_register(amba_devs[i], &iomem_resource);
>> +}
>> +
>> +MACHINE_START(SPEAR1300, "ST-SPEAR1300-EVB")
>> +     .boot_params    =       0x00000100,
>> +     .map_io         =       spear13xx_map_io,
>> +     .init_irq       =       spear13xx_init_irq,
>> +     .timer          =       &spear13xx_timer,
>> +     .init_machine   =       spear1300_evb_init,
>> +MACHINE_END
>> diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
>> new file mode 100644
>> index 0000000..d11e300
>> --- /dev/null
>> +++ b/arch/arm/mach-spear13xx/spear13xx.c
>> @@ -0,0 +1,98 @@
>> +/*
>> + * arch/arm/mach-spear13xx/spear13xx.c
>> + *
>> + * SPEAr13XX machines common source file
>> + *
>> + * Copyright (C) 2010 ST Microelectronics
>> + * Shiraz Hashim <shiraz.hashim@st.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/ptrace.h>
>> +#include <linux/io.h>
>> +#include <asm/hardware/gic.h>
>> +#include <asm/irq.h>
>> +#include <asm/localtimer.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/smp_twd.h>
>> +#include <mach/irqs.h>
>> +#include <mach/generic.h>
>> +#include <mach/hardware.h>
> 
> So do you need all these includes?
> 

I would cross check and eliminate un-necessary ones.

>> +
>> +/* Add spear13xx machines common devices here */
>> +/* uart device registeration */
>> +struct amba_device uart_device = {
>> +     .dev = {
>> +             .init_name = "uart",
>> +     },
>> +     .res = {
>> +             .start = SPEAR13XX_UART_BASE,
>> +             .end = SPEAR13XX_UART_BASE + SZ_4K - 1,
>> +             .flags = IORESOURCE_MEM,
>> +     },
>> +     .irq = {IRQ_UART, NO_IRQ},
>> +};
>> +
>> +/* Do spear13xx familiy common initialization part here */
>> +void __init spear13xx_init(void)
>> +{
>> +     /* nothing to do for now */
>> +}
>> +
>> +/* This will initialize vic */
>> +void __init spear13xx_init_irq(void)
>> +{
>> +     gic_dist_init(0, __io_address(SPEAR13XX_GIC_DIST_BASE), 29);
>> +     gic_cpu_init(0, __io_address(SPEAR13XX_GIC_CPU_BASE));
>> +}
>> +
>> +/* Following will create static virtual/physical mappings */
>> +struct map_desc spear13xx_io_desc[] __initdata = {
>> +     {
>> +             .virtual        = IO_ADDRESS(SPEAR13XX_UART_BASE),
>> +             .pfn            = __phys_to_pfn(SPEAR13XX_UART_BASE),
>> +             .length         = SZ_4K,
>> +             .type           = MT_DEVICE
>> +     }, {
>> +             .virtual        = IO_ADDRESS(SPEAR13XX_A9SM_PERIP_BASE),
>> +             .pfn            = __phys_to_pfn(SPEAR13XX_A9SM_PERIP_BASE),
>> +             .length         = SZ_8K,
>> +             .type           = MT_DEVICE
>> +     }, {
>> +             .virtual        = IO_ADDRESS(SPEAR13XX_MISC_BASE),
>> +             .pfn            = __phys_to_pfn(SPEAR13XX_MISC_BASE),
>> +             .length         = SZ_8K,
>> +             .type           = MT_DEVICE
>> +     }, {
>> +             .virtual        = IO_ADDRESS(SPEAR13XX_SYSRAM0_BASE),
>> +             .pfn            = __phys_to_pfn(SPEAR13XX_SYSRAM0_BASE),
>> +             .length         = SZ_32K,
>> +             .type           = MT_DEVICE
>> +     },
>> +};
>> +
>> +/* This will create static memory mapping for selected devices */
>> +void __init spear13xx_map_io(void)
>> +{
>> +     iotable_init(spear13xx_io_desc, ARRAY_SIZE(spear13xx_io_desc));
>> +
>> +     /* This will initialize clock framework */
>> +     clk_init();
>> +}
>> +
>> +static void __init spear13xx_timer_init(void)
>> +{
>> +#ifdef CONFIG_LOCAL_TIMERS
>> +     /* Setup the local timer base */
>> +     twd_base = __io_address(SPEAR13XX_LOCAL_TMR_BASE);
>> +#endif
>> +     spear_setup_timer();
>> +}
>> +
>> +struct sys_timer spear13xx_timer = {
>> +     .init = spear13xx_timer_init,
>> +};
>> --
>> 1.7.2.2

regards
Shiraz
