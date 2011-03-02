From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  2 Mar 2011 12:01:20 +0100
Subject: [PATCH 1/4] ARM i.MX: Move gpio initialization to SoC specific files
In-Reply-To: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
References: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1299063683-24903-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This saves us from soc level dispatching in generic files

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx1.c           |   11 +++-
 arch/arm/mach-imx/mm-imx21.c          |   13 +++-
 arch/arm/mach-imx/mm-imx25.c          |   11 +++-
 arch/arm/mach-imx/mm-imx27.c          |   13 +++-
 arch/arm/mach-mx3/mm.c                |   20 +++++-
 arch/arm/mach-mx5/mm-mx50.c           |   13 +++-
 arch/arm/plat-mxc/gpio.c              |  110 ---------------------------------
 arch/arm/plat-mxc/include/mach/gpio.h |   15 +++++
 8 files changed, 82 insertions(+), 124 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index 378c61b..8613e44 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -23,6 +23,8 @@
 
 #include <mach/common.h>
 #include <mach/hardware.h>
+#include <mach/gpio.h>
+#include <mach/irqs.h>
 
 static struct map_desc imx_io_desc[] __initdata = {
 	imx_map_entry(MX1, IO, MT_DEVICE),
@@ -39,10 +41,15 @@ void __init imx1_init_early(void)
 	mxc_arch_reset_init(MX1_IO_ADDRESS(MX1_WDT_BASE_ADDR));
 }
 
-int imx1_register_gpios(void);
+static struct mxc_gpio_port imx1_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 0, 1, MX1_GPIO_INT_PORTA),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 1, 2, MX1_GPIO_INT_PORTB),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 2, 3, MX1_GPIO_INT_PORTC),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 3, 4, MX1_GPIO_INT_PORTD),
+};
 
 void __init mx1_init_irq(void)
 {
 	mxc_init_irq(MX1_IO_ADDRESS(MX1_AVIC_BASE_ADDR));
-	imx1_register_gpios();
+	mxc_gpio_init(imx1_gpio_ports,	ARRAY_SIZE(imx1_gpio_ports));
 }
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index b6152c6..6027e35 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -24,6 +24,8 @@
 #include <mach/common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
+#include <mach/gpio.h>
+#include <mach/irqs.h>
 
 /* MX21 memory map definition */
 static struct map_desc imx21_io_desc[] __initdata = {
@@ -65,10 +67,17 @@ void __init imx21_init_early(void)
 	mxc_arch_reset_init(MX21_IO_ADDRESS(MX21_WDOG_BASE_ADDR));
 }
 
-int imx21_register_gpios(void);
+static struct mxc_gpio_port imx21_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX21, 0, 1, MX21_INT_GPIO),
+	DEFINE_IMX_GPIO_PORT(MX21, 1, 2),
+	DEFINE_IMX_GPIO_PORT(MX21, 2, 3),
+	DEFINE_IMX_GPIO_PORT(MX21, 3, 4),
+	DEFINE_IMX_GPIO_PORT(MX21, 4, 5),
+	DEFINE_IMX_GPIO_PORT(MX21, 5, 6),
+};
 
 void __init mx21_init_irq(void)
 {
 	mxc_init_irq(MX21_IO_ADDRESS(MX21_AVIC_BASE_ADDR));
-	imx21_register_gpios();
+	mxc_gpio_init(imx21_gpio_ports,	ARRAY_SIZE(imx21_gpio_ports));
 }
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index 09dd8d4..02f7b5c 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -27,6 +27,8 @@
 #include <mach/hardware.h>
 #include <mach/mx25.h>
 #include <mach/iomux-v3.h>
+#include <mach/gpio.h>
+#include <mach/irqs.h>
 
 /*
  * This table defines static virtual address mappings for I/O regions.
@@ -55,11 +57,16 @@ void __init imx25_init_early(void)
 	mxc_arch_reset_init(MX25_IO_ADDRESS(MX25_WDOG_BASE_ADDR));
 }
 
-int imx25_register_gpios(void);
+static struct mxc_gpio_port imx25_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 0, 1, MX25_INT_GPIO1),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 1, 2, MX25_INT_GPIO2),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 2, 3, MX25_INT_GPIO3),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 3, 4, MX25_INT_GPIO4),
+};
 
 void __init mx25_init_irq(void)
 {
 	mxc_init_irq(MX25_IO_ADDRESS(MX25_AVIC_BASE_ADDR));
-	imx25_register_gpios();
+	mxc_gpio_init(imx25_gpio_ports,	ARRAY_SIZE(imx25_gpio_ports));
 }
 
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index bcaa3b6..e172e3e 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -24,6 +24,8 @@
 #include <mach/common.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
+#include <mach/gpio.h>
+#include <mach/irqs.h>
 
 /* MX27 memory map definition */
 static struct map_desc imx27_io_desc[] __initdata = {
@@ -65,10 +67,17 @@ void __init imx27_init_early(void)
 	mxc_arch_reset_init(MX27_IO_ADDRESS(MX27_WDOG_BASE_ADDR));
 }
 
