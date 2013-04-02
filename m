From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:09:21 +0900
Subject: [PATCH 13/28] ARM: shmobile: r8a7779: Register GPIO devices
In-Reply-To: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879376-10020-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879376-10020-14-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Move GPIOs handling from the PFC device to separate GPIO devices.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |   58 ++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 042df35..a460ba3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/input.h>
@@ -68,11 +69,6 @@ static struct resource r8a7779_pfc_resources[] = {
 		.end	= 0xfffc023b,
 		.flags	= IORESOURCE_MEM,
 	},
-	[1] = {
-		.start	= 0xffc40000,
-		.end	= 0xffc46fff,
-		.flags	= IORESOURCE_MEM,
-	}
 };
 
 static struct platform_device r8a7779_pfc_device = {
@@ -82,9 +78,59 @@ static struct platform_device r8a7779_pfc_device = {
 	.num_resources	= ARRAY_SIZE(r8a7779_pfc_resources),
 };
 
+#define R8A7779_GPIO(idx, npins) \
+static struct resource r8a7779_gpio##idx##_resources[] = {		\
+	[0] = {								\
+		.start	= 0xffc40000 + 0x1000 * (idx),			\
+		.end	= 0xffc4002b + 0x1000 * (idx),			\
+		.flags	= IORESOURCE_MEM,				\
+	},								\
+	[1] = {								\
+		.start	= gic_iid(0xad + (idx)),			\
+		.flags	= IORESOURCE_IRQ,				\
+	}								\
+};									\
+									\
+static struct gpio_rcar_config r8a7779_gpio##idx##_platform_data = {	\
+	.gpio_base	= 32 * (idx),					\
+	.irq_base	= 0,						\
+	.number_of_pins	= npins,					\
+	.pctl_name	= "pfc-r8a7779",				\
+};									\
+									\
+static struct platform_device r8a7779_gpio##idx##_device = {		\
+	.name		= "gpio_rcar",					\
+	.id		= idx,						\
+	.resource	= r8a7779_gpio##idx##_resources,		\
+	.num_resources	= ARRAY_SIZE(r8a7779_gpio##idx##_resources),	\
+	.dev		= {						\
+		.platform_data	= &r8a7779_gpio##idx##_platform_data,	\
+	},								\
+}
+
+R8A7779_GPIO(0, 32);
+R8A7779_GPIO(1, 32);
+R8A7779_GPIO(2, 32);
+R8A7779_GPIO(3, 32);
+R8A7779_GPIO(4, 32);
+R8A7779_GPIO(5, 32);
+R8A7779_GPIO(6, 9);
+
+static struct platform_device *r8a7779_pinctrl_devices[] __initdata = {
+	&r8a7779_pfc_device,
+	&r8a7779_gpio0_device,
+	&r8a7779_gpio1_device,
+	&r8a7779_gpio2_device,
+	&r8a7779_gpio3_device,
+	&r8a7779_gpio4_device,
+	&r8a7779_gpio5_device,
+	&r8a7779_gpio6_device,
+};
+
 void __init r8a7779_pinmux_init(void)
 {
-	platform_device_register(&r8a7779_pfc_device);
+	platform_add_devices(r8a7779_pinctrl_devices,
+			    ARRAY_SIZE(r8a7779_pinctrl_devices));
 }
 
 static struct plat_sci_port scif0_platform_data = {
-- 
1.7.10.4
