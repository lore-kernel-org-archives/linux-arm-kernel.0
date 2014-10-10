From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Fri, 10 Oct 2014 18:50:07 +0300
Subject: =?UTF-8?q?=5BPATCH=203/3=5D=20pwm=3A=20set=20the=20actual=20number=20of=20pwms=20arguments=20defined=20in=20board=20dts?=
In-Reply-To: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1412956207-24008-4-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For backward compatibility board device tree has to define only a
minimal amount of mandatory pwms arguments, additional arguments shall
be considered as optional, update pc->of_pwm_n_cells according to the
actual data taken from device tree file.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pwm/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ccf1be7..2b77322 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -543,12 +543,13 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 		goto put;
 	}
 
-	if (args.args_count != pc->of_pwm_n_cells) {
+	if (args.args_count < pc->of_pwm_n_cells) {
 		pr_warn("%s: wrong #pwm-cells for %s\n", np->full_name,
 			 args.np->full_name);
 		pwm = ERR_PTR(-EINVAL);
 		goto put;
 	}
+	pc->of_pwm_n_cells = args.args_count;
 
 	pwm = pc->of_xlate(pc, &args);
 	if (IS_ERR(pwm))
-- 
1.7.10.4
