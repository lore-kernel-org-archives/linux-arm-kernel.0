From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 May 2014 10:44:30 +0200
Subject: [PATCH v7 0/3] Add support for PCI in AArch64
In-Reply-To: <CA+sq2Ce+8YB+02B7zhxTXwropZXv9spy-w=AJ8YXCP69kr-_1A@mail.gmail.com>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com>
 <4292818.mI6kZGgTzd@wuerfel>
 <CA+sq2Ce+8YB+02B7zhxTXwropZXv9spy-w=AJ8YXCP69kr-_1A@mail.gmail.com>
Message-ID: <5759329.P75jKFdv3B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 May 2014 09:52:33 Sunil Kovvuri wrote:
> >> In sriov_enable() (drivers/pci/iov.c)
> >>
> >>  296        for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> >>  297                 bars |= (1 << (i + PCI_IOV_RESOURCES));
> >>  298                 res = dev->resource + PCI_IOV_RESOURCES + i;
> >>  299                 if (res->parent)
> >>  300                         nres++;
> >>  301         }
> >>  302         if (nres != iov->nres) {
> >>  303                 dev_err(&dev->dev, "not enough MMIO resources for
> >>  SR-IOV\n");
> >>  304                 return -ENOMEM;
> >>  305         }
> >>
> >> Here its checking if physical function's IOV resource has a parent or not.
> >> Which is pci-pci bridge in this case. Otherwise it doesn't consider
> >> that resource.
> >>
> >> Added below api to your patch.
> >> This will try to claim a resource while creating a PCI device which
> >> inturn sets 'res->parent'.
> >
> > This looks like the wrong approach. The PCI host controller should
> > really have been registered with the root 'iomem_resource' during
> > the probe of the host controller.
> >
> I didn't get this, if a SR-IOV device is connected to a PCI-PCI bridge
> and inturn bridge connected to root port. Then the parent bus is not root,
> but the bridge.  The issue is either hierarchy should not be checked for
> SR-IOV resources or someone should set the hierarchy (i.e parent resources).

Ah, I misunderstood the problem, I thought the PCI core was complaining
about lack of space in the resources, not about a lack of BARs.

It seems there is code like yours in a couple of architectures, but they
only claim the resources of bridges, not the actual devices as you
seem to be doing. Can you check if the x86 version of
pcibios_allocate_bus_resources() does the trick for you? Maybe we can
turn that into a generic helper.

	Arnd
