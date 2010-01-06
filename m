From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:43 -0800
Subject: [PATCH 01/35] davinci: da8xx/omapl1: add support for the second
	sysconfig module
In-Reply-To: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

OMAP-L138 adds a second SYSCFG region having useful functionality
like deep sleep, pull up/down control and SATA clock stop.

This patch makes provision for accessing registers from second
SYSCFG region in da8xx code.

Note that OMAP-L137 has a single SYSCFG region.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c    |    4 ++--
 arch/arm/mach-davinci/board-da850-evm.c    |    2 +-
 arch/arm/mach-davinci/da830.c              |    8 ++++----
 arch/arm/mach-davinci/da850.c              |   20 ++++++++++++--------
 arch/arm/mach-davinci/devices-da8xx.c      |    3 ++-
 arch/arm/mach-davinci/include/mach/da8xx.h |   10 +++++++---
 6 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 31dc990..dc19870 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -112,7 +112,7 @@ static __init void da830_evm_usb_init(void)
 	 * Set up USB clock/mode in the CFGCHIP2 register.
 	 * FYI:  CFGCHIP2 is 0x0000ef00 initially.
 	 */
-	cfgchip2 = __raw_readl(DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP2_REG));
+	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
 	/* USB2.0 PHY reference clock is 24 MHz */
 	cfgchip2 &= ~CFGCHIP2_REFFREQ;
@@ -139,7 +139,7 @@ static __init void da830_evm_usb_init(void)
 	cfgchip2 |=  CFGCHIP2_SESENDEN | CFGCHIP2_VBDTCTEN;
 #endif
 
-	__raw_writel(cfgchip2, DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP2_REG));
+	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
 	/* USB_REFCLKIN is not used. */
 	ret = davinci_cfg_reg(DA830_USB0_DRVVBUS);
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 07de8db..dba2241 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -537,7 +537,7 @@ static int __init da850_evm_config_emac(void)
 	if (!machine_is_davinci_da850_evm())
 		return 0;
 
-	cfg_chip3_base = DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP3_REG);
+	cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
 
 	val = __raw_readl(cfg_chip3_base);
 
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index b22b5cf..5479605 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1208,13 +1208,13 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 
 void __init da830_init(void)
 {
-	da8xx_syscfg_base = ioremap(DA8XX_SYSCFG_BASE, SZ_4K);
-	if (WARN(!da8xx_syscfg_base, "Unable to map syscfg module"))
+	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
+	if (WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module"))
 		return;
 
 	davinci_soc_info_da830.jtag_id_base =
-					DA8XX_SYSCFG_VIRT(DA8XX_JTAG_ID_REG);
-	davinci_soc_info_da830.pinmux_base = DA8XX_SYSCFG_VIRT(0x120);
+					DA8XX_SYSCFG0_VIRT(DA8XX_JTAG_ID_REG);
+	davinci_soc_info_da830.pinmux_base = DA8XX_SYSCFG0_VIRT(0x120);
 
 	davinci_common_init(&davinci_soc_info_da830);
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 717806c..4f84ab4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -838,12 +838,12 @@ static void da850_set_async3_src(int pllnum)
 		}
        }
 
-	v = __raw_readl(DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP3_REG));
+	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 	if (pllnum)
 		v |= CFGCHIP3_ASYNC3_CLKSRC;
 	else
 		v &= ~CFGCHIP3_ASYNC3_CLKSRC;
-	__raw_writel(v, DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP3_REG));
+	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 }
 
 #ifdef CONFIG_CPU_FREQ
@@ -996,9 +996,9 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long index)
 	postdiv = opp->postdiv;
 
 	/* Unlock writing to PLL registers */
-	v = __raw_readl(DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP0_REG));
+	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
 	v &= ~CFGCHIP0_PLL_MASTER_LOCK;
-	__raw_writel(v, DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP0_REG));
+	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
 
 	ret = davinci_set_pllrate(pll, prediv, mult, postdiv);
 	if (WARN_ON(ret))
@@ -1053,13 +1053,17 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 
 void __init da850_init(void)
 {
-	da8xx_syscfg_base = ioremap(DA8XX_SYSCFG_BASE, SZ_4K);
-	if (WARN(!da8xx_syscfg_base, "Unable to map syscfg module"))
+	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
+	if (WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module"))
+		return;
+
+	da8xx_syscfg1_base = ioremap(DA8XX_SYSCFG1_BASE, SZ_4K);
+	if (WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module"))
 		return;
 
 	davinci_soc_info_da850.jtag_id_base =
-					DA8XX_SYSCFG_VIRT(DA8XX_JTAG_ID_REG);
-	davinci_soc_info_da850.pinmux_base = DA8XX_SYSCFG_VIRT(0x120);
+					DA8XX_SYSCFG0_VIRT(DA8XX_JTAG_ID_REG);
+	davinci_soc_info_da850.pinmux_base = DA8XX_SYSCFG0_VIRT(0x120);
 
 	davinci_common_init(&davinci_soc_info_da850);
 
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index dd2d32c..8de5f9f 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -42,7 +42,8 @@
 #define DA8XX_MDIO_REG_OFFSET		0x4000
 #define DA8XX_EMAC_CTRL_RAM_SIZE	SZ_8K
 
-void __iomem *da8xx_syscfg_base;
+void __iomem *da8xx_syscfg0_base;
+void __iomem *da8xx_syscfg1_base;
 
 static struct plat_serial8250_port da8xx_serial_pdata[] = {
 	{
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 9070491..bddc4d4 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -21,7 +21,8 @@
 #include <mach/mmc.h>
 #include <mach/usb.h>
 
-extern void __iomem *da8xx_syscfg_base;
+extern void __iomem *da8xx_syscfg0_base;
+extern void __iomem *da8xx_syscfg1_base;
 
 /*
  * The cp_intc interrupt controller for the da8xx isn't in the same
@@ -34,13 +35,16 @@ extern void __iomem *da8xx_syscfg_base;
 #define DA8XX_CP_INTC_SIZE	SZ_8K
 #define DA8XX_CP_INTC_VIRT	(IO_VIRT - DA8XX_CP_INTC_SIZE - SZ_4K)
 
-#define DA8XX_SYSCFG_BASE	(IO_PHYS + 0x14000)
-#define DA8XX_SYSCFG_VIRT(x)	(da8xx_syscfg_base + (x))
+#define DA8XX_SYSCFG0_BASE	(IO_PHYS + 0x14000)
+#define DA8XX_SYSCFG0_VIRT(x)	(da8xx_syscfg0_base + (x))
 #define DA8XX_JTAG_ID_REG	0x18
 #define DA8XX_CFGCHIP0_REG	0x17c
 #define DA8XX_CFGCHIP2_REG	0x184
 #define DA8XX_CFGCHIP3_REG	0x188
 
+#define DA8XX_SYSCFG1_BASE	(IO_PHYS + 0x22C000)
+#define DA8XX_SYSCFG1_VIRT(x)	(da8xx_syscfg1_base + (x))
+
 #define DA8XX_PSC0_BASE		0x01c10000
 #define DA8XX_PLL0_BASE		0x01c11000
 #define DA8XX_TIMER64P0_BASE	0x01c20000
-- 
1.6.6.rc2.1.g42108
