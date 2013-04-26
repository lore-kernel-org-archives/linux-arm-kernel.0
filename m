From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 26 Apr 2013 11:27:00 +0100
Subject: [PATCH v4 2/7] xen/arm: SMP support
In-Reply-To: <1366966304.3142.33.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1304242012590.4180@kaball.uk.xensource.com>
 <1366831695-13214-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <1366897221.20256.544.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1304251503100.4180@kaball.uk.xensource.com>
 <1366909184.3142.0.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1304251945290.4180@kaball.uk.xensource.com>
 <1366966304.3142.33.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1304261125440.4180@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Apr 2013, Ian Campbell wrote:
> On Thu, 2013-04-25 at 19:45 +0100, Stefano Stabellini wrote:
> > On Thu, 25 Apr 2013, Ian Campbell wrote:
> > > > > > @@ -216,6 +245,8 @@ static int __init xen_guest_init(void)
> > > > > >  	 * is required to use VCPUOP_register_vcpu_info to place vcpu info
> > > > > >  	 * for secondary CPUs as they are brought up. */
> > > > > >  	per_cpu(xen_vcpu, 0) = &HYPERVISOR_shared_info->vcpu_info[0];
> > > > > > +	for_each_online_cpu(i)
> > > > > > +		xen_secondary_init(i);
> > > > > >  
> > > > > >  	gnttab_init();
> > > > > >  	if (!xen_initial_domain())
> > > > > [...]
> > > > > > @@ -244,7 +280,7 @@ static int __init xen_init_events(void)
> > > > > >  		return -EINVAL;
> > > > > >  	}
> > > > > >  
> > > > > > -	enable_percpu_irq(xen_events_irq, 0);
> > > > > > +	on_each_cpu(xen_percpu_enable_events, NULL, 0);
> > > > > 
> > > > > It feels like there ought to be some sort of per-cpu bringup callback
> > > > > which takes care of these dynamically. Maybe that doesn't matter until
> > > > > we get vcpu hotplug going?
> > > > 
> > > > I suspect there isn't one, considering that on_each_cpu is also used by 
> > > > kvm_vgic_hyp_init, kvm_timer_hyp_init and others.
> > > 
> > > Could we use cpu_notifiers for this?
> > 
> > cpu_notifiers are for cpu hotplug, not for secondary cpu bringup
> 
> Are you sure they don't also trigger during bringup, because the
> distinction is a little bit academic...

My mistake, they do run on secondary cpus, but not in our case because
xen_guest_init is called *after* cpu_notifiers are called.
So, they are too early for Xen.