-int imx27_register_gpios(void);
+static struct mxc_gpio_port imx27_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX27, 0, 1, MX27_INT_GPIO),
+	DEFINE_IMX_GPIO_PORT(MX27, 1, 2),
+	DEFINE_IMX_GPIO_PORT(MX27, 2, 3),
+	DEFINE_IMX_GPIO_PORT(MX27, 3, 4),
+	DEFINE_IMX_GPIO_PORT(MX27, 4, 5),
+	DEFINE_IMX_GPIO_PORT(MX27, 5, 6),
+};
 
 void __init mx27_init_irq(void)
 {
 	mxc_init_irq(MX27_IO_ADDRESS(MX27_AVIC_BASE_ADDR));
-	imx27_register_gpios();
+	mxc_gpio_init(imx27_gpio_ports,	ARRAY_SIZE(imx27_gpio_ports));
 }
diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index eefd4cf..54d7174 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -27,6 +27,8 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-v3.h>
+#include <mach/gpio.h>
+#include <mach/irqs.h>
 
 #ifdef CONFIG_SOC_IMX31
 static struct map_desc mx31_io_desc[] __initdata = {
@@ -53,11 +55,16 @@ void __init imx31_init_early(void)
 	mxc_arch_reset_init(MX31_IO_ADDRESS(MX31_WDOG_BASE_ADDR));
 }
 
-int imx31_register_gpios(void);
+static struct mxc_gpio_port imx31_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 0, 1, MX31_INT_GPIO1),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 1, 2, MX31_INT_GPIO2),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 2, 3, MX31_INT_GPIO3),
+};
+
 void __init mx31_init_irq(void)
 {
 	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
-	imx31_register_gpios();
+	mxc_gpio_init(imx31_gpio_ports,	ARRAY_SIZE(imx31_gpio_ports));
 }
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
@@ -82,11 +89,16 @@ void __init imx35_init_early(void)
 	mxc_arch_reset_init(MX35_IO_ADDRESS(MX35_WDOG_BASE_ADDR));
 }
 
-int imx35_register_gpios(void);
+static struct mxc_gpio_port imx35_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 0, 1, MX35_INT_GPIO1),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 1, 2, MX35_INT_GPIO2),
+	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 2, 3, MX35_INT_GPIO3),
+};
+
 void __init mx35_init_irq(void)
 {
 	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
-	imx35_register_gpios();
+	mxc_gpio_init(imx35_gpio_ports,	ARRAY_SIZE(imx35_gpio_ports));
 }
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
diff --git a/arch/arm/mach-mx5/mm-mx50.c b/arch/arm/mach-mx5/mm-mx50.c
index 69b3426..b9c363b 100644
--- a/arch/arm/mach-mx5/mm-mx50.c
+++ b/arch/arm/mach-mx5/mm-mx50.c
@@ -26,6 +26,8 @@
 #include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/iomux-v3.h>
