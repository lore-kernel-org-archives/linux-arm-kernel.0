From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sat, 29 Oct 2016 20:00:30 -0400
Subject: [PATCH] pinctrl: sunxi: make bool drivers explicitly non-modular
Message-ID: <20161030000030.9394-1-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of the Kconfigs for any of these drivers are tristate,
meaning that they currently are not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the drivers there is no doubt they are builtin-only.  All
drivers get essentially the same change, so they are handled in batch.

Changes are (1) use builtin_platform_driver, (2) use init.h header
(3) delete module_exit related code, (4) delete MODULE_DEVICE_TABLE,
and (5) delete MODULE_LICENCE/MODULE_AUTHOR and associated tags.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We do delete the MODULE_LICENSE etc. tags since all that information
is already contained at the top of each file in the comments.

Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
Cc: Fabian Frederick <fabf@skynet.be>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Vishnu Patekar <vishnupatekar0510@gmail.com>
Cc: Mylene Josserand <mylene.josserand@free-electrons.com>
Cc: linux-gpio at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

diff --git a/drivers/pinctrl/sunxi/pinctrl-gr8.c b/drivers/pinctrl/sunxi/pinctrl-gr8.c
index 2904d2b7378b..2f232c3a0579 100644
--- a/drivers/pinctrl/sunxi/pinctrl-gr8.c
+++ b/drivers/pinctrl/sunxi/pinctrl-gr8.c
@@ -12,7 +12,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -525,7 +525,6 @@ static const struct of_device_id sun5i_gr8_pinctrl_match[] = {
 	{ .compatible = "nextthing,gr8-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun5i_gr8_pinctrl_match);
 
 static struct platform_driver sun5i_gr8_pinctrl_driver = {
 	.probe	= sun5i_gr8_pinctrl_probe,
@@ -534,8 +533,4 @@ static struct platform_driver sun5i_gr8_pinctrl_driver = {
 		.of_match_table	= sun5i_gr8_pinctrl_match,
 	},
 };
-module_platform_driver(sun5i_gr8_pinctrl_driver);
-
-MODULE_AUTHOR("Mylene Josserand <mylene.josserand@free-electrons.com");
-MODULE_DESCRIPTION("NextThing GR8 pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun5i_gr8_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
index 862a096c5dba..fb30b86a97ee 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
@@ -10,7 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -1035,7 +1035,6 @@ static const struct of_device_id sun4i_a10_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun4i_a10_pinctrl_match);
 
 static struct platform_driver sun4i_a10_pinctrl_driver = {
 	.probe	= sun4i_a10_pinctrl_probe,
@@ -1044,8 +1043,4 @@ static struct platform_driver sun4i_a10_pinctrl_driver = {
 		.of_match_table	= sun4i_a10_pinctrl_match,
 	},
 };
-module_platform_driver(sun4i_a10_pinctrl_driver);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("Allwinner A10 pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun4i_a10_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c b/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
index f9a3f8f446f7..a5b57fdff9e1 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
@@ -10,7 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -674,7 +674,6 @@ static const struct of_device_id sun5i_a10s_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun5i-a10s-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun5i_a10s_pinctrl_match);
 
 static struct platform_driver sun5i_a10s_pinctrl_driver = {
 	.probe	= sun5i_a10s_pinctrl_probe,
@@ -683,8 +682,4 @@ static struct platform_driver sun5i_a10s_pinctrl_driver = {
 		.of_match_table	= sun5i_a10s_pinctrl_match,
 	},
 };
-module_platform_driver(sun5i_a10s_pinctrl_driver);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("Allwinner A10s pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun5i_a10s_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c b/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
index 2bb07b38834f..8575f3f6d3dd 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
@@ -10,7 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -392,7 +392,6 @@ static const struct of_device_id sun5i_a13_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun5i-a13-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun5i_a13_pinctrl_match);
 
 static struct platform_driver sun5i_a13_pinctrl_driver = {
 	.probe	= sun5i_a13_pinctrl_probe,
@@ -401,8 +400,4 @@ static struct platform_driver sun5i_a13_pinctrl_driver = {
 		.of_match_table	= sun5i_a13_pinctrl_match,
 	},
 };
-module_platform_driver(sun5i_a13_pinctrl_driver);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("Allwinner A13 pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun5i_a13_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
index d4bc4f0e8be0..a22bd88a1f03 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
@@ -12,7 +12,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -136,7 +136,6 @@ static const struct of_device_id sun6i_a31_r_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-r-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun6i_a31_r_pinctrl_match);
 
 static struct platform_driver sun6i_a31_r_pinctrl_driver = {
 	.probe	= sun6i_a31_r_pinctrl_probe,
@@ -145,9 +144,4 @@ static struct platform_driver sun6i_a31_r_pinctrl_driver = {
 		.of_match_table	= sun6i_a31_r_pinctrl_match,
 	},
 };
-module_platform_driver(sun6i_a31_r_pinctrl_driver);
-
-MODULE_AUTHOR("Boris Brezillon <boris.brezillon at free-electrons.com");
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("Allwinner A31 R_PIO pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun6i_a31_r_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
index 022863ab0c58..508ec54897ae 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
@@ -10,7 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -926,7 +926,6 @@ static const struct of_device_id sun6i_a31_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun6i_a31_pinctrl_match);
 
 static struct platform_driver sun6i_a31_pinctrl_driver = {
 	.probe	= sun6i_a31_pinctrl_probe,
@@ -935,8 +934,4 @@ static struct platform_driver sun6i_a31_pinctrl_driver = {
 		.of_match_table	= sun6i_a31_pinctrl_match,
 	},
 };
-module_platform_driver(sun6i_a31_pinctrl_driver);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("Allwinner A31 pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun6i_a31_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c
index e570d5c93ecc..231a746a5356 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun6i-a31s.c
@@ -11,7 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -798,7 +798,6 @@ static const struct of_device_id sun6i_a31s_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun6i-a31s-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun6i_a31s_pinctrl_match);
 
 static struct platform_driver sun6i_a31s_pinctrl_driver = {
 	.probe	= sun6i_a31s_pinctrl_probe,
@@ -807,8 +806,4 @@ static struct platform_driver sun6i_a31s_pinctrl_driver = {
 		.of_match_table	= sun6i_a31s_pinctrl_match,
 	},
 };
-module_platform_driver(sun6i_a31s_pinctrl_driver);
-
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-MODULE_DESCRIPTION("Allwinner A31s pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun6i_a31s_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
index 435ad30f45db..b6f4c68ffb39 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
@@ -10,7 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -1045,7 +1045,6 @@ static const struct of_device_id sun7i_a20_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun7i-a20-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun7i_a20_pinctrl_match);
 
 static struct platform_driver sun7i_a20_pinctrl_driver = {
 	.probe	= sun7i_a20_pinctrl_probe,
@@ -1054,8 +1053,4 @@ static struct platform_driver sun7i_a20_pinctrl_driver = {
 		.of_match_table	= sun7i_a20_pinctrl_match,
 	},
 };
-module_platform_driver(sun7i_a20_pinctrl_driver);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("Allwinner A20 pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun7i_a20_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
index 056287635873..2292e05a397b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
@@ -15,7 +15,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -123,7 +123,6 @@ static const struct of_device_id sun8i_a23_r_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun8i-a23-r-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun8i_a23_r_pinctrl_match);
 
 static struct platform_driver sun8i_a23_r_pinctrl_driver = {
 	.probe	= sun8i_a23_r_pinctrl_probe,
@@ -132,10 +131,4 @@ static struct platform_driver sun8i_a23_r_pinctrl_driver = {
 		.of_match_table	= sun8i_a23_r_pinctrl_match,
 	},
 };
-module_platform_driver(sun8i_a23_r_pinctrl_driver);
-
-MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
-MODULE_AUTHOR("Boris Brezillon <boris.brezillon at free-electrons.com");
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("Allwinner A23 R_PIO pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun8i_a23_r_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
index 55083d278bb1..29d307b3c3ec 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23.c
@@ -14,7 +14,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -575,7 +575,6 @@ static const struct of_device_id sun8i_a23_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun8i-a23-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun8i_a23_pinctrl_match);
 
 static struct platform_driver sun8i_a23_pinctrl_driver = {
 	.probe	= sun8i_a23_pinctrl_probe,
@@ -584,9 +583,4 @@ static struct platform_driver sun8i_a23_pinctrl_driver = {
 		.of_match_table	= sun8i_a23_pinctrl_match,
 	},
 };
-module_platform_driver(sun8i_a23_pinctrl_driver);
-
-MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
-MODULE_DESCRIPTION("Allwinner A23 pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun8i_a23_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
index 8b381d69df86..d4fdd643920d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a33.c
@@ -12,7 +12,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -498,7 +498,6 @@ static const struct of_device_id sun8i_a33_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun8i-a33-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun8i_a33_pinctrl_match);
 
 static struct platform_driver sun8i_a33_pinctrl_driver = {
 	.probe	= sun8i_a33_pinctrl_probe,
@@ -507,8 +506,4 @@ static struct platform_driver sun8i_a33_pinctrl_driver = {
 		.of_match_table	= sun8i_a33_pinctrl_match,
 	},
 };
-module_platform_driver(sun8i_a33_pinctrl_driver);
-
-MODULE_AUTHOR("Vishnu Patekar <vishnupatekar0510@gmail.com>");
-MODULE_DESCRIPTION("Allwinner a33 pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun8i_a33_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
index 90b973e15982..9aec1d2232dd 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c
@@ -12,7 +12,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -587,7 +587,6 @@ static const struct of_device_id sun8i_a83t_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun8i_a83t_pinctrl_match);
 
 static struct platform_driver sun8i_a83t_pinctrl_driver = {
 	.probe	= sun8i_a83t_pinctrl_probe,
@@ -596,8 +595,4 @@ static struct platform_driver sun8i_a83t_pinctrl_driver = {
 		.of_match_table	= sun8i_a83t_pinctrl_match,
 	},
 };
-module_platform_driver(sun8i_a83t_pinctrl_driver);
-
-MODULE_AUTHOR("Vishnu Patekar <vishnupatekar0510@gmail.com>");
-MODULE_DESCRIPTION("Allwinner a83t pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun8i_a83t_pinctrl_driver);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
index 1b580ba76453..bc14e954d7a2 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c
@@ -10,7 +10,7 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -733,7 +733,6 @@ static const struct of_device_id sun9i_a80_pinctrl_match[] = {
 	{ .compatible = "allwinner,sun9i-a80-pinctrl", },
 	{}
 };
-MODULE_DEVICE_TABLE(of, sun9i_a80_pinctrl_match);
 
 static struct platform_driver sun9i_a80_pinctrl_driver = {
 	.probe	= sun9i_a80_pinctrl_probe,
@@ -742,8 +741,4 @@ static struct platform_driver sun9i_a80_pinctrl_driver = {
 		.of_match_table	= sun9i_a80_pinctrl_match,
 	},
 };
-module_platform_driver(sun9i_a80_pinctrl_driver);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-MODULE_DESCRIPTION("Allwinner A80 pinctrl driver");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(sun9i_a80_pinctrl_driver);
-- 
2.7.4
