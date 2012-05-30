From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:19 +0800
Subject: [PATCH 01/22] ARM: ux500: New DT:ed snowball_platform_devs for
 one-by-one device enablement
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During Device Tree enablement it is necessary to remove snowball_<device>*
platform_data segments one at at time, as and when particular devices are
DT enabled. This patch provides a temporary solution. Once this new struct
is empty it will be removed again.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index b23a643..d4132f5 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -676,6 +676,13 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 	&ab8500_device,
 };
 
+static struct platform_device *snowball_of_platform_devs[] __initdata = {
+	&snowball_led_dev,
+	&snowball_key_dev,
+	&snowball_sbnet_dev,
+	&ab8500_device,
+};
+
 static void __init mop500_init_machine(void)
 {
 	struct device *parent = NULL;
@@ -876,8 +883,15 @@ static void __init u8500_init_machine(void)
 					ARRAY_SIZE(mop500_i2c2_devices));
 
 	} else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
-		platform_add_devices(snowball_platform_devs,
-				ARRAY_SIZE(snowball_platform_devs));
+		/*
+		 * Devices to be DT:ed:
+		 *   snowball_led_dev   = todo
+		 *   snowball_key_dev   = todo
+		 *   snowball_sbnet_dev = todo
+		 *   ab8500_device      = todo
+		 */
+		platform_add_devices(snowball_of_platform_devs,
+				ARRAY_SIZE(snowball_of_platform_devs));
 
 		snowball_sdi_init(parent);
 	} else if (of_machine_is_compatible("st-ericsson,hrefv60+")) {
-- 
1.7.9.5
