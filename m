From: Frank.Li@freescale.com (Frank Li)
Date: Mon, 12 Nov 2012 17:59:52 +0800
Subject: [PATCH 2/2] regulator: gpio-regulator: fix can't find regulator node
 in dt
Message-ID: <1352714392-30497-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need initilize of_node in regulator config when register regulator,
otherwise regulator driver think it is no-dt device.

in regulator_dev_lookup
list_for_each_entry(r, &regulator_list, list)
	if (r->dev.parent &&
		node == r->dev.of_node)
			return r

r->dev.of_noe will be zero if miss config in cfg.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/regulator/gpio-regulator.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index e467d0a..faa2f71 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -303,6 +303,7 @@ static int __devinit gpio_regulator_probe(struct platform_device *pdev)
 	cfg.dev = &pdev->dev;
 	cfg.init_data = config->init_data;
 	cfg.driver_data = drvdata;
+	cfg.of_node = np;
 
 	if (config->enable_gpio >= 0)
 		cfg.ena_gpio = config->enable_gpio;
-- 
1.7.1
