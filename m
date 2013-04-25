From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 25 Apr 2013 17:48:56 +0100
Subject: [PATCH v4 2/7] xen/arm: SMP support
In-Reply-To: <1366897221.20256.544.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1304242012590.4180@kaball.uk.xensource.com>
 <1366831695-13214-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <1366897221.20256.544.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1304251503100.4180@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Apr 2013, Ian Campbell wrote:
> On Wed, 2013-04-24 at 20:28 +0100, Stefano Stabellini wrote:
> > Map vcpu_info using VCPUOP_register_vcpu_info on secondary cpus.
> > 
> > Call enable_percpu_irq on every cpu.
> > 
> > Changed in v2:
> > - move the percpu variable argument fix to a separate patch;
> > - remove unused variable.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  arch/arm/xen/enlighten.c |   38 +++++++++++++++++++++++++++++++++++++-
> >  1 files changed, 37 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index 99ce189..94bbf3b 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -2,6 +2,7 @@
> >  #include <xen/events.h>
> >  #include <xen/grant_table.h>
> >  #include <xen/hvm.h>
> > +#include <xen/interface/vcpu.h>
> >  #include <xen/interface/xen.h>
> >  #include <xen/interface/memory.h>
> >  #include <xen/interface/hvm/params.h>
> > @@ -32,6 +33,7 @@ struct shared_info xen_dummy_shared_info;
> >  struct shared_info *HYPERVISOR_shared_info = (void *)&xen_dummy_shared_info;
> >  
> >  DEFINE_PER_CPU(struct vcpu_info *, xen_vcpu);
> > +DEFINE_PER_CPU(struct vcpu_info, xen_vcpu_info);
> 
> >  /* These are unused until we support booting "pre-ballooned" */
> >  unsigned long xen_released_pages;
> > @@ -148,6 +150,32 @@ int xen_unmap_domain_mfn_range(struct vm_area_struct *vma,
> >  }
> >  EXPORT_SYMBOL_GPL(xen_unmap_domain_mfn_range);
> >  
> > +static int __init xen_secondary_init(unsigned int cpu)
> > +{
> > +	struct vcpu_register_vcpu_info info;
> > +	struct vcpu_info *vcpup;
> > +	int err;
> > +
> > +	if (cpu == 0)
> > +		return 0;
> > +
> > +	pr_info("Xen: initializing cpu%d\n", cpu);
> > +	vcpup = &per_cpu(xen_vcpu_info, cpu);
> > +
> > +	info.mfn = __pa(vcpup) >> PAGE_SHIFT;
> > +	info.offset = offset_in_page(vcpup);
> 
> Do you need to somehow guarantee it's not going to cross a page? Maybe
> standard C alignment rules make that the case?

That is a good question, I don't think that DEFINE_PER_CPU makes any
alignment guarantees (standard C alignment aside).
I'll switch to __alloc_percpu that allows me to specify an alignment and
has the advantage of being dynamically allocated.


> > @@ -216,6 +245,8 @@ static int __init xen_guest_init(void)
> >  	 * is required to use VCPUOP_register_vcpu_info to place vcpu info
> >  	 * for secondary CPUs as they are brought up. */
> >  	per_cpu(xen_vcpu, 0) = &HYPERVISOR_shared_info->vcpu_info[0];
> > +	for_each_online_cpu(i)
> > +		xen_secondary_init(i);
> >  
> >  	gnttab_init();
> >  	if (!xen_initial_domain())
> [...]
> > @@ -244,7 +280,7 @@ static int __init xen_init_events(void)
> >  		return -EINVAL;
> >  	}
> >  
> > -	enable_percpu_irq(xen_events_irq, 0);
> > +	on_each_cpu(xen_percpu_enable_events, NULL, 0);
> 
> It feels like there ought to be some sort of per-cpu bringup callback
> which takes care of these dynamically. Maybe that doesn't matter until
> we get vcpu hotplug going?

I suspect there isn't one, considering that on_each_cpu is also used by 
kvm_vgic_hyp_init, kvm_timer_hyp_init and others.
