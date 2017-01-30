From: shailendra.v@samsung.com (Shailendra Verma)
Date: Mon, 30 Jan 2017 10:22:33 +0530
Subject: [PATCH] pwm - Fix possible NULL derefrence.
References: <CGME20170130045241epcas1p2a5a0625327e4caab59236ec85551f95e@epcas1p2.samsung.com>
Message-ID: <1485751953-29341-1-git-send-email-shailendra.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/pwm/pwm-sun4i.c |    4 ++++
 drivers/pwm/pwm-tegra.c |    5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b0803f6..9b5c6fe 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -321,6 +321,10 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (!pwm)
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index e464784..a5eb224 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -185,6 +185,11 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pwm->soc = of_device_get_match_data(&pdev->dev);
+	if (!pwm->soc) {
+		dev_err(&pdev->dev, "no device match found\n");
+		return -ENODEV;
+	}
+
 	pwm->dev = &pdev->dev;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.9.5
