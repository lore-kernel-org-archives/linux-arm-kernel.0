From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Mon, 8 May 2017 22:33:25 +0200
Subject: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
In-Reply-To: <20170508175536.GA3305@red-moon>
References: <20170508150224.GA7458@collabora.com>
 <1494261248.2322.21.camel@pengutronix.de>
 <20170508175536.GA3305@red-moon>
Message-ID: <20170508203325.GB9791@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 08, 2017 at 06:55:36PM +0100, Lorenzo Pieralisi wrote:
> On Mon, May 08, 2017 at 06:34:08PM +0200, Lucas Stach wrote:
> > Am Montag, den 08.05.2017, 17:02 +0200 schrieb Peter Senna Tschudin:
> > > Hello Kishon,
> > > 
> > > Our iMX6 hardware (imx6q-b850v3.dts) is not booting with latest
> > > linux-next and I could bisect until:
> > > 
> > > commit 442ec4c04d1235f8c664a74004dae54a7a574d18
> > > Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > Date:   Wed Feb 15 18:48:14 2017 +0530
> > > 
> > >     PCI: dwc: all: Split struct pcie_port into host-only and core structures
> > > 
> > > Which seem to be causing our issues. Our device (imx6q-b850v3.dts) boots
> > > fine with 4.10, and also boots if we disable pcie with:
> > 
> > Are you sure about this bisect? It seems more likely that the secondary
> > bus scanning goes wrong. It seems Lorenzo Pieralisi's cfg space
> > non-posting patches landed in next, so the root cause of this might just
> > be the driver hooking the wrong fault code now.
> > 
> > Async and synchronous aborts are different fault codes on ARM. Can you
> > see of removing the "16 +" in hook_fault_code() in
> > drivers/pci/dwc/pci-imx6.c fixes this issue?
> 
> You can also s/pci_remap_cfgspace/ioremap in pcie-designware-host.c
> to see if my patches are the issue, it is quite a mechanical change.

No change. Exactly same issue, but I noticed that
devm_pci_remap_cfgspace() is called twice for the same device, can this
be a problem?

...
[    0.505069] OF: PCI: host bridge /soc/pcie at 1ffc000 ranges:
[    0.510586] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.516474] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
[    0.522420] imx6q-pcie 1ffc000.pcie: devm_pci_remap_cfgspace()
[    0.528656] imx6q-pcie 1ffc000.pcie: devm_pci_remap_cfgspace()
...
