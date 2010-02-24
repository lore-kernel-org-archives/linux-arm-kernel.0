From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:04 +0100
Subject: [PATCH 09/39] arm/mx2: define seperate gpio port descriptions for
	imx21 and imx27
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the gpio ports have different addresses on imx21 and imx27 there are
two different port descriptions needed if not relying on the overloaded
cpp macro IO_ADDRESS.  So some cpp magic is added to minimize code
duplication.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx2/devices.c |   72 ++++++++++++++++++++++++++----------------
 1 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
index cda4ace..a4b809b 100644
--- a/arch/arm/mach-mx2/devices.c
+++ b/arch/arm/mach-mx2/devices.c
@@ -432,36 +432,52 @@ DEFINE_IMX_SSI_DEVICE(0, 1, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 DEFINE_IMX_SSI_DEVICE(1, 2, MX2x_SSI1_BASE_ADDR, MX2x_INT_SSI1);
 
 /* GPIO port description */
-static struct mxc_gpio_port imx_gpio_ports[] = {
-	{
-		.chip.label = "gpio-0",
-		.irq = MX2x_INT_GPIO,
-		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR),
-		.virtual_irq_start = MXC_GPIO_IRQ_START,
-	}, {
-		.chip.label = "gpio-1",
-		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x100),
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
-	}, {
-		.chip.label = "gpio-2",
-		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x200),
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
-	}, {
-		.chip.label = "gpio-3",
-		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x300),
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
-	}, {
-		.chip.label = "gpio-4",
-		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x400),
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 128,
-	}, {
-		.chip.label = "gpio-5",
-		.base = IO_ADDRESS(MX2x_GPIO_BASE_ADDR + 0x500),
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 160,
+#define DEFINE_MXC_GPIO_PORT_IRQ(SOC, n, _irq)				\
+	{								\
+		.chip.label = "gpio-" #n,				\
+		.irq = _irq,						\
+		.base = SOC ## _IO_ADDRESS(MX2x_GPIO_BASE_ADDR +	\
+				n * 0x100),				\
+		.virtual_irq_start = MXC_GPIO_IRQ_START + n * 32,	\
+	}
+
+#define DEFINE_MXC_GPIO_PORT(SOC, n)					\
+	{								\
+		.chip.label = "gpio-" #n,				\
+		.base = SOC ## _IO_ADDRESS(MX2x_GPIO_BASE_ADDR +	\
+				n * 0x100),				\
+		.virtual_irq_start = MXC_GPIO_IRQ_START + n * 32,	\
 	}
-};
+
+#define DEFINE_MXC_GPIO_PORTS(SOC, pfx)					\
+	static struct mxc_gpio_port pfx ## _gpio_ports[] = {		\
+		DEFINE_MXC_GPIO_PORT_IRQ(SOC, 0, SOC ## _INT_GPIO),	\
+		DEFINE_MXC_GPIO_PORT(SOC, 1),				\
+		DEFINE_MXC_GPIO_PORT(SOC, 2),				\
+		DEFINE_MXC_GPIO_PORT(SOC, 3),				\
+		DEFINE_MXC_GPIO_PORT(SOC, 4),				\
+		DEFINE_MXC_GPIO_PORT(SOC, 5),				\
+	}
+
+#ifdef CONFIG_MACH_MX21
+DEFINE_MXC_GPIO_PORTS(MX21, imx21);
+#endif
+
+#ifdef CONFIG_MACH_MX27
+DEFINE_MXC_GPIO_PORTS(MX27, imx27);
+#endif
 
 int __init mxc_register_gpios(void)
 {
-	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
+#ifdef CONFIG_MACH_MX21
+	if (cpu_is_mx21())
+		return mxc_gpio_init(imx21_gpio_ports, ARRAY_SIZE(imx21_gpio_ports));
+	else
+#endif
+#ifdef CONFIG_MACH_MX27
+	if (cpu_is_mx27())
+		return mxc_gpio_init(imx27_gpio_ports, ARRAY_SIZE(imx27_gpio_ports));
+	else
+#endif
+		return 0;
 }
-- 
1.6.6.2
