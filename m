From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:09 +0530
Subject: [PATCH V6 09/10] ST SPEAr13xx: Adding support for SPEAr1310
In-Reply-To: <cover.1298977719.git.viresh.kumar@st.com>
References: <cover.1298977719.git.viresh.kumar@st.com>
Message-ID: <7146aa384acb44b9782eba719b1bd703ef1e613d.1298977719.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bhupesh Sharma <bhupesh.sharma@st.com>

This patch adds support for SPEAr1310 Machine and evaluation board.

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Reviewed-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Makefile                                |    1 +
 arch/arm/configs/spear13xx_defconfig             |    1 +
 arch/arm/mach-spear13xx/Kconfig                  |   11 ++
 arch/arm/mach-spear13xx/Makefile                 |    6 +
 arch/arm/mach-spear13xx/clock.c                  |  154 ++++++++++++++++++++++
 arch/arm/mach-spear13xx/include/mach/generic.h   |   17 +++
 arch/arm/mach-spear13xx/include/mach/irqs.h      |   37 +++++
 arch/arm/mach-spear13xx/include/mach/spear.h     |    1 +
 arch/arm/mach-spear13xx/include/mach/spear1310.h |   64 +++++++++
 arch/arm/mach-spear13xx/spear1310.c              |  144 ++++++++++++++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c          |   61 +++++++++
 11 files changed, 497 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1310.h
 create mode 100644 arch/arm/mach-spear13xx/spear1310.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310_evb.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f4f3021..4b25e69 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -194,6 +194,7 @@ machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_ARCH_NUC93X)		:= nuc93x
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
 machine-$(CONFIG_MACH_SPEAR1300)	:= spear13xx
+machine-$(CONFIG_MACH_SPEAR1310)	:= spear13xx
 machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 10b1cf5..9f3baf8 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -9,6 +9,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR13XX=y
 CONFIG_BOARD_SPEAR1300_EVB=y
+CONFIG_BOARD_SPEAR1310_EVB=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_AEABI=y
diff --git a/arch/arm/mach-spear13xx/Kconfig b/arch/arm/mach-spear13xx/Kconfig
index 3ea463d..229ef93 100644
--- a/arch/arm/mach-spear13xx/Kconfig
+++ b/arch/arm/mach-spear13xx/Kconfig
@@ -11,6 +11,12 @@ config BOARD_SPEAR1300_EVB
 	help
 	  Supports ST SPEAr1300 Evaluation Board
 
+config BOARD_SPEAR1310_EVB
+	bool "SPEAr1310 Evaluation Board"
+	select MACH_SPEAR1310
+	help
+	  Supports ST SPEAr1310 Evaluation Board
+
 endmenu
 
 config MACH_SPEAR1300
@@ -18,4 +24,9 @@ config MACH_SPEAR1300
 	help
 	  Supports ST SPEAr1300 Machine
 
+config MACH_SPEAR1310
+	bool "SPEAr1310"
+	help
+	  Supports ST SPEAr1310 Machine
+
 endif #ARCH_SPEAR13XX
diff --git a/arch/arm/mach-spear13xx/Makefile b/arch/arm/mach-spear13xx/Makefile
index 09b71e4..24bbe16 100644
--- a/arch/arm/mach-spear13xx/Makefile
+++ b/arch/arm/mach-spear13xx/Makefile
@@ -13,3 +13,9 @@ obj-$(CONFIG_MACH_SPEAR1300)		+= spear1300.o
 
 # spear1300 boards files
 obj-$(CONFIG_BOARD_SPEAR1300_EVB)	+= spear1300_evb.o
