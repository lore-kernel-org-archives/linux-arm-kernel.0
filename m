From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 9 Jul 2013 07:05:13 +0200
Subject: [PATCHv4 04/11] PCI: Introduce new MSI chip infrastructure
In-Reply-To: <20130708165149.55499b8e@skate>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo4aodspFnC0uR87yYAgswQQdmU48uoX5NA43UZjbCpOuw@mail.gmail.com>
 <20130708165149.55499b8e@skate>
Message-ID: <20130709050511.GB16232@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 04:51:49PM +0200, Thomas Petazzoni wrote:
> Dear Bjorn Helgaas,

Sorry for chiming in so late, I've had bad internet connectivity and
email access for a few days.

> On Fri, 5 Jul 2013 15:51:10 -0600, Bjorn Helgaas wrote:
>
> > >  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> > >  {
> > > +       struct msi_chip *chip = dev->bus->msi;
> > > +
> > > +       if (chip && chip->setup_irq) {
> > > +               int err;
> > > +
> > > +               err = chip->setup_irq(chip, dev, desc);
> > > +               if (err < 0)
> > > +                       return err;
> > > +
> > > +               irq_set_chip_data(desc->irq, chip);
> > > +               return err;
> > > +       }
> > > +
> > >         return -EINVAL;
> > 
> > It's sub-optimal to indent the whole body of a function like this.  I
> > think this is a bit more readable:
> > 
> >     if (!chip || !chip->setup_irq)
> >         return -EINVAL
> > 
> >     err = chip->setup_irq(...);
> >     ...
> >     return err;
> > 
> > The return value of ->setup_irq() (and hence of arch_setup_msi_irq())
> > is a bit unclear.  Apparently it can return negative values (errors)
> > or positive values (not sure what they mean), or zero (again, not
> > sure).  A comment would clear this up.
>
> I've changed ->setup_irq() to simply return 0 on success, and a
> negative error code on failure.
>
> Apparently, according to the default implementation
> of arch_msi_setup_irqs(), the arch_msi_setup_irq() hook is supposed to
> return:
>  * A negative value on error, the value being an error code that is
>    propagated to the caller.
>  * A positive value on some other errors, in which case the -ENOSPC
>    error value is returned. To me, it doesn't make a lot of sense, as
>    arch_msi_setup_irq() could just as well return -ENOSPC directly.
>  * A 0 value on success.

Yes, I think that'd be much more straightforward. Having > 0 as a
special case isn't useful here.

> > It might even be worth introducing a no-op chip with pointers to no-op
> > functions so we don't have to do these checks ("if (chip &&
> > chip->xxx)" everywhere.  I'm not sure if there's a Linux consensus on
> > that -- certainly there are many examples of code that *does* make
> > these checks everywhere -- so I'll ack it either way.
>
> The problem with this is that I'm not sure where in the PCI code this
> association to the default implementation should be done. And there are
> also two levels to take into account here:
>
>  * The PCI driver may not specify any msi_chip structure for a
>    particular pci_bus. This would have to be detected by the PCI core
>    when the bus is registered, and bus->msi would be set to the special
>    no-op msi_chip.

You could check if bus->msi was set after the call to pcibios_bus_add()
but that's a bit wonky because it may break once the first architecture
appears that assigns it in a different place.

>  * The PCI driver may specify an msi_chip structure, but without
>    necessarily implementation all the methods. This could be solved by
>    offering a pci_msi_chip_assign(struct pci_bus *, struct msi_chip *)
>    function to be used by PCI drivers to assign their msi_chip to a
>    given pci_bus, and this function would fill in the missing msi_chip
>    operations with the default implementation.
>
> I am not sure it is really worth doing at this point, but I'm open to
> suggestions on this.

I think these extra calls aren't that bad given how other alternatives
are much easier to break things. Perhaps checking for the methods could
be dropped, therefore making them mandatory (by crashing if they're not
implemented).

> > >  int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> > >  {
> > > +       struct msi_chip *chip = dev->bus->msi;
> > > +
> > > +       if (chip && chip->check_device)
> > > +               return chip->check_device(chip, dev, nvec, type);
> > > +
> > 
> > These functions are poorly named.  They give no clue what
> > "check_device" means.  Are we checking that it exists, that it
> > supports some property, that it's enabled, ... ?
>
> Well the naming clearly doesn't come from this commit. The
> arch_msi_check_device() hook was around before this commit, and the
> reason the operation is named ->check_device() is just because it used
> the same terminology as the existing arch_msi_check_device() call.
>
> This hook is only used in one place, the PowerPC architecture, in
> arch/powerpc/kernel/msi.c, to actually check whether the given device
> supports MSI.
>
> I can rename if to arch_msi_device_supports_msi() and
> ->device_supports_msi(), or arch_msi_device_has_msi() and
> ->device_has_msi(), but that a change that relatively unrelated to this
> commit, I'd say.
>
> Here as well, I'm open to suggestions,

I don't think *_check_device() is all that bad. Some of the
implementations in PowerPC only use it to output a debug message, others
do some more checking. Some of the checks look generic enough to move
them into the core.

If you rename it to *_has_msi() or *_supports_msi() then I'd expect it
to return a boolean and you loose the advantage of being able to return
a more meaningful value. Although I'm not sure how useful that error
code really is. It is passed all the way up to the caller of
pci_enable_msi(), so a driver could use it to construct a better error
message based on the error code. From a quick glance a few of them seem
to do that.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130709/d850b288/attachment.sig>
