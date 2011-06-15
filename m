From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Jun 2011 18:23:12 +0100
Subject: [PATCH v3 1/9] ARM: l2x0: fix disabling function to avoid deadlock
In-Reply-To: <1308158600-7169-1-git-send-email-will.deacon@arm.com>
References: <1308158600-7169-1-git-send-email-will.deacon@arm.com>
Message-ID: <1308158600-7169-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The l2x0_disable function attempts to writel with the l2x0_lock held.
This results in deadlock when the writel contains an outer_sync call
for the platform since the l2x0_lock is already held by the disable
function. A further problem is that disabling the L2 without flushing it
first can lead to the spin_lock operation becoming visible after the
spin_unlock, causing any subsequent L2 maintenance to deadlock.

This patch replaces the writel with a call to writel_relaxed in the
disabling code and adds a flush before disabling in the control
register, preventing livelock from occurring.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-l2x0.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ef59099..44c0867 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -120,17 +120,22 @@ static void l2x0_cache_sync(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void l2x0_flush_all(void)
+static void __l2x0_flush_all(void)
 {
-	unsigned long flags;
-
-	/* clean all ways */
-	spin_lock_irqsave(&l2x0_lock, flags);
 	debug_writel(0x03);
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
 	cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
 	cache_sync();
 	debug_writel(0x00);
+}
+
+static void l2x0_flush_all(void)
+{
+	unsigned long flags;
+
+	/* clean all ways */
+	spin_lock_irqsave(&l2x0_lock, flags);
+	__l2x0_flush_all();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
@@ -266,7 +271,9 @@ static void l2x0_disable(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&l2x0_lock, flags);
-	writel(0, l2x0_base + L2X0_CTRL);
+	__l2x0_flush_all();
+	writel_relaxed(0, l2x0_base + L2X0_CTRL);
+	dsb();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-- 
1.7.0.4
