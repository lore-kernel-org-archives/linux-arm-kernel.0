From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  2 Dec 2013 11:19:08 +0900
Subject: [PATCH 06/28] ARM: shmobile: r8a7791 GPIO platform device support
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
Message-ID: <70cb6d19fbbf4ac999cd4c81eee65ad643ecacdd.1385950394.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add GPIO controller platform devices for the r8a7791 SoC.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7791.c | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 84cad8c..59dd442 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
@@ -39,9 +40,48 @@ static const struct resource pfc_resources[] __initconst = {
 	platform_device_register_simple("pfc-r8a7791", -1, pfc_resources, \
 					ARRAY_SIZE(pfc_resources))
 
+#define R8A7791_GPIO(idx, base, nr)					\
+static const struct resource r8a7791_gpio##idx##_resources[] __initconst = { \
+	DEFINE_RES_MEM((base), 0x50),					\
+	DEFINE_RES_IRQ(gic_spi(4 + (idx))),				\
+};									\
+									\
+static const struct gpio_rcar_config					\
+r8a7791_gpio##idx##_platform_data __initconst = {			\
+	.gpio_base	= 32 * (idx),					\
+	.irq_base	= 0,						\
+	.number_of_pins	= (nr),						\
+	.pctl_name	= "pfc-r8a7791",				\
+	.has_both_edge_trigger = 1,					\
+};									\
+
+R8A7791_GPIO(0, 0xe6050000, 32);
+R8A7791_GPIO(1, 0xe6051000, 32);
+R8A7791_GPIO(2, 0xe6052000, 32);
+R8A7791_GPIO(3, 0xe6053000, 32);
+R8A7791_GPIO(4, 0xe6054000, 32);
+R8A7791_GPIO(5, 0xe6055000, 32);
+R8A7791_GPIO(6, 0xe6055400, 32);
+R8A7791_GPIO(7, 0xe6055800, 26);
+
+#define r8a7791_register_gpio(idx)					\
+	platform_device_register_resndata(&platform_bus, "gpio_rcar", idx, \
+		r8a7791_gpio##idx##_resources,				\
+		ARRAY_SIZE(r8a7791_gpio##idx##_resources),		\
+		&r8a7791_gpio##idx##_platform_data,			\
+		sizeof(r8a7791_gpio##idx##_platform_data))
+
 void __init r8a7791_pinmux_init(void)
 {
 	r8a7791_register_pfc();
+	r8a7791_register_gpio(0);
+	r8a7791_register_gpio(1);
+	r8a7791_register_gpio(2);
+	r8a7791_register_gpio(3);
+	r8a7791_register_gpio(4);
+	r8a7791_register_gpio(5);
+	r8a7791_register_gpio(6);
+	r8a7791_register_gpio(7);
 }
 
 #define SCIF_COMMON(scif_type, baseaddr, irq)			\
-- 
1.8.4
