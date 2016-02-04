From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu,  4 Feb 2016 18:28:45 +0100
Subject: [PATCH V4 07/23] pci, acpi,
 mcfg: Provide default RAW ACPI PCI config space accessors.
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Message-ID: <1454606941-9523-8-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets keep RAW ACPI PCI config space accessors empty by default,
since we are note sure if they are necessary accross all archs.
Once we sort this out, we can provide generic version or let
architectures to overwrite, like now x86.

Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Duc Dang <dhdang@apm.com>
Tested-by: Dongdong Liu <liudongdong3@huawei.com>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/mcfg.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 745b83e..3e1e7be 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -9,9 +9,30 @@
 
 #include <linux/acpi.h>
 #include <linux/ecam.h>
+#include <linux/pci.h>
 
 #define	PREFIX	"MCFG: "
 
+/*
+ * raw_pci_read/write - raw ACPI PCI config space accessors.
+ *
+ * By defauly (__weak) these accessors are empty and should be overwritten
+ * by architectures which support operations on ACPI PCI_Config regions,
+ * see osl.c file.
+ */
+
+int __weak raw_pci_read(unsigned int domain, unsigned int bus,
+			unsigned int devfn, int reg, int len, u32 *val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
+int __weak raw_pci_write(unsigned int domain, unsigned int bus,
+			 unsigned int devfn, int reg, int len, u32 val)
+{
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
 int __init acpi_parse_mcfg(struct acpi_table_header *header)
 {
 	struct acpi_table_mcfg *mcfg;
-- 
1.9.1
