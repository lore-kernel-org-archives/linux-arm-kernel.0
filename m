From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Thu, 12 Nov 2015 08:42:12 +0100
Subject: [PATCH] pwm: sun4i: fix a possible NULL dereference
Message-ID: <1447314132-29458-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

Reported-by: coverity (CID 1324139)
Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index cd9dde5..3011fcc 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -291,6 +291,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
+	if (!match)
+		return -ENODEV;
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (!pwm)
-- 
2.4.10
