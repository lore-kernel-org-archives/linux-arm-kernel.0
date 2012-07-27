From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Jul 2012 15:25:47 +0100
Subject: [PATCH 13/24] xen/arm: get privilege status
In-Reply-To: <1343382276.6812.126.camel@zakaz.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-13-git-send-email-stefano.stabellini@eu.citrix.com>
 <1343382276.6812.126.camel@zakaz.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1207271514140.26163@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jul 2012, Ian Campbell wrote:
> On Thu, 2012-07-26 at 16:33 +0100, Stefano Stabellini wrote:
> > Use Xen features to figure out if we are privileged.
> > 
> > XENFEAT_dom0 was introduced by 23735 in xen-unstable.hg.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  arch/arm/xen/enlighten.c         |    7 +++++++
> >  include/xen/interface/features.h |    3 +++
> >  2 files changed, 10 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > index dc68074..2e013cf 100644
> > --- a/arch/arm/xen/enlighten.c
> > +++ b/arch/arm/xen/enlighten.c
> > @@ -2,6 +2,7 @@
> >  #include <xen/interface/xen.h>
> >  #include <xen/interface/memory.h>
> >  #include <xen/platform_pci.h>
> > +#include <xen/features.h>
> >  #include <asm/xen/hypervisor.h>
> >  #include <asm/xen/hypercall.h>
> >  #include <linux/module.h>
> > @@ -58,6 +59,12 @@ int __init xen_guest_init(void)
> >  	}
> >  	xen_domain_type = XEN_HVM_DOMAIN;
> >  
> > +	xen_setup_features();
> > +	if (xen_feature(XENFEAT_dom0))
> > +		xen_start_info->flags |= SIF_INITDOMAIN|SIF_PRIVILEGED;
> > +	else
> > +		xen_start_info->flags &= ~(SIF_INITDOMAIN|SIF_PRIVILEGED);
> 
> What happens here on platforms prior to hypervisor changeset 23735?

It wouldn't work.
Considering that we are certainly not going to backport ARM support to
Xen 4.1, and that both ARM and XENFEAT_dom0 will be present in Xen 4.2,
do we really need to support the Xen unstable changesets between ARM was
introduced and XENFEAT_dom0 appeared?
