From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 2 May 2013 11:38:12 +0100
Subject: [Xen-devel] [PATCH 3/3] xen/arm: account for stolen ticks
In-Reply-To: <1367482862.21869.28.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <1367482862.21869.28.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1305021134160.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 May 2013, Ian Campbell wrote:
> On Wed, 2013-05-01 at 20:27 +0100, Stefano Stabellini wrote:
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index d30042e..8f040a0 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -14,6 +14,7 @@
> >  #include <xen/xen-ops.h>
> >  #include <asm/xen/hypervisor.h>
> >  #include <asm/xen/hypercall.h>
> > +#include <asm/arch_timer.h>
> >  #include <asm/system_misc.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irqreturn.h>
> > @@ -172,6 +173,8 @@ static int __init xen_secondary_init(unsigned int cpu)
> >  		   later ones fail to. */
> >  		per_cpu(xen_vcpu, cpu) = vcpup;
> >  	}
> > +
> > +	xen_setup_runstate_info(cpu);
> 
> Is this called for the boot processor too?

Yep.

> (do you have a linux-next branch where I can easily find the baseline
> for this series?)

git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git lost_ticks_1

It's based on my 3.9-rc3-smp-6 branch currently in linux-next (that is
based on 3.9-rc3).
However lost_ticks_1 is not in linux-next yet.
