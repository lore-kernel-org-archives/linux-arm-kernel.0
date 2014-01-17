From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Jan 2014 20:25:00 +0800
Subject: [PATCH 06/20] ARM64 / ACPI: Introduce some PCI functions when PCI is
 enabled
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1389961514-13562-7-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce some PCI functions to make ACPI can be compiled when
CONFIG_PCI is enabled, these functions should be revisited when
implemented on ARM64.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Makefile          |    1 +
 arch/arm64/pci/Makefile      |    1 +
 arch/arm64/pci/pci.c         |   33 +++++++++++++++++++++++++++++++++
 drivers/acpi/plat/arm-core.c |   19 +++++++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 arch/arm64/pci/Makefile
 create mode 100644 arch/arm64/pci/pci.c

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2fceb71..fcaa58e 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -45,6 +45,7 @@ export	TEXT_OFFSET GZFLAGS
 core-y		+= arch/arm64/kernel/ arch/arm64/mm/
 core-$(CONFIG_KVM) += arch/arm64/kvm/
 core-$(CONFIG_XEN) += arch/arm64/xen/
+drivers-$(CONFIG_PCI)	+= arch/arm64/pci/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 libs-y		+= $(LIBGCC)
 
diff --git a/arch/arm64/pci/Makefile b/arch/arm64/pci/Makefile
new file mode 100644
index 0000000..b8d5dbd
--- /dev/null
+++ b/arch/arm64/pci/Makefile
@@ -0,0 +1 @@
+obj-y                 += pci.o
diff --git a/arch/arm64/pci/pci.c b/arch/arm64/pci/pci.c
new file mode 100644
index 0000000..4e46790
--- /dev/null
+++ b/arch/arm64/pci/pci.c
@@ -0,0 +1,33 @@
+#include <linux/acpi.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+/**
+ * raw_pci_read - Platform-specific PCI config space access.
+ *
+ * Default empty implementation.  Replace with an architecture-specific setup
+ * routine, if necessary.
+ */
+int __weak raw_pci_read(unsigned int domain, unsigned int bus,
+			unsigned int devfn, int reg, int len, u32 *val)
+{
+	return -EINVAL;
+}
+
+int __weak raw_pci_write(unsigned int domain, unsigned int bus,
+			unsigned int devfn, int reg, int len, u32 val)
+{
+	return -EINVAL;
+}
+
+/* Root bridge scanning */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	return NULL;
+}
+
+void __init pci_acpi_crs_quirks(void)
+{
+	return;
+}
diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
index 3c8521d..1835b21 100644
--- a/drivers/acpi/plat/arm-core.c
+++ b/drivers/acpi/plat/arm-core.c
@@ -100,6 +100,25 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 
+int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
+{
+	return -1;
+}
+
+int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_register_ioapic);
+
+int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
+{
+	/* TBD */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(acpi_unregister_ioapic);
+
 /*
  * success: return IRQ number (>0)
  * failure: return =< 0
-- 
1.7.9.5
