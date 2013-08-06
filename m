From: gsi@denx.de (Gerhard Sittig)
Date: Tue,  6 Aug 2013 22:43:49 +0200
Subject: [PATCH v4 09/31] powerpc/fsl-pci: improve clock API use
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <1375821851-31609-10-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

make the Freescale PCI driver get, prepare and enable the PCI clock
during probe(); the clock gets put upon device close by the devm approach

clock lookup is non-fatal as not all platforms may provide clock specs
in their device tree, but failure to enable specified clocks are fatal

the driver appears to not have a remove() routine, so no reference to
the clock is kept during use, and the clock isn't released (the devm
approach will put the clock, but it won't get disabled or unprepared)

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/sysdev/fsl_pci.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 46ac1dd..549ff08 100644
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
@@ -926,12 +928,32 @@ void fsl_pci_assign_primary(void)
 
 static int fsl_pci_probe(struct platform_device *pdev)
 {
+	struct clk *clk;
 	int ret;
 	struct device_node *node;
 #ifdef CONFIG_SWIOTLB
 	struct pci_controller *hose;
 #endif
 
+	/*
+	 * clock lookup is non-fatal since the driver is shared among
+	 * platforms and not all of them provide clocks specs in their
+	 * device tree, but failure to enable a specified clock is
+	 * considered fatal
+	 */
+	clk = devm_clk_get(&pdev->dev, "per");
+	if (!IS_ERR(clk)) {
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			dev_err(dev, "Could not enable peripheral clock\n");
+			return ret;
+		}
+		/*
+		 * TODO where to store the 'clk' reference?  there appears
+		 * to be no remove() routine which undoes what probe() does
+		 */
+	}
+
 	node = pdev->dev.of_node;
 	ret = fsl_add_bridge(pdev, fsl_pci_primary == node);
 
-- 
1.7.10.4
