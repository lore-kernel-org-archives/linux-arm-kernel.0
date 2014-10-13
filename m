From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 13 Oct 2014 17:21:39 +0300
Subject: [PATCHv2 3/3] pwm: set the actual number of pwms arguments defined in
 board dts
In-Reply-To: <1413210099-7862-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413210099-7862-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1413210099-7862-5-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For backward compatibility board device tree has to define only a
minimal amount of mandatory pwms arguments, which is specified by a
driver. Additional arguments shall be considered as optional, update
pc->of_pwm_n_cells according to the actual data taken from device tree
file.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
Changes from v1 to v2:
- rebased on top of modified patch v2 2/3

 drivers/pwm/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index f6231c6..4d9fc7f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -543,12 +543,13 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 		goto put;
 	}
 
-	if (args.args_count != pc->of_pwm_n_cells) {
+	if (args.args_count < pc->of_pwm_n_cells) {
 		pr_err("%s: wrong #pwm-cells for %s\n", np->full_name,
 			 args.np->full_name);
 		pwm = ERR_PTR(-EINVAL);
 		goto put;
 	}
+	pc->of_pwm_n_cells = args.args_count;
 
 	pwm = pc->of_xlate(pc, &args);
 	if (IS_ERR(pwm))
-- 
1.7.10.4
