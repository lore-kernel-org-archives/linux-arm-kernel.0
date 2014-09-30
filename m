From: heyunlei@huawei.com (Yunlei He)
Date: Tue, 30 Sep 2014 09:29:50 +0800
Subject: [PATCH] pinctrl: pinctrl-single.c: init pinctrl single at
 arch_initcall time
Message-ID: <1412040590-10764-1-git-send-email-heyunlei@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: heyunlei <heyunlei@huawei.com>

On our arm platform, some modules (e.g. I2C bus driver) use the
pinctrl-single driver to configure the SoC pin, but pinctrl-single
driver uses module_init time, that makes some modules initialize ahead
the pinctrl-single and fail to register.

This patch changes the initialization priority of pinctrl-single from
module_init time to arch_initcall time.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 drivers/pinctrl/pinctrl-single.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 95dd9cf..4b9e5b9 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -2012,7 +2012,18 @@ static struct platform_driver pcs_driver = {
 #endif
 };
 
-module_platform_driver(pcs_driver);
+static int __init pinctrl_single_init(void)
+{
+		return platform_driver_register(&pcs_driver);
+}
+
+static void __exit pinctrl_single_exit(void)
+{
+		platform_driver_unregister(&pcs_driver);
+}
+
+arch_initcall(pinctrl_single_init);
+module_exit(pinctrl_single_exit);
 
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("One-register-per-pin type device tree based pinctrl driver");
-- 
1.7.9.5
