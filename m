From: drivshin@awxrd.com (David Rivshin)
Date: Mon, 30 Jul 2018 18:30:30 -0400
Subject: [PATCH v3] pwm: pwm-omap-dmtimer: return -EPROBE_DEFER if no dmtimer
 platform data
Message-ID: <20180730223030.10628-1-drivshin@awxrd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Rivshin <DRivshin@allworx.com>

If a pwm-omap-dmtimer is probed before the dmtimer it uses, the platform
data won't be set yet.

Fixes: ac30751df953 ("ARM: OMAP: pdata-quirks: Remove unused timer pdata")
Cc: <stable@vger.kernel.org> # 4.17+
Signed-off-by: David Rivshin <drivshin@allworx.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>
---
Changes in v3:
* Changed dev_info to dev_dbg
Changes in v2:
* Added Pavel's Acked-by/Tested-by [1]

[1] https://lkml.org/lkml/2018/7/16/346

 drivers/pwm/pwm-omap-dmtimer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 665da3c8fbceb..f45798679e3c0 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -264,8 +264,9 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
 	if (!timer_pdata) {
-		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
-		ret = -EINVAL;
+		dev_dbg(&pdev->dev,
+			 "dmtimer pdata structure NULL, deferring probe\n");
+		ret = -EPROBE_DEFER;
 		goto put;
 	}
 

base-commit: acb1872577b346bd15ab3a3f8dff780d6cca4b70
-- 
2.17.1
