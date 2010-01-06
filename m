From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:47 -0800
Subject: [PATCH 05/35] davinci: make it possible to include clock.h and psc.h
	in assembly code
In-Reply-To: <1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

psc.h contains register defines for PSC module which
need to be accessed in assembly code which helps the
DA850/OMAP-L138 SoC go to sleep. Shutting down DDR clock
using PSC is a part of the sleep procedure.

Also, the PLL related hardware definitions in clock.h are
needed in assembly code to bypass the DDR2 PLL.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.h            |   10 +++++++---
 arch/arm/mach-davinci/include/mach/psc.h |    4 ++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index eca4d99..31fb6ea 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -12,9 +12,6 @@
 #ifndef __ARCH_ARM_DAVINCI_CLOCK_H
 #define __ARCH_ARM_DAVINCI_CLOCK_H
 
-#include <linux/list.h>
-#include <asm/clkdev.h>
-
 #define DAVINCI_PLL1_BASE 0x01c40800
 #define DAVINCI_PLL2_BASE 0x01c40c00
 #define MAX_PLL 2
@@ -68,6 +65,11 @@
  */
 #define PLL_LOCK_TIME		20
 
+#ifndef __ASSEMBLER__
+
+#include <linux/list.h>
+#include <asm/clkdev.h>
+
 struct pll_data {
 	u32 phys_base;
 	void __iomem *base;
@@ -124,3 +126,5 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 extern struct platform_device davinci_wdt_device;
 
 #endif
+
+#endif
diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index 2776b23..651f6d8 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -191,8 +191,12 @@
 
 #define MDSTAT_STATE_MASK 0x1f
 
+#ifndef __ASSEMBLER__
+
 extern int davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id);
 extern void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 		unsigned int id, char enable);
 
+#endif
+
 #endif /* __ASM_ARCH_PSC_H */
-- 
1.6.6.rc2.1.g42108
