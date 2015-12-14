From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 13 Dec 2015 20:07:14 -0500
Subject: [PATCH] drivers/misc: make arm-charlcd.c explicitly non-modular
Message-ID: <1450055234-418-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/misc/Kconfig:config ARM_CHARLCD
drivers/misc/Kconfig:   bool "ARM Ltd. Character LCD Driver"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, and this driver did not have a ".remove"
function coded for non-modular drivers either.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We don't replace module.h with init.h since the file already has that.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[ No 0/N lead in this time as drivers/misc only has one cleanup
  patch, but everyone on the Cc: knows what the 0/N boilerplate
  would say if it existed by now anyway... ]

 drivers/misc/arm-charlcd.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/arm-charlcd.c b/drivers/misc/arm-charlcd.c
index c65b5ea5d5ef..b3176ee92b90 100644
--- a/drivers/misc/arm-charlcd.c
+++ b/drivers/misc/arm-charlcd.c
@@ -8,7 +8,6 @@
  * Author: Linus Walleij <triad@df.lth.se>
  */
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
@@ -328,20 +327,6 @@ out_no_resource:
 	return ret;
 }
 
-static int __exit charlcd_remove(struct platform_device *pdev)
-{
-	struct charlcd *lcd = platform_get_drvdata(pdev);
-
-	if (lcd) {
-		free_irq(lcd->irq, lcd);
-		iounmap(lcd->virtbase);
-		release_mem_region(lcd->phybase, lcd->physize);
-		kfree(lcd);
-	}
-
-	return 0;
-}
-
 static int charlcd_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -376,13 +361,8 @@ static struct platform_driver charlcd_driver = {
 	.driver = {
 		.name = DRIVERNAME,
 		.pm = &charlcd_pm_ops,
+		.suppress_bind_attrs = true,
 		.of_match_table = of_match_ptr(charlcd_match),
 	},
-	.remove = __exit_p(charlcd_remove),
 };
-
-module_platform_driver_probe(charlcd_driver, charlcd_probe);
-
-MODULE_AUTHOR("Linus Walleij <triad@df.lth.se>");
-MODULE_DESCRIPTION("ARM Character LCD Driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver_probe(charlcd_driver, charlcd_probe);
-- 
2.6.1
