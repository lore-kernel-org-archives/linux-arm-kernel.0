From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Thu, 28 Jun 2018 09:12:07 +0800
Subject: [PATCH 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
In-Reply-To: <CAHp75Ve2N_Bt8FvX8xCx3JtQ+ozZE=isfsKp9swY+86Cg-78XQ@mail.gmail.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
 <1530091298-28120-2-git-send-email-honghui.zhang@mediatek.com>
 <CAHp75Ve2N_Bt8FvX8xCx3JtQ+ozZE=isfsKp9swY+86Cg-78XQ@mail.gmail.com>
Message-ID: <1530148327.28284.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-06-27 at 19:35 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> >
> > Mediatek's host controller have two slots, each have it's own control
> > registers. The host driver need to identify which slot was connected
> > in order to access the device's configuration space. There's problem
> > for current host driver to find out which slot was connected to for
> > a given EP device.
> >
> > Assuming each slot have connect with one EP device as below:
> >
> >                 host bridge
> >   bus 0 --> __________|_______
> >            |                  |
> >            |                  |
> >          slot 0             slot 1
> >   bus 1 -->|        bus 2 --> |
> >            |                  |
> >          EP 0               EP 1
> >
> > While PCI emulation, system software will scan all the PCI device
> > starting from devfn 0. So it will get the proper port for slot0 and
> > slot1 device when using PCI_SLOT(devfn) for match. But it will get
> > the wrong slot for EP1: The devfn will be start from 0 when scanning
> > EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> > for port0's slot value. So the host driver should not using EP's devfn
> > but the slot's devfn(the slot which EP was connected to) for match.
> >
> > This patch fix the mtk_pcie_find_port's logical by using the slot's
> > devfn for match.
> 
> 
> > +       list_for_each_entry(port, &pcie->ports, list) {
> > +               if (bus->number == 0 && port->slot == PCI_SLOT(devfn)) {
> >                         return port;
> > +               } else if (bus->number != 0) {
> 
> You can do it like (no need 'else')
> 
> if (...)
>  return ...;
> if (bus->number) {
>  ...
> }
> 
> > +                       pbus = bus;
> > +                       do {
> > +                               dev = pbus->self;
> > +                               if (port->slot == PCI_SLOT(dev->devfn))
> > +                                       return port;
> > +
> > +                               pbus = dev->bus;
> > +                       } while (dev->bus->number != 0);
> 
> This can be rewritten like
> 
> pbus = bus;
> while (pbus->number) {
>  dev = ...;
>  ...
>  pbus = dev->bus;
> }
> 
> and no need for if (bus->number) anymore.
> 

Hi, Andy, thanks very much for your advise, I will change it in the next
version.

thanks.
> > +               }
> > +       }
> >
> >         return NULL;
> >  }
> > --
> > 2.6.4
> >
> 
> 
> 
