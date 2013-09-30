From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 30 Sep 2013 18:20:55 +0100
Subject: [RFC PATCH 2/3] ARM: mcpm: Implement cpu_kill() to synchronise
 on powerdown
In-Reply-To: <alpine.LFD.2.03.1309301252050.6331@syhkavp.arg>
References: <1380553607-3271-1-git-send-email-Dave.Martin@arm.com>
 <1380553607-3271-3-git-send-email-Dave.Martin@arm.com>
 <alpine.LFD.2.03.1309301252050.6331@syhkavp.arg>
Message-ID: <20130930172055.GC3209@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 01:00:00PM -0400, Nicolas Pitre wrote:
> On Mon, 30 Sep 2013, Dave Martin wrote:
> 
> > CPU hotplug and kexec rely on smp_ops.cpu_kill(), which is supposed
> > to wait for the CPU to park or power down, and perform the last
> > rites (such as disabling clocks etc., where the platform doesn't do
> > this automatically).
> > 
> > kexec in particular is unsafe without performing this
> > synchronisation to park secondaries.  Without it, the secondaries
> > might not be parked when kexec trashes the kernel.
> > 
> > There is no generic way to do this synchronisation, so a new mcpm
> > platform_ops method power_down_finish() is added by this patch.
> > 
> > The new method is mandatory.  A platform which provides no way to
> > detect when CPUs are parked is likely broken.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm/common/mcpm_entry.c   |    5 +++++
> >  arch/arm/common/mcpm_platsmp.c |   10 ++++++++++
> >  arch/arm/include/asm/mcpm.h    |   31 +++++++++++++++++++++++++++++++
> >  3 files changed, 46 insertions(+)
> > 
> > diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> > index 370236d..b722027 100644
> > --- a/arch/arm/common/mcpm_entry.c
> > +++ b/arch/arm/common/mcpm_entry.c
> > @@ -89,6 +89,11 @@ void mcpm_cpu_power_down(void)
> >  	BUG();
> >  }
> >  
> > +int mcpm_cpu_power_down_finish(unsigned int cpu, unsigned int cluster)
> > +{
> > +	return platform_ops->power_down_finish(cpu, cluster);
> > +}
> 
> Please make it return an error (non-zero return value) if platform_ops 
> or platform_ops->power_down_finish is NULL.  Otherwise this would oops 
> the kernel.
> 
> There is a patch already handling the other cases in RMK's patch system.

OK -- I didn't pay enough attention as that went past.

I'll grab that patch and rebase onto it.


Do you have concerns about the mandatoriness of the new call?  The
alternative would be to check for it at registration time and set
smp_ops.cpu_kill to NULL if the backend method isn't there.

But I really wouldn't want to encourage that until someone comes
up with a good reason.

[...]

> > diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
> > index 0f7b762..22cdc6f 100644
> > --- a/arch/arm/include/asm/mcpm.h
> > +++ b/arch/arm/include/asm/mcpm.h
> > @@ -78,10 +78,40 @@ int mcpm_cpu_power_up(unsigned int cpu, unsigned int cluster);
> >   *
> >   * This does not return.  Re-entry in the kernel is expected via
> >   * mcpm_entry_point.
> > + *
> > + * The CPU is not necessarily truly halted until
> > + * mcpu_cpu_power_down_finish() subsequently returns non-zero for the
> 
> s/mcpu/mcpm/
> 
> > + * specified cpu.  Until then, other CPUs should make sure they do not
> > + * trash memory the target CPU might be executing/accessing.
> >   */
> >  void mcpm_cpu_power_down(void);
> >  
> >  /**
> > + * mcpm_cpu_power_down_finish - wait for a specified CPU to halt, and
> > + *	make sure it is powered off
> > + *
> > + * @cpu: CPU number within given cluster
> > + * @cluster: cluster number for the CPU
> > + *
> > + * Call this function to ensure that a pending powerdown has taken
> > + * effect and the CPU is safely parked before performing non-mcpm
> > + * operations that may affect the CPU (such as kexec trashing the
> > + * kernel text).
> > + *
> > + * It is *not* necessary to call this function if you only need to
> > + * serialise a pending powerdown with mcpu_cpu_power_up() or a wakeup
> 
> Ditto.
> 
> > + * event.
> > + *
> > + * Do not call this function unless the specified CPU has already
> > + * called mcpu_cpu_power_down() or has committed to doing so.
> 
> Ditto.

Ummm, duh.  Fixed -- thanks.

[...]

Cheers
---Dave
