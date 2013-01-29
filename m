From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Tue, 29 Jan 2013 13:08:49 +0530
Subject: [PATCH V2 1/6] pinctrl: pinctrl-single: use arch_initcall and
 module_exit
In-Reply-To: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
Message-ID: <1359445134-13323-2-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, I2C driver gets probed before pinctrl driver.
To achieve I2C pin muxing via pinctrl driver before I2C
probe get called, register pinctrl driver in arch_initcall.
Also, add module_exit to unregister pinctrl driver.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
---
:100644 100644 f6a360b... 3a96390... M	drivers/pinctrl/pinctrl-single.c
 drivers/pinctrl/pinctrl-single.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index f6a360b..3a96390 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1089,7 +1089,17 @@ static struct platform_driver pcs_driver = {
 	},
 };
 
-module_platform_driver(pcs_driver);
+static int __init pcs_pinctrl_init(void)
+{
+	return platform_driver_register(&pcs_driver);
+}
+arch_initcall(pcs_pinctrl_init);
+
+static void __exit pcs_pinctrl_exit(void)
+{
+	platform_driver_unregister(&pcs_driver);
+}
+module_exit(pcs_pinctrl_exit);
 
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("One-register-per-pin type device tree based pinctrl driver");
-- 
1.7.4.1
