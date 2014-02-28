From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 28 Feb 2014 18:28:39 +0100
Subject: [PATCH 3/7] PCI: rcar: use new OF interrupt mapping when possible
In-Reply-To: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1393608523-17509-4-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the recommended method of doing the IRQ
mapping. Still fall back to the old method in order
to not break the just submitted board files.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/host/pci-rcar-gen2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index ceec147baec3..3aa0c6311a42 100644
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
@@ -160,8 +161,13 @@ static int __init rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
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
 
 /* PCI host controller setup */
-- 
1.8.5.3
