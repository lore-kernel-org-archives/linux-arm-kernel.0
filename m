From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri, 29 Jun 2018 11:22:29 +0200
Subject: [PATCH 1/3] PCI: Introduce PCI software bridge common logic
In-Reply-To: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
References: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180629092231.32207-2-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some PCI host controllers do not expose at the hardware level a root
port PCI bridge. Due to this, the Marvell Armada 370/38x/XP PCI
controller driver (pci-mvebu) emulates a root port PCI bridge, and
uses that to (among other things?) dynamically create the memory
windows that correspond to the PCI MEM and I/O regions.

Since we now need to add a very similar logic for the Marvell Armada
37xx PCI controller driver (pci-aardvark), instead of duplicating the
code, we create in this commit a common logic called pci-sw-bridge.

The idea of this logic is to emulate a root port PCI bridge by
providing configuration space read/write operations, and faking behind
the scenes the configuration space of a PCI bridge. A PCI host
controller driver simply has to call pci_sw_bridge_read() and
pci_sw_bridge_write() to read/write the configuration space of the
bridge.

By default, the PCI bridge configuration space is simply emulated by a
chunk of memory, but the PCI host controller can override the behavior
of the read and write operations on a per-register basis to do
additional actions if needed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/Kconfig           |   3 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/pci-sw-bridge.c   | 149 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-sw-bridge.h | 125 +++++++++++++++++++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 drivers/pci/pci-sw-bridge.c
 create mode 100644 include/linux/pci-sw-bridge.h

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 56ff8f6d31fc..1f13575d052b 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -98,6 +98,9 @@ config PCI_ECAM
 config PCI_LOCKLESS_CONFIG
 	bool
 
+config PCI_SW_BRIDGE
+	bool
+
 config PCI_IOV
 	bool "PCI IOV support"
 	depends on PCI
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 535201984b8b..0bd65ddd2c50 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_PCI_MSI)		+= msi.o
 obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
+obj-$(CONFIG_PCI_SW_BRIDGE)	+= pci-sw-bridge.o
 obj-$(CONFIG_ACPI)		+= pci-acpi.o
 obj-$(CONFIG_PCI_LABEL)		+= pci-label.o
 obj-$(CONFIG_X86_INTEL_MID)	+= pci-mid.o
