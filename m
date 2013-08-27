From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 11:34:26 -0300
Subject: [PATCH 02/15] ARM: orion: Assert watchdog RSTOUT enable bit
In-Reply-To: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377614079-10000-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prevent orion_wdt from accessing the RSTOUTn_MASK register,
it's cleaner to enable the watchdog RSTOUT bit in board initialization time.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-dove/board-dt.c                     | 2 ++
 arch/arm/mach-dove/common.c                       | 2 ++
 arch/arm/mach-dove/include/mach/bridge-regs.h     | 1 +
 arch/arm/mach-kirkwood/board-dt.c                 | 2 ++
 arch/arm/mach-kirkwood/common.c                   | 2 ++
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h | 1 +
 arch/arm/mach-mv78xx0/common.c                    | 2 ++
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h  | 1 +
 arch/arm/mach-orion5x/board-dt.c                  | 4 ++++
 arch/arm/mach-orion5x/common.c                    | 2 ++
 arch/arm/mach-orion5x/include/mach/bridge-regs.h  | 1 +
 arch/arm/plat-orion/common.c                      | 5 +++++
 arch/arm/plat-orion/include/plat/common.h         | 1 +
 13 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index f3755ac..6e9570c 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -60,6 +60,8 @@ static void __init dove_dt_init(void)
 {
 	pr_info("Dove 88AP510 SoC\n");
 
+	orion_wdt_reset_enable();
+
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
 #endif
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 00247c7..ac8b4bb 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -367,6 +367,8 @@ void __init dove_init(void)
 	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
 		(dove_tclk + 499999) / 1000000);
 
+	orion_wdt_reset_enable();
+
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
 #endif
diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-dove/include/mach/bridge-regs.h
index 5362df3..079f80b 100644
--- a/arch/arm/mach-dove/include/mach/bridge-regs.h
+++ b/arch/arm/mach-dove/include/mach/bridge-regs.h
@@ -22,6 +22,7 @@
 
 #define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
 #define  SOFT_RESET_OUT_EN	0x00000004
+#define  WDT_RESET_OUT_EN	0x00000002
 
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
 #define  SOFT_RESET		0x00000001
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 6e122ed..aa8d9d6 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -87,6 +87,8 @@ static void __init kirkwood_dt_init(void)
 	 */
 	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
 
+	orion_wdt_reset_enable();
+
 	kirkwood_setup_wins();
 
 	kirkwood_l2_init();
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index e9238b5..dc0f353 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -703,6 +703,8 @@ void __init kirkwood_init(void)
 	 */
 	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
 
+	orion_wdt_reset_enable();
+
 	kirkwood_setup_wins();
 
 	kirkwood_l2_init();
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 91242c9..f44240e 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -22,6 +22,7 @@
 
 #define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
 #define SOFT_RESET_OUT_EN	0x00000004
+#define WDT_RESET_OUT_EN	0x00000002
 
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
 #define SOFT_RESET		0x00000001
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 75062ef..be326bb 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -394,6 +394,8 @@ void __init mv78xx0_init(void)
 	int pclk;
 	int l2clk;
 
+	orion_wdt_reset_enable();
+
 	core_index = mv78xx0_core_index();
 	hclk = get_hclk();
 	get_pclk_l2clk(hclk, core_index, &pclk, &l2clk);
diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
index 5f03484..dd7b7b3 100644
--- a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
@@ -16,6 +16,7 @@
 
 #define RSTOUTn_MASK		(BRIDGE_VIRT_BASE + 0x0108)
 #define SOFT_RESET_OUT_EN	0x00000004
+#define WDT_RESET_OUT_EN	0x00000002
 
 #define SYSTEM_SOFT_RESET	(BRIDGE_VIRT_BASE + 0x010c)
 #define SOFT_RESET		0x00000001
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index b91002c..61fbdc1 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -15,10 +15,12 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/cpu.h>
+#include <linux/clk-provider.h>
 #include <asm/system_misc.h>
 #include <asm/mach/arch.h>
 #include <mach/orion5x.h>
 #include <plat/irq.h>
+#include <plat/common.h>
 #include "common.h"
 
 struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
@@ -39,6 +41,8 @@ static void __init orion5x_dt_init(void)
 	orion5x_id(&dev, &rev, &dev_name);
 	printk(KERN_INFO "Orion ID: %s. TCLK=%d.\n", dev_name, orion5x_tclk);
 
+	orion_wdt_reset_enable();
+
 	/*
 	 * Setup Orion address map
 	 */
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index b41599f..a2583ac 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -316,6 +316,8 @@ void __init orion5x_init(void)
 	orion5x_id(&dev, &rev, &dev_name);
 	printk(KERN_INFO "Orion ID: %s. TCLK=%d.\n", dev_name, orion5x_tclk);
 
+	orion_wdt_reset_enable();
+
 	/*
 	 * Setup Orion address map
 	 */
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
index f727d03..b32e15a 100644
--- a/arch/arm/mach-orion5x/include/mach/bridge-regs.h
+++ b/arch/arm/mach-orion5x/include/mach/bridge-regs.h
@@ -18,6 +18,7 @@
 #define CPU_CTRL		(ORION5X_BRIDGE_VIRT_BASE + 0x104)
 
 #define RSTOUTn_MASK		(ORION5X_BRIDGE_VIRT_BASE + 0x108)
+#define WDT_RESET_OUT_EN	0x00000002
 
 #define CPU_SOFT_RESET		(ORION5X_BRIDGE_VIRT_BASE + 0x10c)
 
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index c66d163..31bf2cb 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -604,6 +604,11 @@ static struct platform_device orion_wdt_device = {
 	.resource	= &orion_wdt_resource,
 };
 
+void __init orion_wdt_reset_enable(void)
+{
+	writel(readl(RSTOUTn_MASK) | WDT_RESET_OUT_EN, RSTOUTn_MASK);
+}
+
 void __init orion_wdt_init(void)
 {
 	platform_device_register(&orion_wdt_device);
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index d9a24f6..3c81aa6 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -75,6 +75,7 @@ void __init orion_spi_init(unsigned long mapbase);
 
 void __init orion_spi_1_init(unsigned long mapbase);
 
+void __init orion_wdt_reset_enable(void);
 void __init orion_wdt_init(void);
 
 void __init orion_xor0_init(unsigned long mapbase_low,
-- 
1.8.1.5
