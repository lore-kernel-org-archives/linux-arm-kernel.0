From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 7 Sep 2017 10:52:37 -0600
Subject: [PATCH v3 3/3] PCI: Avoid slot reset for Cavium cn8xxx root ports
In-Reply-To: <20170907074904.GB13490@hc>
References: <20170830142454.10971-1-jglauber@cavium.com>
 <20170830142454.10971-4-jglauber@cavium.com>
 <20170830084012.19d91759@w520.home> <20170831094052.GA15906@hc>
 <20170831100130.5c8a922e@w520.home> <20170907074011.GA13490@hc>
 <20170907074904.GB13490@hc>
Message-ID: <20170907105237.3f025280@w520.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Sep 2017 09:49:04 +0200
Jan Glauber <jan.glauber@caviumnetworks.com> wrote:

> On Thu, Sep 07, 2017 at 09:40:11AM +0200, Jan Glauber wrote:
> > So what if we add an additional check like:
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index fdf65a6..389db4b 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4389,6 +4389,9 @@ static bool pci_slot_resetable(struct pci_slot *slot)
> >  {
> >         struct pci_dev *dev;
> >  
> > +       if (slot->bus->self & PCI_DEV_FLAGS_NO_BUS_RESET)
> > +               return false;
> > +
> >         list_for_each_entry(dev, &slot->bus->devices, bus_list) {
> >                 if (!dev->slot || dev->slot != slot)
> >                         continue;  
> 
> Obviously I meant:
> if (slot->bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)

Much better, perhaps even incorporate the bus->self check for good
measure... is it possible to have a slot on a root bus?  Taking
different approaches for bus vs slot reset should have been a giant red
flag that something is wrong.  Thanks,

Alex
