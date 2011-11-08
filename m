From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Nov 2011 16:10:00 +0000
Subject: [PATCH 2/2] ARM: highbank: convert logical CPU numbers to
 physical numbers
In-Reply-To: <4EB951D5.9060005@gmail.com>
References: <1320762894-11824-1-git-send-email-will.deacon@arm.com>
 <1320762894-11824-3-git-send-email-will.deacon@arm.com>
 <4EB951D5.9060005@gmail.com>
Message-ID: <20111108160958.GE10538@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Nov 08, 2011 at 03:59:17PM +0000, Rob Herring wrote:
> On 11/08/2011 08:34 AM, Will Deacon wrote:
> > This patch uses the new cpu_logical_map() macro for converting logical
> > CPU numbers into physical numbers when releasing CPUs during the SMP
> > boot and CPU hotplug paths.
> > 
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mach-highbank/highbank.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> > index b82dcf0..a6cdc27 100644
> > --- a/arch/arm/mach-highbank/highbank.c
> > +++ b/arch/arm/mach-highbank/highbank.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/of_address.h>
> > +#include <linux/smp.h>
> >  
> >  #include <asm/cacheflush.h>
> >  #include <asm/unified.h>
> > @@ -72,6 +73,7 @@ static void __init highbank_map_io(void)
> >  
> >  void highbank_set_cpu_jump(int cpu, void *jump_addr)
> >  {
> > +	cpu = cpu_logical_map(cpu);
> 
> This doesn't build for !CONFIG_SMP. It's possible to want to do this for
> core 0 in the cpuidle case.

Damn, I suspect I have the same problem with the imx code. Although it would
be nice to fix this inside of cpu_logical_map, I can't see a way to do that
without moving it into a different header file (which?), so I think the best
option is to ifdef at the point of use.

I'll throw a v2 your way this week.

Will
