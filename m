From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:31 +0900
Subject: [PATCH 100/130] ARM: shmobile: r8a7778: add GPIO support
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-101-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch was tested on Bock-W board

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 36 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 0ca5701..1f36ecc 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -24,6 +24,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/platform_device.h>
 #include <linux/irqchip.h>
@@ -94,17 +95,50 @@ static struct resource ether_resources[] = {
 		&sh_tmu##idx##_platform_data,		\
 		sizeof(sh_tmu##idx##_platform_data))
 
-/* PFC */
+/* PFC/GPIO */
 static struct resource pfc_resources[] = {
 	DEFINE_RES_MEM(0xfffc0000, 0x118),
 };
 
+#define R8A7778_GPIO(idx)						\
+static struct resource r8a7778_gpio##idx##_resources[] = {		\
+	DEFINE_RES_MEM(0xffc40000 + 0x1000 * (idx), 0x30),		\
+	DEFINE_RES_IRQ(gic_iid(0x87)),					\
+};									\
+									\
+static struct gpio_rcar_config r8a7778_gpio##idx##_platform_data = {	\
+	.gpio_base	= 32 * (idx),					\
+	.irq_base	= GPIO_IRQ_BASE(idx),				\
+	.number_of_pins	= 32,						\
+	.pctl_name	= "pfc-r8a7778",				\
+}
+
+R8A7778_GPIO(0);
+R8A7778_GPIO(1);
+R8A7778_GPIO(2);
+R8A7778_GPIO(3);
+R8A7778_GPIO(4);
+
+#define r8a7778_register_gpio(idx)				\
+	platform_device_register_resndata(			\
+		&platform_bus, "gpio_rcar", idx,		\
+		r8a7778_gpio##idx##_resources,			\
+		ARRAY_SIZE(r8a7778_gpio##idx##_resources),	\
+		&r8a7778_gpio##idx##_platform_data,		\
+		sizeof(r8a7778_gpio##idx##_platform_data))
+
 void __init r8a7778_pinmux_init(void)
 {
 	platform_device_register_simple(
 		"pfc-r8a7778", -1,
 		pfc_resources,
 		ARRAY_SIZE(pfc_resources));
+
+	r8a7778_register_gpio(0);
+	r8a7778_register_gpio(1);
+	r8a7778_register_gpio(2);
+	r8a7778_register_gpio(3);
+	r8a7778_register_gpio(4);
 }
 
 void __init r8a7778_add_standard_devices(void)
-- 
1.8.2.1
