From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 24 Oct 2017 11:57:03 -0700
Subject: [PATCH 6/8] PCI: host: brcmstb: add MSI capability
In-Reply-To: <1508868949-16652-7-git-send-email-jim2101024@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-7-git-send-email-jim2101024@gmail.com>
Message-ID: <5406ab92-c1da-f6fa-083d-82d1027130ea@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jim,

On 10/24/2017 11:15 AM, Jim Quinlan wrote:
> This commit adds MSI to the Broadcom STB PCIe host controller. It does
> not add MSIX since that functionality is not in the HW.  The MSI
> controller is physically located within the PCIe block, however, there
> is no reason why the MSI controller could not be moved elsewhere in
> the future.
> 
> Since the internal Brcmstb MSI controller is intertwined with the PCIe
> controller, it is not its own platform device but rather part of the
> PCIe platform device.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/host/Kconfig           |  12 ++
>  drivers/pci/host/Makefile          |   1 +
>  drivers/pci/host/pci-brcmstb-msi.c | 318 +++++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pci-brcmstb.c     |  72 +++++++--
>  drivers/pci/host/pci-brcmstb.h     |  26 +++
>  5 files changed, 419 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/host/pci-brcmstb-msi.c
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index b9b4f11..54aa5d2 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -228,4 +228,16 @@ config PCI_BRCMSTB
>  	default ARCH_BRCMSTB || BMIPS_GENERIC
>  	help
>  	  Adds support for Broadcom Settop Box PCIe host controller.
> +	  To compile this driver as a module, choose m here.
> +
> +config PCI_BRCMSTB_MSI
> +	bool "Broadcom Brcmstb PCIe MSI support"
> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC

This could probably be depends on PCI_BRCMSTB, which would imply these
two conditions. PCI_BRCMSTB_MSI on its own is probably not very useful
without the parent RC driver.

> +	depends on OF
> +	depends on PCI_MSI
> +	default PCI_BRCMSTB
> +	help
> +	  Say Y here if you want to enable MSI support for Broadcom's iProc
> +	  PCIe controller
> +
>  endmenu
> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> index c283321..1026d6f 100644
> --- a/drivers/pci/host/Makefile
> +++ b/drivers/pci/host/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>  obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCI_BRCMSTB) += brcmstb-pci.o
>  brcmstb-pci-objs := pci-brcmstb.o pci-brcmstb-dma.o
> +obj-$(CONFIG_PCI_BRCMSTB_MSI) += pci-brcmstb-msi.o

Should we combine this file with the brcmstb-pci.o? There is probably no
functional difference, except that pci-brcmstb-msi.ko needs to be loaded
first, right?
-- 
Florian
