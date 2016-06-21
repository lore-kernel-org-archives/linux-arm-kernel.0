From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 21 Jun 2016 12:01:41 -0500
Subject: [PATCH 1/2] ARM: Make PCI I/O space optional
In-Reply-To: <20160621165646.7997.44001.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160621165646.7997.44001.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160621170141.7997.22278.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For callers of pci_common_init_dev(), we previously always required a PCI
I/O port resource.  If the caller's ->setup() function had added an I/O
resource, we used that; otherwise, we added a default 64K I/O port space
for it.

There are PCI host bridges that do not support I/O port space, and we
should not add fictitious spaces for them.

If a caller sets struct hw_pci.io_optional, assume it is responsible for
adding any I/O port resource it desires, and do not add any default I/O
port space.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/include/asm/mach/pci.h |    1 +
 arch/arm/kernel/bios32.c        |   13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 0070e85..2d88af5 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -22,6 +22,7 @@ struct hw_pci {
 	struct msi_controller *msi_ctrl;
 	struct pci_ops	*ops;
 	int		nr_controllers;
+	unsigned int	io_optional:1;
 	void		**private_data;
 	int		(*setup)(int nr, struct pci_sys_data *);
 	struct pci_bus *(*scan)(int nr, struct pci_sys_data *);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 05e61a2..65f12ef 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -410,7 +410,8 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
+static int pcibios_init_resource(int busnr, struct pci_sys_data *sys,
+				 int io_optional)
 {
 	int ret;
 	struct resource_entry *window;
@@ -420,6 +421,14 @@ static int pcibios_init_resources(int busnr, struct pci_sys_data *sys)
 			 &iomem_resource, sys->mem_offset);
 	}
 
+	/*
+	 * If a platform says I/O port support is optional, we don't add
+	 * the default I/O space.  The platform is responsible for adding
+	 * any I/O space it needs.
+	 */
+	if (io_optional)
+		return 0;
+
 	resource_list_for_each_entry(window, &sys->resources)
 		if (resource_type(window->res) == IORESOURCE_IO)
 			return 0;
@@ -466,7 +475,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		if (ret > 0) {
 			struct pci_host_bridge *host_bridge;
 
-			ret = pcibios_init_resources(nr, sys);
+			ret = pcibios_init_resource(nr, sys, hw->io_optional);
 			if (ret)  {
 				kfree(sys);
 				break;
