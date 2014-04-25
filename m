From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:33:20 +0100
Subject: [PATCH 028/222] ARM: l2c: simplify l2x0 unlocking code
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeNc-0007F2-2a@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The l2x0 unlocking code is only called from l2x0_enable() now, so move
the logic entirely into that function and simplify it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index e3f4fcbcc88b..157fd7ae331a 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -352,30 +352,21 @@ static void l2x0_disable(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void l2x0_unlock(u32 cache_id)
+static void l2x0_enable(void __iomem *base, u32 aux, unsigned num_lock)
 {
-	int lockregs;
+	unsigned id;
 
-	switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
-	case L2X0_CACHE_ID_PART_L310:
-		lockregs = 8;
-		break;
-	default:
-		/* L210 and unknown types */
-		lockregs = 1;
-		break;
-	}
-
-	l2c_unlock(l2x0_base, lockregs);
-}
+	id = readl_relaxed(base + L2X0_CACHE_ID) & L2X0_CACHE_ID_PART_MASK;
+	if (id == L2X0_CACHE_ID_PART_L310)
+		num_lock = 8;
+	else
+		num_lock = 1;
 
-static void l2x0_enable(void __iomem *base, u32 aux, unsigned num_lock)
-{
 	/* l2x0 controller is disabled */
 	writel_relaxed(aux, base + L2X0_AUX_CTRL);
 
 	/* Make sure that I&D is not locked down when starting */
-	l2x0_unlock(readl_relaxed(base + L2X0_CACHE_ID));
+	l2c_unlock(base, num_lock);
 
 	l2x0_inv_all();
 
-- 
1.8.3.1
