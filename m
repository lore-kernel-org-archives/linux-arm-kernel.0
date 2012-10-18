From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 17 Oct 2012 22:34:03 -0500
Subject: [PATCHv1] arm:socfpga: Enable SMP for socfpga
In-Reply-To: <507F01FD.6070403@gmail.com>
References: <1350501498-23601-1-git-send-email-dinguyen@altera.com>
 <507F01FD.6070403@gmail.com>
Message-ID: <CADhT+wcJmwRMeNugWdgY+aU4EGE-y48R6OePTq==TjZajuxfeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Oct 17, 2012 at 2:07 PM, Rob Herring <robherring2@gmail.com> wrote:
>
> On 10/17/2012 02:18 PM, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> >
> > Enable SMP for the SOCFPGA platform.
> >
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > ---
> >  arch/arm/boot/dts/socfpga.dtsi            |   10 ++
> >  arch/arm/configs/socfpga_defconfig        |    9 +-
>
> Does the multi_v7_defconfig not work for you?

It does. Are you planning to remove the defconfigs the platforms that
are part of
multi_v7_defconfig soon? socfpga_defconfig is broken with SMP enabled because
it needs +# CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set.

>
> >  arch/arm/mach-socfpga/Kconfig             |    1 +
> >  arch/arm/mach-socfpga/Makefile            |    3 +
> >  arch/arm/mach-socfpga/headsmp.S           |   64 +++++++++++
> >  arch/arm/mach-socfpga/include/mach/core.h |   33 ++++++
>
> Move core.h to mach-socfpga.

Will do.

>
> >  arch/arm/mach-socfpga/platsmp.c           |  166
> > +++++++++++++++++++++++++++++
> >  arch/arm/mach-socfpga/socfpga.c           |   33 +++++-
> >  8 files changed, 315 insertions(+), 4 deletions(-)
> >  create mode 100644 arch/arm/mach-socfpga/headsmp.S
> >  create mode 100644 arch/arm/mach-socfpga/include/mach/core.h
> >  create mode 100644 arch/arm/mach-socfpga/platsmp.c
> >
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi
> > b/arch/arm/boot/dts/socfpga.dtsi
> > index 0772f57..19aec42 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -143,5 +143,15 @@
> >                       reg-shift = <2>;
> >                       reg-io-width = <4>;
> >               };
> > +
> > +             rstmgr at ffd05000 {
> > +                             compatible = "altr,rst-mgr";
> > +                             reg = <0xffd05000 0x1000>;
> > +                     };
> > +
> > +             sysmgr at ffd08000 {
> > +                             compatible = "altr,sys-mgr";
> > +                             reg = <0xffd08000 0x4000>;
> > +                     };
>
> Bindings need documentation.

Will add..

