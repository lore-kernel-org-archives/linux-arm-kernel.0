From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 4 Jan 2016 14:22:59 -0500
Subject: [PATCH] drivers/bus: make uniphier-system-bus.c explicitly non-modular
Message-ID: <1451935379-14107-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/bus/Kconfig:config UNIPHIER_SYSTEM_BUS
drivers/bus/Kconfig:    bool "UniPhier System Bus driver"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/bus/uniphier-system-bus.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/uniphier-system-bus.c b/drivers/bus/uniphier-system-bus.c
index 834a2aeaf27a..6b14b8d0a1a2 100644
--- a/drivers/bus/uniphier-system-bus.c
+++ b/drivers/bus/uniphier-system-bus.c
@@ -14,7 +14,7 @@
 
 #include <linux/io.h>
 #include <linux/log2.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -265,7 +265,6 @@ static const struct of_device_id uniphier_system_bus_match[] = {
 	{ .compatible = "socionext,uniphier-system-bus" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, uniphier_system_bus_match);
 
 static struct platform_driver uniphier_system_bus_driver = {
 	.probe		= uniphier_system_bus_probe,
@@ -274,8 +273,4 @@ static struct platform_driver uniphier_system_bus_driver = {
 		.of_match_table = uniphier_system_bus_match,
 	},
 };
-module_platform_driver(uniphier_system_bus_driver);
-
-MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
-MODULE_DESCRIPTION("UniPhier System Bus driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(uniphier_system_bus_driver);
-- 
2.6.1
