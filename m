From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 8 Jan 2013 15:53:42 +0100
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130108142828.GD2718@e106331-lin.cambridge.arm.com>
References: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com><1357649263-1098-4-git-send-email-hdoyu@nvidia.com><20130108142828.GD2718@e106331-lin.cambridge.arm.com>
Message-ID: <20130108.165342.1996373920678167735.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Mark Rutland <mark.rutland@arm.com> wrote @ Tue, 8 Jan 2013 15:28:28 +0100:

> Hello,
> 
> On Tue, Jan 08, 2013 at 12:47:37PM +0000, Hiroshi Doyu wrote:
> > The method to detect the number of CPU cores on Cortex-A9 MPCore and
> > Cortex-A15 MPCore is different. On Cortex-A9 MPCore we can get this
> > information from the Snoop Control Unit(SCU). On Cortex-A15 MPCore we
> > have to read it from the system coprocessor(CP15), because the SCU on
> > Cortex-A15 MPCore does not have software readable registers. This
> > patch selects the correct method at runtime based on the CPU ID.
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > ---
> >  arch/arm/mach-tegra/platsmp.c |   31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> > index 1b926df..68e76ef 100644
> > --- a/arch/arm/mach-tegra/platsmp.c
> > +++ b/arch/arm/mach-tegra/platsmp.c
> > @@ -23,6 +23,7 @@
> >  #include <asm/hardware/gic.h>
> >  #include <asm/mach-types.h>
> >  #include <asm/smp_scu.h>
> > +#include <asm/cputype.h>
> >  
> >  #include <mach/powergate.h>
> >  
> > @@ -34,9 +35,13 @@
> >  #include "common.h"
> >  #include "iomap.h"
> >  
> > +#define CPU_MASK		0xff0ffff0
> > +#define CPU_CORTEX_A9		0x410fc090
> > +#define CPU_CORTEX_A15		0x410fc0f0
> > +
> >  extern void tegra_secondary_startup(void);
> >  
> > -static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
> > +static void __iomem *scu_base;
> >  
> >  #define EVP_CPU_RESET_VECTOR \
> >  	(IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
> > @@ -149,7 +154,26 @@ done:
> >   */
> >  static void __init tegra_smp_init_cpus(void)
> >  {
> > -	unsigned int i, ncores = scu_get_core_count(scu_base);
> > +	unsigned int i, cpu_id, ncores;
> > +	u32 l2ctlr;
> > +	phys_addr_t pa;
> > +
> > +	cpu_id = read_cpuid(CPUID_ID) & CPU_MASK;
> > +	switch (cpu_id) {
> > +	case CPU_CORTEX_A15:
> > +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> > +		ncores = ((l2ctlr >> 24) & 3) + 1;
> > +		break;
> 
> [...]
> 
> As mentioned last time [1], you should get this information from the dt
> instead.

Most of platsmp.c:.smp_init_cpus() implementations seem just to
overwrite # of cores by SCU/MRC detection. Is there any implementation
to use the DT's # and skip SCU/MRC detection in .smp_init_cpus()?
