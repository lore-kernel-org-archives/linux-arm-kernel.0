From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:59 +0100
Subject: [PATCH 31/51] ARM: mx25: move registration of gpios to plat-mxc/gpio.c
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-31-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To use common macros to define the gpio ports for imx{1,21,25,27} the
existing ones had to made more general and a few more base address defines
were necessary.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/devices.c          |   29 ----------------
 arch/arm/plat-mxc/gpio.c              |   58 ++++++++++++++++++++-------------
 arch/arm/plat-mxc/include/mach/mx1.h  |    4 ++
 arch/arm/plat-mxc/include/mach/mx21.h |    6 +++
 arch/arm/plat-mxc/include/mach/mx25.h |    4 ++
 arch/arm/plat-mxc/include/mach/mx27.h |    6 +++
 6 files changed, 55 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 13a3c280..1798be9 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -41,35 +41,6 @@ struct platform_device mxc_keypad_device = {
 	.resource = mxc_keypad_resources,
 };
 
-static struct mxc_gpio_port imx_gpio_ports[] = {
-	{
-		.chip.label = "gpio-0",
-		.base = MX25_IO_ADDRESS(MX25_GPIO1_BASE_ADDR),
-		.irq = 52,
-		.virtual_irq_start = MXC_GPIO_IRQ_START,
-	}, {
-		.chip.label = "gpio-1",
-		.base = MX25_IO_ADDRESS(MX25_GPIO2_BASE_ADDR),
-		.irq = 51,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
-	}, {
-		.chip.label = "gpio-2",
-		.base = MX25_IO_ADDRESS(MX25_GPIO3_BASE_ADDR),
-		.irq = 16,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
-	}, {
-		.chip.label = "gpio-3",
-		.base = MX25_IO_ADDRESS(MX25_GPIO4_BASE_ADDR),
-		.irq = 23,
-		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
-	}
-};
-
-int __init imx25_register_gpios(void)
-{
-	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
-}
-
 static struct resource mx25_rtc_resources[] = {
 	{
 		.start	= MX25_DRYICE_BASE_ADDR,
diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 2c00d9b..e59fb97 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -350,17 +350,17 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 	return 0;
 }
 
-#define DEFINE_IMX_GPIO_PORT_IRQ(soc, n, _irq)				\
+#define DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, _irq)			\
 	{								\
-		.chip.label = "gpio-" #n,				\
+		.chip.label = "gpio-" #_id,				\
 		.irq = _irq,						\
-		.base = soc ## _IO_ADDRESS(soc ## _GPIO_BASE_ADDR +	\
-				(n) * SZ_256),				\
-		.virtual_irq_start = MXC_GPIO_IRQ_START + (n) * 32,	\
+		.base = soc ## _IO_ADDRESS(				\
+				soc ## _GPIO ## _hwid ## _BASE_ADDR),	\
+		.virtual_irq_start = MXC_GPIO_IRQ_START + (_id) * 32,	\
 	}
 
-#define DEFINE_IMX_GPIO_PORT(soc, n)					\
-	DEFINE_IMX_GPIO_PORT_IRQ(soc, n, 0)
+#define DEFINE_IMX_GPIO_PORT(soc, _id, _hwid)				\
+	DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, 0)
 
 #define DEFINE_REGISTER_FUNCTION(prefix)				\
 int __init prefix ## _register_gpios(void)				\
@@ -371,10 +371,10 @@ int __init prefix ## _register_gpios(void)				\
 
 #if defined(CONFIG_SOC_IMX1)
 static struct mxc_gpio_port imx1_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 0, MX1_GPIO_INT_PORTA),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 1, MX1_GPIO_INT_PORTB),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 2, MX1_GPIO_INT_PORTC),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 3, MX1_GPIO_INT_PORTD),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 0, 1, MX1_GPIO_INT_PORTA),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 1, 2, MX1_GPIO_INT_PORTB),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 2, 3, MX1_GPIO_INT_PORTC),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 3, 4, MX1_GPIO_INT_PORTD),
 };
 
 DEFINE_REGISTER_FUNCTION(imx1)
@@ -383,26 +383,38 @@ DEFINE_REGISTER_FUNCTION(imx1)
 
 #if defined(CONFIG_SOC_IMX21)
 static struct mxc_gpio_port imx21_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX21, 0, MX21_INT_GPIO),
-	DEFINE_IMX_GPIO_PORT(MX21, 1),
-	DEFINE_IMX_GPIO_PORT(MX21, 2),
-	DEFINE_IMX_GPIO_PORT(MX21, 3),
-	DEFINE_IMX_GPIO_PORT(MX21, 4),
-	DEFINE_IMX_GPIO_PORT(MX21, 5),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX21, 0, 1, MX21_INT_GPIO),
+	DEFINE_IMX_GPIO_PORT(MX21, 1, 2),
+	DEFINE_IMX_GPIO_PORT(MX21, 2, 3),
+	DEFINE_IMX_GPIO_PORT(MX21, 3, 4),
+	DEFINE_IMX_GPIO_PORT(MX21, 4, 5),
+	DEFINE_IMX_GPIO_PORT(MX21, 5, 6),
 };
 
 DEFINE_REGISTER_FUNCTION(imx21)
 
 #endif /* if defined(CONFIG_SOC_IMX21) */
 
