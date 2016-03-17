From: jchandra@broadcom.com (Jayachandran C)
Date: Fri, 18 Mar 2016 01:48:32 +0530
Subject: [RFC PATCH 3/4] ACPI: PCI: Add generic PCI host controller
In-Reply-To: <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
References: <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1458245913-17211-4-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a generic ACPI based PCI host controller, and provide config
option ACPI_PCI_HOST_GENERIC to enable it.

The implementation selects PCI_MMCONFIG and implements function
pci_mmcfg_late_init() to parse MCFG table and save its entries.
PCI_GENERIC_ECAM is also selected and pci/ecam.c functions are
used to map the config space of the PCI controller.

acpi_pci_root_ops is setup so that init_info looks up the saved
MCFG entries and sets up the config space mapping.  release_info
deletes the mapping and frees the memory. Generic PCI functions
are used for accessing config space.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/acpi/Kconfig        |   9 ++
 drivers/acpi/Makefile       |   1 +
 drivers/acpi/pci_gen_host.c | 247 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 drivers/acpi/pci_gen_host.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 82b96ee..f178f2e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -343,6 +343,15 @@ config ACPI_PCI_SLOT
 	  i.e., segment/bus/device/function tuples, with physical slots in
 	  the system.  If you are unsure, say N.
 
