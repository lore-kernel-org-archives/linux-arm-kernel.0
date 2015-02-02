From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  2 Feb 2015 20:45:34 +0800
Subject: [PATCH v8 06/21] ARM64 / ACPI: Introduce PCI stub functions for ACPI
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1422881149-8177-7-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_ACPI depends CONFIG_PCI on x86 and ia64, in ARM64 server
world we will have PCIe in most cases, but some of them may not,
make CONFIG_ACPI depend CONFIG_PCI on ARM64 will satisfy both.

With that case, we need some arch dependent PCI functions to
access the config space before the PCI root bridge is created, and
pci_acpi_scan_root() to create the PCI root bus. So introduce
some stub function here to make ACPI core compile and revisit
them later when implemented on ARM64.

CC: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/pci.h |  6 ++++++
 arch/arm64/kernel/pci.c      | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 872ba93..fded096 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -24,6 +24,12 @@
  */
 #define PCI_DMA_BUS_IS_PHYS	(0)
 
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	/* no legacy IRQ on arm64 */
+	return -ENODEV;
+}
+
 extern int isa_dma_bridge_buggy;
 
 #ifdef CONFIG_PCI
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index ce5836c..c17e7ea 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -68,3 +69,27 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 	bus->domain_nr = domain;
 }
 #endif
+
+/*
+ * raw_pci_read/write - Platform-specific PCI config space access.
+ */
+int raw_pci_read(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 *val)
+{
+	return -EINVAL;
+}
+
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		unsigned int devfn, int reg, int len, u32 val)
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
+#endif
-- 
1.9.1
