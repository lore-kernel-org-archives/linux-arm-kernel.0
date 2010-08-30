From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:37 +0530
Subject: [PATCH 74/74] ST SPEAr: Enabling devices in various evb.c files
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <7f25ffcaa47aafc0c4c9955cfb60d97b93a30bc9.1283161024.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h   |    6 ++
 arch/arm/mach-spear13xx/include/mach/irqs.h      |   10 +-
 arch/arm/mach-spear13xx/include/mach/spear1310.h |   18 ++++-
 arch/arm/mach-spear13xx/spear1310.c              |   86 ++++++++++++++++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c          |    9 ++
 arch/arm/mach-spear3xx/spear310_evb.c            |    5 +
 arch/arm/mach-spear3xx/spear320_evb.c            |    6 ++
 7 files changed, 134 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 75e9b82..a9160d2 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -257,8 +257,14 @@ void __init spear1300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 /* spear1310 declarations */
 #ifdef CONFIG_MACH_SPEAR1310
 /* Add spear1310 machine device structure declarations here */
+extern struct amba_device spear1310_uart1_device;
+extern struct amba_device spear1310_uart2_device;
+extern struct amba_device spear1310_uart3_device;
+extern struct amba_device spear1310_uart4_device;
+extern struct amba_device spear1310_uart5_device;
 extern struct platform_device spear1310_can0_device;
 extern struct platform_device spear1310_can1_device;
+extern struct platform_device spear1310_i2c1_device;
 
 /* Add spear1310 machine function declarations here */
 void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
index 19ebdf0..1900a63 100644
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -97,11 +97,11 @@
 #define IRQ_CCAN1		(IRQ_SHPI_START + 83)
 #define IRQ_TDM0		(IRQ_SHPI_START + 84)
 #define IRQ_TDM1		(IRQ_SHPI_START + 85)
-#define IRQ_UART0		(IRQ_SHPI_START + 86)
-#define IRQ_UART1		(IRQ_SHPI_START + 87)
-#define IRQ_UART2		(IRQ_SHPI_START + 88)
-#define IRQ_UART3		(IRQ_SHPI_START + 89)
-#define IRQ_UART4		(IRQ_SHPI_START + 90)
+#define IRQ_UART1		(IRQ_SHPI_START + 86)
+#define IRQ_UART2		(IRQ_SHPI_START + 87)
+#define IRQ_UART3		(IRQ_SHPI_START + 88)
+#define IRQ_UART4		(IRQ_SHPI_START + 89)
+#define IRQ_UART5		(IRQ_SHPI_START + 90)
 #define IRQ_I2C_CNTR		(IRQ_SHPI_START + 91)
 #define IRQ_GMAC0_SBD		(IRQ_SHPI_START + 92)
 #define IRQ_GMAC0_PMT		(IRQ_SHPI_START + 93)
diff --git a/arch/arm/mach-spear13xx/include/mach/spear1310.h b/arch/arm/mach-spear13xx/include/mach/spear1310.h
index 5fa69bb..a2b6e55 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear1310.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear1310.h
@@ -16,9 +16,25 @@
 #ifndef __MACH_SPEAR1310_H
 #define __MACH_SPEAR1310_H
 
+#define SPEAR1310_TDM_E1_0_BASE		UL(0x6C200000)
+#define SPEAR1310_TDM_E1_1_BASE		UL(0x6C300000)
+#define SPEAR1310_RS485_0_BASE		UL(0x6C400000)
+#define SPEAR1310_RS485_1_BASE		UL(0x6C500000)
+#define SPEAR1310_RAS_BASE		UL(0x6C800000)
+#define SPEAR1310_GETH1_BASE		UL(0x6D000000)
+#define SPEAR1310_GETH2_BASE		UL(0x6D100000)
+#define SPEAR1310_GETH3_BASE		UL(0x6D200000)
+#define SPEAR1310_GETH4_BASE		UL(0x6D300000)
+#define SPEAR1310_UART1_BASE		UL(0x6D400000)
+#define SPEAR1310_UART2_BASE		UL(0x6D500000)
+#define SPEAR1310_UART3_BASE		UL(0x6D600000)
+#define SPEAR1310_UART4_BASE		UL(0x6D700000)
+#define SPEAR1310_UART5_BASE		UL(0x6D800000)
+#define SPEAR1310_I2C1_BASE		UL(0x6D900000)
 #define SPEAR1310_CAN0_BASE		UL(0x6DA00000)
 #define SPEAR1310_CAN1_BASE		UL(0x6DB00000)
