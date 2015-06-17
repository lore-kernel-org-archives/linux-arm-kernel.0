From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 10:38:54 +0200
Subject: [PATCH v2 5/7] staging: board: Add support for devices with complex
 dependencies
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1434530336-15073-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for easy registering of one ore more platform devices that
may:
  - need clocks that are described in DT,
  - be part of a PM Domain.

All these dependencies are optional.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop support for pinctrl, use standard pinctrl in DT instead,
  - Drop support for configured GPIOs, use "gpio-hog" in DT instead,
  - Use clk_add_alias() instead of open coding,
  - Update for changed function names,
  - Drop RFC status.
---
 drivers/staging/board/board.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 drivers/staging/board/board.h | 20 ++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
index 8712f566b31196e0..29d456e29f38feac 100644
--- a/drivers/staging/board/board.c
+++ b/drivers/staging/board/board.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt)	"board_staging: "  fmt
 
+#include <linux/clkdev.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/device.h>
@@ -16,6 +17,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 
 #include "board.h"
 
@@ -118,3 +121,56 @@ void __init board_staging_gic_fixup_resources(struct resource *res,
 	for (i = 0; i < nres; i++)
 		gic_fixup_resource(&res[i]);
 }
+
+int __init board_staging_register_clock(const struct board_staging_clk *bsc)
+{
+	int error;
+
+	pr_debug("Aliasing clock %s for con_id %s dev_id %s\n", bsc->clk,
+		 bsc->con_id, bsc->dev_id);
+	error = clk_add_alias(bsc->con_id, bsc->dev_id, bsc->clk, NULL);
+	if (error)
+		pr_err("Failed to alias clock %s (%d)\n", bsc->clk, error);
+
+	return error;
+}
+
+int __init board_staging_register_device(const struct board_staging_dev *dev)
+{
+	struct platform_device *pdev = dev->pdev;
+	unsigned int i;
+	int error;
+
+	pr_debug("Trying to register device %s\n", pdev->name);
+	if (board_staging_dt_node_available(pdev->resource,
+					    pdev->num_resources)) {
+		pr_warn("Skipping %s, already in DT\n", pdev->name);
+		return -EEXIST;
+	}
+
+	board_staging_gic_fixup_resources(pdev->resource, pdev->num_resources);
+
+	for (i = 0; i < dev->nclocks; i++)
+		board_staging_register_clock(&dev->clocks[i]);
+
+	error = platform_device_register(pdev);
+	if (error) {
+		pr_err("Failed to register device %s (%d)\n", pdev->name,
+		       error);
+		return error;
+	}
+
+	if (dev->domain)
+		__pm_genpd_name_add_device(dev->domain, &pdev->dev, NULL);
+
+	return error;
+}
+
+void __init board_staging_register_devices(const struct board_staging_dev *devs,
+					   unsigned int ndevs)
+{
+	unsigned int i;
+
+	for (i = 0; i < ndevs; i++)
+		board_staging_register_device(&devs[i]);
+}
diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
index 3af6dbe22f91ebdc..42ed125132201327 100644
--- a/drivers/staging/board/board.h
+++ b/drivers/staging/board/board.h
@@ -4,12 +4,32 @@
 #include <linux/init.h>
 #include <linux/of.h>
 
+struct board_staging_clk {
+	const char *clk;
+	const char *con_id;
+	const char *dev_id;
+};
+
+struct board_staging_dev {
+	/* Platform Device */
+	struct platform_device *pdev;
+	/* Clocks (optional) */
+	const struct board_staging_clk *clocks;
+	unsigned int nclocks;
+	/* Generic PM Domain (optional) */
+	const char *domain;
+};
+
 struct resource;
 
 bool board_staging_dt_node_available(const struct resource *resource,
 				     unsigned int num_resources);
 int board_staging_gic_setup_xlate(const char *gic_match, unsigned int base);
 void board_staging_gic_fixup_resources(struct resource *res, unsigned int nres);
+int board_staging_register_clock(const struct board_staging_clk *bsc);
+int board_staging_register_device(const struct board_staging_dev *dev);
+void board_staging_register_devices(const struct board_staging_dev *devs,
+				    unsigned int ndevs);
 
 #define board_staging(str, fn)			\
 static int __init runtime_board_check(void)	\
-- 
1.9.1
