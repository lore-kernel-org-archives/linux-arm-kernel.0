From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 03:01:48 +0800
Subject: [PATCH 1/6] pinctrl: imx: fix unsigned check if nfuncs with less than
 or equal zero
In-Reply-To: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
References: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1524855713-15527-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The unsigned integer nfuncs is being error checked with a value less
or equal to zero; this is always false if of_get_child_count returns a
-ve for an error condition since nfuncs is not signed. Fix this by
making variables nfuncs and i signed integers.

Detected with Coccinelle:
drivers/pinctrl/freescale/pinctrl-imx.c:620:6-12: WARNING: Unsigned
expression compared with zero: nfuncs <= 0

Cc: Linus Walleij <linus.walleij@linaro.org>
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 24aaddd..77cd364 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -617,7 +617,7 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 		nfuncs = 1;
 	} else {
 		nfuncs = of_get_child_count(np);
-		if (nfuncs <= 0) {
+		if (nfuncs == 0) {
 			dev_err(&pdev->dev, "no functions defined\n");
 			return -EINVAL;
 		}
-- 
2.7.4
