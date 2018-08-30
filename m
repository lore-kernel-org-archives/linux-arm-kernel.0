From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Aug 2018 16:07:39 +0200
Subject: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
In-Reply-To: <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
 <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
 <CAK8P3a2CMcYg6vMmRAc4N80BpFwczGiPnaLNCDZYXCsRydtPQw@mail.gmail.com>
 <CA+sq2Ce3ew0X+RMm7fQ+iUZF0HKptzBr1dBk3NuRL8o82wBTjg@mail.gmail.com>
Message-ID: <CAK8P3a1oeOFVYc2xH+KO1gV0m9utHziGpNtQLAEv-RBxKkB7Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 3:10 PM Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:
>
> > > > If this is a regular PCI ethernet driver, why do you put it into driver/soc
> > > > rather than drivers/net/ethernet/ ?
> > >
> > > No, this is not a ethernet driver, as mentioned in the cover letter
> > > this driver and AF driver doesn't
> > > handle any IO. There will be a separate ethernet driver (will submit
> > > that as well in future) which will
> > > communicate with these drivers for configuring hardware.
> > >
> > > The driver in question here is for a serdes controller which handles
> > > physical ethernet interfaces.
> > > Admin function driver gathers info w.r.t current state of physical
> > > ethernet interfaces from this driver
> > > and notifies actual ethernet driver about changes, if any.
> >
> > Ok. Can you describe the structure that the PCI devices appear
> > in? It might help to be make the connection between the differnet
> > patches to understand how things fit together. In the final
> > picture, how many different pci_driver instances do you have,
> > and what part are they for?
>
> List of PCI devices are CGX, RVU PF0-PFn SRIOV physical functions
> and RVU VF0-VFn SRIOV virtual functions. No of VFs per PF is configurable
> and done by low level firmware.
>
> List of PCI driver instances would be CGX driver, RVU PF0 (i.e admin
> function) driver,
> PF1-PFn either netdev driver or crypto driver, VF0-VFn functionality would be
> same as their PF.
>
> The current plan is to have CGX driver, Admin function driver, PF
> netdev driver,
> VF netdev driver and PF/VF crypto drivers.

Ok, I think I understand the PF/VF distinction now. One (to me)
surprising aspect here is that you not just have one physical function
that you can use to assign resources to multiple virtual functions,
but also a second level of virtualization that is used to assign
resources to "physical functions" that are less physical than the
name suggests.

The part that I have not grasped yet is what the split between
the CGX and the AF is for, how they relate to one another, and
what the software abstraction for the two is going to be.

> > Is the idea that an ethernet device driver always attaches to a
> > virtual function that gets created by the main driver, and that
> > the two drivers share no interfaces on the kernel side, or do
> > you have multiple drivers linking to each other?
>
> Ethernet device driver can attach to both physical function and virtual function
> whose HW resources are provisioned by admin function driver.
>
> Yes the PF/VF ethernet drivers and these drivers won't share any
> kernel interfaces.
> Physical ethernet interface is owned by ethernet driver only, this driver just
> configures which ethernet driver instance uses which physcial interface.

Ok.

         Arnd
