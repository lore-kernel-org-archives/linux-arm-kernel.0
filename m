From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 10:23:04 +0200
Subject: [PATCH v2 0/8] MSI support for Marvell EBU PCIe driver
In-Reply-To: <20130606185110.GP23859@titan.lakedaemon.net>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606185110.GP23859@titan.lakedaemon.net>
Message-ID: <20130607102304.3c42773b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Thu, 6 Jun 2013 14:51:10 -0400, Jason Cooper wrote:
> > Thierry Reding (1):
> >   PCI: Introduce new MSI chip infrastructure
> > 
> > Thomas Petazzoni (7):
> >   PCI: Add registry of MSI chips
> >   irqchip: armada-370-xp: properly request resources
> >   irqchip: armada-370-xp: implement MSI support
> >   arm: mvebu: the MPIC now provides MSI controller features
> >   pci: mvebu: add support for MSI
> >   arm: mvebu: indicate that this platform supports MSI
> >   arm: mvebu: link PCIe controllers to the MSI controller
> > 
> 
> Is there a reason why the following breakdown wouldn't work?

No, it should work. And it's actually possible with how the patches are
organized currently.

> >  arch/arm/boot/dts/armada-370-xp.dtsi     |   1 +
> >  arch/arm/boot/dts/armada-370.dtsi        |   1 +
> >  arch/arm/boot/dts/armada-xp-mv78230.dtsi |   1 +
> >  arch/arm/boot/dts/armada-xp-mv78260.dtsi |   1 +
> >  arch/arm/boot/dts/armada-xp-mv78460.dtsi |   1 +
> 
> through mvebu/arm-soc

Patches 5 and 8.

> 
> >  arch/arm/mach-mvebu/Kconfig              |   1 +
> 
> through mvebu/arm-soc after the other three have landed (v3.11-rc1)

Patch 7.

> >  drivers/irqchip/irq-armada-370-xp.c      | 186 ++++++++++++++++++++++++++++++-
> 
> through tglx

Patches 3 and 4.

> 
> >  drivers/pci/host/pci-mvebu.c             |  21 ++++
> >  drivers/pci/msi.c                        |  59 +++++++++-
> >  drivers/pci/probe.c                      |   1 +
> >  include/linux/msi.h                      |  22 ++++
> >  include/linux/pci.h                      |   1 +
> 
> through Bjorn

Patches 1, 2 and 6.

So as you can see, the patches are already broken down in a way that
allows each maintainer to pick its part. But I admit I could probably
reorder them in the following way:

 1. PCI: Introduce new MSI chip infrastructure
 2. PCI: Add registry of MSI chips
 3. pci: mvebu: add support for MSI
 4. irqchip: armada-370-xp: properly request resources
 5. irqchip: armada-370-xp: implement MSI support
 6. arm: mvebu: the MPIC now provides MSI controller features
 7. arm: mvebu: link PCIe controllers to the MSI controller
 8. arm: mvebu: indicate that this platform supports MSI

1-3 through Bjorn, 4-5 through tglx, 6-8 through you.

The only problem that I see is that 'irqchip: armada-370-xp: implement
MSI support' (which goes through tglx) has a build dependency on 'PCI:
Add registry of MSI chips' (which goes through Bjorn). This is due to
the IRQ controller using the msi_chip_add() function that is introduced
earlier in the PCI core.

How would you solve that?

In any case, at this point I'd like first to have the ACK from Bjorn
Helgaas and Arnd Bergmann on the general approach.

Best regards, 

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
