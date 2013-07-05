From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 6 Jul 2013 00:08:16 +0200
Subject: [PATCHv4 04/11] PCI: Introduce new MSI chip infrastructure
In-Reply-To: <CAErSpo4aodspFnC0uR87yYAgswQQdmU48uoX5NA43UZjbCpOuw@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo4aodspFnC0uR87yYAgswQQdmU48uoX5NA43UZjbCpOuw@mail.gmail.com>
Message-ID: <20130706000816.3affe558@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Bjorn Helgaas,

On Fri, 5 Jul 2013 15:51:10 -0600, Bjorn Helgaas wrote:

> > ---
> >  drivers/pci/msi.c   | 22 ++++++++++++++++++++++
> >  drivers/pci/probe.c |  1 +
> >  include/linux/msi.h | 11 +++++++++++
> >  include/linux/pci.h |  1 +
> >  4 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 289fbfd..62eb3d5 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -32,15 +32,37 @@ static int pci_msi_enable = 1;
> >
> >  int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> >  {
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
> >         return -EINVAL;
> 
> It's sub-optimal to indent the whole body of a function like this.  I
> think this is a bit more readable:
> 
>     if (!chip || !chip->setup_irq)
>         return -EINVAL
> 
>     err = chip->setup_irq(...);
>     ...
>     return err;

Right.

> The return value of ->setup_irq() (and hence of arch_setup_msi_irq())
> is a bit unclear.  Apparently it can return negative values (errors)
> or positive values (not sure what they mean), or zero (again, not
> sure).  A comment would clear this up.

Ok, I'll have to look into this. Maybe Thierry Redding can comment on
this.

> It might even be worth introducing a no-op chip with pointers to no-op
> functions so we don't have to do these checks ("if (chip &&
> chip->xxx)" everywhere.  I'm not sure if there's a Linux consensus on
> that -- certainly there are many examples of code that *does* make
> these checks everywhere -- so I'll ack it either way.

Ok, I'll see if it makes the overall thing cleaner.


> >  int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> >  {
> > +       struct msi_chip *chip = dev->bus->msi;
> > +
> > +       if (chip && chip->check_device)
> > +               return chip->check_device(chip, dev, nvec, type);
> > +
> 
> These functions are poorly named.  They give no clue what
> "check_device" means.  Are we checking that it exists, that it
> supports some property, that it's enabled, ... ?

Maybe Thierry Redding can comment on this one?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
