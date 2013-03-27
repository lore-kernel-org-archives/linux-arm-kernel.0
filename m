From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 09:59:51 +0100
Subject: [PATCH v2 08/10] arm: zynq: Add smp support
In-Reply-To: <aca1f5cbb12e95a294bf35bfbd9f6564bcafd5f0.1364319776.git.michal.simek@xilinx.com>
References: <dcbc38c6f1e319a31693ef0d69195fafc42a5de0.1364319776.git.michal.simek@xilinx.com>
 <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <aca1f5cbb12e95a294bf35bfbd9f6564bcafd5f0.1364319776.git.michal.simek@xilinx.com>
Message-ID: <CAHTX3dJqMhnKe+eyDw_PuxqQYZ8bqyrhRCE_+b1b4TrQo7YMZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/26 Michal Simek <michal.simek@xilinx.com>:
> Zynq is dual core Cortex A9 which starts always
> at zero. Using simple trampoline ensure long jump
> to secondary_startup code.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> v2: Remove boot_lock from secondary_init
>     Incorporate Steffen changes in smp code
>     Use flush range instead of simple flush
>     Add HAVE_SMP
>     Add support for the booting kernels with
>       non zero starting address
> ---
>  arch/arm/mach-zynq/Kconfig   |    1 +
>  arch/arm/mach-zynq/Makefile  |    1 +
>  arch/arm/mach-zynq/common.c  |    1 +
>  arch/arm/mach-zynq/common.h  |   11 ++++
>  arch/arm/mach-zynq/headsmp.S |   24 +++++++
>  arch/arm/mach-zynq/platsmp.c |  149 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-zynq/slcr.c    |   29 ++++++++
>  7 files changed, 216 insertions(+)
>  create mode 100644 arch/arm/mach-zynq/headsmp.S
>  create mode 100644 arch/arm/mach-zynq/platsmp.c
>
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index d70651e..f4a7e63 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -8,6 +8,7 @@ config ARCH_ZYNQ
>         select ICST
>         select MIGHT_HAVE_CACHE_L2X0
>         select USE_OF
> +       select HAVE_SMP
>         select SPARSE_IRQ
>         select CADENCE_TTC_TIMER
>         help
> diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
> index 13ee09b..b595d22 100644
> --- a/arch/arm/mach-zynq/Makefile
> +++ b/arch/arm/mach-zynq/Makefile
> @@ -4,3 +4,4 @@
>
>  # Common support
>  obj-y                          := common.o slcr.o
> +obj-$(CONFIG_SMP)              += headsmp.o platsmp.o
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 4ad3560..da93957 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -104,6 +104,7 @@ static const char *xilinx_dt_match[] = {
>  };
>
>  MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
> +       .smp            = smp_ops(zynq_smp_ops),
>         .map_io         = xilinx_map_io,
>         .init_irq       = irqchip_init,
>         .init_machine   = xilinx_init_machine,
> diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
> index e5628f7..33cdc23 100644
> --- a/arch/arm/mach-zynq/common.h
> +++ b/arch/arm/mach-zynq/common.h
> @@ -19,6 +19,17 @@
>
>  extern int slcr_init(void);
>  extern void slcr_system_reset(void);
> +extern void slcr_cpu_stop(int cpu);
> +extern void slcr_cpu_start(int cpu);
> +
> +#ifdef CONFIG_SMP
> +extern void secondary_startup(void);
> +extern char zynq_secondary_trampoline;
> +extern char zynq_secondary_trampoline_jump;
> +extern char zynq_secondary_trampoline_end;
> +extern int __cpuinit zynq_cpun_start(u32 address, int cpu);
> +extern struct smp_operations zynq_smp_ops __initdata;
> +#endif
>
>  extern void __iomem *zynq_slcr_base;
>  extern void __iomem *scu_base;
> diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
> new file mode 100644
> index 0000000..d183cd2
> --- /dev/null
> +++ b/arch/arm/mach-zynq/headsmp.S
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (c) 2013 Steffen Trumtrar <s.trumtrar@pengutronix.de>
> + * Copyright (c) 2012-2013 Xilinx
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +
> +       __CPUINIT
> +
> +ENTRY(zynq_secondary_trampoline)
> +       ldr     r0, [pc]
> +       bx      r0
> +.globl zynq_secondary_trampoline_jump
> +zynq_secondary_trampoline_jump:
> +       /* Space for jumping address */
> +       .word   /* cpu 1 */
> +.globl zynq_secondary_trampoline_end
> +zynq_secondary_trampoline_end:
> +
> +ENDPROC(zynq_secondary_trampoline)
> diff --git a/arch/arm/mach-zynq/platsmp.c b/arch/arm/mach-zynq/platsmp.c
> new file mode 100644
> index 0000000..062b319
> --- /dev/null
> +++ b/arch/arm/mach-zynq/platsmp.c
> @@ -0,0 +1,149 @@
> +/*
> + * This file contains Xilinx specific SMP code, used to start up
> + * the second processor.
> + *
> + * Copyright (C) 2011-2013 Xilinx
> + *
> + * based on linux/arch/arm/mach-realview/platsmp.c
> + *
> + * Copyright (C) 2002 ARM Ltd.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/jiffies.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <asm/cacheflush.h>
> +#include <asm/smp_scu.h>
> +#include <linux/irqchip/arm-gic.h>
> +#include "common.h"
> +
> +/*
> + * Store number of cores in the system
> + * Because of scu_get_core_count() must be in __init section and can't
> + * be called from zynq_cpun_start() because it is in __cpuinit section.
> + */
> +static int ncores;
> +
> +/* Secondary CPU kernel startup is a 2 step process. The primary CPU
> + * starts the secondary CPU by giving it the address of the kernel and
> + * then sending it an event to wake it up. The secondary CPU then
> + * starts the kernel and tells the primary CPU it's up and running.
> + */
> +static void __cpuinit zynq_secondary_init(unsigned int cpu)
> +{
> +       /*
> +        * if any interrupts are already enabled for the primary
> +        * core (e.g. timer irq), then they will not have been enabled
> +        * for us: do so
> +        */
> +       gic_secondary_init(0);
> +}
> +
> +int __cpuinit zynq_cpun_start(u32 address, int cpu)
> +{
> +       u32 trampoline_code_size = &zynq_secondary_trampoline_end -
> +                                               &zynq_secondary_trampoline;
> +
> +       if (cpu > ncores) {
> +               pr_warn("CPU No. is not available in the system\n");
> +               return -1;
> +       }
> +
> +       /* MS: Expectation that SLCR are directly map and accessible */
> +       /* Not possible to jump to non aligned address */
> +       if (!(address & 3) && (!address || (address >= trampoline_code_size))) {
> +               /* Store pointer to ioremap area which points to address 0x0 */
> +               static u8 __iomem *zero;
> +               u32 trampoline_size = &zynq_secondary_trampoline_jump -
> +                                               &zynq_secondary_trampoline;
> +
> +               slcr_cpu_stop(cpu);
> +
> +               if (__pa(PAGE_OFFSET)) {
> +                       zero = ioremap(0, trampoline_code_size);
> +                       if (!zero) {
> +                               pr_warn("BOOTUP jump vectors not accessible\n");
> +                               return -1;
> +                       }
> +               } else {
> +                       zero = (__force u8 __iomem *)PAGE_OFFSET;
> +               }
> +
> +               /*
> +                * This is elegant way how to jump to any address
> +                * 0x0: Load address at 0x8 to r0
> +                * 0x4: Jump by mov instruction
> +                * 0x8: Jumping address
> +                */
> +               memcpy((__force void *)zero, &zynq_secondary_trampoline,
> +                                               trampoline_size);
> +               writel(address, zero + trampoline_size + sizeof(int));

Please remove this  + sizeof(int). I forget to remove it from this version.
Because I tested Rob's idea to have jump table based on cpu id.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
