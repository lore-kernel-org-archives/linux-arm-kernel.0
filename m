From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 19 Oct 2015 11:10:44 +0100
Subject: [PATCH v2 3/3] xen/arm: don't try to re-register vcpu_info on
 cpu_hotplug.
In-Reply-To: <56212A9F.5070202@citrix.com>
References: <alpine.DEB.2.02.1510161731510.27957@kaball.uk.xensource.com>
 <1445013301-12624-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <56212A9F.5070202@citrix.com>
Message-ID: <alpine.DEB.2.02.1510191109130.27957@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Oct 2015, Julien Grall wrote:
> Hi Stefano,
> 
> On 16/10/15 17:35, Stefano Stabellini wrote:
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  arch/arm/xen/enlighten.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index 6c09cc4..b193811 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -93,6 +93,16 @@ static void xen_percpu_init(void)
> >  	int err;
> >  	int cpu = get_cpu();
> >  
> > +	/* 
> > +	 * VCPUOP_register_vcpu_info cannot be called twice for the same
> > +	 * vcpu, so if vcpu_info is already registered, just get out. This
> > +	 * can happen with cpu-hotplug.
> > +	 */
> > +	if (per_cpu(xen_vcpu, cpu) != NULL) {
> > +		put_cpu();
> > +		return;
> > +	}
> 
> 
> Not really related to this patch. By side effect this patch is also not
> calling irq_percpu_enable.
> 
> Looking around, all the caller of irq_percpu_enable will call
> irq_percpu_disable when the CPU is dying. Is there any side effect to
> not doing this?

Given that Xen won't inject any event irqs when a cpu is offline, I
don't think there are any side effects.


> > +
> >  	pr_info("Xen: initializing cpu%d\n", cpu);
> >  	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
> >  
> > 
> 
> 
> -- 
> Julien Grall
> 
