From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Sat, 21 Oct 2017 19:38:12 +0200
Subject: [PATCH] pwm: sunxi: use of_device_get_match_data
Message-ID: <20171021173812.30102-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usage of of_device_get_match_data reduce the code size a bit.
Furthermore, it prevents an improbable dereference when
of_match_device() return NULL.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6d23f1d1c9b7..334199c58f1d 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -368,14 +368,15 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	struct sun4i_pwm_chip *pwm;
 	struct resource *res;
 	int ret;
-	const struct of_device_id *match;
-
-	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (!pwm)
 		return -ENOMEM;
 
+	pwm->data = of_device_get_match_data(&pdev->dev);
+	if (!pwm->data)
+		return -ENODEV;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pwm->base))
@@ -385,7 +386,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
-	pwm->data = match->data;
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
-- 
2.13.6
