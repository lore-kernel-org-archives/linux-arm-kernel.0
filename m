From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 18:04:54 +0100
Subject: [PATCH 2/6] ARM: l2x0: fix invalidate-all function to avoid livelock
In-Reply-To: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
References: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379898-14256-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the L2 cache disabled, exclusive memory access instructions may
cease to function correctly, leading to livelock when trying to acquire
a spinlock.

The l2x0 invalidate-all routine *must* run with the cache disabled and so
needs to take extra care not to take any locks along the way.

This patch modifies the invalidation routine to avoid locking. Since
the cache is disabled, we make the assumption that other CPUs are not
executing background maintenance tasks on the L2 cache whilst we are
invalidating it.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-l2x0.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 2bce3be..fe5630f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -148,16 +148,17 @@ static void l2x0_clean_all(void)
 
 static void l2x0_inv_all(void)
 {
-	unsigned long flags;
-
-	/* invalidate all ways */
-	spin_lock_irqsave(&l2x0_lock, flags);
 	/* Invalidating when L2 is enabled is a nono */
 	BUG_ON(readl(l2x0_base + L2X0_CTRL) & 1);
+
+	/*
+	 * invalidate all ways
+	 * Since the L2 is disabled, exclusive accessors may not be
+	 * available to us, so avoid taking any locks.
+	 */
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
 	cache_wait_way(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
 	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_inv_range(unsigned long start, unsigned long end)
-- 
1.7.0.4
