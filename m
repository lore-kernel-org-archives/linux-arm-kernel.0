From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 21 Jul 2015 15:30:18 -0500
Subject: [PATCH v3 1/4] PCI: iproc: enable arm64 support for iProc PCIe
In-Reply-To: <1437021563-29139-2-git-send-email-rjui@broadcom.com>
References: <1437021563-29139-1-git-send-email-rjui@broadcom.com>
 <1437021563-29139-2-git-send-email-rjui@broadcom.com>
Message-ID: <20150721203018.GH21967@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 09:39:20PM -0700, Ray Jui wrote:
> This patch enables arm64 support to the iProc PCIe driver

This needs a little more explanation: ARM has a common struct pci_sys_data
but ARM64 does not, and ARM needs pci_fixup_irqs() but ARM64 does not (why
not?), ARM uses the common pci_sys_data for the PCI sysdata while ARM64
uses a driver-specific sysdata, etc.

> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc.c |   15 ++++-----------
>  drivers/pci/host/pcie-iproc.h |    8 ++++++--
>  2 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index d77481e..8a556d5 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -58,11 +58,6 @@
>  #define SYS_RC_INTX_EN               0x330
>  #define SYS_RC_INTX_MASK             0xf
>  
> -static inline struct iproc_pcie *sys_to_pcie(struct pci_sys_data *sys)
> -{
> -	return sys->private_data;
> -}
> -
>  /**
>   * Note access to the configuration registers are protected at the higher layer
>   * by 'pci_lock' in drivers/pci/access.c
> @@ -71,8 +66,7 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>  					    unsigned int devfn,
>  					    int where)
>  {
> -	struct pci_sys_data *sys = bus->sysdata;
> -	struct iproc_pcie *pcie = sys_to_pcie(sys);
> +	struct iproc_pcie *pcie = bus->sysdata;
>  	unsigned slot = PCI_SLOT(devfn);
>  	unsigned fn = PCI_FUNC(devfn);
>  	unsigned busno = bus->number;
> @@ -208,10 +202,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  
>  	iproc_pcie_reset(pcie);
>  
> -	pcie->sysdata.private_data = pcie;
> -
> -	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
> -				  &pcie->sysdata, res);
> +	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops, pcie, res);
>  	if (!bus) {
>  		dev_err(pcie->dev, "unable to create PCI root bus\n");
>  		ret = -ENOMEM;
> @@ -229,7 +220,9 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  
>  	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
> +#ifdef CONFIG_ARM
>  	pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
> +#endif
>  	pci_bus_add_devices(bus);
>  
>  	return 0;
> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
> index ba0a108..0ee9673 100644
> --- a/drivers/pci/host/pcie-iproc.h
> +++ b/drivers/pci/host/pcie-iproc.h
> @@ -18,18 +18,22 @@
>  
>  /**
>   * iProc PCIe device
> + * @sysdata: Per PCI controller data. This needs to be kept at the beginning of
> + * struct iproc_pcie, to enable support of both ARM32 and ARM64 platforms with
> + * minimal changes in the iProc PCIe core driver
>   * @dev: pointer to device data structure
>   * @base: PCIe host controller I/O register base
>   * @resources: linked list of all PCI resources
> - * @sysdata: Per PCI controller data
>   * @root_bus: pointer to root bus
>   * @phy: optional PHY device that controls the Serdes
>   * @irqs: interrupt IDs
>   */
>  struct iproc_pcie {
> +#ifdef CONFIG_ARM
> +	struct pci_sys_data sysdata;
> +#endif

I'm OK with adding #ifdefs to make this work on both ARM and ARM64.  We can
at least see the ifdefs and know what needs to be fixed.  I'm a little more
hesitant about adding code that depends on the position of sysdata within
struct iproc_pcie.  I'd rather have something ugly and robust that cries
out for fixing than something minimal and fragile.

I see that your v1 patch added #ifdef CONFIG_ARM around sysdata at its
original location below, and you mentioned that you took Arnd's advice to
move sysdata to the beginning of the structure, but I don't see Arnd's
email on the list.

>  	struct device *dev;
>  	void __iomem *base;
> -	struct pci_sys_data sysdata;
>  	struct pci_bus *root_bus;
>  	struct phy *phy;
>  	int irqs[IPROC_PCIE_MAX_NUM_IRQS];
> -- 
> 1.7.9.5
> 
