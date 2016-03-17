From: jchandra@broadcom.com (Jayachandran C)
Date: Fri, 18 Mar 2016 01:48:33 +0530
Subject: [RFC PATCH 4/4] ACPI: PCI: Add raw_pci_read/write operations
In-Reply-To: <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
References: <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
Message-ID: <1458245913-17211-5-git-send-email-jchandra@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide implementations of raw_pci_read and raw_pci_write needed
by ACPI.

We already maintain a gen_acpi_pci_roots list with all the ACPI
PCI controllers, so we walk thru this list to see if there is
an existing mapping. If there is one, we can use the generic
config space access.

If there is no existing mapping, create a temporary mapping with
information available in the saved MCFG table and use it to do raw
config space access.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 drivers/acpi/pci_gen_host.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/acpi/pci_gen_host.c b/drivers/acpi/pci_gen_host.c
index a43f2cee..b5472f0 100644
--- a/drivers/acpi/pci_gen_host.c
+++ b/drivers/acpi/pci_gen_host.c
@@ -245,3 +245,90 @@ void __init pci_mmcfg_late_init(void)
 			mcfgsav.cfg, mcfgsav.size);
 	}
 }
+
+/*
+ * First walk thru the root infos of all the known ACPI PCI
+ * controllers to see if there is an existing mapping and
+ * use it if we find one.
+ * Otherwise check the MCFG table and setup a temporary mapping
+ */
+static int raw_pci_op(int domain, unsigned int busn, unsigned int devfn,
+		      int reg, int len, u32 *val, bool write)
+{
+	void __iomem *m;
+	struct acpi_pci_generic_root_info *ri;
+	struct acpi_pci_root *root;
+	bool tmpmap = false;
+	int i, ret = PCIBIOS_DEVICE_NOT_FOUND;
+
+	mutex_lock(&gen_acpi_pci_lock);
+	list_for_each_entry(ri, &gen_acpi_pci_roots, node) {
+		root = ri->common.root;
+		if (domain == root->segment &&
+		    busn >= (u8)root->secondary.start &&
+		    busn <= (u8)root->secondary.end) {
+			m = pci_generic_map_bus(ri->cfg, busn, devfn, reg);
+			if (m)
+				goto found;
+			else
+				goto err_out;
+		}
+	}
+
+	/* not found in existing root buses, check in mcfg */
+	i = mcfg_lookup(domain, busn, busn);
+	if (i < 0)
+		goto err_out;
+
+	/* get a temporary mapping */
+	busn -= mcfgsav.cfg[i].bus_start;
+	m = ioremap(mcfgsav.cfg[i].addr + (busn << 20 | devfn << 12), 1 << 12);
+	if (!m)
+		goto err_out;
+	tmpmap = true;
+	m += reg;
+found:
+	if (write) {
+		switch (len) {
+		case 1:
+			writeb(*val, m);
+			break;
+		case 2:
+			writew(*val, m);
+			break;
+		case 4:
+			writel(*val, m);
+			break;
+		}
+	} else {
+		switch (len) {
+		case 1:
+			*val = readb(m);
+			break;
+		case 2:
+			*val = readw(m);
+			break;
+		case 4:
+			*val = readl(m);
+			break;
+		}
+	}
+	if (tmpmap)
+		iounmap(m);
+	ret = 0;
+err_out:
+	mutex_unlock(&gen_acpi_pci_lock);
+	return ret;
+}
+
+int raw_pci_read(unsigned int domain, unsigned int busn, unsigned int devfn,
+		 int reg, int len, u32 *val)
+{
+	return raw_pci_op(domain, busn, devfn, reg, len, val, false);
+}
+
+int raw_pci_write(unsigned int domain, unsigned int busn, unsigned int devfn,
+		  int reg, int len, u32 val)
+{
+	return raw_pci_op(domain, busn, devfn, reg, len, &val, true);
+}
-- 
1.9.1
