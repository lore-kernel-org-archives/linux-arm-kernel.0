From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed,  8 Jul 2015 16:16:06 +0200
Subject: [PATCH] pinctrl: imx1-core: Fix debug output pin array index
Message-ID: <1436364966-19778-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pins do not have a 1:1 mapping from index to pin_id. Unfortunately
the debug output assumes exactly that.

The first driver using imx1-core was imx27, which had exactly this 1:1
mapping. It was accidently removed when removing all unused pads which
were listed:
	607af165c047 (pinctrl: i.MX27: Remove nonexistent pad definitions)

The patch fixes this issue by printing the pin_id directly and not the
pin name.

Cc: <stable@vger.kernel.org>
Reported-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/pinctrl/freescale/pinctrl-imx1-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
index 5fd4437cee15..f08858769167 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -403,14 +403,12 @@ static int imx1_pinconf_set(struct pinctrl_dev *pctldev,
 			     unsigned num_configs)
 {
 	struct imx1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
-	const struct imx1_pinctrl_soc_info *info = ipctl->info;
 	int i;
 
 	for (i = 0; i != num_configs; ++i) {
 		imx1_write_bit(ipctl, pin_id, configs[i] & 0x01, MX1_PUEN);
 
-		dev_dbg(ipctl->dev, "pinconf set pullup pin %s\n",
-			info->pins[pin_id].name);
+		dev_dbg(ipctl->dev, "pinconf set pullup pin %d\n", pin_id);
 	}
 
 	return 0;
-- 
2.1.4
