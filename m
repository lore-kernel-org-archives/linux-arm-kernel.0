From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 10 Sep 2014 13:12:39 -0400
Subject: [PATCH v3 2/2] PCI: keystone: read pci device id dynamically to
 support multiple ports
In-Reply-To: <1410369159-11564-1-git-send-email-m-karicheri2@ti.com>
References: <1410369159-11564-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1410369159-11564-2-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

K2E SoC has two PCI ports. The SATA controller is connected to second
PCI port (port 1). To support multiple port handling in Keystone PCI
driver, read the PCI device ID dynamically by iomap/read/unmap during
probe and save it in driver's private data and update it in host init code.
The PCI device ID field in the RC's config space is not filled by
default by the hardware and has to be updated by the PCI driver by
reading the same from the SoC register indicated by reg index #2 in
DT bindings.

While at it remove the note for bootargs as this is no longer needed.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 v3 - removed handling of pcie-port and removed the documentation. Also
      updated commit log to reflect the real change.
 v2 - updated based on comment against v1. Removed handling of RC mode
      
 .../devicetree/bindings/pci/pci-keystone.txt       |    3 ---
 drivers/pci/host/pci-keystone.c                    |    9 +++++----
 drivers/pci/host/pci-keystone.h                    |    4 ++--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index bedacf0..54eae29 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -61,6 +61,3 @@ Designware DT Properties not applicable for Keystone PCI
 
 1. pcie_bus clock-names not used.  Instead, a phandle to phys is used.
 
-Note for PCI driver usage
-=========================
-Driver requires pci=pcie_bus_perf in the bootargs for proper functioning.
diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
index f1119eb..a74f26e 100644
--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -253,8 +253,8 @@ static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
 
 static void __init ks_pcie_host_init(struct pcie_port *pp)
 {
-	u32 vendor_device_id, val;
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
+	u32 val;
 
 	ks_pcie_establish_link(ks_pcie);
 	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
@@ -263,8 +263,7 @@ static void __init ks_pcie_host_init(struct pcie_port *pp)
 			pp->dbi_base + PCI_IO_BASE);
 
 	/* update the Vendor ID */
-	vendor_device_id = readl(ks_pcie->va_reg_pciid);
-	writew((vendor_device_id >> 16), pp->dbi_base + PCI_DEVICE_ID);
+	writew(ks_pcie->device_id, pp->dbi_base + PCI_DEVICE_ID);
 
 	/* update the DEV_STAT_CTRL to publish right mrrs */
 	val = readl(pp->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
@@ -373,7 +372,9 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	reg_p = devm_ioremap_resource(dev, res);
 	if (IS_ERR(reg_p))
 		return PTR_ERR(reg_p);
-	ks_pcie->va_reg_pciid = reg_p;
+	ks_pcie->device_id = readl(reg_p) >> 16;
+	devm_iounmap(dev, reg_p);
+	devm_release_mem_region(dev, res->start, resource_size(res));
 
 	pp->dev = dev;
 	platform_set_drvdata(pdev, ks_pcie);
diff --git a/drivers/pci/host/pci-keystone.h b/drivers/pci/host/pci-keystone.h
index 729ea7d..80cfa8e 100644
--- a/drivers/pci/host/pci-keystone.h
+++ b/drivers/pci/host/pci-keystone.h
@@ -19,8 +19,8 @@
 struct keystone_pcie {
 	struct	clk		*clk;
 	struct	pcie_port	pp;
-	void __iomem		*va_reg_pciid;
-
+	/* PCI Device ID */
+	u32			device_id;
 	int			num_legacy_host_irqs;
 	int			legacy_host_irqs[MAX_LEGACY_HOST_IRQS];
 	struct			device_node *legacy_intc_np;
-- 
1.7.9.5
