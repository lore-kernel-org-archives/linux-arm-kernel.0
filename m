From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Wed, 24 Aug 2016 13:43:58 +0200
Subject: [PATCH v3] pwm: sun4i: fix a possible NULL dereference
Message-ID: <1472039038-4047-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

For fixing this problem, we use of_device_get_match_data(), this will
simplify the code a little by using a standard function for
getting the match data.

Testing the return value of of_device_get_match_data is also necessary
for avoiding a second NULL deref on pwm->data.

Reported-by: coverity (CID 1324139)
Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
Changes since v2:
 - Add a test on pwm->data for avoiding a second NULL deref.
Changes since v1:
 - Use of_device_get_match_data()

 drivers/pwm/pwm-sun4i.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 03a99a5..fb76c55 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -309,9 +309,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	struct resource *res;
 	u32 val;
 	int i, ret;
-	const struct of_device_id *match;
-
-	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (!pwm)
@@ -326,7 +323,9 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
-	pwm->data = match->data;
+	pwm->data = of_device_get_match_data(&pdev->dev);
+	if (!pwm->data)
+		return -EINVAL;
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
-- 
2.7.3
