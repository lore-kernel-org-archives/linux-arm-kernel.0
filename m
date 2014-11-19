From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Wed, 19 Nov 2014 17:04:51 +0100
Subject: [PATCH 6/6] pci, acpi: Share ACPI PCI config space accessors.
In-Reply-To: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
Message-ID: <1416413091-13452-7-git-send-email-tomasz.nowicki@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMCFG can be used perfectly for all architectures which support ACPI.
ACPI mandates MMCFG to describe PCI config space ranges which means
we should use MMCONFIG accessors by default.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/mmconfig.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/mmconfig.c b/drivers/acpi/mmconfig.c
index c0ad05f..c9c6e05 100644
--- a/drivers/acpi/mmconfig.c
+++ b/drivers/acpi/mmconfig.c
@@ -23,6 +23,26 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
 
 LIST_HEAD(pci_mmcfg_list);
 
+/*
+ * raw_pci_read/write - ACPI PCI config space accessors.
+ *
+ * ACPI spec defines MMCFG as the way we can access PCI config space,
+ * so let MMCFG be default (__weak).
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
 static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus,
 				  unsigned int devfn)
 {
-- 
1.9.1
