From: jchandra@broadcom.com (Jayachandran C)
Date: Fri, 18 Mar 2016 01:48:31 +0530
Subject: [RFC PATCH 2/4] PCI: generic,thunder: Use generic config functions
In-Reply-To: <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
References: <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1458245913-17211-3-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use functions provided by pci/ecam.c for mapping config space. The
gen_pci structure is updated to store a pointer to the mapping.

'struct gen_pci_cfg_windows' is no longer needed since the mapping
is handled by generic code and 'struct gen_pci_cfg_bus_ops' can be
removed since bus shift is handled by generic code. The rest of the
data related to generic host controller are moved into 'struct gen_pci'
itself.

The generic code handles the bus and devfn shifts, so a common
function gen_pci_map_cfg_bus() has been added which can be used
as ->map_bus by all users.

With the updated interface, the users have to allocate a gen_pci
instance and setup the bus_shift and pci_ops fields in the structure
before calling pci_host_common_probe().

Update pci-host-common.c, pci-host-generic.c, pci-thunder-ecam.c
and pci-thunder-pem.c to use the new interface.

Also add dependency of PCI_GENERIC_ECAM for PCI_HOST_GENERIC
in Kconfig

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/pci/host/Kconfig            |  1 +
 drivers/pci/host/pci-host-common.c  | 68 +++++++++++++++++++------------------
 drivers/pci/host/pci-host-common.h  | 25 +++++---------
 drivers/pci/host/pci-host-generic.c | 51 +++++-----------------------
 drivers/pci/host/pci-thunder-ecam.c | 33 +++++-------------
 drivers/pci/host/pci-thunder-pem.c  | 41 +++++++---------------
 6 files changed, 74 insertions(+), 145 deletions(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index da61fa77..d27b989 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -82,6 +82,7 @@ config PCI_HOST_GENERIC
 	bool "Generic PCI host controller"
 	depends on (ARM || ARM64) && OF
 	select PCI_HOST_COMMON
+	select PCI_GENERIC_ECAM
 	help
 	  Say Y here if you want to support a simple generic PCI host
 	  controller, such as the one emulated by kvmtool.
diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index e9f850f..d3b0664 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -24,6 +24,14 @@
 
 #include "pci-host-common.h"
 
+void __iomem *gen_pci_map_cfg_bus(struct pci_bus *bus,
+					 unsigned int devfn, int where)
+{
+	struct gen_pci *pci = bus->sysdata;
+
+	return pci_generic_map_bus(pci->cfg, bus->number, devfn, where);
+}
+
 static void gen_pci_release_of_pci_ranges(struct gen_pci *pci)
 {
 	pci_free_resource_list(&pci->resources);
@@ -60,7 +68,7 @@ static int gen_pci_parse_request_of_pci_ranges(struct gen_pci *pci)
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
 			break;
 		case IORESOURCE_BUS:
-			pci->cfg.bus_range = res;
+			pci->bus_range = res;
 		default:
 			continue;
 		}
@@ -83,50 +91,44 @@ out_release_res:
 	return err;
 }
 
