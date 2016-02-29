From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 29 Feb 2016 15:48:43 -0500
Subject: [PATCH 7/8] drivers/pinctrl: make sunxi/pinctrl-sun9i-a80-r.c
 explicitly non-modular
In-Reply-To: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
References: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1456778924-20730-8-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig currently controlling compilation of this code is:

drivers/pinctrl/sunxi/Kconfig:config PINCTRL_SUN9I_A80_R
drivers/pinctrl/sunxi/Kconfig:  def_bool MACH_SUN9I

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-gpio at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
index 42547ffa20a8..92a873f73697 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c
@@ -9,7 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -164,7 +164,6 @@ static const struct of_device_id sun9i_a80_r_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun9i-a80-r-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun9i_a80_r_pinctrl_match);
 
 static struct platform_driver sun9i_a80_r_pinctrl_driver = {
 	.probe	= sun9i_a80_r_pinctrl_probe,
@@ -174,8 +173,4 @@ static struct platform_driver sun9i_a80_r_pinctrl_driver = {
 		.of_match_table	= sun9i_a80_r_pinctrl_match,
 	},
 };
-module_platform_driver(sun9i_a80_r_pinctrl_driver);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("Allwinner A80 R_PIO pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun9i_a80_r_pinctrl_driver);
-- 
2.6.1
