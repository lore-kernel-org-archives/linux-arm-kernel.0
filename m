From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 27 Mar 2018 11:20:26 +0200
Subject: [PATCH v3 3/8] clk: davinci: add a reset lookup table for psc0
In-Reply-To: <20180327092031.11251-1-brgl@bgdev.pl>
References: <20180327092031.11251-1-brgl@bgdev.pl>
Message-ID: <20180327092031.11251-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In order to be able to use the reset framework in legacy boot mode as
well, add the reset lookup table to the psc driver for da850 variant.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-da850.c | 7 +++++++
 drivers/clk/davinci/psc.c       | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
index ccc7eb17bf3a..d196dcbed560 100644
--- a/drivers/clk/davinci/psc-da850.c
+++ b/drivers/clk/davinci/psc-da850.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/reset-controller.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/init.h>
@@ -66,8 +67,14 @@ LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
 				"fck",	"ecap.1",
 				"fck",	"ecap.2");
 
+static struct reset_control_lookup da850_psc0_reset_lookup_table[] = {
+	RESET_LOOKUP("da850-psc0", 15, "davinci-rproc.0", NULL),
+};
+
 static int da850_psc0_init(struct device *dev, void __iomem *base)
 {
+	reset_controller_add_lookup(da850_psc0_reset_lookup_table,
+				    ARRAY_SIZE(da850_psc0_reset_lookup_table));
 	return davinci_psc_register_clocks(dev, da850_psc0_info, 16, base);
 }
 
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 3b0e59dfbdd7..063df62381ea 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -425,6 +425,7 @@ __davinci_psc_register_clocks(struct device *dev,
 
 	psc->rcdev.ops = &davinci_psc_reset_ops;
 	psc->rcdev.owner = THIS_MODULE;
+	psc->rcdev.dev = dev;
 	psc->rcdev.of_node = dev->of_node;
 	psc->rcdev.of_reset_n_cells = 1;
 	psc->rcdev.of_xlate = davinci_psc_reset_of_xlate;
-- 
2.16.1
