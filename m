From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Tue, 10 Mar 2015 12:35:19 +0100
Subject: [PATCH v3 8/9] pci, acpi, mcfg: Share ACPI PCI config space accessors.
In-Reply-To: <1425987320-15020-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1425987320-15020-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <1425987320-15020-9-git-send-email-tomasz.nowicki@linaro.org>
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
index 1e646fc..e285f62 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -13,6 +13,26 @@
 
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
 static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
 					struct acpi_mcfg_allocation *cfg)
 {
-- 
1.9.1