+
+# spear1310 specific files
+obj-$(CONFIG_MACH_SPEAR1310)		+= spear1310.o
+
+# spear1310 boards files
+obj-$(CONFIG_BOARD_SPEAR1310_EVB)	+= spear1310_evb.o
diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 58d3ec0..008749a 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -896,6 +896,136 @@ static struct clk ras_tx50_clk = {
 
 #endif
 
+/* spear1310 machine specific clock structures */
+#ifdef CONFIG_MACH_SPEAR1310
+/* can0 clock */
+static struct clk can0_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* can1 clock */
+static struct clk can1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &apb_clk,
+	.recalc = &follow_parent,
+};
+
+/* gmac clocks :RAS part*/
+static struct clk gmac_ras1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_aclk_clk,
+	.recalc = &follow_parent,
+};
+
+static struct clk gmac_ras2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_aclk_clk,
+	.recalc = &follow_parent,
+};
+
+static struct clk gmac_ras3_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_aclk_clk,
+	.recalc = &follow_parent,
+};
+
+static struct clk gmac_ras4_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_aclk_clk,
+	.recalc = &follow_parent,
+};
+
+/* phy clock parent select */
+static struct pclk_info phy_pclk_info[] = {
+	{
+		.pclk = &ras_pll2_clk,
+		.pclk_val = 0x8,
+	}, {
+		.pclk = &ras_tx125_clk,
+		.pclk_val = 0x4,
+	}, {
+		.pclk = &ras_tx50_clk,
+		.pclk_val = 0x0,
+	},
+};
+
+static struct pclk_sel phy_pclk_sel = {
+	.pclk_info = phy_pclk_info,
+	.pclk_count = ARRAY_SIZE(phy_pclk_info),
+	.pclk_sel_reg = IOMEM(IO_ADDRESS(SPEAR1310_RAS_CTRL_REG1)),
+	.pclk_sel_mask = SPEAR1310_PHY_CLK_MASK,
+};
+
+/* Phy 1 Clock */
+struct clk gmac_phy1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &phy_pclk_sel,
+	.pclk_sel_shift = SPEAR1310_PHY_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* Phy 2 Clock */
+static struct clk gmac_phy2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &phy_pclk_sel,
+	.pclk_sel_shift = SPEAR1310_PHY_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* Phy 3 Clock */
+static struct clk gmac_phy3_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &phy_pclk_sel,
+	.pclk_sel_shift = SPEAR1310_PHY_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* Phy 4 Clock */
+static struct clk gmac_phy4_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk_sel = &phy_pclk_sel,
+	.pclk_sel_shift = SPEAR1310_PHY_CLK_SHIFT,
+	.recalc = &follow_parent,
+};
+
+/* uart1 clock */
+static struct clk uart1_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart2 clock */
+static struct clk uart2_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart3 clock */
+static struct clk uart3_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart4 clock */
+static struct clk uart4_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
+
+/* uart5 clock */
+static struct clk uart5_clk = {
+	.flags = ALWAYS_ENABLED,
+	.pclk = &ras_pclk_clk,
+	.recalc = &follow_parent,
+};
+#endif
+
 static struct clk dummy_apb_pclk;
 
 /* array of all spear 13xx clock lookups */
@@ -993,6 +1123,27 @@ static struct clk_lookup spear1300_clk_lookups[] = {
 };
 #endif
 
