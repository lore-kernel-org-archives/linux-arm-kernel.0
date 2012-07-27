From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 27 Jul 2012 15:51:25 +0100
Subject: [PATCH 07/24] xen/arm: Xen detection and shared_info page mapping
In-Reply-To: <alpine.DEB.2.02.1207271545440.26163@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-7-git-send-email-stefano.stabellini@eu.citrix.com>
 <1343381813.6812.120.camel@zakaz.uk.xensource.com>
 <alpine.DEB.2.02.1207271545440.26163@kaball.uk.xensource.com>
Message-ID: <1343400685.25096.15.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-27 at 15:48 +0100, Stefano Stabellini wrote:
> On Fri, 27 Jul 2012, Ian Campbell wrote:
> > On Thu, 2012-07-26 at 16:33 +0100, Stefano Stabellini wrote:
> > > Check for a "/xen" node in the device tree, if it is present set
> > > xen_domain_type to XEN_HVM_DOMAIN and continue initialization.
> > > 
> > > Map the real shared info page using XENMEM_add_to_physmap with
> > > XENMAPSPACE_shared_info.
> > > 
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > ---
> > >  arch/arm/xen/enlighten.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 files changed, 56 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > > index d27c2a6..8c923af 100644
> > > --- a/arch/arm/xen/enlighten.c
> > > +++ b/arch/arm/xen/enlighten.c
> > > @@ -5,6 +5,9 @@
> > >  #include <asm/xen/hypervisor.h>
> > >  #include <asm/xen/hypercall.h>
> > >  #include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_irq.h>
> > > +#include <linux/of_address.h>
> > >  
> > >  struct start_info _xen_start_info;
> > >  struct start_info *xen_start_info = &_xen_start_info;
> > > @@ -33,3 +36,56 @@ int xen_remap_domain_mfn_range(struct vm_area_struct *vma,
> > >  	return -ENOSYS;
> > >  }
> > >  EXPORT_SYMBOL_GPL(xen_remap_domain_mfn_range);
> > > +
> > > +/*
> > > + * == Xen Device Tree format ==
> > > + * - /xen node;
> > > + * - compatible "arm,xen";
> > > + * - one interrupt for Xen event notifications;
> > > + * - one memory region to map the grant_table.
> > > + */
> > > +static int __init xen_guest_init(void)
> > > +{
> > > +	int cpu;
> > > +	struct xen_add_to_physmap xatp;
> > > +	static struct shared_info *shared_info_page = 0;
> > > +	struct device_node *node;
> > > +
> > > +	node = of_find_compatible_node(NULL, NULL, "arm,xen");
> > > +	if (!node) {
> > > +		pr_info("No Xen support\n");
> > > +		return 0;
> > > +	}
> > 
> > This should either only print in the success case (to avoid spamming
> > everyone) or we need a little bit of infrastructure like on x86 so that
> > we print exactly one of:
> > 	"Booting natively on bearmetal"
> > 	"Booting paravirtualised on %s", hypervisor->name
> 
> This function is only going to be called once (actually it might be
> called twice with the change introduced by "xen/arm: Introduce
> xen_guest_init").

Once (or twice), per boot, per ARM system running Linux in the world...

Ian.
