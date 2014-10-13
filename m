From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 13 Oct 2014 17:21:35 +0300
Subject: [PATCHv2 2/3] pwm: push up dynamic printk level on errors in
 of_pwm_get()
In-Reply-To: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1413210099-7862-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changed three user messages on fault are printed under pr_debug(),
however all of them are unrecoverable and result in failed pwm device
registration, report this to a user.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
Changes from v1 to v2:
- corrected the proper kernel log level, thanks to Lothar Wa?mann.

 drivers/pwm/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 681d154..f6231c6 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -532,19 +532,19 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
 					 &args);
 	if (err) {
-		pr_debug("%s(): can't parse \"pwms\" property\n", __func__);
+		pr_err("%s(): can't parse \"pwms\" property\n", __func__);
 		return ERR_PTR(err);
 	}
 
 	pc = of_node_to_pwmchip(args.np);
 	if (IS_ERR(pc)) {
-		pr_debug("%s(): PWM chip not found\n", __func__);
+		pr_err("%s(): PWM chip not found\n", __func__);
 		pwm = ERR_CAST(pc);
 		goto put;
 	}
 
 	if (args.args_count != pc->of_pwm_n_cells) {
-		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
+		pr_err("%s: wrong #pwm-cells for %s\n", np->full_name,
 			 args.np->full_name);
 		pwm = ERR_PTR(-EINVAL);
 		goto put;
-- 
1.7.10.4
