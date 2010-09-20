From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Sep 2010 10:58:15 +0100
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <4C9709F4.9040308@compulab.co.il>
References: <cover.1284655723.git.mike@compulab.co.il>
	<201009161912.12330.arnd@arndb.de>
	<4C961906.4040303@compulab.co.il>
	<201009191639.44488.arnd@arndb.de>
	<4C962DF0.8060209@compulab.co.il>
	<20100919160103.GF9098@n2100.arm.linux.org.uk>
	<4C9709F4.9040308@compulab.co.il>
Message-ID: <20100920095815.GA30793@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 09:15:00AM +0200, Mike Rapoport wrote:
> From what you are saying I understand that the region reservation should
> look like:
>
> static struct resource res_mmio = {
> 	.name	= "PCI IO"
> 	.start	= 0x80400000,
> 	.end	= 0x80400000 + IO_SIZE,
> 	.flags	= IORESOURCE_MEM,
> };
>
> static struct resource pcie_res[] = {
> 	[0] = {
> 		.name	= "PCIe IO",
> 		.start	= 0x1000,
> 		.end	= 0x1000 + IO_SIZE - 1,
> 		.flags	= IORESOURCE_IO,
> 	},
> 	[1] = {
> 		.name	= "PCIe MEM",
> 		.start	= MEM_BASE,
> 		.end	= MEM_BASE + MEM_SIZE - 1,
> 		.flags	= IORESOURCE_MEM,
> 	},
> };
>
> static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
> {
> 	request_region(&iomem_resource, &res_mmio);
> 	request_region(&iomem_resource, &pcie_res[1]);
> 	request_region(&ioport_resource, &pcie_res[0]);
> 	sys->resource[0] = &pcie_res[0];
> 	sys->resource[1] = &pcie_res[1];
> }
>
> I've used 0x1000 as IO resources start because having it 0 would cause  
> pcibios_enable_device to fail.

More or less.  You can avoid the ioport resource (&pcie_res[0]) and
replace it with &ioport_resource if you set PCIBIOS_MIN_IO to 0x1000.
This will have the effect of preventing BARs being allocated below
0x1000.

Don't also forget to check the return value from request_region()...
