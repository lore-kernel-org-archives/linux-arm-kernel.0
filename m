From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 25 Apr 2014 21:20:14 +0800
Subject: [PATCH v3 part1 08/11] ARM64 / ACPI: Introduce PCI functions for ACPI
 on ARM64
In-Reply-To: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1398432017-8506-9-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_ACPI depends CONFIG_PCI now, and ACPI provides ACPI based
PCI hotplug and PCI host bridge hotplug, introduce some PCI
functions to make ACPI core can be compiled, some of the functions
should be revisited when implemented on ARM64.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
---
 arch/arm64/include/asm/pci.h |   11 +++++++++++
 arch/arm64/kernel/pci.c      |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index d93576f..0aa3607 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -21,6 +21,17 @@ struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
 #define pcibios_assign_all_busses() \
 	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
 
+static inline void pcibios_penalize_isa_irq(int irq, int active)
+{
+	/* we don't do dynamic pci irq allocation */
+}
+
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	/* no legacy IRQ on arm64 */
+	return -ENODEV;
+}
+
 /*
  * PCI address space differs from physical memory address space
  */
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 9f29c9a..df90bad 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -17,6 +17,7 @@
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
 
 #include <asm/pci-bridge.h>
 
@@ -171,3 +172,36 @@ unsigned long pci_ioremap_io(const struct resource *res, phys_addr_t phys_addr)
 	/* return io_offset */
 	return start * PAGE_SIZE - res->start;
 }
+
+/*
+ * raw_pci_read - Platform-specific PCI config space access.
+ *
+ * Default empty implementation.  Replace with an architecture-specific setup
+ * routine, if necessary.
+ */
+int raw_pci_read(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 *val)
+{
+	return -EINVAL;
+}
+
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 val)
+{
+	return -EINVAL;
+}
+
+#ifdef CONFIG_ACPI
+/* Root bridge scanning */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	/* TODO: Should be revisited when implementing PCI on ACPI */
+	return NULL;
+}
+
+void __init pci_acpi_crs_quirks(void)
+{
+	/* Do nothing on ARM64 */
+	return;
+}
+#endif
-- 
1.7.9.5
