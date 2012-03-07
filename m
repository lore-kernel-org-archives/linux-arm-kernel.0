From: jason@lakedaemon.net (Jason Cooper)
Date: Wed,  7 Mar 2012 03:44:45 +0000
Subject: [PATCH 04/14] ARM: kirkwood: fdt: absorb kirkwood_init()
In-Reply-To: <cover.1331090356.git.jason@lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
Message-ID: <d26f8923d0e1446e834b0c6b996740264e6457f3.1331090356.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to absorb kirkwood_init() into kirkwood_dt_init() so that as we
convert drivers, we can remove the platform call, eg
kirkwood_rtc_init().  This maintains compatibility with non-fdt
configurations because they still call kirkwood_init() in common.c.

As drivers are converted, we will reinstate the 'static' qualifier in
common.c.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/mach-kirkwood/board-dt.c |   29 ++++++++++++++++++++++++++++-
 arch/arm/mach-kirkwood/common.c   |   12 ++++++------
 arch/arm/mach-kirkwood/common.h   |    8 ++++++++
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 76392af..f514b42 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -29,7 +29,9 @@
 #include <linux/spi/orion_spi.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
+#include <asm/mach/map.h>
 #include <mach/kirkwood.h>
+#include <mach/bridge-regs.h>
 #include <plat/mvsdio.h>
 #include "common.h"
 #include "mpp.h"
@@ -157,7 +159,32 @@ static void __init dreamplug_init(void)
 
 static void __init kirkwood_dt_init(void)
 {
-	kirkwood_init();
+	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
+
+	/*
+	 * Disable propagation of mbus errors to the CPU local bus,
+	 * as this causes mbus errors (which can occur for example
+	 * for PCI aborts) to throw CPU aborts, which we're not set
+	 * up to deal with.
+	 */
+	writel(readl(CPU_CONFIG) & ~CPU_CONFIG_ERROR_PROP, CPU_CONFIG);
+
+	kirkwood_setup_cpu_mbus();
+
+#ifdef CONFIG_CACHE_FEROCEON_L2
+	kirkwood_l2_init();
+#endif
+
+	/* internal devices that every board has */
+	kirkwood_rtc_init();
+	kirkwood_wdt_init();
+	kirkwood_xor0_init();
+	kirkwood_xor1_init();
+	kirkwood_crypto_init();
+
+#ifdef CONFIG_KEXEC
+	kexec_reinit = kirkwood_enable_pcie;
+#endif
 
 	if (of_machine_is_compatible("globalscale,dreamplug"))
 		dreamplug_init();
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index eacf7f5..ae90f60 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -162,7 +162,7 @@ void __init kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts,
 /*****************************************************************************
  * SoC RTC
  ****************************************************************************/
-static void __init kirkwood_rtc_init(void)
+void __init kirkwood_rtc_init(void)
 {
 	orion_rtc_init(RTC_PHYS_BASE, IRQ_KIRKWOOD_RTC);
 }
@@ -278,7 +278,7 @@ void __init kirkwood_crypto_init(void)
 /*****************************************************************************
  * XOR0
  ****************************************************************************/
-static void __init kirkwood_xor0_init(void)
+void __init kirkwood_xor0_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_XOR0;
 
@@ -290,7 +290,7 @@ static void __init kirkwood_xor0_init(void)
 /*****************************************************************************
  * XOR1
  ****************************************************************************/
-static void __init kirkwood_xor1_init(void)
+void __init kirkwood_xor1_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_XOR1;
 
@@ -302,7 +302,7 @@ static void __init kirkwood_xor1_init(void)
 /*****************************************************************************
  * Watchdog
  ****************************************************************************/
-static void __init kirkwood_wdt_init(void)
+void __init kirkwood_wdt_init(void)
 {
 	orion_wdt_init(kirkwood_tclk);
 }
@@ -391,7 +391,7 @@ void __init kirkwood_audio_init(void)
 /*
  * Identify device ID and revision.
  */
-static char * __init kirkwood_id(void)
+char * __init kirkwood_id(void)
 {
 	u32 dev, rev;
 
@@ -434,7 +434,7 @@ static char * __init kirkwood_id(void)
 	}
 }
 
-static void __init kirkwood_l2_init(void)
+void __init kirkwood_l2_init(void)
 {
 #ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
 	writel(readl(L2_CONFIG_REG) | L2_WRITETHROUGH, L2_CONFIG_REG);
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 9071a39..c382447 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -51,6 +51,14 @@ void kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts, int (*dev
 void kirkwood_audio_init(void);
 void kirkwood_restart(char, const char *);
 
+char *kirkwood_id(void);
+void kirkwood_l2_init(void);
+void kirkwood_rtc_init(void);
+void kirkwood_wdt_init(void);
+void kirkwood_xor0_init(void);
+void kirkwood_xor1_init(void);
+void kirkwood_crypto_init(void);
+
 extern int kirkwood_tclk;
 extern struct sys_timer kirkwood_timer;
 
-- 
1.7.3.4
