From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  4 May 2012 19:23:17 +0100
Subject: [PATCH 07/15] drivers/power: Carry out platform_data error checking
 on ab8500 devices
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1336155805-18554-8-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In their current state the ab8500 power devices explode if platform data
isn't provided. This patch prevents this from happening and informs the
user of what has happened.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/power/ab8500_btemp.c   |   12 ++++++++----
 drivers/power/ab8500_charger.c |   12 ++++++++----
 drivers/power/ab8500_fg.c      |   12 ++++++++----
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index d8bb993..a2ebcb4 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -964,10 +964,15 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
 {
 	int irq, i, ret = 0;
 	u8 val;
-	struct abx500_bm_plat_data *plat_data;
+	struct abx500_bm_plat_data *plat_data = pdev->dev.platform_data;
+	struct ab8500_btemp *di;
+
+	if (!plat_data) {
+		dev_err(&pdev->dev, "No platform data\n");
+		return -EINVAL;
+	}
 
-	struct ab8500_btemp *di =
-		kzalloc(sizeof(struct ab8500_btemp), GFP_KERNEL);
+	di = kzalloc(sizeof(struct ab8500_btemp), GFP_KERNEL);
 	if (!di)
 		return -ENOMEM;
 
@@ -977,7 +982,6 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
 	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
 
 	/* get btemp specific platform data */
-	plat_data = pdev->dev.platform_data;
 	di->pdata = plat_data->btemp;
 	if (!di->pdata) {
 		dev_err(di->dev, "no btemp platform data supplied\n");
diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index e2b4acc..a4e37a8 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -2534,10 +2534,15 @@ static int __devexit ab8500_charger_remove(struct platform_device *pdev)
 static int __devinit ab8500_charger_probe(struct platform_device *pdev)
 {
 	int irq, i, charger_status, ret = 0;
-	struct abx500_bm_plat_data *plat_data;
+	struct abx500_bm_plat_data *plat_data = pdev->dev.platform_data;
+	struct ab8500_charger *di;
 
-	struct ab8500_charger *di =
-		kzalloc(sizeof(struct ab8500_charger), GFP_KERNEL);
+	if (!plat_data) {
+		dev_err(&pdev->dev, "No platform data\n");
+		return -EINVAL;
+	}
+
+	di = kzalloc(sizeof(struct ab8500_charger), GFP_KERNEL);
 	if (!di)
 		return -ENOMEM;
 
@@ -2550,7 +2555,6 @@ static int __devinit ab8500_charger_probe(struct platform_device *pdev)
 	spin_lock_init(&di->usb_state.usb_lock);
 
 	/* get charger specific platform data */
-	plat_data = pdev->dev.platform_data;
 	di->pdata = plat_data->charger;
 
 	if (!di->pdata) {
diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index c22f2f0..d88bc47 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -2446,10 +2446,15 @@ static int __devinit ab8500_fg_probe(struct platform_device *pdev)
 {
 	int i, irq;
 	int ret = 0;
-	struct abx500_bm_plat_data *plat_data;
+	struct abx500_bm_plat_data *plat_data = pdev->dev.platform_data;
+	struct ab8500_fg *di;
+
+	if (!plat_data) {
+		dev_err(&pdev->dev, "No platform data\n");
+		return -EINVAL;
+	}
 
-	struct ab8500_fg *di =
-		kzalloc(sizeof(struct ab8500_fg), GFP_KERNEL);
+	di = kzalloc(sizeof(struct ab8500_fg), GFP_KERNEL);
 	if (!di)
 		return -ENOMEM;
 
@@ -2461,7 +2466,6 @@ static int __devinit ab8500_fg_probe(struct platform_device *pdev)
 	di->gpadc = ab8500_gpadc_get("ab8500-gpadc.0");
 
 	/* get fg specific platform data */
-	plat_data = pdev->dev.platform_data;
 	di->pdata = plat_data->fg;
 	if (!di->pdata) {
 		dev_err(di->dev, "no fg platform data supplied\n");
-- 
1.7.9.5
