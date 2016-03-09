From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 9 Mar 2016 13:41:13 +0000
Subject: [PATCH V4 0/5] PCIe Xilinx generic driver for Microblaze and
In-Reply-To: <20160308203444.GA27132@localhost>
References: <1455208091-15556-1-git-send-email-bharatku@xilinx.com>
 <20160308203444.GA27132@localhost>
Message-ID: <8520D5D51A55D047800579B09414719825888041@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Bjorn.
Thanks to Bjorn Helgaas and Arnd Bergmann for your review and suggestions.

Bharat

> On Thu, Feb 11, 2016 at 09:58:06PM +0530, Bharat Kumar Gogada wrote:
> > This patch series does modifications to pcie-xilinx.c, to support common
> > driver on both Zynq and Microblaze architectures.
> > Microblaze pci-common.c has been modified to support generic driver.
> >
> > Bharat Kumar Gogada (5):
> >   PCI: xilinx: Removing xilinx_pcie_parse_and_add_res function
> >   PCI: xilinx: Removing struct hw_pci structure.
> >   PCI: xilinx: Modifying AXI PCIe Host Bridge driver to work on both
> >      Zynq and Microblaze
> >   PCI: xilinx: Updating Zynq PCI binding documentation with
> >     Microblaze node.
> >   Microblaze: Modifying microblaze PCI subsytem to support  generic
> >     Xilinx  AXI PCIe Host Bridge IP driver
> >
> >  .../devicetree/bindings/pci/xilinx-pcie.txt        |  32 +++-
> >  arch/microblaze/Kconfig                            |   3 +
> >  arch/microblaze/pci/pci-common.c                   |  56 ++----
> >  drivers/pci/host/Kconfig                           |   2 +-
> >  drivers/pci/host/pcie-xilinx.c                     | 191 +++------------------
> >  5 files changed, 66 insertions(+), 218 deletions(-)
> 
> I applied this series to my pci/host-xilinx branch for v4.6.
> 
> Michal, you only explicitly acked the last patch, but that only makes
> sense if I apply the whole series, so I applied your ack to all the
> patches.
> 
> Someday somebody should rework pci_fixup_irqs() so that doesn't have
> to be arch-dependent.
> 
> I reworked the changelogs as below.
> 
> Bjorn
> 
> 
> commit 01cf9d524ff0
> Author: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Date:   Thu Feb 11 21:58:11 2016 +0530
> 
>     microblaze/PCI: Support generic Xilinx AXI PCIe Host Bridge IP driver
> 
>     Modify the Microblaze PCI subsystem to work with the generic
>     drivers/pci/host/pcie-xilinx.c driver on Microblaze and Zynq.
> 
>     [bhelgaas: changelog]
>     Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>     Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> commit e5d4b2006c97
> Author: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Date:   Thu Feb 11 21:58:10 2016 +0530
> 
>     PCI: xilinx: Update Zynq binding with Microblaze node
> 
>     Update Zynq PCI binding documentation with Microblaze node.
> 
>     [bhelgaas: fix "microbalze_0_intc" typo]
>     Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>     Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Acked-by: Rob Herring <robh@kernel.org>
>     Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> commit 2c51391d2559
> Author: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Date:   Thu Feb 11 21:58:09 2016 +0530
> 
>     PCI: xilinx: Don't call pci_fixup_irqs() on Microblaze
> 
>     The Xilinx AXI PCIe Host Bridge Soft IP driver was previously only
>     supported on ARM (in particular, on ARCH_ZYNC), and pci_fixup_irqs() is
>     available there.  But Microblaze will do IRQ fixup in pcibios_add_device(),
>     so pci_fixup_irqs() is not available on Microblaze.
> 
>     Don't call pci_fixup_irqs() on Microblaze, so the driver can work on both
>     Zynq and Microblaze Architectures.
> 
>     [bhelgaas: revise changelog to show similarity to bdb8a1844f31 ("PCI: iproc:
> Call pci_fixup_irqs() for ARM64 as well as ARM")]
>     Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>     Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>     Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> commit 4c01f3b089a0
> Author: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Date:   Thu Feb 11 21:58:08 2016 +0530
> 
>     PCI: xilinx: Remove dependency on ARM-specific struct hw_pci
> 
>     The Xilinx PCIe host controller driver uses pci_common_init_dev(), which
>     is ARM-specific and requires the ARM struct hw_pci.  The part of
>     pci_common_init_dev() that is needed is limited and can be done here
>     without using hw_pci.
> 
>     Create and scan the root bus directly without using the ARM
>     pci_common_init_dev() interface.
> 
>     [bhelgaas: revise changelog to show similarity to 79953dd22c1d ("PCI: rcar:
> Remove dependency on ARM-specific struct hw_pci")]
>     Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>     Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>     Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> commit 0259882e342e
> Author: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Date:   Thu Feb 11 21:58:07 2016 +0530
> 
>     PCI: xilinx: Use of_pci_get_host_bridge_resources() to parse DT
> 
>     Use the new of_pci_get_host_bridge_resources() API in place of the PCI
> OF
>     DT parser.
> 
>     [bhelgaas: revise changelog to show similarity to 0021d22b73d6 ("PCI:
> designware: Use of_pci_get_host_bridge_resources() to parse DT")]
>     Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
>     Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>     Acked-by: Michal Simek <michal.simek@xilinx.com>