>
> >       };
> >  };
> > diff --git a/arch/arm/configs/socfpga_defconfig
> > b/arch/arm/configs/socfpga_defconfig
> > index 0ac1293..349ac22 100644
> > --- a/arch/arm/configs/socfpga_defconfig
> > +++ b/arch/arm/configs/socfpga_defconfig
> > @@ -1,5 +1,5 @@
> >  CONFIG_EXPERIMENTAL=y
> > -CONFIG_SYSVIPC=y
> > +CONFIG_NO_HZ=y
> >  CONFIG_IKCONFIG=y
> >  CONFIG_IKCONFIG_PROC=y
> >  CONFIG_LOG_BUF_SHIFT=14
> > @@ -16,10 +16,13 @@ CONFIG_MODULE_UNLOAD=y
> >  # CONFIG_IOSCHED_DEADLINE is not set
> >  # CONFIG_IOSCHED_CFQ is not set
> >  CONFIG_ARCH_SOCFPGA=y
> > -CONFIG_MACH_SOCFPGA_CYCLONE5=y
> > -CONFIG_ARM_THUMBEE=y
> > +# CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
> >  # CONFIG_CACHE_L2X0 is not set
> >  CONFIG_HIGH_RES_TIMERS=y
> > +CONFIG_SMP=y
> > +CONFIG_ARM_ARCH_TIMER=y
> > +CONFIG_HIGHMEM=y
> > +CONFIG_HIGHPTE=y
> >  CONFIG_VMSPLIT_2G=y
> >  CONFIG_NR_CPUS=2
> >  CONFIG_AEABI=y
> > diff --git a/arch/arm/mach-socfpga/Kconfig
> > b/arch/arm/mach-socfpga/Kconfig
> > index 803a328..566e804 100644
> > --- a/arch/arm/mach-socfpga/Kconfig
> > +++ b/arch/arm/mach-socfpga/Kconfig
> > @@ -12,5 +12,6 @@ config ARCH_SOCFPGA
> >       select GENERIC_CLOCKEVENTS
> >       select GPIO_PL061 if GPIOLIB
> >       select HAVE_ARM_SCU
> > +     select HAVE_SMP
> >       select SPARSE_IRQ
> >       select USE_OF
> > diff --git a/arch/arm/mach-socfpga/Makefile
> > b/arch/arm/mach-socfpga/Makefile
> > index 4fb9324..61b1266 100644
> > --- a/arch/arm/mach-socfpga/Makefile
> > +++ b/arch/arm/mach-socfpga/Makefile
> > @@ -2,4 +2,7 @@
> >  # Makefile for the linux kernel.
> >  #
> >
> > +ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
> > +
>
> This can be removed if core.h is moved.
>
> >  obj-y                                        := socfpga.o
> > +obj-$(CONFIG_SMP)    += headsmp.o platsmp.o
> > diff --git a/arch/arm/mach-socfpga/headsmp.S
> > b/arch/arm/mach-socfpga/headsmp.S
> > new file mode 100644
> > index 0000000..b3a24db
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/headsmp.S
> > @@ -0,0 +1,64 @@
> > +/*
> > + *  Copyright (c) 2003 ARM Limited
> > + *  Copyright (c) u-boot contributors
> > + *  Copyright (c) 2012 Pavel Machek <pavel@denx.de>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#include <linux/linkage.h>
> > +#include <linux/init.h>
> > +
> > +     __INIT
> > +
> > +#define CPU1_START_ADDR              0xffd08010
> > +
> > +ENTRY(secondary_trampoline)
>
> This appears to be your reset code at phys addr 0. How does core 0 boot
> if you are copying this to 0?
>
> > +     /* From u-boot: start.S */
> > +     mrs     r0, cpsr
> > +     bic     r0, r0, #0x1f
> > +     orr     r0, r0, #0xd3
> > +     msr     cpsr,r0
> > +
> >
> > +/*************************************************************************
> > + *
> > + * cpu_init_cp15
> > + **  Copyright (c) u-boot contributors
> > + * Setup CP15 registers (cache, MMU, TLBs). The I-cache is turned on
> > unless
> > + * CONFIG_SYS_ICACHE_OFF is defined.
> > + *
> > +
> > *************************************************************************/
> > +ENTRY(cpu_init_cp15)
> > +     /*
> > +      * Invalidate L1 I/D
> > +      */
> > +     mov     r0, #0                  @ set up for MCR
> > +     mcr     p15, 0, r0, c8, c7, 0   @ invalidate TLBs
> > +     mcr     p15, 0, r0, c7, c5, 0   @ invalidate icache
> > +     mcr     p15, 0, r0, c7, c5, 6   @ invalidate BP array
> > +     mcr   p15, 0, r0, c7, c10, 4    @ DSB
> > +     mcr   p15, 0, r0, c7, c5, 4     @ ISB
> > +
> > +     /*
> > +      * disable MMU stuff and caches
> > +      */
> > +     mrc     p15, 0, r0, c1, c0, 0
> > +     bic     r0, r0, #0x00002000     @ clear bits 13 (--V-)
> > +     bic     r0, r0, #0x00000007     @ clear bits 2:0 (-CAM)
> > +     orr     r0, r0, #0x00000002     @ set bit 1 (--A-) Align
> > +     orr     r0, r0, #0x00000800     @ set bit 11 (Z---) BTB
> > +     orr     r0, r0, #0x00001000     @ set bit 12 (I) I-cache
>
> All this should get done by v7_setup.
>
> > +     mcr     p15, 0, r0, c1, c0, 0
> > +
> > +     movw    r0, #:lower16:CPU1_START_ADDR
> > +     movt  r0, #:upper16:CPU1_START_ADDR
> > +
> > +     ldr     r1, [r0]
> > +     bx      r1
> > +
> > +ENTRY(secondary_trampoline_end)
> > +
> > +     .align
> > +     .long   pen_release
> > +
> > diff --git a/arch/arm/mach-socfpga/include/mach/core.h
> > b/arch/arm/mach-socfpga/include/mach/core.h
> > new file mode 100644
> > index 0000000..74a4949
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/include/mach/core.h
> > @@ -0,0 +1,33 @@
> > +/*
> > + * Copyright 2012 Pavel Machek <pavel@denx.de>
> > + * Copyright (C) 2012 Altera Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
> > USA
> > + */
> > +
> > +#ifndef __MACH_CORE_H
> > +#define __MACH_CORE_H
> > +
> > +extern void secondary_startup(void);
> > +extern void __iomem *socfpga_scu_base_addr;
> > +
> > +extern void socfpga_init_clocks(void);
> > +extern void socfpga_sysmgr_init(void);
> > +
> > +extern struct smp_operations socfpga_smp_ops;
> > +
> > +#define SOCFPGA_SCU_VIRT_BASE   0xfffec000
> > +
> > +#endif
> > diff --git a/arch/arm/mach-socfpga/platsmp.c
> > b/arch/arm/mach-socfpga/platsmp.c
> > new file mode 100644
> > index 0000000..59d7069
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/platsmp.c
> > @@ -0,0 +1,166 @@
> > +/*
> > + * Copyright 2010-2011 Calxeda, Inc.
> > + * Copyright 2012 Pavel Machek <pavel@denx.de>
> > + * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
> > + * Copyright (C) 2012 Altera Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> > WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> > or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> > License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/smp.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +
> > +#include <asm/cacheflush.h>
> > +#include <asm/hardware/gic.h>
> > +#include <asm/smp_scu.h>
> > +#include <asm/smp_plat.h>
> > +
> > +#include <mach/core.h>
> > +
> > +static void __iomem *sys_manager_base_addr;
> > +static void __iomem *rst_manager_base_addr;
> > +
> > +static DEFINE_SPINLOCK(boot_lock);
> > +
> > +static void __cpuinit socfpga_secondary_init(unsigned int cpu)
> > +{
> > +     /*
> > +      * if any interrupts are already enabled for the primary
> > +      * core (e.g. timer irq), then they will not have been enabled
> > +      * for us: do so
> > +      */
> > +     gic_secondary_init(0);
> > +
> > +     /*
> > +      * let the primary processor know we're out of the
> > +      * pen, then head off into the C entry point
> > +      */
> > +     pen_release = -1;
> > +     smp_wmb();
> > +
> > +     /*
> > +      * Synchronise with the boot thread.
> > +      */
> > +     spin_lock(&boot_lock);
> > +     spin_unlock(&boot_lock);
> > +}
> > +
> > +static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct
> > task_struct *idle)
> > +{
> > +     unsigned long timeout;
> > +     extern char secondary_trampoline, secondary_trampoline_end;
> > +
> > +     int trampoline_size = &secondary_trampoline_end -
> > &secondary_trampoline;
> > +
> > +     /*
> > +      * Set synchronisation state between this boot processor
> > +      * and the secondary one
> > +      */
> > +     spin_lock(&boot_lock);
> > +
> > +     memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
> > +
> > +     __raw_writel(virt_to_phys(secondary_startup),
> > (sys_manager_base_addr+0x10));
> > +
> > +     pen_release = 0;
> > +     flush_cache_all();
> > +     smp_wmb();
> > +     outer_clean_range(0, trampoline_size);
> > +
> > +     /* This will release CPU #1 out of reset.*/
> > +     __raw_writel(0, rst_manager_base_addr + 0x10);
> > +
> > +     timeout = jiffies + (1 * HZ);
> > +     while (time_before(jiffies, timeout)) {
> > +             smp_rmb();
> > +             if (pen_release == -1)
> > +                     break;
> > +
> > +             udelay(10);
> > +     }
> > +
> > +     /*
> > +      * now the secondary core is starting up let it run its
> > +      * calibrations, then wait for it to finish
> > +      */
> > +     spin_unlock(&boot_lock);
> > +     return pen_release != -1 ? -ENOSYS : 0;
>
> You don't need any of this if you can reset secondary cores on hotplug.

Will investigate with your latest comments.

Thanks for the quick turnaround on the review.

Dinh
>
> Rob
>
