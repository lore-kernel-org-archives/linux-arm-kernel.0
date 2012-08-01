From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 1 Aug 2012 08:54:37 +0200
Subject: [PATCH v3 09/10] of: Add of_pci_parse_ranges()
In-Reply-To: <50183B03.2090809@gmail.com>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-10-git-send-email-thierry.reding@avionic-design.de>
 <50183B03.2090809@gmail.com>
Message-ID: <20120801065437.GB26791@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 03:07:31PM -0500, Rob Herring wrote:
> On 07/26/2012 02:55 PM, Thierry Reding wrote:
> > This new function parses the ranges property of PCI device nodes into
> > an array of struct resource elements. It is useful in multiple-port PCI
> > host controller drivers to collect information about the ranges that it
> > needs to forward to the respective ports.
> 
> It seems to me that some of the DT PCI code in arch/powerpc/kernel/pci*
> like pci_process_bridge_OF_ranges() should apply for ARM as well.
> 
> Each arch defining their own pci controller structs complicates this,
> but I would think at least the DT parsing can be common.

Yes, there's quite a lot of room for refactoring. When I first started
work on this there had been some discussion about whether it would make
sense to move PCI controller drivers into a common location to make it
easier to refactor but the consensus at the time was that this should
not be done.

I still think this might be worthwhile, but I have other things that I
need to finish first.

> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Changes in v3:
> > - new patch
> > 
> >  drivers/of/of_pci.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/of_pci.h |  2 ++
> >  2 files changed, 85 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
> > index 13e37e2..bcff301 100644
> > --- a/drivers/of/of_pci.c
> > +++ b/drivers/of/of_pci.c
> > @@ -1,7 +1,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/export.h>
> > -#include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_pci.h>
> > +#include <linux/slab.h>
> >  #include <asm/prom.h>
> >  
> >  static inline int __of_pci_pci_compare(struct device_node *node,
> > @@ -40,3 +41,84 @@ struct device_node *of_pci_find_child_device(struct device_node *parent,
> >  	return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(of_pci_find_child_device);
> > +
> > +struct resource *of_pci_parse_ranges(struct device_node *node,
> > +				     unsigned int *countp)
> > +{
> > +	unsigned int count, i = 0;
> > +	struct resource *ranges;
> 
> I think res or pci_res would be clearer than ranges that this is a
> struct resource.

"range" is the term used by the PCI specifications to denote these
regions. I don't see what's wrong with using it as a variable name.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120801/7826e0d5/attachment.sig>