+/* array of all spear 1310 clock lookups */
+#ifdef CONFIG_MACH_SPEAR1310
+static struct clk_lookup spear1310_clk_lookups[] = {
+	{.dev_id = "c_can_platform.0",	.clk = &can0_clk},
+	{.dev_id = "c_can_platform.1",	.clk = &can1_clk},
+	{.dev_id = "stmmaceth.1",	.clk = &gmac_ras1_clk},
+	{.dev_id = "stmmaceth.2",	.clk = &gmac_ras2_clk},
+	{.dev_id = "stmmaceth.3",	.clk = &gmac_ras3_clk},
+	{.dev_id = "stmmaceth.4",	.clk = &gmac_ras4_clk},
+	{.dev_id = "stmmacphy.1",	.clk = &gmac_phy1_clk},
+	{.dev_id = "stmmacphy.2",	.clk = &gmac_phy2_clk},
+	{.dev_id = "stmmacphy.3",	.clk = &gmac_phy3_clk},
+	{.dev_id = "stmmacphy.4",	.clk = &gmac_phy4_clk},
+	{.dev_id = "uart1",		.clk = &uart1_clk},
+	{.dev_id = "uart2",		.clk = &uart2_clk},
+	{.dev_id = "uart3",		.clk = &uart3_clk},
+	{.dev_id = "uart4",		.clk = &uart4_clk},
+	{.dev_id = "uart5",		.clk = &uart5_clk},
+};
+#endif
+
 void __init spear13xx_clk_init(void)
 {
 	int i, cnt;
@@ -1001,6 +1152,9 @@ void __init spear13xx_clk_init(void)
 	if (machine_is_spear1300()) {
 		cnt = ARRAY_SIZE(spear1300_clk_lookups);
 		lookups = spear1300_clk_lookups;
+	} else {
+		cnt = ARRAY_SIZE(spear1310_clk_lookups);
+		lookups = spear1310_clk_lookups;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(spear_clk_lookups); i++)
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 781894e..64feaa5 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -47,4 +47,21 @@ void __init spear1300_init(void);
 
 #endif /* CONFIG_MACH_SPEAR1300 */
 
+/* spear1310 declarations */
+#ifdef CONFIG_MACH_SPEAR1310
+/* Add spear1310 machine device structure declarations here */
+extern struct amba_device spear1310_uart1_device;
+extern struct amba_device spear1310_uart2_device;
+extern struct amba_device spear1310_uart3_device;
+extern struct amba_device spear1310_uart4_device;
+extern struct amba_device spear1310_uart5_device;
+extern struct platform_device spear1310_can0_device;
+extern struct platform_device spear1310_can1_device;
+
+/* Add spear1310 machine function declarations here */
+void __init spear1310_init(void);
+void __init spear1310_map_io(void);
+
+#endif /* CONFIG_MACH_SPEAR1310 */
+
 #endif /* __MACH_GENERIC_H */
diff --git a/arch/arm/mach-spear13xx/include/mach/irqs.h b/arch/arm/mach-spear13xx/include/mach/irqs.h
index d9fe051..c175175 100644
--- a/arch/arm/mach-spear13xx/include/mach/irqs.h
+++ b/arch/arm/mach-spear13xx/include/mach/irqs.h
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2010 ST Microelectronics
  * Shiraz Hashim <shiraz.hashim@st.com>
+ * Bhupesh Sharma <bhupesh.sharma@st.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -84,6 +85,42 @@
 #define IRQ_PCIE1		(IRQ_SHPI_START + 69)
 #define IRQ_PCIE2		(IRQ_SHPI_START + 70)
 
+/* Add spear1310 specific IRQs here */
+#ifdef CONFIG_MACH_SPEAR1310
+#define IRQ_FSMC_PC1		(IRQ_SHPI_START + 76)
+#define IRQ_FSMC_PC2		(IRQ_SHPI_START + 77)
+#define IRQ_FSMC_PC3		(IRQ_SHPI_START + 78)
+#define IRQ_FSMC_PC4		(IRQ_SHPI_START + 79)
+#define IRQ_RS4850		(IRQ_SHPI_START + 80)
+#define IRQ_RS4851		(IRQ_SHPI_START + 81)
+#define IRQ_CCAN0		(IRQ_SHPI_START + 82)
+#define IRQ_CCAN1		(IRQ_SHPI_START + 83)
+#define IRQ_TDM0		(IRQ_SHPI_START + 84)
+#define IRQ_TDM1		(IRQ_SHPI_START + 85)
+#define IRQ_UART1		(IRQ_SHPI_START + 86)
+#define IRQ_UART2		(IRQ_SHPI_START + 87)
+#define IRQ_UART3		(IRQ_SHPI_START + 88)
+#define IRQ_UART4		(IRQ_SHPI_START + 89)
+#define IRQ_UART5		(IRQ_SHPI_START + 90)
+#define IRQ_I2C_CNTR		(IRQ_SHPI_START + 91)
+#define IRQ_GMAC0_SBD		(IRQ_SHPI_START + 92)
+#define IRQ_GMAC0_PMT		(IRQ_SHPI_START + 93)
+#define IRQ_GMAC1_SBD		(IRQ_SHPI_START + 94)
+#define IRQ_GMAC1_PMT		(IRQ_SHPI_START + 95)
+#define IRQ_GMAC2_SBD		(IRQ_SHPI_START + 96)
+#define IRQ_GMAC2_PMT		(IRQ_SHPI_START + 97)
+#define IRQ_GMAC3_SBD		(IRQ_SHPI_START + 98)
+#define IRQ_GMAC3_PMT		(IRQ_SHPI_START + 99)
+#define IRQ_GPIO		(IRQ_SHPI_START + 100)
+#define IRQ_PCI_BRDG_HOST_FATAL (IRQ_SHPI_START + 101)
+#define IRQ_PCI_INTA		(IRQ_SHPI_START + 102)
+#define IRQ_PCI_INTB		(IRQ_SHPI_START + 103)
+#define IRQ_PCI_INTC		(IRQ_SHPI_START + 104)
+#define IRQ_PCI_INTD		(IRQ_SHPI_START + 105)
+#define IRQ_PCI_ME_TO_ARM	(IRQ_SHPI_START + 106)
+#define IRQ_PCI_SERR_TO_ARM	(IRQ_SHPI_START + 107)
+#endif /* CONFIG_MACH_SPEAR1310 */
+
 #define IRQ_GIC_END		(IRQ_SHPI_START + 128)
 
 #define NR_IRQS			IRQ_GIC_END
diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
index 1a1af72..cf25eb5 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -16,6 +16,7 @@
 
 #include <asm/memory.h>
 #include <mach/spear1300.h>
+#include <mach/spear1310.h>
 
 #define SPEAR13XX_L2CC_BASE		UL(0xED000000)
 
diff --git a/arch/arm/mach-spear13xx/include/mach/spear1310.h b/arch/arm/mach-spear13xx/include/mach/spear1310.h
new file mode 100644
index 0000000..34f0a27
--- /dev/null
+++ b/arch/arm/mach-spear13xx/include/mach/spear1310.h
@@ -0,0 +1,64 @@
+/*
+ * arch/arm/mach-spear13xx/include/mach/spear1310.h
+ *
+ * SPEAr1310 Machine specific definition
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Bhupesh Sharma <bhupesh.sharma@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifdef CONFIG_MACH_SPEAR1310
+
+#ifndef __MACH_SPEAR1310_H
+#define __MACH_SPEAR1310_H
+
+#define SPEAR1310_TDM_E1_0_BASE		UL(0x6C200000)
+#define SPEAR1310_TDM_E1_1_BASE		UL(0x6C300000)
+#define SPEAR1310_RS485_0_BASE		UL(0x6C400000)
+#define SPEAR1310_RS485_1_BASE		UL(0x6C500000)
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
+#define SPEAR1310_CAN0_BASE		UL(0x6DA00000)
+#define SPEAR1310_CAN1_BASE		UL(0x6DB00000)
+#define SPEAR1310_RAS_BASE		UL(0x6C800000)
+#define SPEAR1310_GETH1_BASE		UL(0x6D000000)
+#define SPEAR1310_GETH2_BASE		UL(0x6D100000)
+#define SPEAR1310_GETH3_BASE		UL(0x6D200000)
+#define SPEAR1310_GETH4_BASE		UL(0x6D300000)
+#define SPEAR1310_FSMC1_CS0_BASE	UL(0x70000000)
+#define SPEAR1310_FSMC1_CS1_BASE	UL(0x74000000)
+#define SPEAR1310_FSMC1_CS2_BASE	UL(0x78000000)
+#define SPEAR1310_FSMC1_CS3_BASE	UL(0x7C000000)
+#define SPEAR1310_FSMC1_BASE		UL(0x6FF00000)
+
+/* RAS Area Control Register */
+#define SPEAR1310_RAS_CTRL_REG0		(SPEAR1310_RAS_BASE + 0x0)
+#define SPEAR1310_RAS_CTRL_REG1		(SPEAR1310_RAS_BASE + 0x4)
+#define SPEAR1310_PHY_CLK_MASK		0xF
+#define SPEAR1310_PHY_CLK_SHIFT		0
+
+#define RAS_FSMC_MODE_MASK		0x3
+#define RAS_FSMC_MODE_NOR		0
+#define RAS_FSMC_MODE_NAND		1
+#define RAS_FSMC_MODE_SRAM		2
+#define RAS_FSMC_WIDTH_MASK		0x30
+#define RAS_FSMC_WIDTH_8		0x00
+#define RAS_FSMC_WIDTH_16		0x10
+#define RAS_FSMC_WIDTH_32		0x20
+#define RAS_FSMC_CS_SPLIT		0x40
+
+#endif /* __MACH_SPEAR1310_H */
+
+#endif /* CONFIG_MACH_SPEAR1310 */
diff --git a/arch/arm/mach-spear13xx/spear1310.c b/arch/arm/mach-spear13xx/spear1310.c
new file mode 100644
index 0000000..e4ad092
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear1310.c
@@ -0,0 +1,144 @@
+/*
+ * arch/arm/mach-spear13xx/spear1310.c
+ *
+ * SPEAr1310 machine source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Bhupesh Sharma <bhupesh.sharma@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/ptrace.h>
+#include <asm/irq.h>
+#include <mach/generic.h>
+#include <mach/hardware.h>
+
+/* Add spear1310 specific devices here */
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
+
+/* CAN device registeration */
+static struct resource can0_resources[] = {
+	{
+		.start = SPEAR1310_CAN0_BASE,
+		.end = SPEAR1310_CAN0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_CCAN0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear1310_can0_device = {
+	.name = "c_can_platform",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(can0_resources),
+	.resource = can0_resources,
+};
+
+static struct resource can1_resources[] = {
+	{
+		.start = SPEAR1310_CAN1_BASE,
+		.end = SPEAR1310_CAN1_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_CCAN1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear1310_can1_device = {
+	.name = "c_can_platform",
+	.id = 1,
+	.num_resources = ARRAY_SIZE(can1_resources),
+	.resource = can1_resources,
+};
+
+/* Following will create 1310 specific static virtual/physical mappings */
+struct map_desc spear1310_io_desc[] __initdata = {
+	{
+		.virtual	= IO_ADDRESS(SPEAR1310_RAS_BASE),
+		.pfn		= __phys_to_pfn(SPEAR1310_RAS_BASE),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE
+	},
+};
+
+/* This will create static memory mapping for selected devices */
+void __init spear1310_map_io(void)
+{
+	iotable_init(spear1310_io_desc, ARRAY_SIZE(spear1310_io_desc));
+	spear13xx_map_io();
+}
+
+void __init spear1310_init(void)
+{
+	/* call spear13xx family common init function */
+	spear13xx_init();
+}
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
new file mode 100644
index 0000000..a87e82b
--- /dev/null
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -0,0 +1,61 @@
+/*
+ * arch/arm/mach-spear13xx/spear1310_evb.c
+ *
+ * SPEAr1310 evaluation board source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Bhupesh Sharma <bhupesh.sharma@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <mach/generic.h>
+#include <mach/hardware.h>
+
+static struct amba_device *amba_devs[] __initdata = {
+	/* spear13xx specific devices */
+	&spear13xx_uart_device,
+
+	/* spear1310 specific devices */
+	&spear1310_uart1_device,
+	&spear1310_uart2_device,
+	&spear1310_uart3_device,
+	&spear1310_uart4_device,
+	&spear1310_uart5_device,
+};
+
+static struct platform_device *plat_devs[] __initdata = {
+	/* spear13xx specific devices */
+
+	/* spear1310 specific devices */
+	&spear1310_can0_device,
+	&spear1310_can1_device,
+};
+
+static void __init spear1310_evb_init(void)
+{
+	unsigned int i;
+
+	/* call spear1310 machine init function */
+	spear1310_init();
+
+	/* Add Platform Devices */
+	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
+
+	/* Add Amba Devices */
+	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
+		amba_device_register(amba_devs[i], &iomem_resource);
+}
+
+MACHINE_START(SPEAR1310, "ST-SPEAR1310-EVB")
+	.boot_params	=	0x00000100,
+	.map_io		=	spear1310_map_io,
+	.init_irq	=	spear13xx_init_irq,
+	.timer		=	&spear13xx_timer,
+	.init_machine	=	spear1310_evb_init,
+MACHINE_END
-- 
1.7.2.2