diff --git a/drivers/pci/pci-sw-bridge.c b/drivers/pci/pci-sw-bridge.c
new file mode 100644
index 000000000000..304e8c0e164d
--- /dev/null
+++ b/drivers/pci/pci-sw-bridge.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Marvell
+ *
+ * Author: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
+ *
+ * This file helps PCI controller drivers implement a fake root port
+ * PCI bridge when the HW doesn't provide such a root port PCI
+ * bridge.
+ *
+ * It emulates a PCI bridge by providing a fake PCI configuration
+ * space (and optionally a PCIe capability configuration space) in
+ * memory. By default the read/write operations simply read and update
+ * this fake configuration space in memory. However, PCI controller
+ * drivers can provide through the 'struct pci_sw_bridge_ops'
+ * structure a set of operations to override or complement this
+ * default behavior.
+ */
+
+#include <linux/pci-sw-bridge.h>
+#include <linux/pci.h>
+
+#define PCI_BRIDGE_CONF_END	(PCI_BRIDGE_CONTROL + 2)
+#define PCI_CAP_PCIE_START	PCI_BRIDGE_CONF_END
+#define PCI_CAP_PCIE_END	(PCI_CAP_PCIE_START + PCI_EXP_SLTSTA2 + 2)
+
+/*
+ * Initialize a pci_sw_bridge structure to represent a fake PCI
+ * bridge. The caller needs to have initialized the PCI configuration
+ * space with whatever values make sense (typically at least vendor,
+ * device, revision), the ->ops pointer, and possibly ->data and
+ * ->has_pcie.
+ */
+void pci_sw_bridge_init(struct pci_sw_bridge *bridge)
+{
+	bridge->conf.class = PCI_CLASS_BRIDGE_PCI;
+	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
+	bridge->conf.cache_line_size = 0x10;
+	bridge->conf.status = PCI_STATUS_CAP_LIST;
+
+	if (bridge->has_pcie) {
+		bridge->conf.capabilities_pointer = PCI_CAP_PCIE_START;
+		bridge->pcie_conf.cap_id = PCI_CAP_ID_EXP;
+		/* Set PCIe v2, root port, slot support */
+		bridge->pcie_conf.cap = PCI_EXP_TYPE_ROOT_PORT << 4 | 2 |
+			PCI_EXP_FLAGS_SLOT;
+	}
+}
+
+/*
+ * Should be called by the PCI controller driver when reading the PCI
+ * configuration space of the fake bridge. It will call back the
+ * ->ops->read_base or ->ops->read_pcie operations.
+ */
+int pci_sw_bridge_read(struct pci_sw_bridge *bridge, int where,
+		       int size, u32 *value)
+{
+	int ret;
+	int reg = where & ~3;
+
+	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_END) {
+		*value = 0;
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	if (!bridge->has_pcie && reg >= PCI_BRIDGE_CONF_END) {
+		*value = 0;
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
+		reg -= PCI_CAP_PCIE_START;
+
+		if (bridge->ops->read_pcie)
+			ret = bridge->ops->read_pcie(bridge, reg, value);
+		else
+			ret = PCI_SW_BRIDGE_NOT_HANDLED;
+
+		if (ret == PCI_SW_BRIDGE_NOT_HANDLED)
+			*value = *((u32*) &bridge->pcie_conf + reg / 4);
+	} else {
+		if (bridge->ops->read_base)
+			ret = bridge->ops->read_base(bridge, reg, value);
+		else
+			ret = PCI_SW_BRIDGE_NOT_HANDLED;
+
+		if (ret == PCI_SW_BRIDGE_NOT_HANDLED)
+			*value = *((u32*) &bridge->conf + reg / 4);
+	}
+
+	if (size == 1)
+		*value = (*value >> (8 * (where & 3))) & 0xff;
+	else if (size == 2)
+		*value = (*value >> (8 * (where & 3))) & 0xffff;
+	else if (size != 4)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+ * Should be called by the PCI controller driver when writing the PCI
+ * configuration space of the fake bridge. It will call back the
+ * ->ops->write_base or ->ops->write_pcie operations.
+ */
+int pci_sw_bridge_write(struct pci_sw_bridge *bridge, int where,
+			int size, u32 value)
+{
+	int reg = where & ~3;
+	int mask, ret, old, new;
+
+	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_END)
+		return PCIBIOS_SUCCESSFUL;
+
+	if (!bridge->has_pcie && reg >= PCI_BRIDGE_CONF_END)
+		return PCIBIOS_SUCCESSFUL;
+
+	if (size == 4)
+		mask = 0xffffffff;
+	else if (size == 2)
+		mask = 0xffff << ((where & 0x3) * 8);
+	else if (size == 1)
+		mask = 0xff << ((where & 0x3) * 8);
+	else
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	ret = pci_sw_bridge_read(bridge, reg, 4, &old);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
+
+	new = old & ~mask;
+	new |= (value << ((where & 0x3) * 8)) & mask;
+
+	if (bridge->has_pcie && reg >= PCI_CAP_PCIE_START) {
+		reg -= PCI_CAP_PCIE_START;
+
+		*((u32*) &bridge->pcie_conf + reg / 4) = new;
+
+		if (bridge->ops->write_pcie)
+			bridge->ops->write_pcie(bridge, reg, old, new, mask);
+	} else {
+		*((u32*) &bridge->conf + reg / 4) = new;
+
+		if (bridge->ops->write_base)
+			bridge->ops->write_base(bridge, reg, old, new, mask);
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
diff --git a/include/linux/pci-sw-bridge.h b/include/linux/pci-sw-bridge.h
new file mode 100644
index 000000000000..152648124df5
--- /dev/null
+++ b/include/linux/pci-sw-bridge.h
@@ -0,0 +1,125 @@
+#ifndef __PCI_SW_BRIDGE_H__
+#define __PCI_SW_BRIDGE_H__
+
+#include <linux/kernel.h>
+
+/* PCI configuration space of a PCI-to-PCI bridge. */
+struct pci_sw_bridge_conf {
+	u16 vendor;
+	u16 device;
+	u16 command;
+	u16 status;
+	u8 revision;
+	u8 interface;
+	u16 class;
+	u8 cache_line_size;
+	u8 latency_timer;
+	u8 header_type;
+	u8 bist;
+	u32 bar[2];
+	u8 primary_bus;
+	u8 secondary_bus;
+	u8 subordinate_bus;
+	u8 secondary_latency_timer;
+	u8 iobase;
+	u8 iolimit;
+	u16 secondary_status;
+	u16 membase;
+	u16 memlimit;
+	u16 pref_mem_base;
+	u16 pref_mem_limit;
+	u32 prefbaseupper;
+	u32 preflimitupper;
+	u16 iobaseupper;
+	u16 iolimitupper;
+	u8 capabilities_pointer;
+	u8 reserve[3];
+	u32 romaddr;
+	u8 intline;
+	u8 intpin;
+	u16 bridgectrl;
+};
+
+/* PCI configuration space of the PCIe capabilities */
+struct pci_sw_bridge_pcie_conf {
+	u8 cap_id;
+	u8 next;
+	u16 cap;
+	u32 devcap;
+	u16 devctl;
+	u16 devsta;
+	u32 lnkcap;
+	u16 lnkctl;
+	u16 lnksta;
+	u32 slotcap;
+	u16 slotctl;
+	u16 slotsta;
+	u16 rootctl;
+	u16 rsvd;
+	u32 rootsta;
+	u32 devcap2;
+	u16 devctl2;
+	u16 devsta2;
+	u32 lnkcap2;
+	u16 lnkctl2;
+	u16 lnksta2;
+	u32 slotcap2;
+	u16 slotctl2;
+	u16 slotsta2;
+};
+
+struct pci_sw_bridge;
+
+typedef enum { PCI_SW_BRIDGE_HANDLED,
+	       PCI_SW_BRIDGE_NOT_HANDLED } pci_sw_bridge_read_status_t;
+
+struct pci_sw_bridge_ops {
+	/*
+	 * Called when reading from the regular PCI bridge
+	 * configuration space. Return PCI_SW_BRIDGE_HANDLED when the
+	 * operation has handled the read operation and filled in the
+	 * *value, or PCI_SW_BRIDGE_NOT_HANDLED when the read should
+	 * be emulated by the common code by reading from the
+	 * in-memory copy of the configuration space.
+	 */
+	pci_sw_bridge_read_status_t (*read_base)(struct pci_sw_bridge *bridge,
+						 int reg, u32 *value);
+
+	/*
+	 * Same as ->read_base(), except it is for reading from the
+	 * PCIe capability configuration space.
+	 */
+	pci_sw_bridge_read_status_t (*read_pcie)(struct pci_sw_bridge *bridge,
+						 int reg, u32 *value);
+	/*
+	 * Called when writing to the regular PCI bridge configuration
+	 * space. old is the current value, new is the new value being
+	 * written, and mask indicates which parts of the value are
+	 * being changed.
+	 */
+	void (*write_base)(struct pci_sw_bridge *bridge, int reg,
+			   u32 old, u32 new, u32 mask);
+
+	/*
+	 * Same as ->read_base(), except it is for reading from the
+	 * PCIe capability configuration space.
+	 */
+	void (*write_pcie)(struct pci_sw_bridge *bridge, int reg,
+			   u32 old, u32 new, u32 mask);
+};
+
+struct pci_sw_bridge {
+	struct pci_sw_bridge_conf conf;
+	struct pci_sw_bridge_pcie_conf pcie_conf;
+	struct pci_sw_bridge_ops *ops;
+	void *data;
+	bool has_pcie;
+};
+
+void pci_sw_bridge_init(struct pci_sw_bridge *bridge);
+int pci_sw_bridge_read(struct pci_sw_bridge *bridge, int where,
+		       int size, u32 *value);
+int pci_sw_bridge_write(struct pci_sw_bridge *bridge, int where,
+			int size, u32 value);
+
+#endif /* __PCI_SW_BRIDGE_H__ */
-- 
2.14.4
