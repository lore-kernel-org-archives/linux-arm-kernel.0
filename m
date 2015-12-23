From: henryc.chen@mediatek.com (Henry Chen)
Date: Wed, 23 Dec 2015 18:16:08 +0800
Subject: [PATCH] regulator: mt6397: convert to arch_initcall
Message-ID: <1450865768-10317-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to some device may need reulator operation in earlier boot time like gpu module which
power domain need regulator power on first. Move regulator of mt6397
initialization earlier in boot so that real devices can use regulator
without probe deferring.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/regulator/mt6397-regulator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index a5b2f47..9b89023 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -324,7 +324,11 @@ static struct platform_driver mt6397_regulator_driver = {
 	.probe = mt6397_regulator_probe,
 };
 
-module_platform_driver(mt6397_regulator_driver);
+static int __init mt6397_regulator_init(void)
+{
+	return platform_driver_register(&mt6397_regulator_driver);
+}
+arch_initcall(mt6397_regulator_init);
 
 MODULE_AUTHOR("Flora Fu <flora.fu@mediatek.com>");
 MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6397 PMIC");
-- 
1.9.1
