From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:26:25 +0900
Subject: [PATCH 07/21] ARM: shmobile: kzm9g: reference: Register pinctrl
 mappings for I2C
In-Reply-To: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
References: <1360725999-14514-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360725999-14514-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the GPIO-based I2C pinmux configuration by pinctrl mappings.

This change is for the kzm9g reference DT implementation and
is in keeping with a similar change for the default kzm9g implementation
made by Laurent Pinchart.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v2
* Do not add call to sh73a0_pinmux_init()
  This is done in "ARM: shmobile: parse DT and configure pinmux early on
  kzm9g-reference" which is now a dependency of this patch.
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index e334152..543019f 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -26,15 +26,22 @@
 #include <linux/irq.h>
 #include <linux/input.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static const struct pinctrl_map kzm_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
+				  "i2c3_1", "i2c3"),
+};
+
 static void __init kzm_init(void)
 {
 	sh73a0_add_standard_devices_dt();
+	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
 	sh73a0_pinmux_init();
 
 	/* enable SCIFA4 */
@@ -55,10 +62,6 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_MMCD0_6_PU,	NULL);
 	gpio_request(GPIO_FN_MMCD0_7_PU,	NULL);
 
-	/* I2C 3 */
-	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
-	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.7.10.4