+config ACPI_PCI_HOST_GENERIC
+	bool "Generic ACPI based PCI controller"
+	depends on ARM64
+	select PCI_MMCONFIG
+	select PCI_GENERIC_ECAM
+	help
+	  Say Y if you want the generic ACPI based PCI controller
+	  implementation.
+
 config X86_PM_TIMER
 	bool "Power Management Timer Support" if EXPERT
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index cb648a4..ceab5b0 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
+obj-$(CONFIG_ACPI_PCI_HOST_GENERIC)	+= pci_gen_host.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
diff --git a/drivers/acpi/pci_gen_host.c b/drivers/acpi/pci_gen_host.c
new file mode 100644
index 0000000..a43f2cee
--- /dev/null
+++ b/drivers/acpi/pci_gen_host.c
@@ -0,0 +1,247 @@
+/*
+ * Copyright 2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation (the "GPL").
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License version 2 (GPLv2) for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * version 2 (GPLv2) along with this source code.
+ */
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+#include <linux/sfi_acpi.h>
+#include <linux/slab.h>
+
+#define PREFIX	"ACPI: "
+
+/*
+ * Structure to hold entries from the MCFG table, these need to be
+ * mapped until a pci host bridge claims them for raw_pci_read/write
+ * to work
+ */
+struct mcfg_entry {
+	phys_addr_t		addr;
+	u16			segment;
+	u8			bus_start;
+	u8			bus_end;
+};
+
+/*
+ * Global to save mcfg entries
+ */
+static struct {
+	struct mcfg_entry	*cfg;
+	int			size;
+} mcfgsav;
+
+/* List of all ACPI PCI roots, needed for raw operations */
+static struct list_head gen_acpi_pci_roots;
+
+/* lock for global table AND list above */
+static struct mutex gen_acpi_pci_lock;
+
+/* ACPI info for generic ACPI PCI controller */
+struct acpi_pci_generic_root_info {
+	struct acpi_pci_root_info	common;
+	struct pci_config_window	*cfg;	/* config space mapping */
+	struct list_head		node;	/* node in acpi_pci_roots */
+};
+
+/* Call generic map_bus after getting cfg pointer */
+static void __iomem *gen_acpi_map_cfg_bus(struct pci_bus *bus,
+					  unsigned int devfn, int where)
+{
+	struct acpi_pci_generic_root_info *ri = bus->sysdata;
+
+	return pci_generic_map_bus(ri->cfg, bus->number, devfn, where);
+}
+
+static struct pci_ops acpi_pci_ops = {
+	.map_bus	= gen_acpi_map_cfg_bus,
+	.read		= pci_generic_config_read,
+	.write		= pci_generic_config_write,
+};
+
+/* find the entry in mcfgsav.cfg which contains range bus_start..bus_end */
+static int mcfg_lookup(u16 seg, u8 bus_start, u8 bus_end)
+{
+	struct mcfg_entry *e;
+	int i;
+
+	for (i = 0, e = mcfgsav.cfg; i < mcfgsav.size; i++, e++) {
+		if (seg != e->segment)
+			continue;
+		if (bus_start >= e->bus_start && bus_start <= e->bus_end)
+			return (bus_end <= e->bus_end) ? i : -EINVAL;
+		else if (bus_end >= e->bus_start && bus_end <= e->bus_end)
+			return -EINVAL;
+	}
+	return -ENOENT;
+}
+
+/*
+ * init_info - lookup the bus range for the domain in MCFG, and set up
+ * config space mapping.
+ */
+static int pci_acpi_generic_init_info(struct acpi_pci_root_info *ci)
+{
+	struct acpi_pci_generic_root_info *ri;
+	struct acpi_pci_root *root = ci->root;
+	u16 seg = root->segment;
+	u8 bus_start = root->secondary.start;
+	u8 bus_end = root->secondary.end;
+	phys_addr_t addr = root->mcfg_addr;
+	struct mcfg_entry *e;
+	int ret;
+
+	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
+
+	mutex_lock(&gen_acpi_pci_lock);
+	ret = mcfg_lookup(seg, bus_start, bus_end);
+	switch (ret) {
+	case -ENOENT:
+		if (addr != 0)	/* use address from _CBA */
+			break;
+		pr_err("%04x:%02x-%02x mcfg lookup failed\n", seg,
+		       bus_start, bus_end);
+		goto err_out;
+	case -EINVAL:
+		pr_err("%04x:%02x-%02x bus range error\n", seg, bus_start,
+		       bus_end);
+		goto err_out;
+	default:
+		e = &mcfgsav.cfg[ret];
+		if (addr == 0)
+			addr = e->addr;
+		if (bus_start != e->bus_start) {
+			pr_err("%04x:%02x-%02x bus range mismatch %02x\n",
+			       seg, bus_start, bus_end, e->bus_start);
+			goto err_out;
+		}
+		if (addr != e->addr) {
+			pr_warn("%04x:%02x-%02x addr mismatch, ignoring MCFG\n",
+				seg, bus_start, bus_end);
+		} else if (bus_end != e->bus_end) {
+			pr_warn("%04x:%02x-%02x bus end mismatch %02x\n",
+				seg, bus_start, bus_end, e->bus_end);
+			bus_end = min(bus_end, e->bus_end);
+		}
+		break;
+	}
+
+	ri->cfg = pci_generic_map_config(addr, bus_start, bus_end, 20, 12);
+	if (IS_ERR(ri->cfg)) {
+		ret = PTR_ERR(ri->cfg);
+		pr_err("%04x:%02x-%02x error %d mapping CFG\n", seg, bus_start,
+		       bus_end, ret);
+		goto err_out;
+	}
+	list_add_tail(&ri->node, &gen_acpi_pci_roots);
+err_out:
+	mutex_unlock(&gen_acpi_pci_lock);
+	return ret;
+}
+
+/* release_info: free resrouces allocated by init_info */
+static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
+{
+	struct acpi_pci_generic_root_info *ri;
+
+	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
+
+	mutex_lock(&gen_acpi_pci_lock);
+	list_del(&ri->node);
+	pci_generic_unmap_config(ri->cfg);
+	mutex_unlock(&gen_acpi_pci_lock);
+
+	kfree(ri);
+}
+
+static struct acpi_pci_root_ops acpi_pci_root_ops = {
+	.pci_ops = &acpi_pci_ops,
+	.init_info = pci_acpi_generic_init_info,
+	.release_info = pci_acpi_generic_release_info,
+};
+
+/* Interface called from ACPI code to setup PCI host controller */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	int node = acpi_get_node(root->device->handle);
+	struct acpi_pci_generic_root_info *ri;
+	struct pci_bus *bus, *child;
+
+	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
+	if (!ri)
+		return NULL;
+
+	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common, ri);
+	if (!bus)
+		return NULL;
+
+	pci_bus_size_bridges(bus);
+	pci_bus_assign_resources(bus);
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+
+/* handle MCFG table entries */
+static __init int handle_mcfg(struct acpi_table_header *header)
+{
+	struct acpi_table_mcfg *mcfg;
+	struct acpi_mcfg_allocation *mptr;
+	struct mcfg_entry *e, *arr;
+	int i, n;
+
+	if (!header)
+		return -EINVAL;
+
+	mcfg = (struct acpi_table_mcfg *)header;
+	mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
+	n = (header->length - sizeof(*mcfg)) / sizeof(*mptr);
+	if (n <= 0 || n > 255) {
+		pr_err(PREFIX " MCFG has incorrect entries (%d).\n", n);
+		return -EINVAL;
+	}
+
+	arr = kcalloc(n, sizeof(*arr), GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+
+	for (i = 0, e = arr; i < n; i++, mptr++, e++) {
+		e->segment = mptr->pci_segment;
+		e->addr =  mptr->address;
+		e->bus_start = mptr->start_bus_number;
+		e->bus_end = mptr->end_bus_number;
+	}
+
+	mcfgsav.cfg = arr;
+	mcfgsav.size = n;
+	return 0;
+}
+
+/* Interface called by ACPI - parse and save MCFG table */
+void __init pci_mmcfg_late_init(void)
+{
+	int err;
+
+	mutex_init(&gen_acpi_pci_lock);
+	INIT_LIST_HEAD(&gen_acpi_pci_roots);
+	err = acpi_sfi_table_parse(ACPI_SIG_MCFG, handle_mcfg);
+	if (err) {
+		pr_err(PREFIX " Failed to parse MCFG (%d)\n", err);
+		mcfgsav.size = 0;
+	} else {
+		pr_info(PREFIX " MCFG table at %p, %d entries.\n",
+			mcfgsav.cfg, mcfgsav.size);
+	}
+}
-- 
1.9.1
