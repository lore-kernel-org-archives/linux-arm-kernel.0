From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:03 +0530
Subject: [PATCH 39/74] ST SPEAr: Adding miscellaneous devices and clocks
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <b65f3fded036677e101db1732344c7c0694dec97.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/clock.c                |   87 +++++++++++++++++--
 arch/arm/mach-spear3xx/include/mach/generic.h |    7 ++
 arch/arm/mach-spear3xx/spear310.c             |  115 +++++++++++++++++++------
 arch/arm/mach-spear3xx/spear320.c             |   26 ++++++
 4 files changed, 201 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index 720f04f..2b5d7e1 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -409,13 +409,6 @@ static struct clk usbd_clk = {
 	.recalc = &follow_parent,
 };
 
-/* clcd clock */
-static struct clk clcd_clk = {
-	.flags = ALWAYS_ENABLED,
-	.pclk = &pll3_48m_clk,
-	.recalc = &follow_parent,
-};
-
 /* clock derived from ahb clk */
 /* apb masks structure */
 static struct bus_clk_masks apb_masks = {
@@ -525,8 +518,32 @@ static struct clk fsmc_clk = {
 };
 #endif
 
+/* common clocks to spear310 and spear320 */
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+/* uart1 clock */
+static struct clk uart1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart2 clock */
+static struct clk uart2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+#endif /* CONFIG_MACH_SPEAR310 || CONFIG_MACH_SPEAR320 */
+
 /* common clocks to spear300 and spear320 */
 #if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR320)
+/* clcd clock */
+static struct clk clcd_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &pll3_48m_clk,
+	.recalc = &follow_parent,
+};
+
 /* sdhci clock */
 static struct clk sdhci_clk = {
 	.flags = ALWAYS_ENABLED,
@@ -537,6 +554,13 @@ static struct clk sdhci_clk = {
 
 /* spear300 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR300
+/* gpio1 clock */
+static struct clk gpio1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
 /* keyboard clock */
 static struct clk kbd_clk = {
 	.flags = ALWAYS_ENABLED,
@@ -548,7 +572,26 @@ static struct clk kbd_clk = {
 
 /* spear310 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR310
+/* uart3 clock */
+static struct clk uart3_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart4 clock */
+static struct clk uart4_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
 
+/* uart5 clock */
+static struct clk uart5_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
 #endif
 
 /* spear320 machine specific clock structures */
@@ -560,6 +603,20 @@ static struct clk i2c1_clk = {
 	.recalc = &follow_parent,
 };
 
+/* ssp1 clock */
+static struct clk ssp1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* ssp2 clock */
+static struct clk ssp2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
 /* pwm clock */
 static struct clk pwm_clk = {
 	.flags = ALWAYS_ENABLED,
@@ -596,7 +653,6 @@ static struct clk_lookup spear_clk_lookups[] = {
 	/* clock derived from pll3 clk */
 	{ .con_id = "usbh_clk",		.clk = &usbh_clk},
 	{ .dev_id = "usbd",		.clk = &usbd_clk},
-	{ .dev_id = "clcd",		.clk = &clcd_clk},
 	/* clock derived from ahb clk */
 	{ .con_id = "apb_clk",		.clk = &apb_clk},
 	{ .dev_id = "i2c_designware.0",	.clk = &i2c_clk},
@@ -614,23 +670,36 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{ .con_id = "fsmc",		.clk = &fsmc_clk},
 #endif
 
+/* common clocks to spear310 and spear320 */
+#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
+	{ .dev_id = "uart1",		.clk = &uart1_clk},
+	{ .dev_id = "uart2",		.clk = &uart2_clk},
+#endif
+
 	/* common clock to spear300 and spear320 */
 #if defined(CONFIG_MACH_SPEAR300) || defined(CONFIG_MACH_SPEAR320)
-	{ .dev_id = "sdhci",	.clk = &sdhci_clk},
+	{ .dev_id = "clcd",		.clk = &clcd_clk},
+	{ .dev_id = "sdhci",		.clk = &sdhci_clk},
 #endif /* CONFIG_MACH_SPEAR300 || CONFIG_MACH_SPEAR320 */
 
 	/* spear300 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR300
+	{ .dev_id = "gpio1",		.clk = &gpio1_clk},
 	{ .dev_id = "keyboard",		.clk = &kbd_clk},
 #endif
 
 	/* spear310 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR310
+	{ .dev_id = "uart3",		.clk = &uart3_clk},
+	{ .dev_id = "uart4",		.clk = &uart4_clk},
+	{ .dev_id = "uart5",		.clk = &uart5_clk},
 
 #endif
 	/* spear320 machine specific clock structures */
 #ifdef CONFIG_MACH_SPEAR320
 	{ .dev_id = "i2c_designware.1",	.clk = &i2c1_clk},
+	{ .dev_id = "ssp-pl022.1",	.clk = &ssp1_clk},
+	{ .dev_id = "ssp-pl022.2",	.clk = &ssp2_clk},
 	{ .dev_id = "pwm",		.clk = &pwm_clk},
 #endif
 };
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index ddfc382..2fc36a8 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -162,6 +162,11 @@ extern struct clcd_board clcd_plat_data;
 /* spear310 declarations */
 #elif defined(CONFIG_MACH_SPEAR310)
 /* Add spear310 machine device structure declarations here */
+extern struct amba_device uart1_device;
+extern struct amba_device uart2_device;
+extern struct amba_device uart3_device;
+extern struct amba_device uart4_device;
+extern struct amba_device uart5_device;
 extern struct platform_device plgpio_device;
 extern struct platform_device nand_device;
 
@@ -183,6 +188,8 @@ void __init spear310_init(void);
 /* Add spear320 machine device structure declarations here */
 extern struct amba_device clcd_device;
 extern struct amba_device ssp_device[];
+extern struct amba_device uart1_device;
+extern struct amba_device uart2_device;
 extern struct platform_device i2c1_device;
 extern struct platform_device nand_device;
 extern struct platform_device plgpio_device;
diff --git a/arch/arm/mach-spear3xx/spear310.c b/arch/arm/mach-spear3xx/spear310.c
index b73e2df..29e3c2c 100644
--- a/arch/arm/mach-spear3xx/spear310.c
+++ b/arch/arm/mach-spear3xx/spear310.c
@@ -142,6 +142,96 @@ struct pmx_driver pmx_driver = {
 };
 
 /* Add spear310 specific devices here */
+/* uart1 device registeration */
+struct amba_device uart1_device = {
+	.dev = {
+		.init_name = "uart1",
+	},
+	.res = {
+		.start = SPEAR310_UART1_BASE,
+		.end = SPEAR310_UART1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART1, NO_IRQ},
+};
+
+/* uart2 device registeration */
+struct amba_device uart2_device = {
+	.dev = {
+		.init_name = "uart2",
+	},
+	.res = {
+		.start = SPEAR310_UART2_BASE,
+		.end = SPEAR310_UART2_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART2, NO_IRQ},
+};
+
+/* uart3 device registeration */
+struct amba_device uart3_device = {
+	.dev = {
+		.init_name = "uart3",
+	},
+	.res = {
+		.start = SPEAR310_UART3_BASE,
+		.end = SPEAR310_UART3_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART3, NO_IRQ},
+};
+
+/* uart4 device registeration */
+struct amba_device uart4_device = {
+	.dev = {
+		.init_name = "uart4",
+	},
+	.res = {
+		.start = SPEAR310_UART4_BASE,
+		.end = SPEAR310_UART4_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART4, NO_IRQ},
+};
+
+/* uart5 device registeration */
+struct amba_device uart5_device = {
+	.dev = {
+		.init_name = "uart5",
+	},
+	.res = {
+		.start = SPEAR310_UART5_BASE,
+		.end = SPEAR310_UART5_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART5, NO_IRQ},
+};
+
+/* nand device registeration */
+static struct nand_platform_data nand_platform_data;
+
+static struct resource nand_resources[] = {
+	{
+		.name = "nand_data",
+		.start = SPEAR310_NAND_BASE,
+		.end = SPEAR310_NAND_BASE + SZ_16 - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.name = "fsmc_regs",
+		.start = SPEAR310_FSMC_BASE,
+		.end = SPEAR310_FSMC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device nand_device = {
+	.name = "nand",
+	.id = -1,
+	.resource = nand_resources,
+	.num_resources = ARRAY_SIZE(nand_resources),
+	.dev.platform_data = &nand_platform_data,
+};
+
 /* plgpio device registeration */
 /*
  * pin to offset and offset to pin converter functions
@@ -178,31 +268,6 @@ int spear300_o2p(int offset)
 		return offset + 2;
 }
 
-/* nand device registeration */
-static struct nand_platform_data nand_platform_data;
-
-static struct resource nand_resources[] = {
-	{
-		.name = "nand_data",
-		.start = SPEAR310_NAND_BASE,
-		.end = SPEAR310_NAND_BASE + SZ_16 - 1,
-		.flags = IORESOURCE_MEM,
-	}, {
-		.name = "fsmc_regs",
-		.start = SPEAR310_FSMC_BASE,
-		.end = SPEAR310_FSMC_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device nand_device = {
-	.name = "nand",
-	.id = -1,
-	.resource = nand_resources,
-	.num_resources = ARRAY_SIZE(nand_resources),
-	.dev.platform_data = &nand_platform_data,
-};
-
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
 	.irq_base = SPEAR_PLGPIO_INT_BASE,
diff --git a/arch/arm/mach-spear3xx/spear320.c b/arch/arm/mach-spear3xx/spear320.c
index 7a2e07c..3fbb1f6 100644
--- a/arch/arm/mach-spear3xx/spear320.c
+++ b/arch/arm/mach-spear3xx/spear320.c
@@ -447,6 +447,32 @@ struct amba_device ssp_device[] = {
 	}
 };
 
+/* uart1 device registeration */
+struct amba_device uart1_device = {
+	.dev = {
+		.init_name = "uart1",
+	},
+	.res = {
+		.start = SPEAR320_UART1_BASE,
+		.end = SPEAR320_UART1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART1, NO_IRQ},
+};
+
+/* uart2 device registeration */
+struct amba_device uart2_device = {
+	.dev = {
+		.init_name = "uart2",
+	},
+	.res = {
+		.start = SPEAR320_UART2_BASE,
+		.end = SPEAR320_UART2_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {VIRQ_UART2, NO_IRQ},
+};
+
 /* plgpio device registeration */
 static struct plgpio_platform_data plgpio_plat_data = {
 	.gpio_base = 8,
-- 
1.7.2.2
