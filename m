From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 20 Sep 2014 22:06:34 +0200
Subject: [PATCH 1/3] regulator: axp20x: Use parent device as regulator
 configuration device
In-Reply-To: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1411243596-15117-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1411243596-15117-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current device used for the regulator configuration is the child device
created by the MFD driver. This means that it doesn't have any of_node pointing
to it, and whenever we register the regulators, it will not look into the
regulator supply in the DT, hence requiring to provide regulator aliases in the
MFD driver.

We can easily fix that by using the parent device in our configuration, which
has a DT node associated to it, and will allow a DT lookup. Eventually, we will
be able to remove the aliases in the MFD driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 004aadb7bcc1..2e1010a34ddc 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -245,7 +245,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 	for (i = 0; i < AXP20X_REG_ID_MAX; i++) {
 		init_data = axp20x_matches[i].init_data;
 
-		config.dev = &pdev->dev;
+		config.dev = pdev->dev.parent;
 		config.init_data = init_data;
 		config.regmap = axp20x->regmap;
 		config.of_node = axp20x_matches[i].of_node;
-- 
2.1.0
