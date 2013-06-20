From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 12:00:57 +0200
Subject: [PATCH V6 1/3] pci: Add PCIe driver for Samsung Exynos
In-Reply-To: <00c001ce6d85$4613e530$d23baf90$@samsung.com>
References: <00c001ce6d85$4613e530$d23baf90$@samsung.com>
Message-ID: <201306201200.58057.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Jingoo Han wrote:
> Exynos5440 has a PCIe controller which can be used as Root Complex.
> This driver supports a PCIe controller as Root Complex mode.
> 
> Signed-off-by: Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
> Signed-off-by: Siva Reddy Kallam <siva.kallam@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

The code looks good now.

Acked-by: Arnd Bergmann <arnd@arndb.de>

>  .../devicetree/bindings/pci/exynos-pcie.txt        |   71 ++
>  drivers/pci/host/Kconfig                           |    5 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-exynos.c                      | 1057 ++++++++++++++++++++
>  4 files changed, 1134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/exynos-pcie.txt
>  create mode 100644 drivers/pci/host/pci-exynos.c

But please change the identifier to designware or synopsys as I
asked you to.

Have a look at http://permalink.gmane.org/gmane.linux.kernel.pci/18400

This was an earlier submission for a PCIe host driver obviously
based on the same IP block. I don't know why that driver never
made it into the kernel, but if it gets submitted again, or another
platform uses the same block, it should share most of your driver.

Whatever is exynos specific then can be moved out to a separate
file.

> +Required properties:
> +-compatible: should be "samsung,exynos5440-pcie"

Please also add a generic string, e.g.

- compatible: should contain "snps,dwc-pcie" to identify the
  core, plus an identifier for the specific instance, such
  as "samsung,exynos5440-pcie".

> +
> +static unsigned long global_io_offset;
> +
> +static int exynos_pcie_setup(int nr, struct pci_sys_data *sys)
> +{
> +	struct pcie_port *pp;
> +
> +	pp = sys_to_pcie(sys);
> +
> +	if (!pp)
> +		return 0;
> +
> +	if (global_io_offset < SZ_1M && pp->config.io_size > 0) {
> +		sys->io_offset = global_io_offset - pp->config.io_bus_addr;
> +		pci_ioremap_io(sys->io_offset, pp->io.start);
> +		global_io_offset += SZ_64K;
> +	}
> +
> +	sys->mem_offset = pp->mem.start - pp->config.mem_bus_addr;
> +
> +	pci_add_resource_offset(&sys->resources, &pp->io, sys->io_offset);
> +	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
> +
> +	return 1;
> +}

Just noticed one detail here: the 'pci_add_resource_offset' for the
I/O window should be inside of the 'if' clause, we must not annouce
the I/O port range to the PCI core layer unless we have actually
mapped it.

	Arnd
