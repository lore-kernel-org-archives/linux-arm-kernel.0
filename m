From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 12 Apr 2017 09:58:43 +0800
Subject: [PATCH 2/6] regulator: anatop: only set supply regulator when it
 actually exists
In-Reply-To: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1491962327-12477-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mandatorily set the initdata->supply_regulator while it actually not
exist will cause regulator core to resolve supply each time whenever
a new regulator registered which is meaningless and waste CPU mips.

We can observe more than one hundred times of iteration of resolving
during a MX6Q SDB board booting up.

This patch adds the condition check for vin-supply to avoid the issue.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/regulator/anatop-regulator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 46b9c2c..2a97ada 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -203,7 +203,9 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	if (!initdata)
 		return -ENOMEM;
 
-	initdata->supply_regulator = "vin";
+	if (of_find_property(np, "vin-supply", NULL))
+		initdata->supply_regulator = "vin";
+
 	sreg->initdata = initdata;
 
 	anatop_np = of_get_parent(np);
-- 
2.7.4
