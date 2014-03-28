From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 28 Mar 2014 15:16:07 +0000
Subject: [PATCH 21/75] ARM: l2c: write auxctrl register before unlocking
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Message-ID: <E1WTYVr-0006Ms-RV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should write the auxillary control register before unlocking: the
write may be necessary to enable non-secure access to the lock
registers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2adb82e7f4b3..fc609550b7fa 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -92,10 +92,10 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
 {
 	unsigned long flags;
 
-	l2c_unlock(base, num_lock);
-
 	writel_relaxed(aux, base + L2X0_AUX_CTRL);
 
+	l2c_unlock(base, num_lock);
+
 	local_irq_save(flags);
 	__l2c_op_way(base + L2X0_INV_WAY);
 	writel_relaxed(0, base + sync_reg_offset);
@@ -368,12 +368,12 @@ static void l2x0_unlock(u32 cache_id)
 
 static void l2x0_enable(void __iomem *base, u32 aux, unsigned num_lock)
 {
-	/* Make sure that I&D is not locked down when starting */
-	l2x0_unlock(readl_relaxed(base + L2X0_CACHE_ID));
-
 	/* l2x0 controller is disabled */
 	writel_relaxed(aux, base + L2X0_AUX_CTRL);
 
+	/* Make sure that I&D is not locked down when starting */
+	l2x0_unlock(readl_relaxed(base + L2X0_CACHE_ID));
+
 	l2x0_inv_all();
 
 	/* enable L2X0 */
-- 
1.8.3.1
