From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 26 May 2014 16:58:11 +0200
Subject: [PATCH v2 4/5] regulator: axp20x: reset probe data before each probe
In-Reply-To: <1401116292-24066-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1401116292-24066-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1401116292-24066-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init_data and of_node fields of the axp2xx_matches tables are filled
at each device probe by the axp20x_regulator_parse_dt function (which then
calls the of_regulator_match function).
This means we can probe a new device and consider data initialized during
the probe of another device as valid.

Reset init_data and of_node field to NULL before each probe in order to
avoid this kind of issue.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/regulator/axp20x-regulator.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index feaa0b5..4486517 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -323,6 +323,15 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		nregulators = AXP20X_REG_ID_MAX;
 	}
 
+	/*
+	 * Reset matches table (this table might have been modified by a
+	 * previous AXP2xx device probe).
+	 */
+	for (i = 0; i < nmatches; i++) {
+		matches[i].init_data = NULL;
+		matches[i].of_node = NULL;
+	}
+
 	ret = axp20x_regulator_parse_dt(pdev, matches, nmatches);
 	if (ret)
 		return ret;
-- 
1.8.3.2
