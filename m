From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon,  7 Apr 2014 11:30:20 +0200
Subject: [PATCH v2 rebased] PCI: rcar: use new OF interrupt mapping when
 possible
In-Reply-To: <20140404170103.GF9007@google.com>
References: <20140404170103.GF9007@google.com>
Message-ID: <1396863020-21880-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the recommended method of doing the IRQ
mapping. Still fall back to the old method in order
to not break the just submitted board files.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v2: pass in parent device to pci_common_init(), to
    make DT parsing work.
---
 drivers/pci/host/pci-rcar-gen2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index fd3e3ab56509..4fe349dcaf59 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -180,8 +181,13 @@ static int rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pci_sys_data *sys = dev->bus->sysdata;
 	struct rcar_pci_priv *priv = sys->private_data;
+	int irq;
+
+	irq = of_irq_parse_and_map_pci(dev, slot, pin);
+	if (!irq)
+		irq = priv->irq;
 
-	return priv->irq;
+	return irq;
 }
 
 #ifdef CONFIG_PCI_DEBUG
-- 
1.9.1
