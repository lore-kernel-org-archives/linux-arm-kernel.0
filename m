From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 12 Mar 2013 16:08:54 -0600
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
References: <513D6F9C.9000100@firmworks.com>
 <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130312220854.GA23112@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 10:30:06PM +0100, Thierry Reding wrote:

> > Not going down the of_pci_* code paths for address translation at the
> > root port bridge nodes is certainly not right.
> 
> I'm not so sure. Why should the pcie-controller be a PCI device?

The spec is clear on that point as well:

 device_type
  A Standard Package conforming to this specification and corresponding
  to a device that implements a PCI bus shall implement this property
  with the string value "pci"

The children of a pcie-controller node are PCI devices, thus the
pcie-controller node 'implements a PCI bus'. Or, as you say 'device on
the processor/SoC/platform bus that bridges to the PCI bus'

Think of device_type as also meaning bus_type and it makes more
logical sense, the name is terrible, but its usage is governed by the
OF docs..

> The other alternative would be to amend the specification. Besides the
> fact that the specification says so I don't see any reason why this
> shouldn't be allowed.

'the specification says so' *IS* the reason. DT isn't a free for all
where you get to do whatever you want, or whatever 'feels' right. It
is supposed to be a stable, OS agnostic ABI. That means bindings have
to follow the specs (when available).

Maybe a future revision will support PCI-E ECAM, but we don't know
what that will look like, and I'm pretty sure you don't want to hold
up your patches until an IEEE committee gets around to deciding
something ;)

Jason
