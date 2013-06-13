From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 13 Jun 2013 22:18:50 +0900
Subject: [PATCH V4 1/3] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <2061566.hRLrhtBK6z@wuerfel>
References: <003601ce6756$444e8cd0$cceba670$@samsung.com>
 <2061566.hRLrhtBK6z@wuerfel>
Message-ID: <000901ce6838$8b514720$a1f3d560$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 12, 2013 8:23 PM, Arnd Bergmann wrote:
> On Wednesday 12 June 2013 19:19:05 Jingoo Han wrote:
> 
> > +
> > +struct pcie_port {
> > +	struct device		*dev;
> > +	u8			controller;
> > +	u8			root_bus_nr;
> > +	void __iomem		*dbi_base;
> > +	void __iomem		*elbi_base;
> > +	void __iomem		*phy_base;
> > +	void __iomem		*purple_base;
> > +	phys_addr_t		cfg0_base;
> > +	void __iomem		*va_cfg0_base;
> > +	phys_addr_t		cfg1_base;
> > +	void __iomem		*va_cfg1_base;
> > +	phys_addr_t		io_base;
> > +	phys_addr_t		mem_base;
> > +	spinlock_t		conf_lock;
> > +	struct resource		cfg;
> > +	struct resource		io;
> > +	struct resource		mem;
> > +	struct pcie_port_info	config;
> > +	struct clk		*clk;
> > +	struct clk		*bus_clk;
> > +	int			irq;
> > +	int			reset_gpio;
> > +};
> 
> This looks much better now.
> 
> > +
> > +/* synopsis specific PCIE configuration registers*/
> > +#define PCIE_PORT_LINK_CONTROL		0x710
> > +#define PORT_LINK_MODE_MASK		(0x3f << 16)
> > +#define PORT_LINK_MODE_4_LANES		(0x7 << 16)
> 
> Do you mean this is a "Synopsys" designware part? In that case it
> should really not be called "exynos-pcie" but "designware-pcie"
> and you should make sure that the driver makes no assumptions about
> the platform. A lot of other platforms also use designware
> parts and should be able to reuse this driver.

Sorry, I don't think so.
Only core block is a "Synopsys" designware part IP block,
other parts are Exynos-specific.
So, it is hard to share with other PCIe IPs using synopsis core.

> 
> > +static void exynos_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
> > +{
> > +	u32 val;
> > +	void __iomem *dbi_base = pp->dbi_base;
> > +
> > +	/* Program viewport 0 : OUTBOUND : CFG0 */
> > +	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> > +	writel_rc(pp, (u32)pp->cfg0_base, dbi_base + PCIE_ATU_LOWER_BASE);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> > +	writel_rc(pp, (u32)pp->cfg0_base + pp->config.cfg0_size - 1,
> > +			dbi_base + PCIE_ATU_LIMIT);
> > +	writel_rc(pp, busdev, dbi_base + PCIE_ATU_LOWER_TARGET);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> > +	writel_rc(pp, PCIE_ATU_TYPE_CFG0, dbi_base + PCIE_ATU_CR1);
> > +	val = PCIE_ATU_ENABLE;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> > +}
> 
> I think you should not assume that the physical base address is a 32
> bit value. The hardware clearly supports "lower" and "upper" halves
> for the address window, so when resource_size_t is 64 bit, you should
> set the upper half accordingly. Since the hardware is always 64 bit,
> you can use a "u64" type rather than resource_size_t to simplify the
> code here.

OK, I will replace "u32" with "u64".

> 
> > +static void exynos_pcie_prog_viewport_mem_outbound(struct pcie_port *pp)
> > +{
> > +	u32 val;
> > +	void __iomem *dbi_base = pp->dbi_base;
> > +
> > +	/* Program viewport 0 : OUTBOUND : MEM */
> > +	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> > +	writel_rc(pp, PCIE_ATU_TYPE_MEM, dbi_base + PCIE_ATU_CR1);
> > +	val = PCIE_ATU_ENABLE;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> > +	writel_rc(pp, (u32)pp->mem_base, dbi_base + PCIE_ATU_LOWER_BASE);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> > +	writel_rc(pp, (u32)(pp->mem_base + pp->config.mem_size - 1),
> > +			dbi_base + PCIE_ATU_LIMIT);
> > +	writel_rc(pp, (u32)pp->mem_base, dbi_base + PCIE_ATU_LOWER_TARGET);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> > +}
> 
> You probably should not assume that there is a 1:1 mapping between
> bus addresses and host physical addresses, but rather read both
> values from the DT individually. With the ranges defined as
> 
>        0x82000000 0 0x40210000 0x40210000 0 0x10000000>; /* non-prefetchable memory */
> 
> the second and third cell should go into
> PCIE_ATU_UPPER_TARGET/PCIE_ATU_LOWER_TARGET, while the translated address
> (from the third cell) should go into PCIE_ATU_LOWER_BASE/PCIE_ATU_UPPER_BASE
> 
> The PCIE_ATU_LIMIT seems to correctly get translated from the last
> cell.

