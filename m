From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 18 Oct 2012 17:06:55 +0800
Subject: [PATCH 01/10] pinctrl: use postcore_initcall
Message-ID: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since pins are configured in device driver, pinctrl driver should be
loaded by those device driver. module_platform_driver() only declares
pinctrl driver is in module_initcall privilege. Use postcore_initcall
privilege instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 76a4260..64d109a 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -980,7 +980,17 @@ static struct platform_driver pcs_driver = {
 	},
 };
 
-module_platform_driver(pcs_driver);
+static int __init pcs_driver_init(void)
+{
+	return platform_driver_register(&pcs_driver);
+}
+postcore_initcall(pcs_driver_init);
+
+static void __exit pcs_driver_exit(void)
+{
+	platform_driver_unregister(&pcs_driver);
+}
+module_exit(pcs_driver_exit);
 
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("One-register-per-pin type device tree based pinctrl driver");
-- 
1.7.0.4
