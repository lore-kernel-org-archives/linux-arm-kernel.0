From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 May 2013 20:44:33 +0100
Subject: [PATCH 4/4] ARM: highbank: fix build after cache flush change
In-Reply-To: <20130502194125.GH14496@n2100.arm.linux.org.uk>
References: <1367515404-512212-1-git-send-email-arnd@arndb.de>
 <1367515404-512212-5-git-send-email-arnd@arndb.de>
 <5182C0DF.9000500@gmail.com> <20130502194125.GH14496@n2100.arm.linux.org.uk>
Message-ID: <20130502194433.GI14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 08:41:26PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 02, 2013 at 02:39:11PM -0500, Rob Herring wrote:
> > On 05/02/2013 12:23 PM, Arnd Bergmann wrote:
> > > Commit "ARM: cpu hotplug: remove majority of cache flushing from
> > > platforms" has removed the inclusion of asm/cacheflush.h from
> > > a number of files. Highbank still needs it because it calls
> > > flush_cache_louis().
> > 
> > AFAICT, the commit in question only showed up buried in a reply to
> > another thread and was never cc'ed to the relevant platform maintainers...
> > 
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> > > Cc: Rob Herring <rob.herring@calxeda.com>
> > > ---
> > 
> > I'd rather see the highbank changes dropped as this will all go away
> > with PSCI in 3.11, but:
> > 
> > Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> I'll drop the removal of asm/cacheflush.h but not the rest of it; I
> believe your existing code to be in error with or without my changes.

Actually, no I'm not even going to do that, because that is _wrong_.  This
is what my mach-highbank/hotplug.c looks like after my change:

#include <linux/kernel.h>
        
#include "core.h"
#include "sysregs.h"
 
extern void secondary_startup(void);

/*
 * platform-specific code to shutdown a CPU
 *
 */
void __ref highbank_cpu_die(unsigned int cpu)
{
        highbank_set_cpu_jump(cpu, phys_to_virt(0));
        highbank_set_core_pwr();

        cpu_do_idle();

        /* We should never return from idle */
        panic("highbank: cpu %d unexpectedly exit from shutdown\n", cpu);
}

hence my change is completely correct in removing asm/cacheflush.h.
