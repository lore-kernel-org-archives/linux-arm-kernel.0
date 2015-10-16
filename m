From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 16 Oct 2015 16:23:26 +0100
Subject: [PATCH 1/3] xen/arm: Enable cpu_hotplug.c
In-Reply-To: <561EDC7D.1050005@citrix.com>
References: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
 <1444844997-27314-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <561EDC7D.1050005@citrix.com>
Message-ID: <alpine.DEB.2.02.1510161623080.27957@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Oct 2015, Julien Grall wrote:
> Hi Stefano,
> 
> On 14/10/2015 18:49, Stefano Stabellini wrote:
> > Build cpu_hotplug for ARM and ARM64 guests.
> > 
> > Rename arch_(un)register_cpu to xen_(un)register_cpu and provide an
> > empty implementation on ARM and ARM64. On x86 just call
> > arch_(un)register_cpu as we are already doing.
> > 
> > Initialize cpu_hotplug on ARM.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >   arch/arm/include/asm/xen/hypervisor.h |    8 ++++++++
> >   arch/x86/include/asm/xen/hypervisor.h |    5 +++++
> >   arch/x86/xen/enlighten.c              |   15 +++++++++++++++
> >   drivers/xen/Makefile                  |    2 --
> >   drivers/xen/cpu_hotplug.c             |    6 ++++--
> >   5 files changed, 32 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/xen/hypervisor.h
> > b/arch/arm/include/asm/xen/hypervisor.h
> > index 04ff8e7..2bc418a 100644
> > --- a/arch/arm/include/asm/xen/hypervisor.h
> > +++ b/arch/arm/include/asm/xen/hypervisor.h
> > @@ -26,4 +26,12 @@ void __init xen_early_init(void);
> >   static inline void xen_early_init(void) { return; }
> >   #endif
> > 
> 
> I know that those helpers are empty for now. But I would prefer to see them
> protected by (FWIW, it's what you did for x86).
> 
> #ifdef CONFIG_CPU_HOTPLUG

Fair enough.


> > +static inline void xen_arch_register_cpu(int num)
> > +{
> > +}
> > +
> > +static inline void xen_arch_unregister_cpu(int num)
> > +{
> > +}
> > +
> 
> #endif
> 
> >   #endif /* _ASM_ARM_XEN_HYPERVISOR_H */
> 
> [...]
> 
> > diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
> > index cc6513a..122b351 100644
> > --- a/drivers/xen/cpu_hotplug.c
> > +++ b/drivers/xen/cpu_hotplug.c
> > @@ -11,7 +11,7 @@
> >   static void enable_hotplug_cpu(int cpu)
> >   {
> >   	if (!cpu_present(cpu))
> > -		arch_register_cpu(cpu);
> > +		xen_arch_register_cpu(cpu);
> > 
> >   	set_cpu_present(cpu, true);
> >   }
> > @@ -19,7 +19,7 @@ static void enable_hotplug_cpu(int cpu)
> >   static void disable_hotplug_cpu(int cpu)
> >   {
> >   	if (cpu_present(cpu))
> > -		arch_unregister_cpu(cpu);
> > +		xen_arch_unregister_cpu(cpu);
> > 
> >   	set_cpu_present(cpu, false);
> >   }
> > @@ -102,8 +102,10 @@ static int __init setup_vcpu_hotplug_event(void)
> >   	static struct notifier_block xsn_cpu = {
> >   		.notifier_call = setup_cpu_watcher };
> > 
> > +#ifdef CONFIG_X86
> >   	if (!xen_pv_domain())
> >   		return -ENODEV;
> > +#endif
> 
> For ARM, you need to check if it's a Xen domain. Otherwise a kernel aware of
> Xen won't boot on baremetal.

That's a good point!


> > 
> >   	register_xenstore_notifier(&xsn_cpu);
> > 
> > 
> 
> Regards,
> 
> -- 
> Julien Grall
> 
