From: gsi@denx.de (Gerhard Sittig)
Date: Thu, 18 Jul 2013 22:20:56 +0200
Subject: [PATCH v2 22/24] powerpc/fsl-pci: OF clock lookup,
 prepare before enable
In-Reply-To: <1374166855-7280-1-git-send-email-gsi@denx.de>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
Message-ID: <1374178858-8683-8-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

device tree based clock lookup, must prepare clocks before enabling
them, error check in the clock setup

this change implements non-fatal clock lookup for compatibility with
platforms that don't provide OF clock specs, but failure to enable a
specified clock is considered fatal

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/sysdev/fsl_pci.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 46ac1dd..cb2ed92 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -17,6 +17,8 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  */
+
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -741,6 +743,7 @@ err0:
 
 int __init mpc83xx_add_bridge(struct device_node *dev)
 {
+	struct clk *clk;
 	int ret;
 	int len;
 	struct pci_controller *hose;
@@ -758,6 +761,18 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	}
 	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
+	/* non-fatal OF clock lookup, but fatal when a clock
+	 * was specified yet could not get enabled */
+	clk = of_clk_get_by_name(dev, "per");
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		clk_put(clk);
+		if (ret) {
+			pr_err("Could not enable peripheral clock\n");
+			return ret;
+		}
+	}
+
 	/* Fetch host bridge registers address */
 	if (of_address_to_resource(dev, 0, &rsrc_reg)) {
 		printk(KERN_WARNING "Can't get pci register base!\n");
-- 
1.7.10.4