+static void gen_pci_generic_unmap_cfg(void *ptr)
+{
+	pci_generic_unmap_config((struct pci_config_window *)ptr);
+}
+
 static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
 {
 	int err;
-	u8 bus_max;
-	resource_size_t busn;
-	struct resource *bus_range;
+	struct resource *cfgres = &pci->cfgres;
+	struct resource *bus_range = pci->bus_range;
+	unsigned int bus_shift = pci->bus_shift;
 	struct device *dev = pci->host.dev.parent;
 	struct device_node *np = dev->of_node;
-	u32 sz = 1 << pci->cfg.ops->bus_shift;
+	struct pci_config_window *cfg;
 
-	err = of_address_to_resource(np, 0, &pci->cfg.res);
+	err = of_address_to_resource(np, 0, cfgres);
 	if (err) {
 		dev_err(dev, "missing \"reg\" property\n");
 		return err;
 	}
 
 	/* Limit the bus-range to fit within reg */
-	bus_max = pci->cfg.bus_range->start +
-		  (resource_size(&pci->cfg.res) >> pci->cfg.ops->bus_shift) - 1;
-	pci->cfg.bus_range->end = min_t(resource_size_t,
-					pci->cfg.bus_range->end, bus_max);
-
-	pci->cfg.win = devm_kcalloc(dev, resource_size(pci->cfg.bus_range),
-				    sizeof(*pci->cfg.win), GFP_KERNEL);
-	if (!pci->cfg.win)
-		return -ENOMEM;
-
-	/* Map our Configuration Space windows */
-	if (!devm_request_mem_region(dev, pci->cfg.res.start,
-				     resource_size(&pci->cfg.res),
-				     "Configuration Space"))
-		return -ENOMEM;
-
-	bus_range = pci->cfg.bus_range;
-	for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
-		u32 idx = busn - bus_range->start;
-
-		pci->cfg.win[idx] = devm_ioremap(dev,
-						 pci->cfg.res.start + idx * sz,
-						 sz);
-		if (!pci->cfg.win[idx])
-			return -ENOMEM;
+	bus_range->end = min(bus_range->end,
+		bus_range->start + (resource_size(cfgres) >> bus_shift) - 1);
+
+	cfg = pci_generic_map_config(cfgres->start, bus_range->start,
+				     bus_range->end, bus_shift, bus_shift - 8);
+
+	if (IS_ERR(cfg))
+		return PTR_ERR(cfg);
+
+	err = devm_add_action(dev, gen_pci_generic_unmap_cfg, cfg);
+	if (err) {
+		gen_pci_generic_unmap_cfg(cfg);
+		return err;
 	}
 
+	pci->cfg = cfg;
 	return 0;
 }
 
