From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 12:40:10 +0100
Subject: [PATCH 1/4] ARM i.MX23/28: deobfuscate gpio initialization
In-Reply-To: <1296128413-20778-1-git-send-email-s.hauer@pengutronix.de>
References: <1296128413-20778-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296128413-20778-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/gpio.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mxs/gpio.c b/arch/arm/mach-mxs/gpio.c
index d7ad7a6..36df2d7 100644
--- a/arch/arm/mach-mxs/gpio.c
+++ b/arch/arm/mach-mxs/gpio.c
@@ -297,20 +297,17 @@ int __init mxs_gpio_init(struct mxs_gpio_port *port, int cnt)
 		.virtual_irq_start = MXS_GPIO_IRQ_START + (_id) * 32,	\
 	}
 
-#define DEFINE_REGISTER_FUNCTION(prefix)				\
-int __init prefix ## _register_gpios(void)				\
-{									\
-	return mxs_gpio_init(prefix ## _gpio_ports,			\
-			ARRAY_SIZE(prefix ## _gpio_ports));		\
-}
-
 #ifdef CONFIG_SOC_IMX23
 static struct mxs_gpio_port mx23_gpio_ports[] = {
 	DEFINE_MXS_GPIO_PORT(MX23, 0),
 	DEFINE_MXS_GPIO_PORT(MX23, 1),
 	DEFINE_MXS_GPIO_PORT(MX23, 2),
 };
-DEFINE_REGISTER_FUNCTION(mx23)
+
+int __init mx23_register_gpios(void)
+{
+	return mxs_gpio_init(mx23_gpio_ports, ARRAY_SIZE(mx23_gpio_ports));
+}
 #endif
 
 #ifdef CONFIG_SOC_IMX28
@@ -321,5 +318,9 @@ static struct mxs_gpio_port mx28_gpio_ports[] = {
 	DEFINE_MXS_GPIO_PORT(MX28, 3),
 	DEFINE_MXS_GPIO_PORT(MX28, 4),
 };
-DEFINE_REGISTER_FUNCTION(mx28)
+
+int __init mx28_register_gpios(void)
+{
+	return mxs_gpio_init(mx28_gpio_ports, ARRAY_SIZE(mx28_gpio_ports));
+}
 #endif
-- 
1.7.2.3