+#include <mach/gpio.h>
+#include <mach/irqs.h>
 
 /*
  * Define the MX50 memory map.
@@ -54,10 +56,17 @@ void __init imx50_init_early(void)
 	mxc_arch_reset_init(MX50_IO_ADDRESS(MX50_WDOG_BASE_ADDR));
 }
 
-int imx50_register_gpios(void);
+static struct mxc_gpio_port imx50_gpio_ports[] = {
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 0, 1, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 1, 2, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 2, 3, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 3, 4, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 4, 5, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 5, 6, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
+};
 
 void __init mx50_init_irq(void)
 {
 	tzic_init_irq(MX50_IO_ADDRESS(MX50_TZIC_BASE_ADDR));
-	imx50_register_gpios();
+	mxc_gpio_init(imx50_gpio_ports,	ARRAY_SIZE(imx50_gpio_ports));
 }
diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index e396df8..57d5985 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -350,113 +350,3 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 
 	return 0;
 }
-
-#define DEFINE_IMX_GPIO_PORT_IRQ_HIGH(soc, _id, _hwid, _irq, _irq_high)	\
-	{								\
-		.chip.label = "gpio-" #_id,				\
-		.irq = _irq,						\
-		.irq_high = _irq_high,					\
-		.base = soc ## _IO_ADDRESS(				\
-				soc ## _GPIO ## _hwid ## _BASE_ADDR),	\
-		.virtual_irq_start = MXC_GPIO_IRQ_START + (_id) * 32,	\
-	}
-
-#define DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, _irq)			\
-	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(soc, _id, _hwid, _irq, 0)
-#define DEFINE_IMX_GPIO_PORT(soc, _id, _hwid)				\
-	DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, 0)
-
-#define DEFINE_REGISTER_FUNCTION(prefix)				\
-int __init prefix ## _register_gpios(void)				\
-{									\
-	return mxc_gpio_init(prefix ## _gpio_ports,			\
-			ARRAY_SIZE(prefix ## _gpio_ports));		\
-}
-
-#if defined(CONFIG_SOC_IMX1)
-static struct mxc_gpio_port imx1_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 0, 1, MX1_GPIO_INT_PORTA),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 1, 2, MX1_GPIO_INT_PORTB),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 2, 3, MX1_GPIO_INT_PORTC),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX1, 3, 4, MX1_GPIO_INT_PORTD),
-};
-
-DEFINE_REGISTER_FUNCTION(imx1)
-
-#endif /* if defined(CONFIG_SOC_IMX1) */
-
-#if defined(CONFIG_SOC_IMX21)
-static struct mxc_gpio_port imx21_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX21, 0, 1, MX21_INT_GPIO),
-	DEFINE_IMX_GPIO_PORT(MX21, 1, 2),
-	DEFINE_IMX_GPIO_PORT(MX21, 2, 3),
-	DEFINE_IMX_GPIO_PORT(MX21, 3, 4),
-	DEFINE_IMX_GPIO_PORT(MX21, 4, 5),
-	DEFINE_IMX_GPIO_PORT(MX21, 5, 6),
-};
-
-DEFINE_REGISTER_FUNCTION(imx21)
-
-#endif /* if defined(CONFIG_SOC_IMX21) */
-
-#if defined(CONFIG_SOC_IMX25)
-static struct mxc_gpio_port imx25_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 0, 1, MX25_INT_GPIO1),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 1, 2, MX25_INT_GPIO2),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 2, 3, MX25_INT_GPIO3),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX25, 3, 4, MX25_INT_GPIO4),
-};
-
-DEFINE_REGISTER_FUNCTION(imx25)
-
-#endif /* if defined(CONFIG_SOC_IMX25) */
-
-#if defined(CONFIG_SOC_IMX27)
-static struct mxc_gpio_port imx27_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX27, 0, 1, MX27_INT_GPIO),
-	DEFINE_IMX_GPIO_PORT(MX27, 1, 2),
-	DEFINE_IMX_GPIO_PORT(MX27, 2, 3),
-	DEFINE_IMX_GPIO_PORT(MX27, 3, 4),
-	DEFINE_IMX_GPIO_PORT(MX27, 4, 5),
-	DEFINE_IMX_GPIO_PORT(MX27, 5, 6),
-};
-
-DEFINE_REGISTER_FUNCTION(imx27)
-
-#endif /* if defined(CONFIG_SOC_IMX27) */
-
-#if defined(CONFIG_SOC_IMX31)
-static struct mxc_gpio_port imx31_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 0, 1, MX31_INT_GPIO1),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 1, 2, MX31_INT_GPIO2),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 2, 3, MX31_INT_GPIO3),
-};
-
-DEFINE_REGISTER_FUNCTION(imx31)
-
-#endif /* if defined(CONFIG_SOC_IMX31) */
-
-#if defined(CONFIG_SOC_IMX35)
-static struct mxc_gpio_port imx35_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 0, 1, MX35_INT_GPIO1),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 1, 2, MX35_INT_GPIO2),
-	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 2, 3, MX35_INT_GPIO3),
-};
-
-DEFINE_REGISTER_FUNCTION(imx35)
-
-#endif /* if defined(CONFIG_SOC_IMX35) */
-
-#if defined(CONFIG_SOC_IMX50)
-static struct mxc_gpio_port imx50_gpio_ports[] = {
-	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 0, 1, MX50_INT_GPIO1_LOW, MX50_INT_GPIO1_HIGH),
-	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 1, 2, MX50_INT_GPIO2_LOW, MX50_INT_GPIO2_HIGH),
-	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 2, 3, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
-	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 3, 4, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
-	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 4, 5, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
-	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(MX50, 5, 6, MX50_INT_GPIO3_LOW, MX50_INT_GPIO3_HIGH),
-};
-
-DEFINE_REGISTER_FUNCTION(imx50)
-
-#endif /* if defined(CONFIG_SOC_IMX50) */
diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 0044e2f..a2747f1 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -46,6 +46,21 @@ struct mxc_gpio_port {
 	spinlock_t lock;
 };
 
+#define DEFINE_IMX_GPIO_PORT_IRQ_HIGH(soc, _id, _hwid, _irq, _irq_high)	\
+	{								\
+		.chip.label = "gpio-" #_id,				\
+		.irq = _irq,						\
+		.irq_high = _irq_high,					\
+		.base = soc ## _IO_ADDRESS(				\
+				soc ## _GPIO ## _hwid ## _BASE_ADDR),	\
+		.virtual_irq_start = MXC_GPIO_IRQ_START + (_id) * 32,	\
+	}
+
+#define DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, _irq)			\
+	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(soc, _id, _hwid, _irq, 0)
+#define DEFINE_IMX_GPIO_PORT(soc, _id, _hwid)				\
+	DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, 0)
+
 int mxc_gpio_init(struct mxc_gpio_port*, int);
 
 #endif
-- 
1.7.2.3
