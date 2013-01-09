From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 9 Jan 2013 06:46:51 +0100
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130108142651.GB3931@n2100.arm.linux.org.uk>
References: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com><1357649263-1098-4-git-send-email-hdoyu@nvidia.com><20130108142651.GB3931@n2100.arm.linux.org.uk>
Message-ID: <20130109.074651.1513003283585604525.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> wrote @ Tue, 8 Jan 2013 15:26:51 +0100:

> On Tue, Jan 08, 2013 at 02:47:37PM +0200, Hiroshi Doyu wrote:
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
> 
> NAK. There's some patches around to make this stuff generic, we don't
> need more ifdefs springing up.  We need to get those generic patches
> in.

Does anyone give some pointers to the above patches?
