From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Sat, 28 Nov 2015 09:56:36 +0000
Subject: [PATCH v10] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <565877B5.9060503@arm.com>
References: <1448636523-20503-1-git-send-email-bharatku@xilinx.com>
 <565877B5.9060503@arm.com>
Message-ID: <8520D5D51A55D047800579B09414719825866D65@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v10] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
> PCIe Host Controller
> 
> On 27/11/15 15:02, Bharat Kumar Gogada wrote:
> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes for v10:
> > -> Changed MSI address to PCIe controller base.
> > -> Removed nwl_check_hwirq function, instead using
> > -> bitmap_find_next_zero_area
> >    API to do the same.
> > ---
> >  .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |   68 ++
> >  drivers/pci/host/Kconfig                           |   10 +
> >  drivers/pci/host/Makefile                          |    1 +
> >  drivers/pci/host/pcie-xilinx-nwl.c                 | 1068 ++++++++++++++++++++
> >  4 files changed, 1147 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> >  create mode 100644 drivers/pci/host/pcie-xilinx-nwl.c
> >
> > diff --git a/drivers/pci/host/pcie-xilinx-nwl.c
> > b/drivers/pci/host/pcie-xilinx-nwl.c
> > new file mode 100644
> > index 0000000..d070344
> > --- /dev/null
> > +++ b/drivers/pci/host/pcie-xilinx-nwl.c
> 
> [...]
> 
> > +#define MSI_ADDRESS				0xFD480000
> > +
> 
> Really? Why do you bother having DT support then? You might as well
> hardcode everything, while you're at it.
> 
> /me felling depressed now.
Agreed, I'm already having this parameter in nwl_pcie structure, will use it. 
> 
> > +struct nwl_msi {			/* MSI information */
> > +	struct irq_domain *msi_domain;
> > +	unsigned long *bitmap;
> > +	struct irq_domain *dev_domain;
> > +	struct mutex lock;		/* protect bitmap variable */
> > +	int irq_msi0;
> > +	int irq_msi1;
> > +};
> > +
> > +struct nwl_pcie {
> > +	struct device *dev;
> > +	void __iomem *breg_base;
> > +	void __iomem *pcireg_base;
> > +	void __iomem *ecam_base;
> > +	u32 phys_breg_base;		/* Physical Bridge Register Base */
> > +	u32 phys_pcie_reg_base;		/* Physical PCIe Controller
> Base */
> > +	u32 phys_ecam_base;		/* Physical Configuration Base */
> 
> All these u32 should be phys_addr_t. Not all the world is 32bit, fortunately.
Agreed will address it next patch.
> 
> > +	u32 breg_size;
> [...]
> 
> 
> > +static int nwl_pcie_bridge_init(struct nwl_pcie *pcie) {
> > +	struct platform_device *pdev = to_platform_device(pcie->dev);
> > +	u32 breg_val, ecam_val, first_busno = 0;
> > +	int err;
> > +	int check_link_up = 0;
> > +
> > +	/* Check for BREG present bit */
> > +	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) &
> BREG_PRESENT;
> > +	if (!breg_val) {
> > +		dev_err(pcie->dev, "BREG is not present\n");
> > +		return breg_val;
> > +	}
> > +	/* Write bridge_off to breg base */
> > +	nwl_bridge_writel(pcie, (u32)(pcie->phys_breg_base),
> > +			  E_BREG_BASE_LO);
> > +
> 
> I love the casting of a u32 to a u32. You have to program E_BREG_BASE_HI as
> well, once you've fixed the data type.
> Agreed, will address this in next patch.
> > +	/* Enable BREG */
> > +	nwl_bridge_writel(pcie, ~BREG_ENABLE_FORCE & BREG_ENABLE,
> > +			  E_BREG_CONTROL);
> > +	/* Check for ECAM present bit */
> > +	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CAPABILITIES) &
> E_ECAM_PRESENT;
> > +	if (!ecam_val) {
> > +		dev_err(pcie->dev, "ECAM is not present\n");
> > +		return ecam_val;
> > +	}
> |
> > +	/* Write phy_reg_base to ecam base */
> > +	nwl_bridge_writel(pcie, (u32)pcie->phys_ecam_base,
> E_ECAM_BASE_LO);
> 
> Same here.
> Agreed, will address this in next patch.

Regards,
Bharat
