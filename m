From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Fri, 19 Aug 2011 18:39:57 +0530
Subject: [RFC PATCH 1/4] ARM: kernel: Small fixes in save/restore common code.
In-Reply-To: <1313759340-31319-1-git-send-email-amit.kachhap@linaro.org>
References: <1313759340-31319-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <1313759400-31347-1-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These changes are necessary to make the retention cpuidle state work. This adds 
support for saving more L2 registers.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/common/gic.c        |    1 -
 arch/arm/kernel/sr_helpers.h |    2 +-
 arch/arm/mm/cache-l2x0.c     |   10 +++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index d845b75..124e122 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -385,7 +385,6 @@ static void gic_dist_save(unsigned int gic_nr)
 		gic_data[gic_nr].saved_spi_enable[i] =
 			readl_relaxed(dist_base + GIC_DIST_ENABLE_SET + i * 4);
 
-	writel_relaxed(0, dist_base + GIC_DIST_CTRL);
 }
 
 /*
diff --git a/arch/arm/kernel/sr_helpers.h b/arch/arm/kernel/sr_helpers.h
index 1ae3a9a..5a30461 100644
--- a/arch/arm/kernel/sr_helpers.h
+++ b/arch/arm/kernel/sr_helpers.h
@@ -44,7 +44,7 @@ static inline void exit_coherency(void)
 		"mcr	p15, 0, %0, c1, c0, 1\n"
 		 : "=&r" (v)
 		 : "Ir" (0x40)
-		 : );
+		 : "cc");
 }
 #else
 static inline void exit_coherency(void) { }
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 4c99d41..f23696b 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -285,7 +285,11 @@ static void l2x0_save_context(void *data, bool dormant, unsigned long end)
 	*l2x0_regs =  readl_relaxed(l2x0_base + L2X0_TAG_LATENCY_CTRL);
 	l2x0_regs++;
 	*l2x0_regs =  readl_relaxed(l2x0_base + L2X0_DATA_LATENCY_CTRL);
-
+	l2x0_regs++;
+	*l2x0_regs =  readl_relaxed(l2x0_base + L2X0_PREFETCH_CTRL);
+	l2x0_regs++;
+	*l2x0_regs =  readl_relaxed(l2x0_base + L2X0_POWER_CTRL);
+	dormant = 0;
 	if (!dormant) {
 		/* clean entire L2 before disabling it*/
 		writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
@@ -325,6 +329,10 @@ static void l2x0_restore_context(void *data, bool dormant)
 		writel_relaxed(*l2x0_regs, l2x0_base + L2X0_TAG_LATENCY_CTRL);
 		l2x0_regs++;
 		writel_relaxed(*l2x0_regs, l2x0_base + L2X0_DATA_LATENCY_CTRL);
+		l2x0_regs++;
+		writel_relaxed(*l2x0_regs, l2x0_base + L2X0_PREFETCH_CTRL);
+		l2x0_regs++;
+		writel_relaxed(*l2x0_regs, l2x0_base + L2X0_POWER_CTRL);
 		/*
 		 * If L2 is retained do not invalidate
 		 */
-- 
1.7.1
