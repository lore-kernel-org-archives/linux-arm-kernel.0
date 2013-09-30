From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 30 Sep 2013 13:32:30 -0400 (EDT)
Subject: [RFC PATCH 2/3] ARM: mcpm: Implement cpu_kill() to synchronise
 on powerdown
In-Reply-To: <20130930172055.GC3209@localhost.localdomain>
References: <1380553607-3271-1-git-send-email-Dave.Martin@arm.com>
 <1380553607-3271-3-git-send-email-Dave.Martin@arm.com>
 <alpine.LFD.2.03.1309301252050.6331@syhkavp.arg>
 <20130930172055.GC3209@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1309301329180.6331@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Sep 2013, Dave Martin wrote:

> On Mon, Sep 30, 2013 at 01:00:00PM -0400, Nicolas Pitre wrote:
> > On Mon, 30 Sep 2013, Dave Martin wrote:
> > 
> > > CPU hotplug and kexec rely on smp_ops.cpu_kill(), which is supposed
> > > to wait for the CPU to park or power down, and perform the last
> > > rites (such as disabling clocks etc., where the platform doesn't do
> > > this automatically).
> > > 
> > > kexec in particular is unsafe without performing this
> > > synchronisation to park secondaries.  Without it, the secondaries
> > > might not be parked when kexec trashes the kernel.
> > > 
> > > There is no generic way to do this synchronisation, so a new mcpm
> > > platform_ops method power_down_finish() is added by this patch.
> > > 
> > > The new method is mandatory.  A platform which provides no way to
> > > detect when CPUs are parked is likely broken.
> > > 
> > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > ---
> > >  arch/arm/common/mcpm_entry.c   |    5 +++++
> > >  arch/arm/common/mcpm_platsmp.c |   10 ++++++++++
> > >  arch/arm/include/asm/mcpm.h    |   31 +++++++++++++++++++++++++++++++
> > >  3 files changed, 46 insertions(+)
> > > 
> > > diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> > > index 370236d..b722027 100644
> > > --- a/arch/arm/common/mcpm_entry.c
> > > +++ b/arch/arm/common/mcpm_entry.c
> > > @@ -89,6 +89,11 @@ void mcpm_cpu_power_down(void)
> > >  	BUG();
> > >  }
> > >  
> > > +int mcpm_cpu_power_down_finish(unsigned int cpu, unsigned int cluster)
> > > +{
> > > +	return platform_ops->power_down_finish(cpu, cluster);
> > > +}
> > 
> > Please make it return an error (non-zero return value) if platform_ops 
> > or platform_ops->power_down_finish is NULL.  Otherwise this would oops 
> > the kernel.
> > 
> > There is a patch already handling the other cases in RMK's patch system.
> 
> OK -- I didn't pay enough attention as that went past.
> 
> I'll grab that patch and rebase onto it.
> 
> 
> Do you have concerns about the mandatoriness of the new call?  The
> alternative would be to check for it at registration time and set
> smp_ops.cpu_kill to NULL if the backend method isn't there.
> But I really wouldn't want to encourage that until someone comes
> up with a good reason.

Agreed.  If for some reasons this method is unneeded on some platform 
then the backend just needs to return success unconditionally, ideally 
with a comment explaining why it is so.


Nicolas
