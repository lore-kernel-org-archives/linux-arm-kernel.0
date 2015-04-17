From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Fri, 17 Apr 2015 09:14:57 +0200
Subject: [PATCH v5 8/9] pci, acpi, mcfg: Share ACPI PCI config space accessors.
In-Reply-To: <1429254898-32743-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1429254898-32743-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <1429254898-32743-9-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MCFG can be used perfectly for all architectures which support ACPI.
ACPI mandates MCFG to describe PCI config space ranges which means
we should use MMCONFIG accessors by default.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/mcfg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 787defe..5ff2602 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -12,6 +12,26 @@
 
 #define	PREFIX	"MCFG: "
 
+/*
+ * raw_pci_read/write - ACPI PCI config space accessors.
+ *
+ * ACPI spec defines MCFG table as the way we can describe access to PCI config
+ * space, so let MCFG be default (__weak).
+ *
+ * If platform needs more fancy stuff, should provides its own implementation.
+ */
+int __weak raw_pci_read(unsigned int domain, unsigned int bus,
+			unsigned int devfn, int reg, int len, u32 *val)
+{
+	return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
+}
+
+int __weak raw_pci_write(unsigned int domain, unsigned int bus,
+			 unsigned int devfn, int reg, int len, u32 val)
+{
+	return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
+}
+
 int __init acpi_parse_mcfg(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
-- 
1.9.1
