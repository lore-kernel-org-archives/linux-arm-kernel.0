From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 26 May 2015 20:49:22 +0800
Subject: [PATCH 09/11] pci, acpi, mcfg: Share ACPI PCI config space accessors.
In-Reply-To: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1432644564-24746-10-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

MCFG can be used perfectly for all architectures which support ACPI.
ACPI mandates MCFG to describe PCI config space ranges which means
we should use MMCONFIG accessors by default.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/acpi/mcfg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 745b83e..90c81fa 100644
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
