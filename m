From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 18 Oct 2018 18:17:47 +0100
Subject: [PATCH v3 0/4] PCI: emulated PCI bridge config space
In-Reply-To: <20181018153719.23115-1-thomas.petazzoni@bootlin.com>
References: <20181018153719.23115-1-thomas.petazzoni@bootlin.com>
Message-ID: <20181018171747.GA529@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 05:37:15PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> The pci-mvebu driver already contains some logic to emulate a root
> port PCI bridge configuration space. It turns out that we have a
> similar need for the pci-aardvark driver. Instead of duplicating the
> same logic in two drivers, this patch series starts by adding a small
> common infrastructure that helps emulate a root port PCI bridge config
> space, converts pci-mvebu to use it, and finally extends pci-aardvark
> to use it as well.
> 
> Thanks to this, Marvell Armada 3720 based systems, which use the
> Aarkvark PCI controller, will have better PCI support, by having a
> root port PCI bridge exposed.
> 
> The emulated PCI bridge common logic is a proposal, I very much
> welcome comments and suggestions. Also, if you feel that adding a
> common logic for only two drivers is too early, I'm fine with
> duplicating a bit of code betwen pci-mvebu and pci-aardvark.
> 
> Changes v2 -> v3:
> 
>  - Address the FIXME comment that was pointed out by Russell. In fact
>    the |= pcie_devctl was not needed, because pcie_devctl is always
>    zero. To fix this, an additional commit was added to the series to
>    drop the use of unneeded fields in the PCI Express capability block
>    emulation in pci-mvebu.
> 
>  - Drop some more code from pci-mvebu that was used to prevent messing
>    up with W1C bits, because this is now already taken care of by the
>    common bridge emulation logic.
> 
>  - Fixed the commit log of "PCI: mvebu: Convert to PCI emulated bridge
>    config space" according to Lorenzo comments.
> 
>  - Use PCI_STD_HEADER_SIZEOF when defining PCI_BRIDGE_CONTROL, as
>    suggested by Bjorn.
> 
>  - Added Bjorn Acked-by and Russell Reviewed-by on the patch adding
>    the common logic.
> 
> Changes v1 -> v2:
> 
>  - Rebased to 4.19-rc1
> 
>  - The functions implementing the config space read/write emulation
>    now have the knowledge of which registers/bits are read-only,
>    read-write, reserved and write-1-to-clear, and behave according to
>    this information.
> 
>  - I have renamed the function to use conf_read() and conf_write()
>    suffixes, as suggested by Bjorn.
> 
>  - The whole thing is now named pci-bridge-emul instead of
>    pci-sw-bridge (and of course all functions, types and macros were
>    changed accordingly), as Bjorn wasn't happy about pci-sw-bridge.
> 
>  - The header file was moved into drivers/pci (instead of being in
>    include/linux).
> 
> Thanks a lot in advance for your review and feedback.
> 
> Best regards,
> 
> Thomas Petazzoni
> 
> Thomas Petazzoni (3):
>   PCI: Introduce PCI bridge emulated config space common logic
>   PCI: mvebu: Drop unused PCI express capability code
>   PCI: mvebu: Convert to PCI emulated bridge config space
> 
> Zachary Zhang (1):
>   PCI: aardvark: Implement emulated root PCI bridge config space
> 
>  drivers/pci/Kconfig                   |   3 +
>  drivers/pci/Makefile                  |   1 +
>  drivers/pci/controller/Kconfig        |   2 +
>  drivers/pci/controller/pci-aardvark.c | 129 ++++++++++-
>  drivers/pci/controller/pci-mvebu.c    | 384 +++++++++-----------------------
>  drivers/pci/pci-bridge-emul.c         | 408 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci-bridge-emul.h         | 124 +++++++++++
>  7 files changed, 764 insertions(+), 287 deletions(-)
>  create mode 100644 drivers/pci/pci-bridge-emul.c
>  create mode 100644 drivers/pci/pci-bridge-emul.h

I have applied the series with Bjorn and Russell ACKs to
pci/controller-misc, tentatively for v4.20.

Thanks !
Lorenzo
