From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:23 +0200
Subject: [PATCH 11/16] deps: WIP: generic: annotate some initcalls
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-12-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WIP means Work In Progress.

Change some generic drivers to offer annotated initcalls.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/input/keyboard/gpio_keys.c | 2 +-
 drivers/misc/sram.c                | 2 +-
 drivers/regulator/fixed.c          | 3 ++-
 drivers/usb/phy/phy-generic.c      | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ddf4045..319bcf7 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -855,7 +855,7 @@ static void __exit gpio_keys_exit(void)
 	platform_driver_unregister(&gpio_keys_device_driver);
 }
 
-late_initcall(gpio_keys_init);
+annotated_initcall(late, gpio_keys_init, gpio_keys_device_driver.driver);
 module_exit(gpio_keys_exit);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 15c33cc..eb662bd 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -243,4 +243,4 @@ static int __init sram_init(void)
 	return platform_driver_register(&sram_driver);
 }
 
-postcore_initcall(sram_init);
+annotated_initcall(postcore, sram_init, sram_driver.driver);
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index ff62d69..ec35d10 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -221,7 +221,8 @@ static int __init regulator_fixed_voltage_init(void)
 {
 	return platform_driver_register(&regulator_fixed_voltage_driver);
 }
-subsys_initcall(regulator_fixed_voltage_init);
+annotated_initcall(subsys, regulator_fixed_voltage_init,
+					regulator_fixed_voltage_driver.driver);
 
 static void __exit regulator_fixed_voltage_exit(void)
 {
diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index deee68e..baf95d0 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -360,7 +360,7 @@ static int __init usb_phy_generic_init(void)
 {
 	return platform_driver_register(&usb_phy_generic_driver);
 }
-subsys_initcall(usb_phy_generic_init);
+annotated_initcall(subsys, usb_phy_generic_init, usb_phy_generic_driver.driver);
 
 static void __exit usb_phy_generic_exit(void)
 {
-- 
2.1.0
