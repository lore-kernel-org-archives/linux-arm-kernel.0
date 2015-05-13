From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 13 May 2015 09:35:13 +0200
Subject: [PATCH] ARM: berlin: add CPU hotplug support
In-Reply-To: <20150512232322.GR2067@n2100.arm.linux.org.uk>
References: <1431440186-14075-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150512232322.GR2067@n2100.arm.linux.org.uk>
Message-ID: <20150513073513.GE32171@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 12:23:22AM +0100, Russell King - ARM Linux wrote:
> On Tue, May 12, 2015 at 04:16:26PM +0200, Antoine Tenart wrote:
> > Adds CPU hotplug support for Berlin SoCs (currently BG2 and BG2Q). The
> > CPUs are put in WFI after disabling the coherency.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >  arch/arm/mach-berlin/platsmp.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
> > index 702e7982015a..d9c62057be76 100644
> > --- a/arch/arm/mach-berlin/platsmp.c
> > +++ b/arch/arm/mach-berlin/platsmp.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/of_address.h>
> >  
> >  #include <asm/cacheflush.h>
> > +#include <asm/cp15.h>
> 
> I don't see anything being added by this patch which would need this
> include.

v7_exit_coherency_flush(..) needs CR_C to be defined, which is done in
asm/cp15.h. Is there a better way to get this defined here?

> >  
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +static void berlin_cpu_die(unsigned int cpu)
> > +{
> > +	v7_exit_coherency_flush(louis);
> > +	while (1)
> > +		cpu_do_idle();
> > +}
> > +#endif
> > +

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
