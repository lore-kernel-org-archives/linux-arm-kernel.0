From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:11 +0900
Subject: [PATCH 05/17] pinctrl: uniphier: set pinctrl_desc name in common
 probe function
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every SoC driver sets the same name for struct pinctrl_desc and
platform_driver.  The common probe function can set desc->name
instead of duplicating strings in each SoC driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 5 +----
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 5 +----
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 5 +----
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 5 +----
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 5 +----
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 5 +----
 7 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index ab89efb..4aa67c6 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -667,6 +667,7 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 	}
 
 	priv->socdata = socdata;
+	desc->name = dev->driver->name;
 	desc->pctlops = &uniphier_pctlops;
 	desc->pmxops = &uniphier_pmxops;
 	desc->confops = &uniphier_confops;
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index 5353ce4..1e7bacd 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -19,8 +19,6 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "uniphier-ld4-pinctrl"
-
 static const struct pinctrl_pin_desc uniphier_ld4_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "EA1", UNIPHIER_PIN_IECTRL_NONE,
 			     8, UNIPHIER_PIN_DRV_4_8,
@@ -858,7 +856,6 @@ static struct uniphier_pinctrl_socdata uniphier_ld4_pindata = {
 };
 
 static struct pinctrl_desc uniphier_ld4_pinctrl_desc = {
-	.name = DRIVER_NAME,
 	.pins = uniphier_ld4_pins,
 	.npins = ARRAY_SIZE(uniphier_ld4_pins),
 };
