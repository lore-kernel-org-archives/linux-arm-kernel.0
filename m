From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  8 May 2013 14:29:08 +0100
Subject: [PATCH 8/9] pinctrl: abx500: Rejiggle platform data and DT
 initialisation
In-Reply-To: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368019749-19455-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A pointer to GPIO platform data is always passed to the driver now, so
there's little point in checking for 'pdata' and executing the DT case if
it's not there. The difference between booting with DT and !DT is when
booting with DT, plat_id is not populated. Thus, in the DT case we have
to use a DT match table in order to find out which platform we're
executing on. So, we're changing the semantics here to only use the
match table if no plat_id is supplied though platform data.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/pinctrl-abx500.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
index 2a2a9df..6d45327 100644
--- a/drivers/pinctrl/pinctrl-abx500.c
+++ b/drivers/pinctrl/pinctrl-abx500.c
@@ -851,23 +851,12 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 
 	if (abx500_pdata)
 		pdata = abx500_pdata->gpio;
-	if (!pdata) {
-		if (np) {
-			const struct of_device_id *match;
 
-			match = of_match_device(abx500_gpio_match, &pdev->dev);
-			if (!match)
-				return -ENODEV;
-			id = (unsigned long)match->data;
-		} else {
-			dev_err(&pdev->dev, "gpio dt and platform data missing\n");
-			return -ENODEV;
-		}
+	if (!(pdata || np)) {
+		dev_err(&pdev->dev, "gpio dt and platform data missing\n");
+		return -ENODEV;
 	}
 
-	if (platid)
-		id = platid->driver_data;
-
 	pct = devm_kzalloc(&pdev->dev, sizeof(struct abx500_pinctrl),
 				   GFP_KERNEL);
 	if (pct == NULL) {
@@ -882,6 +871,16 @@ static int abx500_gpio_probe(struct platform_device *pdev)
 	pct->chip.dev = &pdev->dev;
 	pct->chip.base = (np) ? -1 : pdata->gpio_base;
 
+	if (platid)
+		id = platid->driver_data;
+	else if (np) {
+		const struct of_device_id *match;
+
+		match = of_match_device(abx500_gpio_match, &pdev->dev);
+		if (match)
+			id = (unsigned long)match->data;
+	}
+
 	/* initialize the lock */
 	mutex_init(&pct->lock);
 
-- 
1.7.10.4
