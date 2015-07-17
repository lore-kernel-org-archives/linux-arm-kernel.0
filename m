From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Jul 2015 09:38:43 +0200
Subject: [PATCH] Subject: pinctrl: imx1-core: Fix debug output in
 .pin_config_set callback
In-Reply-To: <55A85B59.5060906@gtsys.com.hk>
References: <55A85B59.5060906@gtsys.com.hk>
Message-ID: <1437118723-19217-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx1_pinconf_set assumes that the array of pins in struct
imx1_pinctrl_soc_info can be indexed by pin id to get the
pinctrl_pin_desc for a pin. This used to be correct up to commit
607af165c047 which removed some entries from the array and so made it
wrong to access the array by pin id.

The result of this bug is a wrong pin name in the output for small pin
ids and an oops for the bigger ones.

This patch is the result of a discussion that includes patches by Markus
Pargmann and Chris Ruehl.

Fixes: 607af165c047 ("pinctrl: i.MX27: Remove nonexistent pad definitions")
Cc: stable at vger.kernel.org
Reported-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/freescale/pinctrl-imx1-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
index 5fd4437cee15..88a7fac11bd4 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -403,14 +403,13 @@ static int imx1_pinconf_set(struct pinctrl_dev *pctldev,
 			     unsigned num_configs)
 {
 	struct imx1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	const struct imx1_pinctrl_soc_info *info = ipctl->info;
 	int i;
 
 	for (i = 0; i != num_configs; ++i) {
 		imx1_write_bit(ipctl, pin_id, configs[i] & 0x01, MX1_PUEN);
 
 		dev_dbg(ipctl->dev, "pinconf set pullup pin %s\n",
-			info->pins[pin_id].name);
+			pin_desc_get(pctldev, pin_id)->name);
 	}
 
 	return 0;
-- 
2.1.4
