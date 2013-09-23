From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 23 Sep 2013 10:13:38 +0200
Subject: [PATCH v2 04/10] irqdomain: Return errors from
 irq_create_of_mapping()
In-Reply-To: <CAL_JsqLQeAQD460f8Lk9eDE2dCzLusC1mXZ-_uaKVFLfhJNryg@mail.gmail.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-5-git-send-email-treding@nvidia.com>
 <CAL_JsqLQeAQD460f8Lk9eDE2dCzLusC1mXZ-_uaKVFLfhJNryg@mail.gmail.com>
Message-ID: <20130923081337.GB11881@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 22, 2013 at 04:14:43PM -0500, Rob Herring wrote:
> On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > Instead of returning 0 for all errors, allow the precise error code to
> > be propagated. This will be used in subsequent patches to allow further
> > propagation of error codes.
> >
> > The interrupt number corresponding to the new mapping is returned in an
> > output parameter so that the return value is reserved to signal success
> > (== 0) or failure (< 0).
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> One comment below, otherwise:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> > index 905a24b..ae71b14 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -230,6 +230,7 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
> >  {
> >         struct of_irq oirq;
> >         unsigned int virq;
> > +       int ret;
> >
> >         pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
> >
> > @@ -266,8 +267,10 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
> >                          oirq.size, oirq.specifier[0], oirq.specifier[1],
> >                          of_node_full_name(oirq.controller));
> >
> > -               virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
> > -                                            oirq.size);
> > +               ret = irq_create_of_mapping(oirq.controller, oirq.specifier,
> > +                                           oirq.size, &virq);
> > +               if (ret)
> > +                       virq = NO_IRQ;
> >         }
> >         if(virq == NO_IRQ) {
> >                 pr_debug(" Failed to map !\n");
> 
> Can you get rid of NO_IRQ usage here instead of adding to it.

I was trying to stay consistent with the remainder of the code. PowerPC
is a pretty heavy user of NO_IRQ. Of all 348 references, more than half
(182) are in arch/powerpc, so I'd rather like to get a go-ahead from
Benjamin on this.

That said, perhaps we should just go all the way and get rid of NO_IRQ
for good. Things could get somewhat messy, though. There are a couple of
these spread through the code:

	#ifndef NO_IRQ
	#define NO_IRQ (-1)
	#endif

And this isn't very encouraging either:

	$ git grep 'irq.*=.*-1' | wc -l
	638

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/c73738f4/attachment-0001.sig>
