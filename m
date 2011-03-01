From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:12 +0530
Subject: [PATCH V6 6/8] ST SPEAr: Replacing SIZE macro's with SZ_4K macros
In-Reply-To: <cover.1298977691.git.viresh.kumar@st.com>
References: <cover.1298977691.git.viresh.kumar@st.com>
Message-ID: <eead81c52eaac14d6d2daa5eeb3b680ebcc1edf7.1298977691.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resource size required mostly is 4K for all devices, whereas currently
reserved space is much beyond that. This patch replaces SIZE macro's used at
multiple places with SZ_4K.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear3xx/spear300.c |    8 +++-----
 arch/arm/mach-spear3xx/spear310.c |    2 +-
 arch/arm/mach-spear3xx/spear320.c |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c |   12 ++++++------
 arch/arm/mach-spear6xx/spear6xx.c |   25 ++++++++++---------------
 5 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 23d2a14..2697e65 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -437,7 +437,7 @@ struct amba_device gpio1_device = {
 	},
 	.res = {
 		.start = SPEAR300_GPIO_BASE,
-		.end = SPEAR300_GPIO_BASE + SPEAR300_GPIO_SIZE - 1,
+		.end = SPEAR300_GPIO_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {VIRQ_GPIO1, NO_IRQ},
@@ -452,8 +452,7 @@ void __init spear300_init(void)
 	spear3xx_init();
 
 	/* shared irq registration */
-	shirq_ras1.regs.base =
-		ioremap(SPEAR300_TELECOM_BASE, SPEAR300_TELECOM_REG_SIZE);
+	shirq_ras1.regs.base = ioremap(SPEAR300_TELECOM_BASE, SZ_4K);
 	if (shirq_ras1.regs.base) {
 		ret = spear_shirq_register(&shirq_ras1);
 		if (ret)
@@ -461,8 +460,7 @@ void __init spear300_init(void)
 	}
 
 	/* pmx initialization */
-	pmx_driver.base = ioremap(SPEAR300_SOC_CONFIG_BASE,
-			SPEAR300_SOC_CONFIG_SIZE);
+	pmx_driver.base = ioremap(SPEAR300_SOC_CONFIG_BASE, SZ_4K);
 	if (pmx_driver.base) {
 		ret = pmx_register(&pmx_driver);
 		if (ret)
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index 3a3d548..5c0a67b 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -267,7 +267,7 @@ void __init spear310_init(void)
 	spear3xx_init();
 
 	/* shared irq registration */
-	base = ioremap(SPEAR310_SOC_CONFIG_BASE, SPEAR310_SOC_CONFIG_SIZE);
+	base = ioremap(SPEAR310_SOC_CONFIG_BASE, SZ_4K);
 	if (base) {
 		/* shirq 1 */
 		shirq_ras1.regs.base = base;
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 8ba3ff2..741c1f4 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -520,7 +520,7 @@ void __init spear320_init(void)
 	spear3xx_init();
 
 	/* shared irq registration */
-	base = ioremap(SPEAR320_SOC_CONFIG_BASE, SPEAR320_SOC_CONFIG_SIZE);
+	base = ioremap(SPEAR320_SOC_CONFIG_BASE, SZ_4K);
 	if (base) {
 		/* shirq 1 */
 		shirq_ras1.regs.base = base;
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 634116f..d3ba8ca 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -35,7 +35,7 @@ struct amba_device gpio_device = {
 	},
 	.res = {
 		.start = SPEAR3XX_ICM3_GPIO_BASE,
-		.end = SPEAR3XX_ICM3_GPIO_BASE + SPEAR3XX_ICM3_GPIO_SIZE - 1,
+		.end = SPEAR3XX_ICM3_GPIO_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {IRQ_BASIC_GPIO, NO_IRQ},
@@ -48,7 +48,7 @@ struct amba_device uart_device = {
 	},
 	.res = {
 		.start = SPEAR3XX_ICM1_UART_BASE,
-		.end = SPEAR3XX_ICM1_UART_BASE + SPEAR3XX_ICM1_UART_SIZE - 1,
+		.end = SPEAR3XX_ICM1_UART_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	.irq = {IRQ_UART, NO_IRQ},
@@ -71,22 +71,22 @@ struct map_desc spear3xx_io_desc[] __initdata = {
 	{
 		.virtual	= VA_SPEAR3XX_ICM1_UART_BASE,
 		.pfn		= __phys_to_pfn(SPEAR3XX_ICM1_UART_BASE),
-		.length		= SPEAR3XX_ICM1_UART_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR3XX_ML1_VIC_BASE,
 		.pfn		= __phys_to_pfn(SPEAR3XX_ML1_VIC_BASE),
-		.length		= SPEAR3XX_ML1_VIC_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR3XX_ICM3_SYS_CTRL_BASE,
 		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_SYS_CTRL_BASE),
-		.length		= SPEAR3XX_ICM3_SYS_CTRL_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR3XX_ICM3_MISC_REG_BASE,
 		.pfn		= __phys_to_pfn(SPEAR3XX_ICM3_MISC_REG_BASE),
-		.length		= SPEAR3XX_ICM3_MISC_REG_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	},
 };
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 378440b..9818129 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -31,8 +31,7 @@ struct amba_device uart_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM1_UART0_BASE,
-			.end = SPEAR6XX_ICM1_UART0_BASE +
-				SPEAR6XX_ICM1_UART0_SIZE - 1,
+			.end = SPEAR6XX_ICM1_UART0_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_UART_0, NO_IRQ},
@@ -42,8 +41,7 @@ struct amba_device uart_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM1_UART1_BASE,
-			.end = SPEAR6XX_ICM1_UART1_BASE +
-				SPEAR6XX_ICM1_UART1_SIZE - 1,
+			.end = SPEAR6XX_ICM1_UART1_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_UART_1, NO_IRQ},
@@ -72,8 +70,7 @@ struct amba_device gpio_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_CPU_GPIO_BASE,
-			.end = SPEAR6XX_CPU_GPIO_BASE +
-				SPEAR6XX_CPU_GPIO_SIZE - 1,
+			.end = SPEAR6XX_CPU_GPIO_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_LOCAL_GPIO, NO_IRQ},
@@ -84,8 +81,7 @@ struct amba_device gpio_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM3_GPIO_BASE,
-			.end = SPEAR6XX_ICM3_GPIO_BASE +
-				SPEAR6XX_ICM3_GPIO_SIZE - 1,
+			.end = SPEAR6XX_ICM3_GPIO_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_BASIC_GPIO, NO_IRQ},
@@ -96,8 +92,7 @@ struct amba_device gpio_device[] = {
 		},
 		.res = {
 			.start = SPEAR6XX_ICM2_GPIO_BASE,
-			.end = SPEAR6XX_ICM2_GPIO_BASE +
-				SPEAR6XX_ICM2_GPIO_SIZE - 1,
+			.end = SPEAR6XX_ICM2_GPIO_BASE + SZ_4K - 1,
 			.flags = IORESOURCE_MEM,
 		},
 		.irq = {IRQ_APPL_GPIO, NO_IRQ},
@@ -122,27 +117,27 @@ static struct map_desc spear6xx_io_desc[] __initdata = {
 	{
 		.virtual	= VA_SPEAR6XX_ICM1_UART0_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_ICM1_UART0_BASE),
-		.length		= SPEAR6XX_ICM1_UART0_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR6XX_CPU_VIC_PRI_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_CPU_VIC_PRI_BASE),
-		.length		= SPEAR6XX_CPU_VIC_PRI_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR6XX_CPU_VIC_SEC_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_CPU_VIC_SEC_BASE),
-		.length		= SPEAR6XX_CPU_VIC_SEC_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR6XX_ICM3_SYS_CTRL_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_SYS_CTRL_BASE),
-		.length		= SPEAR6XX_ICM3_MISC_REG_BASE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	}, {
 		.virtual	= VA_SPEAR6XX_ICM3_MISC_REG_BASE,
 		.pfn		= __phys_to_pfn(SPEAR6XX_ICM3_MISC_REG_BASE),
-		.length		= SPEAR6XX_ICM3_MISC_REG_SIZE,
+		.length		= SZ_4K,
 		.type		= MT_DEVICE
 	},
 };
-- 
1.7.2.2
