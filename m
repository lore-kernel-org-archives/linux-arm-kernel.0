From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 23 May 2016 15:13:30 +0800
Subject: [PATCH v2 2/3] regulator: of: Add support for parsing operation mode
In-Reply-To: <1463987611-32139-1-git-send-email-henryc.chen@mediatek.com>
References: <1463987611-32139-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <1463987611-32139-3-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators support their operating mode to be changed by consumers for
module specific purpose.

This patch adds support to parse those properties and fill the regulator
constraints so the regulator core can call the regualtor_set_mode to change
the modes.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/regulator/of_regulator.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 6b0aa80..7f8d82e 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -31,7 +31,7 @@ static void of_get_regulation_constraints(struct device_node *np,
 	struct regulation_constraints *constraints = &(*init_data)->constraints;
 	struct regulator_state *suspend_state;
 	struct device_node *suspend_np;
-	int ret, i;
+	int ret, i, cnt;
 	u32 pval;
 
 	constraints->name = of_get_property(np, "regulator-name", NULL);
@@ -167,6 +167,19 @@ static void of_get_regulation_constraints(struct device_node *np,
 		suspend_state = NULL;
 		suspend_np = NULL;
 	}
+	cnt = of_property_count_elems_of_size(np,
+					      "regulator-supported-modes",
+					      sizeof(u32));
+	if (cnt > 0)
+		constraints->valid_ops_mask |= REGULATOR_CHANGE_MODE;
+
+	for (i = 0; i < cnt; i++) {
+		u32 mode;
+
+		of_property_read_u32_index(np, "regulator-supported-modes",
+					   i, &mode);
+		constraints->valid_modes_mask |= (1 << mode);
+	}
 }
 
 /**
-- 
1.8.1.1.dirty
