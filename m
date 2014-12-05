From: yadi.hu@windriver.com (yhu2)
Date: Fri, 5 Dec 2014 13:02:58 +0800
Subject: zynq-edac reports error
Message-ID: <54813C82.4060204@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We see the following error printout from kernel:

[2000-01-01 00:00:05.365891] ERROR: xmu03 kernel:[ 5.828996] zynq-edac 
f8006000.ps7-ddrc: ecc not enabled

We don't use ECC so the printout is valid. However, it should not be an 
ERROR priority on this. The edac driver should
look at the "xlnx,has-ecc" property and take appropriate action.

Any comments would be appreciated!

---
drivers/edac/zynq_edac.c | 11 +++++++++++
  1 file changed, 11 insertions(+)

diff --git a/drivers/edac/zynq_edac.c b/drivers/edac/zynq_edac.c
index 2b7635f..cec3203 100644
--- a/drivers/edac/zynq_edac.c
+++ b/drivers/edac/zynq_edac.c
@@ -19,6 +19,7 @@
   */

  #include <linux/edac.h>
+#include <linux/of.h>
  #include <linux/module.h>
  #include <linux/platform_device.h>

@@ -507,6 +508,16 @@ static int zynq_edac_mc_probe(struct 
platform_device *pdev)
      int rc;
      struct resource *res;
      void __iomem *baseaddr;
+   struct device_node *np = pdev->dev.of_node;
+   u32 *edac_enable;
+
+   if (!np || !of_device_is_available(np))
+        return -ENODEV;
+
+   edac_enable = (u32 *)of_get_property(np, "xlnx,has-ecc", NULL);
+   if (!edac_enable || !(*edac_enable))/* property has-ecc disenabled 
or no exist */
+        return -ENODEV;
+

      /* Get the data from the platform device */
      res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.8.5.2.233.g932f7e4
