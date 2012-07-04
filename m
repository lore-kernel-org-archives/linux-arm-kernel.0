From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  4 Jul 2012 15:34:12 +0100
Subject: [PATCH] ARM: ux500: Register pinctrl from platform code until it's
 been DT:ed
Message-ID: <1341412452-3808-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some inconsistencies with the way pinctrl devices are named
when registered from platform code to the ones registered by Device
Tree. Platform devices look like 'pinctrl-db8500', whereas the ones
registered from Device Tree look more like 'pinctrl.2'. This leads to
failure when carrying out name-based searches for known devices.

Until the correct DT bindings have been applied to the pinctrl driver
it will fail to function correctly. For instance, during a Device
Tree boot on Snowball no bootlog is visible due to a UART port probe
failure. Regulators fail in a similar way.

This patch prevents Device Tree from probing the pinctrl driver and
ensures registration is completed from platform code instead.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi      |    1 +
 arch/arm/mach-ux500/board-mop500.c |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 4ad5160..0e9ca87 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -172,6 +172,7 @@
 
 		pinctrl {
 			compatible = "stericsson,nmk_pinctrl";
+			status = "disabled";
 		};
 
 		usb at a03e0000 {
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 461012a..2a5d46f 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -824,6 +824,8 @@ static void __init u8500_init_machine(void)
 	/* automatically probe child nodes of db8500 device */
 	of_platform_populate(NULL, u8500_local_bus_nodes, u8500_auxdata_lookup, parent);
 
+	dbx500_add_pinctrl(parent, "pinctrl-db8500");
+
 	if (of_machine_is_compatible("st-ericsson,mop500")) {
 		mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
 
-- 
1.7.9.5