OK, I will change it.

> 
> > +static void exynos_pcie_prog_viewport_io_outbound(struct pcie_port *pp)
> > +{
> > +	u32 val;
> > +	void __iomem *dbi_base = pp->dbi_base;
> > +
> > +	/* Program viewport 1 : OUTBOUND : IO */
> > +	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> > +	writel_rc(pp, PCIE_ATU_TYPE_IO, dbi_base + PCIE_ATU_CR1);
> > +	val = PCIE_ATU_ENABLE;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> > +	writel_rc(pp, (u32)pp->io_base, dbi_base + PCIE_ATU_LOWER_BASE);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> > +	writel_rc(pp, (u32)(pp->io_base + pp->config.io_size - 1),
> > +			dbi_base + PCIE_ATU_LIMIT);
> > +	writel_rc(pp, (u32)pp->io_base, dbi_base + PCIE_ATU_LOWER_TARGET);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> > +}
> 
> You don't actually map the I/O space anywhere into virtual memory.
> I think you need to call pci_ioremap_io with the pp->io_base at
> boot time.

Sorry, when pci_ioremap_io() is used, Exynos5440 hangs.
I don't know how to deal this.

> 
> I think you mixed up the PCIE_ATU_LOWER_TARGET, it should really be 0,
> since all I/O port numbers have to be smaller than IO_SPACE_LIMIT.
>
> The first argument to pci_ioremap_io needs to be unique for each
> domain and you need to use it to calculate the io_offset you
> set in pci_sys_data->io_offset.
> 
> > +static void exynos_pcie_prog_viewport_mem_inbound(struct pcie_port *pp)
> > +{
> > +	u32 val;
> > +	void __iomem *dbi_base = pp->dbi_base;
> > +	struct pcie_port_info *config = &pp->config;
> > +
> > +	/* Program viewport 0 : INBOUND : MEMORY */
> > +	val = PCIE_ATU_REGION_INBOUND | PCIE_ATU_REGION_INDEX0;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> > +	writel_rc(pp, PCIE_ATU_TYPE_MEM, dbi_base + PCIE_ATU_CR1);
> > +	val = PCIE_ATU_ENABLE | PCIE_ATU_BAR_MODE_ENABLE;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_LOWER_BASE);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> > +	writel_rc(pp, config->in_mem_size - 1, dbi_base + PCIE_ATU_LIMIT);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_LOWER_TARGET);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> > +}
> 
> You hardcode the in_mem_size to 256 MB. Does that mean you only allow
> PCI bus master DMA on the first part of RAM? Shouldn't it get
> computed from the actual location and size of RAM?

I will remove the hard-coded in_mem_size, instead use the size of MEM region.

> 
> > +static void exynos_pcie_prog_viewport_io_inbound(struct pcie_port *pp)
> > +{
> > +	u32 val;
> > +	void __iomem *dbi_base = pp->dbi_base;
> > +	struct pcie_port_info *config = &pp->config;
> > +
> > +	/* Program viewport 1 : INBOUND : IO */
> > +	val = PCIE_ATU_REGION_INBOUND | PCIE_ATU_REGION_INDEX1;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> > +	writel_rc(pp, PCIE_ATU_TYPE_IO, dbi_base + PCIE_ATU_CR1);
> > +	val = PCIE_ATU_ENABLE | PCIE_ATU_BAR_MODE_ENABLE;
> > +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_LOWER_BASE);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> > +	writel_rc(pp, config->in_mem_size - 1, dbi_base + PCIE_ATU_LIMIT);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_LOWER_TARGET);
> > +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> > +}
> 
> I don't understand what in inbound I/O access actually means. What
> does this do, is it for PCI target emulation?

I reviewed the manual, and I will fix it.
I will add bus addresses and host physical addresses to
PCIE_ATU_LOWER_BASE/ PCIE_ATU_LOWER_TARGET.

> 
> > +
> > +static int exynos_pcie_setup(int nr, struct pci_sys_data *sys)
> > +{
> > +	struct pcie_port *pp;
> > +
> > +	pp = sys_to_pcie(sys);
> > +
> > +	if (!pp)
> > +		return 0;
> > +
> > +	pci_add_resource_offset(&sys->resources, &pp->io, sys->io_offset);
> > +	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
> > +
> > +	return 1;
> > +}
> 
> You don't actually set up io_offset and mem_offset, right?

OK, I will replace pci_add_resource_offset() with pci_add_resource().


Best regards,
Jingoo Han

> 
> 	Arnd
