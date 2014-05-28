From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 19:11:06 +0200
Subject: [PATCH 2/5] regulator: Pass the config device node to
 regulator_dev_lookup
In-Reply-To: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1401297069-7423-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now, regulator registers only looks for parent supplies in the struct
device of_node.

That means that single devices that expose several regulators in the DT have to
tie the parent supplies to the parent device, instead of the regulator itself
like described in the regulator bindings.

The regulator device node is already present in the regulator_config structure
that is passed to regulator_register. Use it to first match in the regulator
node, and then to the device node itself.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3e3954252a23..c8e26be5ea01 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3503,7 +3503,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	if (supply) {
 		struct regulator_dev *r;
 
-		r = regulator_dev_lookup(dev, NULL, supply, &ret);
+		r = regulator_dev_lookup(dev, config->of_node, supply, &ret);
 
 		if (ret == -ENODEV) {
 			/*
-- 
1.9.3