@@ -878,7 +875,7 @@ MODULE_DEVICE_TABLE(of, uniphier_ld4_pinctrl_match);
 static struct platform_driver uniphier_ld4_pinctrl_driver = {
 	.probe = uniphier_ld4_pinctrl_probe,
 	.driver = {
-		.name = DRIVER_NAME,
+		.name = "uniphier-ld4-pinctrl",
 		.of_match_table = uniphier_ld4_pinctrl_match,
 	},
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index c405960..458c8a4 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -19,8 +19,6 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "uniphier-ld6b-pinctrl"
-
 static const struct pinctrl_pin_desc uniphier_ld6b_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "ED0", UNIPHIER_PIN_IECTRL_NONE,
 			     0, UNIPHIER_PIN_DRV_4_8,
@@ -1246,7 +1244,6 @@ static struct uniphier_pinctrl_socdata uniphier_ld6b_pindata = {
 };
 
 static struct pinctrl_desc uniphier_ld6b_pinctrl_desc = {
-	.name = DRIVER_NAME,
 	.pins = uniphier_ld6b_pins,
 	.npins = ARRAY_SIZE(uniphier_ld6b_pins),
 };
@@ -1266,7 +1263,7 @@ MODULE_DEVICE_TABLE(of, uniphier_ld6b_pinctrl_match);
 static struct platform_driver uniphier_ld6b_pinctrl_driver = {
 	.probe = uniphier_ld6b_pinctrl_probe,
 	.driver = {
-		.name = DRIVER_NAME,
+		.name = "uniphier-ld6b-pinctrl",
 		.of_match_table = uniphier_ld6b_pinctrl_match,
 	},
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 54b08d5..7fcaeb5 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -19,8 +19,6 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "uniphier-pro4-pinctrl"
-
 static const struct pinctrl_pin_desc uniphier_pro4_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "CK24O", UNIPHIER_PIN_IECTRL_NONE,
 			     0, UNIPHIER_PIN_DRV_4_8,
@@ -1532,7 +1530,6 @@ static struct uniphier_pinctrl_socdata uniphier_pro4_pindata = {
 };
 
 static struct pinctrl_desc uniphier_pro4_pinctrl_desc = {
-	.name = DRIVER_NAME,
 	.pins = uniphier_pro4_pins,
 	.npins = ARRAY_SIZE(uniphier_pro4_pins),
 };
@@ -1552,7 +1549,7 @@ MODULE_DEVICE_TABLE(of, uniphier_pro4_pinctrl_match);
 static struct platform_driver uniphier_pro4_pinctrl_driver = {
 	.probe = uniphier_pro4_pinctrl_probe,
 	.driver = {
-		.name = DRIVER_NAME,
+		.name = "uniphier-pro4-pinctrl",
 		.of_match_table = uniphier_pro4_pinctrl_match,
 	},
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index 19b15db..47fa57e 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -19,8 +19,6 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "uniphier-pro5-pinctrl"
-
 static const struct pinctrl_pin_desc uniphier_pro5_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "AEXCKA1", 0,
 			     0, UNIPHIER_PIN_DRV_4_8,
@@ -1323,7 +1321,6 @@ static struct uniphier_pinctrl_socdata uniphier_pro5_pindata = {
 };
 
 static struct pinctrl_desc uniphier_pro5_pinctrl_desc = {
-	.name = DRIVER_NAME,
 	.pins = uniphier_pro5_pins,
 	.npins = ARRAY_SIZE(uniphier_pro5_pins),
 };
@@ -1343,7 +1340,7 @@ MODULE_DEVICE_TABLE(of, uniphier_pro5_pinctrl_match);
 static struct platform_driver uniphier_pro5_pinctrl_driver = {
 	.probe = uniphier_pro5_pinctrl_probe,
 	.driver = {
-		.name = DRIVER_NAME,
+		.name = "uniphier-pro5-pinctrl",
 		.of_match_table = uniphier_pro5_pinctrl_match,
 	},
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index 762de0e..246e2be 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -19,8 +19,6 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "uniphier-pxs2-pinctrl"
-
 static const struct pinctrl_pin_desc uniphier_pxs2_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "ED0", UNIPHIER_PIN_IECTRL_NONE,
 			     0, UNIPHIER_PIN_DRV_4_8,
@@ -1241,7 +1239,6 @@ static struct uniphier_pinctrl_socdata uniphier_pxs2_pindata = {
 };
 
 static struct pinctrl_desc uniphier_pxs2_pinctrl_desc = {
-	.name = DRIVER_NAME,
 	.pins = uniphier_pxs2_pins,
 	.npins = ARRAY_SIZE(uniphier_pxs2_pins),
 };
@@ -1261,7 +1258,7 @@ MODULE_DEVICE_TABLE(of, uniphier_pxs2_pinctrl_match);
 static struct platform_driver uniphier_pxs2_pinctrl_driver = {
 	.probe = uniphier_pxs2_pinctrl_probe,
 	.driver = {
-		.name = DRIVER_NAME,
+		.name = "uniphier-pxs2-pinctrl",
 		.of_match_table = uniphier_pxs2_pinctrl_match,
 	},
 };
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index 9fe8762..915259f 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -19,8 +19,6 @@
 
 #include "pinctrl-uniphier.h"
 
-#define DRIVER_NAME "uniphier-sld8-pinctrl"
-
 static const struct pinctrl_pin_desc uniphier_sld8_pins[] = {
 	UNIPHIER_PINCTRL_PIN(0, "PCA00", 0,
 			     15, UNIPHIER_PIN_DRV_4_8,
@@ -766,7 +764,6 @@ static struct uniphier_pinctrl_socdata uniphier_sld8_pindata = {
 };
 
 static struct pinctrl_desc uniphier_sld8_pinctrl_desc = {
-	.name = DRIVER_NAME,
 	.pins = uniphier_sld8_pins,
 	.npins = ARRAY_SIZE(uniphier_sld8_pins),
 };
@@ -786,7 +783,7 @@ MODULE_DEVICE_TABLE(of, uniphier_sld8_pinctrl_match);
 static struct platform_driver uniphier_sld8_pinctrl_driver = {
 	.probe = uniphier_sld8_pinctrl_probe,
 	.driver = {
-		.name = DRIVER_NAME,
+		.name = "uniphier-sld8-pinctrl",
 		.of_match_table = uniphier_sld8_pinctrl_match,
 	},
 };
-- 
1.9.1
