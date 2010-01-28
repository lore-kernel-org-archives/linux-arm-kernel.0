From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Jan 2010 14:59:29 -0800
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and resume
	functions
Message-ID: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Willie Ruan <wruan@quicinc.com>

The application processor in Qualcomm's MSM chips can be powered off
(also called power collapse) during suspend and idle time. L2 cache power
will be collapsed too on current chips. To handle this scenario, we need
to add a function (l2x0_suspend here) to flush L2 cache before the power
loss and another function (l2x0_resume) to restore the cache settings
after the power is restored.

To minimize performance impact these two functions should be called as
close as possible to the point where power is collapsed and restored.
Since it is possible that the power could not be turned off, e.g. due to
a pending interrupt, the parameter 'collapsed' should be used for the
l2x0_resume function to indicate the actual power collapse state.

Signed-off-by: Willie Ruan <wruan@quicinc.com>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    3 ++
 arch/arm/mm/cache-l2x0.c                   |   46 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index cdb9022..a86b948 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -55,4 +55,7 @@
 extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
 #endif
 
+extern void l2x0_suspend(void);
+extern void l2x0_resume(int collapsed);
+
 #endif
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index cb8fc65..c746878 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -2,6 +2,7 @@
  * arch/arm/mm/cache-l2x0.c - L210/L220 cache controller support
  *
  * Copyright (C) 2007 ARM Limited
+ * Copyright (c) 2009, Code Aurora Forum. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -26,6 +27,7 @@
 #define CACHE_LINE_SIZE		32
 
 static void __iomem *l2x0_base;
+static uint32_t aux_ctrl_save;
 static DEFINE_SPINLOCK(l2x0_lock);
 
 static inline void cache_wait(void __iomem *reg, unsigned long mask)
@@ -54,6 +56,13 @@ static inline void l2x0_inv_all(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static inline void l2x0_flush_all(void)
+{
+	/* clean and invalidate all ways */
+	sync_writel(0xff, L2X0_CLEAN_INV_WAY, 0xff);
+	cache_sync();
+}
+
 static void l2x0_inv_range(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
@@ -176,3 +185,40 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 
 	printk(KERN_INFO "L2X0 cache controller enabled\n");
 }
+
+/*
+ * l2x0_suspend - Suspend L2 cache
+ *
+ * Call this function when L2 cache power will be collapsed (power-off):
+ * 	1) during suspend;
+ *	2) during idle.
+ */
+void l2x0_suspend(void)
+{
+	/* Save aux control register value */
+	aux_ctrl_save = readl(l2x0_base + L2X0_AUX_CTRL);
+	/* Flush all cache */
+	l2x0_flush_all();
+	/* Disable the cache */
+	writel(0, l2x0_base + L2X0_CTRL);
+}
+
+/*
+ * l2x0_resume - Resume L2 cache
+ * @collapsed:  1 -- power was collapsed
+ *              0 -- power was not collapsed
+ *
+ * Call this function with the 'collapsed' paramater to tell
+ * whether the power was really collapsed. Cache is still valid
+ * if there was no power loss, thus performance is maintained
+ * because of no need to invalidate the cache.
+ */
+void l2x0_resume(int collapsed)
+{
+	if (collapsed)
+		/* Restore aux control register value */
+		writel(aux_ctrl_save, l2x0_base + L2X0_AUX_CTRL);
+
+	/* Enable the cache */
+	writel(1, l2x0_base + L2X0_CTRL);
+}
-- 
1.6.3.3