-#define SPEAR1310_RAS_BASE		UL(0x6C800000)
+#define SPEAR1310_FSMC1_MEM_BASE	UL(0x70000000)
+#define SPEAR1310_FSMC1_BASE		UL(0x6FF00000)
 
 /* RAS Area Control Register */
 #define SPEAR1310_RAS_CTRL_REG1		(SPEAR1310_RAS_BASE + 0x4)
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
index 5cadea8..2f7fabc 100644
--- a/arch/arm/mach-spear13xx/spear1310.c
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -325,6 +325,70 @@ struct pmx_dev pmx_can = {
 };
 
 /* Add spear1310 specific devices here */
+/* uart1 device registeration */
+struct amba_device spear1310_uart1_device = {
+	.dev = {
+		.init_name = "uart1",
+	},
+	.res = {
+		.start = SPEAR1310_UART1_BASE,
+		.end = SPEAR1310_UART1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART1, NO_IRQ},
+};
+
+/* uart2 device registeration */
+struct amba_device spear1310_uart2_device = {
+	.dev = {
+		.init_name = "uart2",
+	},
+	.res = {
+		.start = SPEAR1310_UART2_BASE,
+		.end = SPEAR1310_UART2_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART2, NO_IRQ},
+};
+
+/* uart3 device registeration */
+struct amba_device spear1310_uart3_device = {
+	.dev = {
+		.init_name = "uart3",
+	},
+	.res = {
+		.start = SPEAR1310_UART3_BASE,
+		.end = SPEAR1310_UART3_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART3, NO_IRQ},
+};
+
+/* uart4 device registeration */
+struct amba_device spear1310_uart4_device = {
+	.dev = {
+		.init_name = "uart4",
+	},
+	.res = {
+		.start = SPEAR1310_UART4_BASE,
+		.end = SPEAR1310_UART4_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART4, NO_IRQ},
+};
+
+/* uart5 device registeration */
+struct amba_device spear1310_uart5_device = {
+	.dev = {
+		.init_name = "uart5",
+	},
+	.res = {
+		.start = SPEAR1310_UART5_BASE,
+		.end = SPEAR1310_UART5_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_UART5, NO_IRQ},
+};
 
 /* CAN device registeration */
 static struct resource can0_resources[] = {
@@ -363,6 +427,28 @@ struct platform_device spear1310_can1_device = {
 	.resource = can1_resources,
 };
 
+/* i2c1 device registeration */
+static struct resource i2c1_resources[] = {
+	{
+		.start = SPEAR1310_I2C1_BASE,
+		.end = SPEAR1310_I2C1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_I2C_CNTR,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear1310_i2c1_device = {
+	.name = "i2c_designware",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+	},
+	.num_resources = ARRAY_SIZE(i2c1_resources),
+	.resource = i2c1_resources,
+};
+
 void __init spear1310_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 		u8 pmx_dev_count)
 {
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index 6335b88..d1c728d 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -64,7 +64,15 @@ static struct amba_device *amba_devs[] __initdata = {
 	/* spear13xx specific devices */
 	&spear13xx_gpio_device[0],
 	&spear13xx_gpio_device[1],
+	&spear13xx_ssp_device,
 	&spear13xx_uart_device,
+
+	/* spear1310 specific devices */
+	&spear1310_uart1_device,
+	&spear1310_uart2_device,
+	&spear1310_uart3_device,
+	&spear1310_uart4_device,
+	&spear1310_uart5_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
@@ -84,6 +92,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear1310 specific devices */
 	&spear1310_can0_device,
 	&spear1310_can1_device,
+	&spear1310_i2c1_device,
 };
 
 /* keyboard specific platform data */
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 70e473d..3d87d66 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -65,6 +65,11 @@ static struct amba_device *amba_devs[] __initdata = {
 	&spear3xx_wdt_device,
 
 	/* spear310 specific devices */
+	&spear310_uart1_device,
+	&spear310_uart2_device,
+	&spear310_uart3_device,
+	&spear310_uart4_device,
+	&spear310_uart5_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index de161c8..98ab4e6 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -58,11 +58,16 @@ static struct pmx_dev *pmx_devs[] = {
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear3xx specific devices */
 	&spear3xx_gpio_device,
+	&spear3xx_ssp0_device,
 	&spear3xx_uart_device,
 	&spear3xx_wdt_device,
 
 	/* spear320 specific devices */
 	&spear320_clcd_device,
+	&spear320_ssp_device[0],
+	&spear320_ssp_device[1],
+	&spear320_uart1_device,
+	&spear320_uart2_device,
 };
 
 static struct platform_device *plat_devs[] __initdata = {
@@ -77,6 +82,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear320 specific devices */
 	&spear320_can0_device,
 	&spear320_can1_device,
+	&spear320_emi_nor_device,
 	&spear320_i2c1_device,
 	&spear320_nand_device,
 	&spear320_plgpio_device,
-- 
1.7.2.2
