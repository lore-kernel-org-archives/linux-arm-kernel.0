From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 3 Jul 2016 13:30:38 -0400
Subject: [PATCH 2/4] bus: imx-weim: make it explicitly non-modular
In-Reply-To: <20160703173040.23612-1-paul.gortmaker@windriver.com>
References: <20160703173040.23612-1-paul.gortmaker@windriver.com>
Message-ID: <20160703173040.23612-3-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/bus/Kconfig:config IMX_WEIM
drivers/bus/Kconfig:    bool "Freescale EIM DRIVER

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Alison Chaiken <alison_chaiken@mentor.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/bus/imx-weim.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 4bd361d64270..cdc75b1b264d 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -7,7 +7,7 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
@@ -57,7 +57,6 @@ static const struct of_device_id weim_id_table[] = {
 	{ .compatible = "fsl,imx51-weim", .data = &imx51_weim_devtype, },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, weim_id_table);
 
 static int __init imx_weim_gpr_setup(struct platform_device *pdev)
 {
@@ -209,8 +208,4 @@ static struct platform_driver weim_driver = {
 		.of_match_table	= weim_id_table,
 	},
 };
-module_platform_driver_probe(weim_driver, weim_probe);
-
-MODULE_AUTHOR("Freescale Semiconductor Inc.");
-MODULE_DESCRIPTION("i.MX EIM Controller Driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver_probe(weim_driver, weim_probe);
-- 
2.8.4
