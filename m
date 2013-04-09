From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 9 Apr 2013 10:18:50 +0200
Subject: [RFCv1 08/11] PCI: Introduce new MSI chip infrastructure
In-Reply-To: <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
Message-ID: <20130409081850.GB27255@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 04:28:58PM -0600, Bjorn Helgaas wrote:
> On Tue, Mar 26, 2013 at 10:52 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > From: Thierry Reding <thierry.reding@avionic-design.de>
> >
> > The new struct msi_chip is used to associated an MSI controller with a
> > PCI bus. It is automatically handed down from the root to its children
> > during bus enumeration.
> >
> > This patch provides default (weak) implementations for the architecture-
> > specific MSI functions (arch_setup_msi_irq(), arch_teardown_msi_irq()
> > and arch_msi_check_device()) which check if a PCI device's bus has an
> > attached MSI chip and forward the call appropriately.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  drivers/pci/msi.c   |   35 +++++++++++++++++++++++++++++++----
> >  drivers/pci/probe.c |    1 +
> >  include/linux/msi.h |   10 ++++++++++
> >  include/linux/pci.h |    1 +
> >  4 files changed, 43 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 00cc78c..fce3549 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -26,14 +26,41 @@
> >
> >  static int pci_msi_enable = 1;
> >
> > -/* Arch hooks */
> > +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> > +{
> > +       struct msi_chip *chip = dev->bus->msi;
> > +
> > +       if (chip && chip->setup_irq) {
> > +               int err;
> > +
> > +               err = chip->setup_irq(chip, dev, desc);
> > +               if (err < 0)
> > +                       return err;
> > +
> > +               irq_set_chip_data(desc->irq, chip);
> > +               return err;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> >
> > -#ifndef arch_msi_check_device
> > -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> > +void __weak arch_teardown_msi_irq(unsigned int irq)
> >  {
> > +       struct msi_chip *chip = irq_get_chip_data(irq);
> > +
> > +       if (chip && chip->teardown_irq)
> > +               chip->teardown_irq(chip, irq);
> > +}
> > +
> > +int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> 
> I like the replacement of "#ifndef arch_msi_check_device()" with a
> weak implementation here, but this only does half the job -- shouldn't
> we remove the powerpc "#define arch_msi_check_device
> arch_msi_check_device" at the same time?

Yes, there are a few things that can be done to cleanup the "mess"
around this subsequently. For instance I have a local patch which
completely removes the ARCH_SUPPORTS_MSI symbol because it isn't
useful after making the symbols weak. One other obvious item is to
convert more architectures to implement an MSI chip.

> And since we're touching all the check_device() implementations, maybe
> we could come up with a better name.  "check_device()" conveys
> absolutely no information about what we're checking or what the sense
> of the result is.  arch_msi_supported()?  pcibios_msi_supported()?  I
> guess it should be consistent with the other arch interfaces, so
> arch_*() is probably better.

At least on PowerPC the arch_msi_check_device() hook also refuses to
setup multiple MSI per device because it isn't supported. I can't think
of a better alternative than arch_msi_supported(), though so that's fine
with me.

Perhaps pcibios_msi_supported() wouldn't be so bad either. Other
architecture-specific functions already use that prefix (see the OF
support functions) and it might be good to settle on one convention for
consistency.

That said, the goal is to eventually get rid of all the arch_msi_*()
functions. The only reason they are still there is because I didn't want
to convert everything in one go. So I wanted to put the infrastructure
in place that we need to support multi-platform on ARM (which is given
by this generic MSI chip infrastructure). Later the remaining PCI
architectures can be converted to provide an msi_chip as well, at which
point the now weak implementations can become non-weak and be renamed to
something like pci_{setup,teardown,check}_msi() to make it more obvious
that they are generic.

> Maybe the ugly #ifdef-ery around arch_setup_msi_irqs,
> arch_teardown_msi_irqs, and arch_restore_msi_irqs could be cleaned up
> similarly?  Somebody worked pretty hard to obfuscate all that,
> probably before weak functions were available.

I think Andrew or Jason at one point commented whether they should be
allowed to be implemented by an MSI chip. If so we could use the same
approach as for the other functions.

> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index b494066..9307550 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -634,6 +634,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
> >
> >         child->parent = parent;
> >         child->ops = parent->ops;
> > +       child->msi = parent->msi;
> >         child->sysdata = parent->sysdata;
> >         child->bus_flags = parent->bus_flags;
> >
> > diff --git a/include/linux/msi.h b/include/linux/msi.h
> > index ce93a34..ea4a5be 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -58,5 +58,15 @@ extern int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> >  extern void arch_teardown_msi_irqs(struct pci_dev *dev);
> >  extern int arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
> >
> > +struct msi_chip {
> > +       struct module *owner;
> > +       struct device *dev;
> > +
> > +       int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
> > +                        struct msi_desc *desc);
> > +       void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
> > +       int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
> > +                           int nvec, int type);
> 
> If we do end up adding interfaces like this (I'm not sure it will work
> -- see below), I think it would be better to pass just the pci_dev,
> not the "msi_chip, pci_dev" pair.  Passing both pointers avoids a
> cheap lookup in the caller, but it adds a way that two inseparable
> things can get out of sync.

Yes, that's a good idea and we can easily do that.

> > +};
> >
> >  #endif /* LINUX_MSI_H */
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 2461033a..6aca43ea 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -416,6 +416,7 @@ struct pci_bus {
> >         struct resource busn_res;       /* bus numbers routed to this bus */
> >
> >         struct pci_ops  *ops;           /* configuration access functions */
> > +       struct msi_chip *msi;           /* MSI controller */
> 
> "msi" seems like a too-generic name here; it suggests an interrupt or
> IRQ, not a controller.

It's short and to the point. The bus abstraction doesn't really have any
interrupt functionality, has it? Even for PCI devices the MSI interrupt
number is actually stored in the .irq field, so I don't think it's too
generic. But if you insist I'll think of another name.

> I'm not sure this is the correct place for it.  Having it in the
> struct pci_bus means you need arch code to fill it in, e.g., you added
> it in mvebu_pcie_scan_bus() in patch 09/11.  There's no good way to do
> that for arches that use pci_scan_root_bus(), which is the direction
> I'd like to go.

We could add an argument to pci_scan_root_bus() to pass this information
in. It's a bit ugly but see below...

> I think it probably should go in sysdata instead.  That would mean you
> can't really do generic weak setup/tear-down functions, because they
> wouldn't know how to pull the MSI controller info out of the
> arch-specific sysdata.  But there are so many levels of weak-ness
> going on there, maybe it would be a good thing to get rid of one :)

Isn't putting more data into sysdata a step in the opposite direction of
where we want to go? I seem to remember some discussion about wanting to
consolidate the various architecture-specific implementations and move
more common code into the PCI core. If we handle the whole MSI business
in architecture-specific code we gain little to nothing compared to the
current situation.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130409/e25780af/attachment-0001.sig>
