From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 17 Apr 2012 11:43:57 +0100
Subject: [PATCH 05/16] ARM: ux500: New DT:ed snowball_platform_devs for
 one-by-one device enablement
In-Reply-To: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334659448-11521-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During Device Tree enablement it is necessary to remove
snowball_<device>* platform_data segments one at at time,
as and when particular devices are DT enabled. This patch
provides a temporary solution. Once this new struct is
empty it will be removed again.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index a352313..ee1296a 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -609,6 +609,13 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
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
@@ -801,8 +808,16 @@ static void __init u8500_init_machine(void)
 		mop500_sdi_init(parent);
 	} else if (of_machine_is_compatible("calaosystems,snowball-a9500")) {
 		snowball_pins_init();
-		platform_add_devices(snowball_platform_devs,
-				ARRAY_SIZE(snowball_platform_devs));
+
+		/*
+		 * Devices to be DT:ed:
+		 *   snowball_led_dev   = todo
+		 *   snowball_key_dev   = todo
+		 *   snowball_sbnet_dev = done
+		 *   ab8500_device      = todo
+		 */
+		platform_add_devices(snowball_of_platform_devs,
+				ARRAY_SIZE(snowball_of_platform_devs));
 
 	} else if (of_machine_is_compatible("st-ericsson,hrefv60+")) {
 		/*
-- 
1.7.9.1
