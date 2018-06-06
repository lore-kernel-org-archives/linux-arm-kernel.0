From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Wed, 6 Jun 2018 06:36:24 +0000
Subject: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
In-Reply-To: <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
Message-ID: <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On 05 June 2018 18:34, Frank wrote:
> On 06/05/18 04:28, Michel Pollet wrote:
> > The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
> > it requires a special enable method to get it started.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > ---
> >  arch/arm/mach-shmobile/Makefile        |  1 +
> >  arch/arm/mach-shmobile/smp-r9a06g032.c | 79
> > ++++++++++++++++++++++++++++++++++
> >  2 files changed, 80 insertions(+)
> >  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c
> >
> > diff --git a/arch/arm/mach-shmobile/Makefile
> > b/arch/arm/mach-shmobile/Makefile index 1939f52..d7fc98f 100644
> > --- a/arch/arm/mach-shmobile/Makefile
> > +++ b/arch/arm/mach-shmobile/Makefile
> > @@ -34,6 +34,7 @@ smp-$(CONFIG_ARCH_SH73A0)+= smp-sh73a0.o
> headsmp-scu.o platsmp-scu.o
> >  smp-$(CONFIG_ARCH_R8A7779)+= smp-r8a7779.o headsmp-scu.o
> platsmp-scu.o
> >  smp-$(CONFIG_ARCH_R8A7790)+= smp-r8a7790.o
> >  smp-$(CONFIG_ARCH_R8A7791)+= smp-r8a7791.o
> > +smp-$(CONFIG_ARCH_R9A06G032)+= smp-r9a06g032.o
> >  smp-$(CONFIG_ARCH_EMEV2)+= smp-emev2.o headsmp-scu.o
> platsmp-scu.o
> >
> >  # PM objects
> > diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c
> > b/arch/arm/mach-shmobile/smp-r9a06g032.c
> > new file mode 100644
> > index 0000000..cd40e6e
> > --- /dev/null
> > +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * R9A06G032 Second CA7 enabler.
> > + *
> > + * Copyright (C) 2018 Renesas Electronics Europe Limited
> > + *
> > + * Michel Pollet <michel.pollet@bp.renesas.com>,
> <buserror@gmail.com>
> > + * Derived from action,s500-smp
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/smp.h>
> > +
> > +/*
> > + * The second CPU is parked in ROM at boot time. It requires waking
> > +it after
> > + * writing an address into the BOOTADDR register of sysctrl.
> > + *
> > + * So the default value of the "cpu-release-addr" corresponds to
> BOOTADDR...
> > + *
> > + * *However* the BOOTADDR register is not available when the kernel
> > + * starts in NONSEC mode.
> > + *
> > + * So for NONSEC mode, the bootloader re-parks the second CPU into a
> > +pen
> > + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a
> > +SRAM address,
> > + * which is not restricted.
>
> The binding document for cpu-release-addr does not have a definition for 32
> bit arm.  The existing definition is only 64 bit arm.  Please add the definition
> for 32 bit arm to patch 1.

Hmmm I do find a definition in
Documentation/devicetree/bindings/arm/cpus.txt -- just under where I
added my 'enable-method' -- And it is already used as 32 bits in at least
arch/arm/boot/dts/stih407-family.dtsi.

What do you want me to add to this exactly? Do you want me to just
change "required for systems that have an "enable-method" property
value of "spin-table" to also specify renesas,r9a06g032 ?

Thanks!
Michel

>
> -Frank
>
>
> > + */
> > +
> > +static void __iomem *cpu_bootaddr;
> > +
> > +static DEFINE_SPINLOCK(cpu_lock);
> > +
> > +static int r9a06g032_smp_boot_secondary(unsigned int cpu, struct
> > +task_struct *idle) {
> > +if (!cpu_bootaddr)
> > +return -ENODEV;
> > +
> > +spin_lock(&cpu_lock);
> > +
> > +writel(__pa_symbol(secondary_startup), cpu_bootaddr);
> > +arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> > +
> > +spin_unlock(&cpu_lock);
> > +
> > +return 0;
> > +}
> > +
> > +static void __init r9a06g032_smp_prepare_cpus(unsigned int max_cpus)
> > +{
> > +struct device_node *dn;
> > +int ret;
> > +u32 bootaddr;
> > +
> > +dn = of_get_cpu_node(1, NULL);
> > +if (!dn) {
> > +pr_err("CPU#1: missing device tree node\n");
> > +return;
> > +}
> > +/*
> > + * Determine the address from which the CPU is polling.
> > + * The bootloader *does* change this property
> > + */
> > +ret = of_property_read_u32(dn, "cpu-release-addr", &bootaddr);
> > +of_node_put(dn);
> > +if (ret) {
> > +pr_err("CPU#1: invalid cpu-release-addr property\n");
> > +return;
> > +}
> > +pr_info("CPU#1: cpu-release-addr %08x\n", bootaddr);
> > +
> > +cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr)); }
> > +
> > +static const struct smp_operations r9a06g032_smp_ops __initconst = {
> > +.smp_prepare_cpus = r9a06g032_smp_prepare_cpus,
> > +.smp_boot_secondary = r9a06g032_smp_boot_secondary, };
> > +CPU_METHOD_OF_DECLARE(r9a06g032_smp, "renesas,r9a06g032-smp",
> > +&r9a06g032_smp_ops);
> >




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
