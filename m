From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 31 May 2013 14:25:20 +0100
Subject: [PATCH RFC 2/6] arm64/xen: arm/xen header changes to compile on
 arm64
In-Reply-To: <20130531104303.GB18045@localhost.cambridge.arm.com>
References: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
 <1369930713-6063-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130531104303.GB18045@localhost.cambridge.arm.com>
Message-ID: <alpine.DEB.2.02.1305311422250.4799@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 May 2013, Catalin Marinas wrote:
> On Thu, May 30, 2013 at 05:18:29PM +0100, Stefano Stabellini wrote:
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  arch/arm/include/asm/xen/events.h |    4 ++++
> >  arch/arm/include/asm/xen/page.h   |    2 ++
> >  2 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
> > index 8b1f37b..12e4e0b 100644
> > --- a/arch/arm/include/asm/xen/events.h
> > +++ b/arch/arm/include/asm/xen/events.h
> > @@ -13,7 +13,11 @@ enum ipi_vector {
> >  
> >  static inline int xen_irqs_disabled(struct pt_regs *regs)
> >  {
> > +#ifdef CONFIG_ARM
> >  	return raw_irqs_disabled_flags(regs->ARM_cpsr);
> > +#else
> > +	return raw_irqs_disabled_flags((unsigned long) regs->pstate);
> > +#endif
> >  }
> 
> At least for this part, it makes sense to live in the arch/arm64
> directory.

Yes, good idea, there isn't much else in that header file anyway.


> >  #define xchg_xen_ulong(ptr, val) atomic64_xchg(container_of((ptr),	\
> > diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
> > index 30cdacb..cb2fa15 100644
> > --- a/arch/arm/include/asm/xen/page.h
> > +++ b/arch/arm/include/asm/xen/page.h
> > @@ -1,7 +1,9 @@
> >  #ifndef _ASM_ARM_XEN_PAGE_H
> >  #define _ASM_ARM_XEN_PAGE_H
> >  
> > +#ifdef ARM
> >  #include <asm/mach/map.h>
> > +#endif
> >  #include <asm/page.h>
> >  #include <asm/pgtable.h>
> 
> Is there anything ARM-specific in this file?

The only ARM-specific stuff here is the definition of xen_remap, like
you have spotted in the other email. The inclusion of asm/mach/map.h is
needed because it containes the definition of MT_MEMORY.
