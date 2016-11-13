From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 13 Nov 2016 14:03:00 -0500
Subject: [PATCH 1/3] soc: sunxi: make sunxi_sram explicitly non-modular
In-Reply-To: <20161113190302.18099-1-paul.gortmaker@windriver.com>
References: <20161113190302.18099-1-paul.gortmaker@windriver.com>
Message-ID: <20161113190302.18099-2-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/soc/sunxi/Kconfig:config SUNXI_SRAM
drivers/soc/sunxi/Kconfig:      bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 99e354c8f53f..5e10408a2aef 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -12,7 +12,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -269,7 +269,6 @@ static const struct of_device_id sunxi_sram_dt_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sram-controller" },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
 
 static struct platform_driver sunxi_sram_driver = {
 	.driver = {
@@ -278,8 +277,4 @@ static struct platform_driver sunxi_sram_driver = {
 	},
 	.probe	= sunxi_sram_probe,
 };
-module_platform_driver(sunxi_sram_driver);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-MODULE_DESCRIPTION("Allwinner sunXi SRAM Controller Driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sunxi_sram_driver);
-- 
2.10.1
