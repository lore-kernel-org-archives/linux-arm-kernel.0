From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Jul 2010 21:43:59 +0900
Subject: [PATCH 2/2] ARM: S5PV210: Add s5pv210_sw_reset for SWRESET
In-Reply-To: <1279889039-9718-1-git-send-email-kgene.kim@samsung.com>
References: <1279889039-9718-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279889039-9718-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds s5pv210_sw_reset() which includes SWRESET for S5PV210/S5PC110.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/cpu.c                     |    9 +++++++++
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |    2 ++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 411a4a9..2a61d81 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -34,6 +34,7 @@
 #include <plat/s5pv210.h>
 #include <plat/iic-core.h>
 #include <plat/sdhci.h>
+#include <plat/reset.h>
 
 /* Initial IO mappings */
 
@@ -69,6 +70,11 @@ static void s5pv210_idle(void)
 	local_irq_enable();
 }
 
+static void s5pv210_sw_reset(void)
+{
+	__raw_writel(0x1, S5P_SWRESET);
+}
+
 /* s5pv210_map_io
  *
  * register the standard cpu IO areas
@@ -138,5 +144,8 @@ int __init s5pv210_init(void)
 	/* set idle function */
 	pm_idle = s5pv210_idle;
 
+	/* set sw_reset function */
+	s5p_reset_hook = s5pv210_sw_reset;
+
 	return sysdev_register(&s5pv210_sysdev);
 }
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
index 2a25ab4..499aef7 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -90,6 +90,8 @@
 #define S5P_CLKDIV0_PCLK66_SHIFT	(28)
 #define S5P_CLKDIV0_PCLK66_MASK		(0x7 << S5P_CLKDIV0_PCLK66_SHIFT)
 
+#define S5P_SWRESET		S5P_CLKREG(0x2000)
+
 /* Registers related to power management */
 #define S5P_PWR_CFG		S5P_CLKREG(0xC000)
 #define S5P_EINT_WAKEUP_MASK	S5P_CLKREG(0xC004)
-- 
1.6.2.5
