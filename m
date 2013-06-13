From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Jun 2013 16:13:59 +0200
Subject: [PATCH V5 1/3] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
References: <000b01ce6839$0f0455d0$2d0d0170$@samsung.com>
Message-ID: <13685067.uPzcc2y1CU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 June 2013 22:22:31 Jingoo Han wrote:

> +struct pcie_port_info {
> +	u32		cfg0_size;
> +	u32		cfg1_size;
> +	u32		io_size;
> +	u32		mem_size;
> +	phys_addr_t	io_bus_addr;
> +	phys_addr_t	mem_bus_addr;
> +};
> +
> +struct pcie_port {
> +	struct device		*dev;
> +	u8			controller;
> +	u8			root_bus_nr;
> +	void __iomem		*dbi_base;
> +	void __iomem		*elbi_base;
> +	void __iomem		*phy_base;
> +	void __iomem		*purple_base;
> +	phys_addr_t		cfg0_base;
> +	void __iomem		*va_cfg0_base;
> +	phys_addr_t		cfg1_base;
> +	void __iomem		*va_cfg1_base;
> +	phys_addr_t		io_base;
> +	phys_addr_t		mem_base;
> +	spinlock_t		conf_lock;
> +	struct resource		cfg;
> +	struct resource		io;
> +	struct resource		mem;
> +	struct pcie_port_info	config;
> +	struct clk		*clk;
> +	struct clk		*bus_clk;
> +	int			irq;
> +	int			reset_gpio;
> +};

You mentioned that you'd use u64 for the resources here but did not.

> +
> +static void exynos_pcie_prog_viewport_cfg0(struct pcie_port *pp, u32 busdev)
> +{
> +	u32 val;
> +	void __iomem *dbi_base = pp->dbi_base;
> +
> +	/* Program viewport 0 : OUTBOUND : CFG0 */
> +	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX0;
> +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> +	writel_rc(pp, (u64)pp->cfg0_base, dbi_base + PCIE_ATU_LOWER_BASE);
> +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> +	writel_rc(pp, (u64)pp->cfg0_base + pp->config.cfg0_size - 1,
> +			dbi_base + PCIE_ATU_LIMIT);
> +	writel_rc(pp, busdev, dbi_base + PCIE_ATU_LOWER_TARGET);
> +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> +	writel_rc(pp, PCIE_ATU_TYPE_CFG0, dbi_base + PCIE_ATU_CR1);
> +	val = PCIE_ATU_ENABLE;
> +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> +}
> +
> +static void exynos_pcie_prog_viewport_cfg1(struct pcie_port *pp, u32 busdev)
> +{
> +	u32 val;
> +	void __iomem *dbi_base = pp->dbi_base;
> +
> +	/* Program viewport 1 : OUTBOUND : CFG1 */
> +	val = PCIE_ATU_REGION_OUTBOUND | PCIE_ATU_REGION_INDEX1;
> +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> +	writel_rc(pp, PCIE_ATU_TYPE_CFG1, dbi_base + PCIE_ATU_CR1);
> +	val = PCIE_ATU_ENABLE;
> +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> +	writel_rc(pp, (u64)pp->cfg1_base, dbi_base + PCIE_ATU_LOWER_BASE);
> +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> +	writel_rc(pp, (u64)pp->cfg1_base + pp->config.cfg1_size - 1,
> +			dbi_base + PCIE_ATU_LIMIT);
> +	writel_rc(pp, busdev, dbi_base + PCIE_ATU_LOWER_TARGET);
> +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> +}

And you still don't set up the UPPER halves, which was really the point
of my comment. Same thing for all the other ones.

> +static void exynos_pcie_prog_viewport_mem_inbound(struct pcie_port *pp)
> +{
> +	u32 val;
> +	void __iomem *dbi_base = pp->dbi_base;
> +
> +	/* Program viewport 0 : INBOUND : MEM */
> +	val = PCIE_ATU_REGION_INBOUND | PCIE_ATU_REGION_INDEX0;
> +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> +	writel_rc(pp, PCIE_ATU_TYPE_MEM, dbi_base + PCIE_ATU_CR1);
> +	val = PCIE_ATU_ENABLE | PCIE_ATU_BAR_MODE_ENABLE;
> +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> +	writel_rc(pp, (u64)pp->config.mem_bus_addr,
> +			dbi_base + PCIE_ATU_LOWER_BASE);
> +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> +	writel_rc(pp, (u64)pp->config.mem_bus_addr + pp->config.mem_size - 1,
> +			dbi_base + PCIE_ATU_LIMIT);
> +	writel_rc(pp, (u64)pp->mem_base, dbi_base + PCIE_ATU_LOWER_TARGET);
> +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> +}

This makes even less sense than before, it seems like now you only
allow DMA between PCI devices but not to main memory.

> +static void exynos_pcie_prog_viewport_io_inbound(struct pcie_port *pp)
> +{
> +	u32 val;
> +	void __iomem *dbi_base = pp->dbi_base;
> +
> +	/* Program viewport 1 : INBOUND : IO */
> +	val = PCIE_ATU_REGION_INBOUND | PCIE_ATU_REGION_INDEX1;
> +	writel_rc(pp, val, dbi_base + PCIE_ATU_VIEWPORT);
> +	writel_rc(pp, PCIE_ATU_TYPE_IO, dbi_base + PCIE_ATU_CR1);
> +	val = PCIE_ATU_ENABLE | PCIE_ATU_BAR_MODE_ENABLE;
> +	writel_rc(pp, val, dbi_base + PCIE_ATU_CR2);
> +	writel_rc(pp, (u64)pp->config.io_bus_addr,
> +			dbi_base + PCIE_ATU_LOWER_BASE);
> +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_BASE);
> +	writel_rc(pp, (u64)pp->config.io_bus_addr + pp->config.io_size - 1,
> +			dbi_base + PCIE_ATU_LIMIT);
> +	writel_rc(pp, (u64)pp->io_base, dbi_base + PCIE_ATU_LOWER_TARGET);
> +	writel_rc(pp, 0, dbi_base + PCIE_ATU_UPPER_TARGET);
> +}

Can you please explain what the inbound window is as I asked you?
I still don't see why you would need to set it up like this.

> +static int exynos_pcie_setup(int nr, struct pci_sys_data *sys)
> +{
> +	struct pcie_port *pp;
> +
> +	pp = sys_to_pcie(sys);
> +
> +	if (!pp)
> +		return 0;
> +
> +	pci_add_resource(&sys->resources, &pp->io);
> +	pci_add_resource(&sys->resources, &pp->mem);

Now you are missing the offsets. You have to at least pass an offset for one
of the I/O spaces, since they are using the same bus address. The offset must
match the value you pass to pci_ioremap_io.

For the memory space, you should pass the difference between the physical
base address and the bus address. That address happens to be zero with
you DT setup, but I would advise to also try out some other values in DT,
just to ensure it still works.

> +	pp->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);

Ok.

> +
> +static int __exit exynos_pcie_remove(struct platform_device *pdev)
> +{
> +	struct pcie_port *pp = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(pp->bus_clk);
> +	clk_disable_unprepare(pp->clk);
> +
> +	return 0;
> +}

You also don't remove the PCI devices here, as mentioned in an earlier
review.

	Arnd
