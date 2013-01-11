From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Jan 2013 14:54:00 -0500 (EST)
Subject: [PATCH 02/16] ARM: b.L: introduce the CPU/cluster power API
In-Reply-To: <50F05CD4.8050905@ti.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-3-git-send-email-nicolas.pitre@linaro.org>
 <50F04B4F.2070300@ti.com> <alpine.LFD.2.02.1301111312180.6300@xanadu.home>
 <50F05CD4.8050905@ti.com>
Message-ID: <alpine.LFD.2.02.1301111432200.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Jan 2013, Santosh Shilimkar wrote:

> On Saturday 12 January 2013 12:03 AM, Nicolas Pitre wrote:
> > On Fri, 11 Jan 2013, Santosh Shilimkar wrote:
> > 
> > > On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
> > > > This is the basic API used to handle the powering up/down of individual
> > > > CPUs in a big.LITTLE system.  The platform specific backend
> > > > implementation
> > > > has the responsibility to also handle the cluster level power as well
> > > > when
> > > > the first/last CPU in a cluster is brought up/down.
> > > > 
> > > > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > > > ---
> > > >    arch/arm/common/bL_entry.c      | 88
> > > > +++++++++++++++++++++++++++++++++++++++
> > > >    arch/arm/include/asm/bL_entry.h | 92
> > > > +++++++++++++++++++++++++++++++++++++++++
> > > >    2 files changed, 180 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c
> > > > index 80fff49417..41de0622de 100644
> > > > --- a/arch/arm/common/bL_entry.c
> > > > +++ b/arch/arm/common/bL_entry.c
> > > > @@ -11,11 +11,13 @@
> > > > 
> > > >    #include <linux/kernel.h>
> > > >    #include <linux/init.h>
> > > > +#include <linux/irqflags.h>
> > > > 
> > > >    #include <asm/bL_entry.h>
> > > >    #include <asm/barrier.h>
> > > >    #include <asm/proc-fns.h>
> > > >    #include <asm/cacheflush.h>
> > > > +#include <asm/idmap.h>
> > > > 
> > > >    extern volatile unsigned long
> > > > bL_entry_vectors[BL_NR_CLUSTERS][BL_CPUS_PER_CLUSTER];
> > > > 
> > > > @@ -28,3 +30,89 @@ void bL_set_entry_vector(unsigned cpu, unsigned
> > > > cluster,
> > > > void *ptr)
> > > >    	outer_clean_range(__pa(&bL_entry_vectors[cluster][cpu]),
> > > >    			  __pa(&bL_entry_vectors[cluster][cpu + 1]));
> > > >    }
> > > > +
> > > > +static const struct bL_platform_power_ops *platform_ops;
> > > > +
> > > > +int __init bL_platform_power_register(const struct
> > > > bL_platform_power_ops
> > > > *ops)
> > > > +{
> > > > +	if (platform_ops)
> > > > +		return -EBUSY;
> > > > +	platform_ops = ops;
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +int bL_cpu_power_up(unsigned int cpu, unsigned int cluster)
> > > > +{
> > > > +	if (!platform_ops)
> > > > +		return -EUNATCH;
> > > > +	might_sleep();
> > > > +	return platform_ops->power_up(cpu, cluster);
> > > > +}
> > > > +
> > > > +typedef void (*phys_reset_t)(unsigned long);
> > > > +
> > > > +void bL_cpu_power_down(void)
> > > > +{
> > > > +	phys_reset_t phys_reset;
> > > > +
> > > > +	BUG_ON(!platform_ops);
> > > > +	BUG_ON(!irqs_disabled());
> > > > +
> > > > +	/*
> > > > +	 * Do this before calling into the power_down method,
> > > > +	 * as it might not always be safe to do afterwards.
> > > > +	 */
> > > > +	setup_mm_for_reboot();
> > > > +
> > > > +	platform_ops->power_down();
> > > > +
> > > > +	/*
> > > > +	 * It is possible for a power_up request to happen concurrently
> > > > +	 * with a power_down request for the same CPU. In this case the
> > > > +	 * power_down method might not be able to actually enter a
> > > > +	 * powered down state with the WFI instruction if the power_up
> > > > +	 * method has removed the required reset condition.  The
> > > > +	 * power_down method is then allowed to return. We must perform
> > > > +	 * a re-entry in the kernel as if the power_up method just had
> > > > +	 * deasserted reset on the CPU.
> > > > +	 *
> > > > +	 * To simplify race issues, the platform specific implementation
> > > > +	 * must accommodate for the possibility of unordered calls to
> > > > +	 * power_down and power_up with a usage count. Therefore, if a
> > > > +	 * call to power_up is issued for a CPU that is not down, then
> > > > +	 * the next call to power_down must not attempt a full shutdown
> > > > +	 * but only do the minimum (normally disabling L1 cache and CPU
> > > > +	 * coherency) and return just as if a concurrent power_up request
> > > > +	 * had happened as described above.
> > > > +	 */
> > > > +
> > > > +	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
> > > > +	phys_reset(virt_to_phys(bL_entry_point));
> > > > +
> > > > +	/* should never get here */
> > > > +	BUG();
> > > > +}
> > > > +
> > > > +void bL_cpu_suspend(u64 expected_residency)
> > > > +{
> > > > +	phys_reset_t phys_reset;
> > > > +
> > > > +	BUG_ON(!platform_ops);
> > > > +	BUG_ON(!irqs_disabled());
> > > > +
> > > > +	/* Very similar to bL_cpu_power_down() */
> > > > +	setup_mm_for_reboot();
> > > > +	platform_ops->suspend(expected_residency);
> > > > +	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
> > > > +	phys_reset(virt_to_phys(bL_entry_point));
> > > > +	BUG();
> > > > 
> > > I might be missing all the rationales behind not having a recovery for
> > > CPUs entering suspend if they actualy come here because of some events.
> > > This is pretty much possible in many scenario's and hence letting CPU
> > > cpu come out of suspend should be possible. May be switcher code don't
> > > have such requirement but it appeared bit off to me.
> > 
> > There are two things to consider here:
> > 
> > 1) The CPU is suspended.  CPU state is lost. Next interrupt to wake up
> >     the CPU will make it restart from the reset vector and re-entry in
> >     the kernel will happen via bL_entry_point to deal with the various
> >     cluster issues, to eventually resume kernel code via cpu_resume.
> >     Obviously, the machine specific backend code would have set the
> >     bL_entry_point address in its machine specific reset vector in
> >     advance.
> This is the successful case and in that case you will anyway not hit the
> BUG.
> > 
> > 2) An interrupt comes along before the CPU is effectively suspended, say
> >     right before the backend code executes a WFI to shut the CPU down.
> >     The CPU and possibly cluster state was already set for being powered
> >     off.  We cannot simply return at this point as caches are off, the
> >     CPU is not coherent with the rest of the system anymore, etc.  So if
> >     the platform specific backend ever returns, say because the final WFI
> >     exited, then we have to go through the same arbitration process to
> >     restore the CPU and cluster state as if that was a hard reset.  Hence
> >     the cpu_reset call to loop back into bL_entry_point.
> > 
> This is the one I was thinking. Enabling C bit and SMP bit should be
> enough for CPU to get back to right state since the CPU has not lost
> the context all the registers including SP is intact and CPU should
> be able to resume.

No.  If we are the last man then the CCI is disabled and we cannot just 
enable the C and SMP bits anymore without turning the CCI back on.  And 
even if we are not the last man, maybe another CPU is concurrently going 
through the same code and that one _is_ the last man, in which case it 
will have waited until we are done flushing our cache to turn off the 
CCI but we don't know about that.  And yet another CPU might be coming 
up just at the same moment but this one will want to turn on the CCI and 
that has to be done in a controlled way, and that control is performed 
in the code from bL_entry_point.  So, in short, we cannot just return 
from here.

> > In either cases, we simply cannot ever return from bL_cpu_suspend()
> > directly.  Of course, the caller is expected to have used
> > bL_set_entry_vector() beforehand, most probably with cpu_resume as
> > argument.
> > 
> The above might get complicated if when above situation happens on
> last CPU where even CCI gets disabled and then adding the rever code
> for all of that may not be worth. You approach is much safer.

Indeed.  Furthermore, that revert code does exist already: it is all in 
bL_head.S.  Hence the cpu_reset(bL_entry_point) call.

> Thanks for explaining it further.

No problem.  That literally took us months to get this code 
right so it might not be fully obvious to others after the first look.


Nicolas