@@ -168,8 +170,8 @@ int pci_host_common_probe(struct platform_device *pdev,
 		pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 
 
-	bus = pci_scan_root_bus(dev, pci->cfg.bus_range->start,
-				&pci->cfg.ops->ops, pci, &pci->resources);
+	bus = pci_scan_root_bus(dev, pci->bus_range->start,
+				pci->ops, pci, &pci->resources);
 	if (!bus) {
 		dev_err(dev, "Scanning rootbus failed");
 		return -ENODEV;
diff --git a/drivers/pci/host/pci-host-common.h b/drivers/pci/host/pci-host-common.h
index 09f3fa0..4eb2ff0 100644
--- a/drivers/pci/host/pci-host-common.h
+++ b/drivers/pci/host/pci-host-common.h
@@ -22,26 +22,19 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
-struct gen_pci_cfg_bus_ops {
-	u32 bus_shift;
-	struct pci_ops ops;
-};
-
-struct gen_pci_cfg_windows {
-	struct resource				res;
-	struct resource				*bus_range;
-	void __iomem				**win;
-
-	struct gen_pci_cfg_bus_ops		*ops;
-};
-
 struct gen_pci {
-	struct pci_host_bridge			host;
-	struct gen_pci_cfg_windows		cfg;
-	struct list_head			resources;
+	struct pci_host_bridge		host;
+	struct resource			*bus_range;
+	unsigned int			bus_shift;
+	struct resource			cfgres;
+	struct pci_config_window	*cfg;
+	struct pci_ops			*ops;
+	struct list_head		resources;
 };
 
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct gen_pci *pci);
+void __iomem *gen_pci_map_cfg_bus(struct pci_bus *bus,
+				  unsigned int devfn, int where);
 
 #endif /* _PCI_HOST_COMMON_H */
diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
index e8aa78f..7b6cee1 100644
--- a/drivers/pci/host/pci-host-generic.c
+++ b/drivers/pci/host/pci-host-generic.c
@@ -27,51 +27,15 @@
 
 #include "pci-host-common.h"
 
-static void __iomem *gen_pci_map_cfg_bus_cam(struct pci_bus *bus,
-					     unsigned int devfn,
-					     int where)
-{
-	struct gen_pci *pci = bus->sysdata;
-	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
-
-	return pci->cfg.win[idx] + ((devfn << 8) | where);
-}
-
-static struct gen_pci_cfg_bus_ops gen_pci_cfg_cam_bus_ops = {
-	.bus_shift	= 16,
-	.ops		= {
-		.map_bus	= gen_pci_map_cfg_bus_cam,
-		.read		= pci_generic_config_read,
-		.write		= pci_generic_config_write,
-	}
-};
-
-static void __iomem *gen_pci_map_cfg_bus_ecam(struct pci_bus *bus,
-					      unsigned int devfn,
-					      int where)
-{
-	struct gen_pci *pci = bus->sysdata;
-	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
-
-	return pci->cfg.win[idx] + ((devfn << 12) | where);
-}
-
-static struct gen_pci_cfg_bus_ops gen_pci_cfg_ecam_bus_ops = {
-	.bus_shift	= 20,
-	.ops		= {
-		.map_bus	= gen_pci_map_cfg_bus_ecam,
-		.read		= pci_generic_config_read,
-		.write		= pci_generic_config_write,
-	}
+static struct pci_ops gen_pci_ops = {
+	.map_bus	= gen_pci_map_cfg_bus,
+	.read		= pci_generic_config_read,
+	.write		= pci_generic_config_write,
 };
 
 static const struct of_device_id gen_pci_of_match[] = {
-	{ .compatible = "pci-host-cam-generic",
-	  .data = &gen_pci_cfg_cam_bus_ops },
-
-	{ .compatible = "pci-host-ecam-generic",
-	  .data = &gen_pci_cfg_ecam_bus_ops },
-
+	{ .compatible = "pci-host-cam-generic", .data = (void *)16},
+	{ .compatible = "pci-host-ecam-generic", .data = (void *)20},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, gen_pci_of_match);
@@ -86,7 +50,8 @@ static int gen_pci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	of_id = of_match_node(gen_pci_of_match, dev->of_node);
-	pci->cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
+	pci->bus_shift = (unsigned long)of_id->data;
+	pci->ops = &gen_pci_ops;
 
 	return pci_host_common_probe(pdev, pci);
 }
diff --git a/drivers/pci/host/pci-thunder-ecam.c b/drivers/pci/host/pci-thunder-ecam.c
index d71935cb..34714df 100644
--- a/drivers/pci/host/pci-thunder-ecam.c
+++ b/drivers/pci/host/pci-thunder-ecam.c
@@ -15,17 +15,6 @@
 
 #include "pci-host-common.h"
 
-/* Mapping is standard ECAM */
-static void __iomem *thunder_ecam_map_bus(struct pci_bus *bus,
-					  unsigned int devfn,
-					  int where)
-{
-	struct gen_pci *pci = bus->sysdata;
-	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
-
-	return pci->cfg.win[idx] + ((devfn << 12) | where);
-}
-
 static void set_val(u32 v, int where, int size, u32 *val)
 {
 	int shift = (where & 3) * 8;
@@ -129,7 +118,7 @@ static int thunder_ecam_p2_config_read(struct pci_bus *bus, unsigned int devfn,
 	 * the config space access window.  Since we are working with
 	 * the high-order 32 bits, shift everything down by 32 bits.
 	 */
-	node_bits = (pci->cfg.res.start >> 32) & (1 << 12);
+	node_bits = (pci->cfgres.start >> 32) & (1 << 12);
 
 	v |= node_bits;
 	set_val(v, where, size, val);
@@ -358,19 +347,14 @@ static int thunder_ecam_config_write(struct pci_bus *bus, unsigned int devfn,
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
-static struct gen_pci_cfg_bus_ops thunder_ecam_bus_ops = {
-	.bus_shift	= 20,
-	.ops		= {
-		.map_bus        = thunder_ecam_map_bus,
-		.read           = thunder_ecam_config_read,
-		.write          = thunder_ecam_config_write,
-	}
+static struct pci_ops thunder_ecam_pci_ops = {
+	.map_bus        = gen_pci_map_cfg_bus,
+	.read           = thunder_ecam_config_read,
+	.write          = thunder_ecam_config_write,
 };
 
 static const struct of_device_id thunder_ecam_of_match[] = {
-	{ .compatible = "cavium,pci-host-thunder-ecam",
-	  .data = &thunder_ecam_bus_ops },
-
+	{ .compatible = "cavium,pci-host-thunder-ecam" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, thunder_ecam_of_match);
@@ -378,14 +362,13 @@ MODULE_DEVICE_TABLE(of, thunder_ecam_of_match);
 static int thunder_ecam_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
 
 	if (!pci)
 		return -ENOMEM;
 
-	of_id = of_match_node(thunder_ecam_of_match, dev->of_node);
-	pci->cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
+	pci->ops = &thunder_ecam_pci_ops;
+	pci->bus_shift = 20;
 
 	return pci_host_common_probe(pdev, pci);
 }
diff --git a/drivers/pci/host/pci-thunder-pem.c b/drivers/pci/host/pci-thunder-pem.c
index cabb92a..eb248c1 100644
--- a/drivers/pci/host/pci-thunder-pem.c
+++ b/drivers/pci/host/pci-thunder-pem.c
@@ -31,15 +31,6 @@ struct thunder_pem_pci {
 	void __iomem	*pem_reg_base;
 };
 
-static void __iomem *thunder_pem_map_bus(struct pci_bus *bus,
-					 unsigned int devfn, int where)
-{
-	struct gen_pci *pci = bus->sysdata;
-	resource_size_t idx = bus->number - pci->cfg.bus_range->start;
-
-	return pci->cfg.win[idx] + ((devfn << 16) | where);
-}
-
 static int thunder_pem_bridge_read(struct pci_bus *bus, unsigned int devfn,
 				   int where, int size, u32 *val)
 {
@@ -134,15 +125,15 @@ static int thunder_pem_config_read(struct pci_bus *bus, unsigned int devfn,
 {
 	struct gen_pci *pci = bus->sysdata;
 
-	if (bus->number < pci->cfg.bus_range->start ||
-	    bus->number > pci->cfg.bus_range->end)
+	if (bus->number < pci->bus_range->start ||
+	    bus->number > pci->bus_range->end)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
 	 * The first device on the bus is the PEM PCIe bridge.
 	 * Special case its config access.
 	 */
-	if (bus->number == pci->cfg.bus_range->start)
+	if (bus->number == pci->bus_range->start)
 		return thunder_pem_bridge_read(bus, devfn, where, size, val);
 
 	return pci_generic_config_read(bus, devfn, where, size, val);
@@ -258,33 +249,28 @@ static int thunder_pem_config_write(struct pci_bus *bus, unsigned int devfn,
 {
 	struct gen_pci *pci = bus->sysdata;
 
-	if (bus->number < pci->cfg.bus_range->start ||
-	    bus->number > pci->cfg.bus_range->end)
+	if (bus->number < pci->bus_range->start ||
+	    bus->number > pci->bus_range->end)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	/*
 	 * The first device on the bus is the PEM PCIe bridge.
 	 * Special case its config access.
 	 */
-	if (bus->number == pci->cfg.bus_range->start)
+	if (bus->number == pci->bus_range->start)
 		return thunder_pem_bridge_write(bus, devfn, where, size, val);
 
 
 	return pci_generic_config_write(bus, devfn, where, size, val);
 }
 
-static struct gen_pci_cfg_bus_ops thunder_pem_bus_ops = {
-	.bus_shift	= 24,
-	.ops		= {
-		.map_bus	= thunder_pem_map_bus,
-		.read		= thunder_pem_config_read,
-		.write		= thunder_pem_config_write,
-	}
+static struct pci_ops thunder_pem_pci_ops = {
+	.map_bus        = gen_pci_map_cfg_bus,
+	.read           = thunder_pem_config_read,
+	.write          = thunder_pem_config_write,
 };
 
 static const struct of_device_id thunder_pem_of_match[] = {
-	{ .compatible = "cavium,pci-host-thunder-pem",
-	  .data = &thunder_pem_bus_ops },
-
+	{ .compatible = "cavium,pci-host-thunder-pem" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, thunder_pem_of_match);
@@ -292,7 +278,6 @@ MODULE_DEVICE_TABLE(of, thunder_pem_of_match);
 static int thunder_pem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	resource_size_t bar4_start;
 	struct resource *res_pem;
 	struct thunder_pem_pci *pem_pci;
@@ -301,8 +286,8 @@ static int thunder_pem_probe(struct platform_device *pdev)
 	if (!pem_pci)
 		return -ENOMEM;
 
-	of_id = of_match_node(thunder_pem_of_match, dev->of_node);
-	pem_pci->gen_pci.cfg.ops = (struct gen_pci_cfg_bus_ops *)of_id->data;
+	pem_pci->gen_pci.ops = &thunder_pem_pci_ops;
+	pem_pci->gen_pci.bus_shift = 24;
 
 	/*
 	 * The second register range is the PEM bridge to the PCIe
-- 
1.9.1
