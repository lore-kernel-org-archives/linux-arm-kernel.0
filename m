From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 18:00:50 +0900
Subject: [PATCH 2/5] ARM: shmobile: lager: add MMCIF support
In-Reply-To: <cover.1375174556.git.horms+renesas@verge.net.au>
References: <cover.1375174556.git.horms+renesas@verge.net.au>
Message-ID: <63d0539e5466e1c5765b9dfdffafd619d4115ba5.1375174556.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add support for the MMCIF1 interface on Lager.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index d0da052..3c67b2a 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -24,10 +24,15 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/r8a7790.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -70,6 +75,22 @@ static __initdata struct gpio_keys_platform_data lager_keys_pdata = {
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+/* Fixed 3.3V regulator to be used by MMCIF */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] =
+{
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.1"),
+};
+
+/* MMCIF */
+static struct sh_mmcif_plat_data mmcif1_pdata = {
+	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+};
+
+static struct resource mmcif1_resources[] = {
+	DEFINE_RES_MEM_NAMED(0xee220000, 0x80, "MMCIF1"),
+	DEFINE_RES_IRQ(gic_spi(170)),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
@@ -77,6 +98,11 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
 				  "scif1_data", "scif1"),
+	/* MMCIF1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.1", "pfc-r8a7790",
+				  "mmc1_data8", "mmc1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.1", "pfc-r8a7790",
+				  "mmc1_ctrl", "mmc1"),
 };
 
 static void __init lager_add_standard_devices(void)
@@ -94,6 +120,11 @@ static void __init lager_add_standard_devices(void)
 	platform_device_register_data(&platform_bus, "gpio-keys", -1,
 				      &lager_keys_pdata,
 				      sizeof(lager_keys_pdata));
+	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+	platform_device_register_resndata(&platform_bus, "sh_mmcif", 1,
+					  mmcif1_resources, ARRAY_SIZE(mmcif1_resources),
+					  &mmcif1_pdata, sizeof(mmcif1_pdata));
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.3.2
