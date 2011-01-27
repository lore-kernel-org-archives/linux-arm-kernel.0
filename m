From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 27 Jan 2011 12:40:11 +0100
Subject: [PATCH 2/4] ARM i.MX23/28: do not use complicated macros if not
	necessary
In-Reply-To: <1296128413-20778-1-git-send-email-s.hauer@pengutronix.de>
References: <1296128413-20778-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1296128413-20778-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of ## preprocessor construct where it only makes the
code harder to read.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/gpio.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mxs/gpio.c b/arch/arm/mach-mxs/gpio.c
index 36df2d7..8bcb340 100644
--- a/arch/arm/mach-mxs/gpio.c
+++ b/arch/arm/mach-mxs/gpio.c
@@ -287,21 +287,23 @@ int __init mxs_gpio_init(struct mxs_gpio_port *port, int cnt)
 	return 0;
 }
 
-#define DEFINE_MXS_GPIO_PORT(soc, _id)					\
+#define MX23_GPIO_BASE	MX23_IO_ADDRESS(MX23_PINCTRL_BASE_ADDR)
+#define MX28_GPIO_BASE	MX28_IO_ADDRESS(MX28_PINCTRL_BASE_ADDR)
+
+#define DEFINE_MXS_GPIO_PORT(_base, _irq, _id)				\
 	{								\
 		.chip.label = "gpio-" #_id,				\
 		.id = _id,						\
-		.irq = soc ## _INT_GPIO ## _id,				\
-		.base = soc ## _IO_ADDRESS(				\
-				soc ## _PINCTRL ## _BASE_ADDR),		\
+		.irq = _irq,						\
+		.base = _base,						\
 		.virtual_irq_start = MXS_GPIO_IRQ_START + (_id) * 32,	\
 	}
 
 #ifdef CONFIG_SOC_IMX23
 static struct mxs_gpio_port mx23_gpio_ports[] = {
-	DEFINE_MXS_GPIO_PORT(MX23, 0),
-	DEFINE_MXS_GPIO_PORT(MX23, 1),
-	DEFINE_MXS_GPIO_PORT(MX23, 2),
+	DEFINE_MXS_GPIO_PORT(MX23_GPIO_BASE, MX23_INT_GPIO0, 0),
+	DEFINE_MXS_GPIO_PORT(MX23_GPIO_BASE, MX23_INT_GPIO1, 1),
+	DEFINE_MXS_GPIO_PORT(MX23_GPIO_BASE, MX23_INT_GPIO2, 2),
 };
 
 int __init mx23_register_gpios(void)
@@ -312,11 +314,11 @@ int __init mx23_register_gpios(void)
 
 #ifdef CONFIG_SOC_IMX28
 static struct mxs_gpio_port mx28_gpio_ports[] = {
-	DEFINE_MXS_GPIO_PORT(MX28, 0),
-	DEFINE_MXS_GPIO_PORT(MX28, 1),
-	DEFINE_MXS_GPIO_PORT(MX28, 2),
-	DEFINE_MXS_GPIO_PORT(MX28, 3),
-	DEFINE_MXS_GPIO_PORT(MX28, 4),
+	DEFINE_MXS_GPIO_PORT(MX28_GPIO_BASE, MX28_INT_GPIO0, 0),
+	DEFINE_MXS_GPIO_PORT(MX28_GPIO_BASE, MX28_INT_GPIO1, 1),
+	DEFINE_MXS_GPIO_PORT(MX28_GPIO_BASE, MX28_INT_GPIO2, 2),
+	DEFINE_MXS_GPIO_PORT(MX28_GPIO_BASE, MX28_INT_GPIO3, 3),
+	DEFINE_MXS_GPIO_PORT(MX28_GPIO_BASE, MX28_INT_GPIO4, 4),
 };
 
 int __init mx28_register_gpios(void)
-- 
1.7.2.3
