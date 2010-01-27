From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 26 Jan 2010 17:19:57 -0700 (MST)
Subject: [PATCH v3] OMAP3 clock: split out DPLL3 M2 divider functions into
	mach-omap2/clkt34xx_dpll3m2.c
Message-ID: <alpine.DEB.2.00.1001261703450.13835@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, 

just FYI, one minor tweak to this patch (updated version below). The file 
"mach-omap2/clkt3xxx_dpll3m2.c" has been renamed to 
"mach-omap2/clkt34xx_dpll3m2.c" to reflect the fact that it is not 
available on AM35xx chips.


- Paul


From: Paul Walmsley <paul@pwsan.com>

Split the DPLL3 M2 divider clock functions out of clock34xx.c and move
them into mach-omap2/clkt34xx_dpll3m2.c. This is intended to make the
clock code easier to understand, since all of the functions needed to
manage the OMAP3 DPLL3 M2 divider are now located in their own file,
rather than being mixed with other, unrelated functions.

Clock debugging is also now more finely-grained, since the DEBUG macro
can now be defined for the DPLL3 M2 clock alone.  This should reduce
unnecessary console noise when debugging DVFS.

Also, if at some future point the mach-omap2/ directory is split
into OMAP2/3/4 variants, this clkt file can be placed in the mach-omap34xx/
directory, rather than shared with other chip types that don't use this
clock type.

This patch also lays the groundwork to skip compilation of this
code on OMAP3 chips that don't support DVFS (e.g., AM35xx) via
the Makefile, rather than via #ifdefs.

Thanks to Alexander Shishkin <virtuoso@slind.org> for his comments to
improve the patch description.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jouni H?gander <jouni.hogander@nokia.com>
Cc: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/mach-omap2/Makefile           |    3 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |  120 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.c        |   90 ------------------------
 3 files changed, 122 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt34xx_dpll3m2.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7ce5fea..b7b7d7e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -15,11 +15,12 @@ clock-omap2xxx				= clkt2xxx_dpllcore.o \
 					  clkt2xxx_virt_prcm_set.o \
 					  clkt2xxx_apll.o clkt2xxx_osc.o \
 					  clkt2xxx_sys.o
+clock-omap34xx				= clkt34xx_dpll3m2.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
 			    $(clock-omap2xxx)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
