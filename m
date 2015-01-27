From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 28 Jan 2015 00:05:53 +0100
Subject: [PATCH RESENT] pinctrl: pinctrl-imx: don't use invalid value of
 conf_reg
Message-ID: <1422399953-6259-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The right check for conf_reg to be invalid it testing against -1 not 0
as is done in the rest of the driver.

This fixes an oops that can be triggered by:

	cat /sys/kernel/debug/pinctrl/43fac000.iomuxc/*

Fixes: ae75ff814538 ("pinctrl: pinctrl-imx: add imx pinctrl core driver")
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---

Notes:
    Resent to fix email address of Dong Aisheng

 drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 52f2b9404fe0..448f10986c28 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -437,7 +437,7 @@ static void imx_pinconf_dbg_show(struct pinctrl_dev *pctldev,
 	const struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
 	unsigned long config;
 
-	if (!pin_reg || !pin_reg->conf_reg) {
+	if (!pin_reg || pin_reg->conf_reg == -1) {
 		seq_printf(s, "N/A");
 		return;
 	}
-- 
2.1.4
