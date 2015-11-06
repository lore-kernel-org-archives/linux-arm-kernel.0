From: stefano.stabellini@citrix.com (Stefano Stabellini)
Date: Fri, 6 Nov 2015 11:39:18 +0000
Subject: [PATCH v11 5/5] xen/arm: account for stolen ticks
In-Reply-To: <20151105165743.GG32247@leverpostej>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <20151105165743.GG32247@leverpostej>
Message-ID: <alpine.DEB.2.02.1511061126500.13541@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Nov 2015, Mark Rutland wrote:
> >  static void xen_percpu_init(void)
> >  {
> >  	struct vcpu_register_vcpu_info info;
> > @@ -104,6 +120,8 @@ static void xen_percpu_init(void)
> >  	BUG_ON(err);
> >  	per_cpu(xen_vcpu, cpu) = vcpup;
> >  
> > +	xen_setup_runstate_info(cpu);
> 
> Does the runstate memory area get unregsitered when a kernel tears
> things down, or is kexec somehow inhibited for xen guests?
> 
> i couldn't spot either happening, but I may have missed it.

I don't think that the runstate memory area needs to be unregistered for
kexec, but I am not very knowledgeble on kexec and Xen, CC'ing Vitaly
and David.


> > +
> >  after_register_vcpu_info:
> >  	enable_percpu_irq(xen_events_irq, 0);
> >  	put_cpu();
> > @@ -271,6 +289,9 @@ static int __init xen_guest_init(void)
> >  
> >  	register_cpu_notifier(&xen_cpu_notifier);
> >  
> > +	pv_time_ops.steal_clock = xen_stolen_accounting;
> > +	static_key_slow_inc(&paravirt_steal_enabled);
> > +
> >  	return 0;
> >  }
> >  early_initcall(xen_guest_init);
> > -- 
> > 1.7.10.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
