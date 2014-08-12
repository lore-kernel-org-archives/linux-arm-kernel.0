From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 12 Aug 2014 17:25:15 +0100
Subject: [PATCH v9 02/12] PCI: OF: Parse and map the IRQ when adding the PCI
 device.
In-Reply-To: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1407860725-25202-3-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enhance the default implementation of pcibios_add_device() to
parse and map the IRQ of the device if a DT binding is available.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1c8592b..29d1775 100644
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
@@ -1453,6 +1454,8 @@ EXPORT_SYMBOL(pcim_pin_device);
  */
 int __weak pcibios_add_device(struct pci_dev *dev)
 {
+	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
+
 	return 0;
 }
 
-- 
2.0.4