-			    $(omap-3-4-common)
+			    $(omap-3-4-common) $(clock-omap34xx)
 obj-$(CONFIG_ARCH_OMAP4) += $(omap-3-4-common) $(prcm-common) $(clock-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
new file mode 100644
index 0000000..14f1a4b
--- /dev/null
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -0,0 +1,120 @@
+/*
+ * OMAP3 M2 divider clock code
+ *
+ * Copyright (C) 2007-2008 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010 Nokia Corporation
+ *
+ * Paul Walmsley
+ * Jouni H?gander
+ *
+ * Parts of this code are based on code written by
+ * Richard Woodruff, Tony Lindgren, Tuukka Tikkanen, Karthik Dasu
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/clock.h>
+#include <plat/sram.h>
+#include <plat/sdrc.h>
+
+#include "clock.h"
+#include "clock34xx.h"
+#include "sdrc.h"
+
+#define CYCLES_PER_MHZ			1000000
+
+/*
+ * CORE DPLL (DPLL3) M2 divider rate programming functions
+ *
+ * These call into SRAM code to do the actual CM writes, since the SDRAM
+ * is clocked from DPLL3.
+ */
+
+/**
+ * omap3_core_dpll_m2_set_rate - set CORE DPLL M2 divider
+ * @clk: struct clk * of DPLL to set
+ * @rate: rounded target rate
+ *
+ * Program the DPLL M2 divider with the rounded target rate.  Returns
+ * -EINVAL upon error, or 0 upon success.
+ */
+int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 new_div = 0;
+	u32 unlock_dll = 0;
+	u32 c;
+	unsigned long validrate, sdrcrate, _mpurate;
+	struct omap_sdrc_params *sdrc_cs0;
+	struct omap_sdrc_params *sdrc_cs1;
+	int ret;
+
+	if (!clk || !rate)
+		return -EINVAL;
+
+	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
+	if (validrate != rate)
+		return -EINVAL;
+
+	sdrcrate = sdrc_ick_p->rate;
+	if (rate > clk->rate)
+		sdrcrate <<= ((rate / clk->rate) >> 1);
+	else
+		sdrcrate >>= ((clk->rate / rate) >> 1);
+
+	ret = omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
+	if (ret)
+		return -EINVAL;
+
+	if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
+		pr_debug("clock: will unlock SDRC DLL\n");
+		unlock_dll = 1;
+	}
+
+	/*
+	 * XXX This only needs to be done when the CPU frequency changes
+	 */
+	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
+	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
+	c += 1;  /* for safety */
+	c *= SDRC_MPURATE_LOOPS;
+	c >>= SDRC_MPURATE_SCALE;
+	if (c == 0)
+		c = 1;
+
+	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
+		 validrate);
+	pr_debug("clock: SDRC CS0 timing params used:"
+		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+		 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+		 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
+	if (sdrc_cs1)
+		pr_debug("clock: SDRC CS1 timing params used: "
+		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+		 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
+		 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+
+	if (sdrc_cs1)
+		omap3_configure_core_dpll(
+				  new_div, unlock_dll, c, rate > clk->rate,
+				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
+				  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
+				  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+	else
+		omap3_configure_core_dpll(
+				  new_div, unlock_dll, c, rate > clk->rate,
+				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
+				  0, 0, 0, 0);
+
+	return 0;
+}
+
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 4c4bb3c..552ad30 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -42,8 +42,6 @@
 #include "cm.h"
 #include "cm-regbits-34xx.h"
 
-#define CYCLES_PER_MHZ			1000000
-
 /*
  * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
  * that are sourced by DPLL5, and both of these require this clock
@@ -162,94 +160,6 @@ int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 	return omap3_noncore_dpll_set_rate(clk, rate);
 }
 
-
-/*
- * CORE DPLL (DPLL3) rate programming functions
- *
- * These call into SRAM code to do the actual CM writes, since the SDRAM
- * is clocked from DPLL3.
- */
-
-/**
- * omap3_core_dpll_m2_set_rate - set CORE DPLL M2 divider
- * @clk: struct clk * of DPLL to set
- * @rate: rounded target rate
- *
- * Program the DPLL M2 divider with the rounded target rate.  Returns
- * -EINVAL upon error, or 0 upon success.
- */
-int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
-{
-	u32 new_div = 0;
-	u32 unlock_dll = 0;
-	u32 c;
-	unsigned long validrate, sdrcrate, _mpurate;
-	struct omap_sdrc_params *sdrc_cs0;
-	struct omap_sdrc_params *sdrc_cs1;
-	int ret;
-
-	if (!clk || !rate)
-		return -EINVAL;
-
-	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
-	if (validrate != rate)
-		return -EINVAL;
-
-	sdrcrate = sdrc_ick_p->rate;
-	if (rate > clk->rate)
-		sdrcrate <<= ((rate / clk->rate) >> 1);
-	else
-		sdrcrate >>= ((clk->rate / rate) >> 1);
-
-	ret = omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
-	if (ret)
-		return -EINVAL;
-
-	if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
-		pr_debug("clock: will unlock SDRC DLL\n");
-		unlock_dll = 1;
-	}
-
-	/*
-	 * XXX This only needs to be done when the CPU frequency changes
-	 */
-	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
-	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
-	c += 1;  /* for safety */
-	c *= SDRC_MPURATE_LOOPS;
-	c >>= SDRC_MPURATE_SCALE;
-	if (c == 0)
-		c = 1;
-
-	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
-		 validrate);
-	pr_debug("clock: SDRC CS0 timing params used:"
-		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
-		 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-		 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
-	if (sdrc_cs1)
-		pr_debug("clock: SDRC CS1 timing params used: "
-		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
-		 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-		 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
-
-	if (sdrc_cs1)
-		omap3_configure_core_dpll(
-				  new_div, unlock_dll, c, rate > clk->rate,
-				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-				  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-				  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
-	else
-		omap3_configure_core_dpll(
-				  new_div, unlock_dll, c, rate > clk->rate,
-				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-				  0, 0, 0, 0);
-
-	return 0;
-}
-
 /* Common clock code */
 
 /*
-- 
1.6.6.rc2.5.g49666
