From: anson.huang@nxp.com (Yongcai Huang)
Date: Fri, 26 Aug 2016 12:20:15 +0000
Subject: [PATCH 3/3] ARM: imx: add SMP support for i.MX7D
In-Reply-To: <20160826111356.GM1041@n2100.armlinux.org.uk>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
 <1472209971-32469-4-git-send-email-Anson.Huang@nxp.com>
 <20160826111356.GM1041@n2100.armlinux.org.uk>
Message-ID: <AM3PR04MB13154FA0116D397AABD75E10F5EC0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk]
> Sent: 2016-08-26 7:14 PM
> To: Yongcai Huang <anson.huang@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; shawnguo at kernel.org; kernel at pengutronix.de;
> Fabio Estevam <fabio.estevam@nxp.com>; robh+dt at kernel.org;
> mark.rutland at arm.com
> Subject: Re: [PATCH 3/3] ARM: imx: add SMP support for i.MX7D
> 
> On Fri, Aug 26, 2016 at 07:12:51PM +0800, Anson Huang wrote:
> > i.MX7D has 2 cortex-a7 ARM core, add support for booting up SMP kernel
> > with 2 CPUs.
> >
> > The existing i.MX SMP code is designed for i.MX6 series SoCs which
> > have cortex-a9 ARM core, but i.MX7D has 2 cortex-a7 ARM core, so we
> > need to add runtime check for those differences between cortex-a9 and
> > cortex-a7.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/mach-imx/headsmp.S    | 11 +++++++++++
> >  arch/arm/mach-imx/mach-imx7d.c |  2 ++
> >  arch/arm/mach-imx/platsmp.c    | 19 ++++++++++++++++++-
> >  arch/arm/mach-imx/src.c        | 38 ++++++++++++++++++++++++++++++----
> ----
> >  4 files changed, 61 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-
> imx/headsmp.S
> > index 6c28d28..a26e459 100644
> > --- a/arch/arm/mach-imx/headsmp.S
> > +++ b/arch/arm/mach-imx/headsmp.S
> > @@ -26,7 +26,18 @@ diag_reg_offset:
> >  	.endm
> >
> >  ENTRY(v7_secondary_startup)
> > +	.word	0xc070			@ 0xc07 is cortex-a7 id
> > +	.word	0xfff0			@ mask for core type
> > +
> >  ARM_BE8(setend be)			@ go BE8 if entered LE
> > +	mrc     p15, 0, r0, c0, c0, 0
> > +	adr	r1, v7_secondary_startup
> > +	ldr	r2, [r1]
> > +	ldr	r3, [r1, #0x4]
> > +	and     r0, r0, r3
> > +	cmp     r0, r2
> > +	beq     secondary_startup
> > +
> 
> Total NAK on the above.  There's no way that we want to even try executing
> those two .word values (and I don't care if "it works when tested", we just
> don't try and execute data.)

Sure, I misunderstood the way of putting .word, actually, for i.MX7D, I can
just call common secondary_startup instead of v7_seondary_startup, so I can
remove all changes in this file.

> 
> >  	set_diag_reg
> >  	b	secondary_startup
> >  ENDPROC(v7_secondary_startup)
> > diff --git a/arch/arm/mach-imx/mach-imx7d.c
> > b/arch/arm/mach-imx/mach-imx7d.c index 26ca744..ef3dce6 100644
> > --- a/arch/arm/mach-imx/mach-imx7d.c
> > +++ b/arch/arm/mach-imx/mach-imx7d.c
> > @@ -99,6 +99,7 @@ static void __init imx7d_init_machine(void)
> >
> >  static void __init imx7d_init_irq(void)  {
> > +	imx_gpcv2_check_dt();
> >  	imx_init_revision_from_anatop();
> >  	imx_src_init();
> >  	irqchip_init();
> > @@ -111,6 +112,7 @@ static const char *const imx7d_dt_compat[]
> > __initconst = {  };
> >
> >  DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
> > +	.smp		= smp_ops(imx_smp_ops),
> >  	.init_irq	= imx7d_init_irq,
> >  	.init_machine	= imx7d_init_machine,
> >  	.dt_compat	= imx7d_dt_compat,
> > diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> > index 711dbbd..63af911 100644
> > --- a/arch/arm/mach-imx/platsmp.c
> > +++ b/arch/arm/mach-imx/platsmp.c
> > @@ -60,8 +60,17 @@ static int imx_boot_secondary(unsigned int cpu,
> > struct task_struct *idle)  static void __init imx_smp_init_cpus(void)
> > {
> >  	int i, ncores;
> > +	unsigned long val, arch_type;
> >
> > -	ncores = scu_get_core_count(scu_base);
> > +	asm volatile("mrc p15, 0, %0, c0, c0, 0" : "=r" (arch_type));
> > +
> > +	if (((arch_type >> 4) & 0xfff) == 0xc07) {
> 
> This is buggy.  Plus, we have macros for this.  Please use the macros in
> asm/cputype.h to achieve these tests.

Thanks, I will use read_cpuid_id() API intead of putting asm code here.

> 
> > +		/* cortex-a7 core number is in bit[25:24] of CP15 L2CTLR */
> > +		asm volatile("mrc p15, 1, %0, c9, c0, 2" : "=r" (val));
> > +		ncores = ((val >> 24) & 0x3) + 1;
> > +	} else {
> > +		ncores = scu_get_core_count(scu_base);
> > +	}
> >
> >  	for (i = ncores; i < NR_CPUS; i++)
> >  		set_cpu_possible(i, false);
> > @@ -74,6 +83,14 @@ void imx_smp_prepare(void)
> >
> >  static void __init imx_smp_prepare_cpus(unsigned int max_cpus)  {
> > +	unsigned long arch_type;
> > +
> > +	asm volatile("mrc p15, 0, %0, c0, c0, 0" : "=r" (arch_type));
> > +
> > +	/* no need for cortex-a7 */
> > +	if (((arch_type >> 4) & 0xfff) == 0xc07)
> 
> Ditto.

Ditto.

> 
> > +		return;
> > +
> >  	imx_smp_prepare();
> >
> >  	/*
> > diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c index
> > 70b083f..1fda72a 100644
> > --- a/arch/arm/mach-imx/src.c
> > +++ b/arch/arm/mach-imx/src.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/smp.h>
> >  #include <asm/smp_plat.h>
> >  #include "common.h"
> > +#include "hardware.h"
> >
> >  #define SRC_SCR				0x000
> >  #define SRC_GPR1			0x020
> > @@ -30,6 +31,15 @@
> >  #define BP_SRC_SCR_CORE1_RST		14
> >  #define BP_SRC_SCR_CORE1_ENABLE		22
> >
> > +/* below are for i.MX7D */
> > +#define SRC_GPR1_V2                     0x074
> > +#define SRC_A7RCR0                      0x004
> > +#define SRC_A7RCR1                      0x008
> > +#define SRC_M4RCR                       0x00C
> > +
> > +#define BP_SRC_A7RCR0_A7_CORE_RESET0   0
> > +#define BP_SRC_A7RCR1_A7_CORE1_ENABLE  1
> > +
> >  static void __iomem *src_base;
> >  static DEFINE_SPINLOCK(scr_lock);
> >
> > @@ -87,12 +97,21 @@ void imx_enable_cpu(int cpu, bool enable)
> >  	u32 mask, val;
> >
> >  	cpu = cpu_logical_map(cpu);
> > -	mask = 1 << (BP_SRC_SCR_CORE1_ENABLE + cpu - 1);
> >  	spin_lock(&scr_lock);
> > -	val = readl_relaxed(src_base + SRC_SCR);
> > -	val = enable ? val | mask : val & ~mask;
> > -	val |= 1 << (BP_SRC_SCR_CORE1_RST + cpu - 1);
> > -	writel_relaxed(val, src_base + SRC_SCR);
> > +	if (cpu_is_imx7d()) {
> 
> It's about time iMX folk learned that "imx*" is a SoC and _not_ a CPU.
> It should be "soc_is_imx7d()" because we're wanting to know whether the
> _SoC_ is an iMX7D.  The _CPU_ is a _Cortex-A7_.

Agree, I will add a new patch in this patch set to replace all the cpu_is_xxx with
Soc_is_xxx.

Thanks for review.
Anson.

> 
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
