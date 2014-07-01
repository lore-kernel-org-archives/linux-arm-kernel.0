From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue,  1 Jul 2014 19:43:32 +0100
Subject: [PATCH v8 7/9] pci: of: Parse and map the IRQ when adding the PCI
 device.
In-Reply-To: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
References: <1404240214-9804-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1404240214-9804-8-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enhance the default implementation of pcibios_add_device() to
parse and map the IRQ of the device if a DT binding is available.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 63a54a3..8e65dc3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/log2.h>
+#include <linux/of_pci.h>
 #include <linux/pci-aspm.h>
 #include <linux/pm_wakeup.h>
 #include <linux/interrupt.h>
@@ -1453,6 +1454,9 @@ EXPORT_SYMBOL(pcim_pin_device);
  */
 int __weak pcibios_add_device(struct pci_dev *dev)
 {
+#ifdef CONFIG_OF
+	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+#endif
 	return 0;
 }
 
-- 
2.0.0
