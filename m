From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 09:58:47 +0800
Subject: [PATCH 6/6] regulator: anatop: set default voltage selector for pcie
In-Reply-To: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1491962327-12477-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the initial voltage selector for vddpcie in case it's disabled
by default.

This fixes the below warning:
20c8000.anatop:regulator-vddpcie: Failed to read a valid default voltage selector.
anatop_regulator: probe of 20c8000.anatop:regulator-vddpcie failed with error -22

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/regulator/anatop-regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 6da0b20..910adfd 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -301,6 +301,11 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 		if (!sreg->sel && rdesc->name && !strcmp(rdesc->name, "vddpu"))
 			sreg->sel = 22;
 
+		/* set the default voltage of the pcie phy to be 1.100v */
+		if (!sreg->sel && rdesc->name &&
+		    !strcmp(rdesc->name, "vddpcie"))
+			sreg->sel = 0x10;
+
 		if (!sreg->bypass && !sreg->sel) {
 			dev_err(&pdev->dev, "Failed to read a valid default voltage selector.\n");
 			return -EINVAL;
-- 
2.7.4
