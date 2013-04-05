From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:47 +0200
Subject: [PATCH 05/14] mfd: prcmu: pass a base and size with the early initcall
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-6-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This patch will make an early remapping of the PRCMU, to be
used when setting up the clocks, that will call down into parts
of the PRCMU driver before it is probed.

Going forward this will be removed like this:

- The mailbox subsystem need to be merged.
  http://marc.info/?l=linux-kernel&m=136314559201983&w=2

- At this point the PRCMU clock code can be moved over to the
  ux500 clock driver in drivers/clk/ux500/* and maintained
  there in a decentralized manner.

- This early initcall and PRCMU base parameters become part of
  the ux500_clk_init() call instead.

Cc: Suman Anna <s-anna@ti.com>
Cc: Loic Pallardy <loic.pallardy@st.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu.c        | 17 +++++++++++------
 drivers/mfd/db8500-prcmu.c       | 13 ++++++++++++-
 include/linux/mfd/db8500-prcmu.h |  4 ++--
 include/linux/mfd/dbx500-prcmu.h |  6 +++---
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 741d06a..af13b6d 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -8,7 +8,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/mfd/db8500-prcmu.h>
+#include <linux/mfd/dbx500-prcmu.h>
 #include <linux/clksrc-dbx500-prcmu.h>
 #include <linux/sys_soc.h>
 #include <linux/err.h>
@@ -68,15 +68,20 @@ void __init ux500_init_irq(void)
 	 * Init clocks here so that they are available for system timer
 	 * initialization.
 	 */
-	if (cpu_is_u8500_family() || cpu_is_u9540())
-		db8500_prcmu_early_init();
-
-	if (cpu_is_u8500_family() || cpu_is_u9540())
+	if (cpu_is_u8500_family()) {
+		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
 		u8500_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
 			       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
 			       U8500_CLKRST6_BASE);
-	else if (cpu_is_u8540())
+	} else if (cpu_is_u9540()) {
+		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K - 1);
+		u8500_clk_init(U8500_CLKRST1_BASE, U8500_CLKRST2_BASE,
+			       U8500_CLKRST3_BASE, U8500_CLKRST5_BASE,
+			       U8500_CLKRST6_BASE);
+	} else if (cpu_is_u8540()) {
+		prcmu_early_init(U8500_PRCMU_BASE, SZ_8K + SZ_4K - 1);
 		u8540_clk_init();
+	}
 }
 
 void __init ux500_init_late(void)
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 21f261b..9166427 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2825,8 +2825,19 @@ static void dbx500_fw_version_init(struct platform_device *pdev,
 	}
 }
 
-void __init db8500_prcmu_early_init(void)
+void __init db8500_prcmu_early_init(u32 phy_base, u32 size)
 {
+	/*
+	 * This is a temporary remap to bring up the clocks. It is
+	 * subsequently replaces with a real remap. After the merge of
+	 * the mailbox subsystem all of this early code goes away, and the
+	 * clock driver can probe independently. An early initcall will
+	 * still be needed, but it can be diverted into drivers/clk/ux500/*.
+	 */
+	prcmu_base = ioremap(phy_base, size);
+	if (!prcmu_base)
+		pr_err("%s: ioremap() of prcmu registers failed!\n", __func__);
+
 	spin_lock_init(&mb0_transfer.lock);
 	spin_lock_init(&mb0_transfer.dbb_irqs_lock);
 	mutex_init(&mb0_transfer.ac_wake_lock);
diff --git a/include/linux/mfd/db8500-prcmu.h b/include/linux/mfd/db8500-prcmu.h
index 77a46ae..ac943df 100644
--- a/include/linux/mfd/db8500-prcmu.h
+++ b/include/linux/mfd/db8500-prcmu.h
@@ -489,7 +489,7 @@ struct prcmu_auto_pm_config {
 
 #ifdef CONFIG_MFD_DB8500_PRCMU
 
-void db8500_prcmu_early_init(void);
+void db8500_prcmu_early_init(u32 phy_base, u32 size);
 int prcmu_set_rc_a2p(enum romcode_write);
 enum romcode_read prcmu_get_rc_p2a(void);
 enum ap_pwrst prcmu_get_xp70_current_state(void);
@@ -553,7 +553,7 @@ void db8500_prcmu_write_masked(unsigned int reg, u32 mask, u32 value);
 
 #else /* !CONFIG_MFD_DB8500_PRCMU */
 
-static inline void db8500_prcmu_early_init(void) {}
+static inline void db8500_prcmu_early_init(u32 phy_base, u32 size) {}
 
 static inline int prcmu_set_rc_a2p(enum romcode_write code)
 {
diff --git a/include/linux/mfd/dbx500-prcmu.h b/include/linux/mfd/dbx500-prcmu.h
index 3abcca9..8c546cb 100644
--- a/include/linux/mfd/dbx500-prcmu.h
+++ b/include/linux/mfd/dbx500-prcmu.h
@@ -276,9 +276,9 @@ struct prcmu_fw_version {
 
 #if defined(CONFIG_UX500_SOC_DB8500)
 
-static inline void __init prcmu_early_init(void)
+static inline void prcmu_early_init(u32 phy_base, u32 size)
 {
-	return db8500_prcmu_early_init();
+	return db8500_prcmu_early_init(phy_base, size);
 }
 
 static inline int prcmu_set_power_state(u8 state, bool keep_ulp_clk,
@@ -500,7 +500,7 @@ static inline int prcmu_config_a9wdog(u8 num, bool sleep_auto_off)
 }
 #else
 
-static inline void __init prcmu_early_init(void) {}
+static inline void prcmu_early_init(u32 phy_base, u32 size) {}
 
 static inline int prcmu_set_power_state(u8 state, bool keep_ulp_clk,
 	bool keep_ap_pll)
-- 
1.7.11.3
