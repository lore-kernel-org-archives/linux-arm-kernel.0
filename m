From: david@lechnology.com (David Lechner)
Date: Fri, 19 Jan 2018 21:20:23 -0600
Subject: [PATCH 5/6] ARM: da8xx: Move CFGCHIP registration to init_time
In-Reply-To: <1516418424-28686-1-git-send-email-david@lechnology.com>
References: <1516418424-28686-1-git-send-email-david@lechnology.com>
Message-ID: <1516418424-28686-6-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the registration of the CFGCHIP syscon device to the
init_time callback. This is in preparation of moving to the common
clock framework. There are a number of clocks in this syscon device
so it will be needed at this point in boot to register the clocks.

In da850.c also move the PLL unlock code to make use of the CFGCHIP
regmap. It makes more sense to have it in init_time anyway since it
is related to clocks.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     |  4 ----
 arch/arm/mach-davinci/board-da850-evm.c     |  4 ----
 arch/arm/mach-davinci/board-mityomapl138.c  |  4 ----
 arch/arm/mach-davinci/board-omapl138-hawk.c |  4 ----
 arch/arm/mach-davinci/da830.c               |  1 +
 arch/arm/mach-davinci/da850.c               | 28 ++++++++++++----------------
 arch/arm/mach-davinci/devices-da8xx.c       | 29 ++++-------------------------
 arch/arm/mach-davinci/include/mach/da8xx.h  |  3 ++-
 8 files changed, 19 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 7adf009..3a1a86c 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -551,10 +551,6 @@ static __init void da830_evm_init(void)
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	int ret;
 
-	ret = da8xx_register_cfgchip();
-	if (ret)
-		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
-
 	ret = da830_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index d9d423d..3063478 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1334,10 +1334,6 @@ static __init void da850_evm_init(void)
 {
 	int ret;
 
-	ret = da8xx_register_cfgchip();
-	if (ret)
-		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
-
 	ret = da850_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index f9a725a..d1c8548 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -502,10 +502,6 @@ static void __init mityomapl138_init(void)
 {
 	int ret;
 
-	ret = da8xx_register_cfgchip();
-	if (ret)
-		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
-
 	/* for now, no special EDMA channels are reserved */
 	ret = da850_register_edma(NULL);
 	if (ret)
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index bc8a747..e2ba9da 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -281,10 +281,6 @@ static __init void omapl138_hawk_init(void)
 {
 	int ret;
 
-	ret = da8xx_register_cfgchip();
-	if (ret)
-		pr_warn("%s: CFGCHIP registration failed: %d\n", __func__, ret);
-
 	ret = da850_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 350d767..39de5a6 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1223,6 +1223,7 @@ void __init da830_init(void)
 
 void __init da830_init_time(void)
 {
+	da8xx_register_cfgchip();
 	davinci_clk_init(da830_clks);
 	davinci_timer_init();
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 34117e61..5c86d77 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -17,6 +17,8 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
+#include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/platform_data/gpio-davinci.h>
 
@@ -40,10 +42,6 @@
 
 #define DA850_REF_FREQ		24000000
 
-#define CFGCHIP3_ASYNC3_CLKSRC	BIT(4)
-#define CFGCHIP3_PLL1_MASTER_LOCK	BIT(5)
-#define CFGCHIP0_PLL_MASTER_LOCK	BIT(4)
-
 static int da850_set_armrate(struct clk *clk, unsigned long rate);
 static int da850_round_armrate(struct clk *clk, unsigned long rate);
 static int da850_set_pll0rate(struct clk *clk, unsigned long armrate);
@@ -1370,8 +1368,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 
 void __init da850_init(void)
 {
-	unsigned int v;
-
 	davinci_common_init(&davinci_soc_info_da850);
 
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
@@ -1381,20 +1377,20 @@ void __init da850_init(void)
 	da8xx_syscfg1_base = ioremap(DA8XX_SYSCFG1_BASE, SZ_4K);
 	if (WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module"))
 		return;
-
-	/* Unlock writing to PLL0 registers */
-	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
-	v &= ~CFGCHIP0_PLL_MASTER_LOCK;
-	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
-
-	/* Unlock writing to PLL1 registers */
-	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
-	v &= ~CFGCHIP3_PLL1_MASTER_LOCK;
-	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 }
 
 void __init da850_init_time(void)
 {
+	struct regmap *cfgchip;
+
+	cfgchip = da8xx_register_cfgchip();
+	if (WARN(IS_ERR(cfgchip), "failed to register CFGCHIP syscon"))
+		return;
+
+	/* Unlock writing to PLL registers */
+	regmap_write_bits(cfgchip, CFGCHIP(0), CFGCHIP0_PLL_MASTER_LOCK, 0);
+	regmap_write_bits(cfgchip, CFGCHIP(3), CFGCHIP3_PLL1_MASTER_LOCK, 0);
+
 	davinci_clk_init(da850_clks);
 	davinci_timer_init();
 }
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index fe5e15a..44cda0a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -11,7 +11,7 @@
  * (at your option) any later version.
  */
 #include <linux/init.h>
-#include <linux/platform_data/syscon.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/dma-contiguous.h>
 #include <linux/serial_8250.h>
@@ -1105,29 +1105,8 @@ int __init da850_register_sata(unsigned long refclkpn)
 }
 #endif
 
-static struct syscon_platform_data da8xx_cfgchip_platform_data = {
-	.label	= "cfgchip",
-};
-
-static struct resource da8xx_cfgchip_resources[] = {
-	{
-		.start	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP0_REG,
-		.end	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP4_REG + 3,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device da8xx_cfgchip_device = {
-	.name	= "syscon",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &da8xx_cfgchip_platform_data,
-	},
-	.num_resources	= ARRAY_SIZE(da8xx_cfgchip_resources),
-	.resource	= da8xx_cfgchip_resources,
-};
-
-int __init da8xx_register_cfgchip(void)
+struct regmap * __init da8xx_register_cfgchip(void)
 {
-	return platform_device_register(&da8xx_cfgchip_device);
+	return syscon_register(DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP0_REG,
+			       sizeof(u32) * 5, "ti,da830-cfgchip");
 }
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 3481a0d..7a40ec7 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -18,6 +18,7 @@
 #include <linux/spi/spi.h>
 #include <linux/platform_data/davinci_asp.h>
 #include <linux/reboot.h>
+#include <linux/regmap.h>
 #include <linux/videodev2.h>
 
 #include <mach/serial.h>
@@ -125,7 +126,7 @@ void da8xx_rproc_reserve_cma(void);
 int da8xx_register_rproc(void);
 int da850_register_gpio(void);
 int da830_register_gpio(void);
-int da8xx_register_cfgchip(void);
+struct regmap *da8xx_register_cfgchip(void);
 
 extern struct platform_device da8xx_serial_device[];
 extern struct emac_platform_data da8xx_emac_pdata;
-- 
2.7.4