+#if defined(CONFIG_ARCH_MX25)
+static struct mxc_gpio_port imx25_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 0, 1, MX25_INT_GPIO1),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 1, 2, MX25_INT_GPIO2),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 2, 3, MX25_INT_GPIO3),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 3, 4, MX25_INT_GPIO4),
+};
+
+DEFINE_REGISTER_FUNCTION(imx25)
+
+#endif /* if defined(CONFIG_ARCH_MX25) */
+
 #if defined(CONFIG_SOC_IMX27)
 static struct mxc_gpio_port imx27_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX27, 0, MX27_INT_GPIO),
-	DEFINE_IMX_GPIO_PORT(MX27, 1),
-	DEFINE_IMX_GPIO_PORT(MX27, 2),
-	DEFINE_IMX_GPIO_PORT(MX27, 3),
-	DEFINE_IMX_GPIO_PORT(MX27, 4),
-	DEFINE_IMX_GPIO_PORT(MX27, 5),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX27, 0, 1, MX27_INT_GPIO),
+	DEFINE_IMX_GPIO_PORT(MX27, 1, 2),
+	DEFINE_IMX_GPIO_PORT(MX27, 2, 3),
+	DEFINE_IMX_GPIO_PORT(MX27, 3, 4),
+	DEFINE_IMX_GPIO_PORT(MX27, 4, 5),
+	DEFINE_IMX_GPIO_PORT(MX27, 5, 6),
 };
 
 DEFINE_REGISTER_FUNCTION(imx27)
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index f1e336e..75d9621 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -65,6 +65,10 @@
 #define MX1_CCM_BASE_ADDR		(0x1B000 + MX1_IO_BASE_ADDR)
 #define MX1_SCM_BASE_ADDR		(0x1B804 + MX1_IO_BASE_ADDR)
 #define MX1_GPIO_BASE_ADDR		(0x1C000 + MX1_IO_BASE_ADDR)
+#define MX1_GPIO1_BASE_ADDR		(0x1C000 + MX1_IO_BASE_ADDR)
+#define MX1_GPIO2_BASE_ADDR		(0x1C100 + MX1_IO_BASE_ADDR)
+#define MX1_GPIO3_BASE_ADDR		(0x1C200 + MX1_IO_BASE_ADDR)
+#define MX1_GPIO4_BASE_ADDR		(0x1C300 + MX1_IO_BASE_ADDR)
 #define MX1_EIM_BASE_ADDR		(0x20000 + MX1_IO_BASE_ADDR)
 #define MX1_SDRAMC_BASE_ADDR		(0x21000 + MX1_IO_BASE_ADDR)
 #define MX1_MMA_BASE_ADDR		(0x22000 + MX1_IO_BASE_ADDR)
diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/plat-mxc/include/mach/mx21.h
index a82f590..6cd049e 100644
--- a/arch/arm/plat-mxc/include/mach/mx21.h
+++ b/arch/arm/plat-mxc/include/mach/mx21.h
@@ -48,6 +48,12 @@
 #define MX21_SDHC1_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x13000)
 #define MX21_SDHC2_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x14000)
 #define MX21_GPIO_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x15000)
+#define MX21_GPIO1_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x000)
+#define MX21_GPIO2_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x100)
+#define MX21_GPIO3_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x200)
+#define MX21_GPIO4_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x300)
+#define MX21_GPIO5_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x400)
+#define MX21_GPIO6_BASE_ADDR			(MX21_GPIO_BASE_ADDR + 0x500)
 #define MX21_AUDMUX_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x16000)
 #define MX21_CSPI3_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x17000)
 #define MX21_LCDC_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x21000)
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index cea851f..024bebe 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -66,8 +66,10 @@
 #define MX25_INT_SSI1		12
 #define MX25_INT_CSPI2		13
 #define MX25_INT_CSPI1		14
+#define MX25_INT_GPIO3		16
 #define MX25_INT_CSI		17
 #define MX25_INT_UART3		18
+#define MX25_INT_GPIO4		23
 #define MX25_INT_KPP		24
 #define MX25_INT_DRYICE		25
 #define MX25_INT_PWM1		26
@@ -84,6 +86,8 @@
 #define MX25_INT_CAN1		43
 #define MX25_INT_CAN2		44
 #define MX25_INT_UART1		45
+#define MX25_INT_GPIO2		51
+#define MX25_INT_GPIO1		52
 #define MX25_INT_FEC		57
 
 #define MX25_DMA_REQ_SSI2_RX1	22
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index 45419b3..eb09ec0 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -51,6 +51,12 @@
 #define MX27_SDHC1_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x13000)
 #define MX27_SDHC2_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x14000)
 #define MX27_GPIO_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x15000)
+#define MX27_GPIO1_BASE_ADDR			(MX27_GPIO_BASE_ADDR + 0x000)
+#define MX27_GPIO2_BASE_ADDR			(MX27_GPIO_BASE_ADDR + 0x100)
+#define MX27_GPIO3_BASE_ADDR			(MX27_GPIO_BASE_ADDR + 0x200)
+#define MX27_GPIO4_BASE_ADDR			(MX27_GPIO_BASE_ADDR + 0x300)
+#define MX27_GPIO5_BASE_ADDR			(MX27_GPIO_BASE_ADDR + 0x400)
+#define MX27_GPIO6_BASE_ADDR			(MX27_GPIO_BASE_ADDR + 0x500)
 #define MX27_AUDMUX_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x16000)
 #define MX27_CSPI3_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x17000)
 #define MX27_MSHC_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x18000)
-- 
1.7.2.3
