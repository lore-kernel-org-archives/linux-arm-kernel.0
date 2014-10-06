From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  6 Oct 2014 21:33:37 +0200
Subject: [PATCH 2/2] regulator: imx-anatop: Fail on invalid voltage selector
In-Reply-To: <1412624017-28673-1-git-send-email-mpa@pengutronix.de>
References: <1412624017-28673-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1412624017-28673-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A '0' voltage selector is invalid and can't be used with this driver.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/regulator/anatop-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 30e8d7ad5813..542d14ed48bb 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -291,6 +291,11 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		 */
 		if (!sreg->sel && !strcmp(sreg->name, "vddpu"))
 			sreg->sel = 22;
+
+		if (!sreg->sel) {
+			dev_err(&pdev->dev, "Failed to read a valid default voltage selector.\n");
+			return -EINVAL;
+		}
 	} else {
 		rdesc->ops = &anatop_rops;
 	}
-- 
2.1.0
