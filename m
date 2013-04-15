From: andrew.murray@arm.com (Andrew Murray)
Date: Mon, 15 Apr 2013 10:31:15 +0100
Subject: [PATCH v4] ARM: pci: create pci_common_init_dev()
In-Reply-To: <1365970932-10998-1-git-send-email-linus.walleij@linaro.org>
References: <1365970932-10998-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130415093115.GA3849@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 14, 2013 at 09:22:12PM +0100, Linus Walleij wrote:
> When working with device tree support for PCI on ARM you run
> into a problem when mapping IRQs from the device tree irqmaps:
> doing this the code in drivers/of/of_pci_irq.c will try to
> find the OF node on the root bridge and this fails, because
> bus->dev.of_node is NULL, and that in turn boils down to
> the fact that pci_set_bus_of_node() has called
> pcibios_get_phb_of_node() from drivers/pci/of.c to obtain
> the OF node of the bridge or its parent and none is set
> and thus NULL is returned.
> 
> Fix this by adding an additional parent argument API for
> registering PCI bridges on the ARM architecture called
> pci_common_init_dev(), and pass along this parent to
> pci_scan_root_bus() called from pcibios_init_hw() in
> bios32.c and voila: the IRQ mappings start working:
> the OF node can be retrieved from the parent.
> 
> Create the old pci_common_init() as a wrapper around
> the new call.
> 
> Cc: Mike Rapoport <mike@compulab.co.il>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmitt <benh@kernel.crashing.org>
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Put opening bracket on its own line.
> - Use the proper rmk+kernel address for Russells CC.
> ---

Reviewed-by: Andrew Murray <andrew.murray@arm.com>
