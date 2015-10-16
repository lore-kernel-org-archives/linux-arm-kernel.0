From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 16 Oct 2015 16:31:08 +0100
Subject: [PATCH 3/3] xen/arm: don't try to re-register vcpu_info on
 cpu_hotplug.
In-Reply-To: <561ED80D.9020905@citrix.com>
References: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
 <1444844997-27314-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <561ED80D.9020905@citrix.com>
Message-ID: <alpine.DEB.2.02.1510161629450.27957@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Oct 2015, Julien Grall wrote:
> Hi Stefano,
> 
> On 14/10/2015 18:49, Stefano Stabellini wrote:
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >   arch/arm/xen/enlighten.c |    6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index 6c09cc4..59f5421 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -93,6 +93,12 @@ static void xen_percpu_init(void)
> >   	int err;
> >   	int cpu = get_cpu();
> > 
> > +	/* vcpu_info already registered, can happen with cpu-hotplug */
> 
> Can you please add more comment and explain in the commit message why this is
> necessary for cpu-hotplug?
> 
> I had to look at the x86 code to fully understand that it's not possible to
> call VCPUOP_register_vcpu_info twice because there is no hypercall to remove
> the vcpu shared page.

Sure


> 
> > +	if (per_cpu(xen_vcpu, cpu) != NULL) {
> > +		put_cpu();
> > +		return;
> > +	}
> > +
> >   	pr_info("Xen: initializing cpu%d\n", cpu);
> >   	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
> > 
> > 
> 
> Regards,
> 
> -- 
> Julien Grall
> 
