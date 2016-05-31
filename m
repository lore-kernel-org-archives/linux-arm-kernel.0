From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 31 May 2016 17:05:10 +0900
Subject: [PATCH 04/17] pinctrl: uniphier: set pinctrl_desc owner in common
 probe function
In-Reply-To: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464681923-7469-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1464681923-7469-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The owner of the struct pinctrl_desc matches that of platform_driver.
Set it in the common probe function.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 1 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c  | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c | 1 -
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c | 1 -
 7 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 5d08de0..ab89efb 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -670,6 +670,7 @@ int uniphier_pinctrl_probe(struct platform_device *pdev,
 	desc->pctlops = &uniphier_pctlops;
 	desc->pmxops = &uniphier_pmxops;
 	desc->confops = &uniphier_confops;
+	desc->owner = dev->driver->owner;
 
 	priv->pctldev = devm_pinctrl_register(dev, desc, priv);
 	if (IS_ERR(priv->pctldev)) {
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
index ad193c7..5353ce4 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c
@@ -861,7 +861,6 @@ static struct pinctrl_desc uniphier_ld4_pinctrl_desc = {
 	.name = DRIVER_NAME,
 	.pins = uniphier_ld4_pins,
 	.npins = ARRAY_SIZE(uniphier_ld4_pins),
-	.owner = THIS_MODULE,
 };
 
 static int uniphier_ld4_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
index 0782a6d..c405960 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c
@@ -1249,7 +1249,6 @@ static struct pinctrl_desc uniphier_ld6b_pinctrl_desc = {
 	.name = DRIVER_NAME,
 	.pins = uniphier_ld6b_pins,
 	.npins = ARRAY_SIZE(uniphier_ld6b_pins),
-	.owner = THIS_MODULE,
 };
 
 static int uniphier_ld6b_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
index 2d45307..54b08d5 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c
@@ -1535,7 +1535,6 @@ static struct pinctrl_desc uniphier_pro4_pinctrl_desc = {
 	.name = DRIVER_NAME,
 	.pins = uniphier_pro4_pins,
 	.npins = ARRAY_SIZE(uniphier_pro4_pins),
-	.owner = THIS_MODULE,
 };
 
 static int uniphier_pro4_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
index 8452dad..19b15db 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c
@@ -1326,7 +1326,6 @@ static struct pinctrl_desc uniphier_pro5_pinctrl_desc = {
 	.name = DRIVER_NAME,
 	.pins = uniphier_pro5_pins,
 	.npins = ARRAY_SIZE(uniphier_pro5_pins),
-	.owner = THIS_MODULE,
 };
 
 static int uniphier_pro5_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
index 89d3fdb..762de0e 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c
@@ -1244,7 +1244,6 @@ static struct pinctrl_desc uniphier_pxs2_pinctrl_desc = {
 	.name = DRIVER_NAME,
 	.pins = uniphier_pxs2_pins,
 	.npins = ARRAY_SIZE(uniphier_pxs2_pins),
-	.owner = THIS_MODULE,
 };
 
 static int uniphier_pxs2_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
index ab635f2..9fe8762 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c
@@ -769,7 +769,6 @@ static struct pinctrl_desc uniphier_sld8_pinctrl_desc = {
 	.name = DRIVER_NAME,
 	.pins = uniphier_sld8_pins,
 	.npins = ARRAY_SIZE(uniphier_sld8_pins),
-	.owner = THIS_MODULE,
 };
 
 static int uniphier_sld8_pinctrl_probe(struct platform_device *pdev)
-- 
1.9.1
