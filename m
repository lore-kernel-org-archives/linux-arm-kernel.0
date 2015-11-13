From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 13 Nov 2015 18:10:22 +0000
Subject: [Xen-devel] [PATCH v4 2/7] xen/arm: introduce
 HYPERVISOR_platform_op on arm and arm64
In-Reply-To: <5645E868.30706@citrix.com>
References: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
 <1447349448-22610-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <5645E868.30706@citrix.com>
Message-ID: <alpine.DEB.2.02.1511131757360.2653@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Nov 2015, Julien Grall wrote:
> Hi Stefano,
> 
> On 12/11/15 17:30, Stefano Stabellini wrote:
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > 
> > ---
> > 
> > Changes in v2:
> > - rename dom0_op to platform_op
> > ---
> >  arch/arm/include/asm/xen/hypercall.h |    2 ++
> >  arch/arm/xen/enlighten.c             |    1 +
> >  arch/arm/xen/hypercall.S             |    1 +
> >  arch/arm64/xen/hypercall.S           |    1 +
> >  4 files changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
> > index 712b50e..c3e00d0 100644
> > --- a/arch/arm/include/asm/xen/hypercall.h
> > +++ b/arch/arm/include/asm/xen/hypercall.h
> > @@ -35,6 +35,7 @@
> >  
> >  #include <xen/interface/xen.h>
> >  #include <xen/interface/sched.h>
> > +#include <xen/interface/platform.h>
> >  
> >  long privcmd_call(unsigned call, unsigned long a1,
> >  		unsigned long a2, unsigned long a3,
> > @@ -49,6 +50,7 @@ int HYPERVISOR_memory_op(unsigned int cmd, void *arg);
> >  int HYPERVISOR_physdev_op(int cmd, void *arg);
> >  int HYPERVISOR_vcpu_op(int cmd, int vcpuid, void *extra_args);
> >  int HYPERVISOR_tmem_op(void *arg);
> > +int HYPERVISOR_platform_op(void *arg);
> 
> int HYPERVISOR_platform_op(struct xen_platform_op *platform_op) to allow
> compiler type checking and match the x86 version.

Yeah, I am just following the same pattern as the others


> Also, the implementation of the helper differ from x86. On x86, the
> helper takes care of setting the interface_version while here you
> request the caller to do it.
> 
> It's better if we have similar requirement across the architecture as
> this helpers may be called from common code.

I agree with your point (I thought about it myself) but the current
assembly scheme for hypercalls doesn't work well with that. I would have
to introduce, and maintain going forward, two special hypercall
implementations in assembly, one for arm and another for arm64, just to
set interface_version. I don't think it is worth it; I prefer to have to
maintain the explicit interface_version setting at the call sites (that
today is just one).
