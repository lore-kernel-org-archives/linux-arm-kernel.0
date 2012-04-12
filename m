From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Apr 2012 15:12:25 +0100
Subject: [PATCH 2/3] ARM: l2x0: only apply workaround for erratum #753970 on
 PL310
In-Reply-To: <1334239946-15934-1-git-send-email-will.deacon@arm.com>
References: <1334239946-15934-1-git-send-email-will.deacon@arm.com>
Message-ID: <1334239946-15934-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The workaround for PL310 erratum #753970 can lead to deadlock on systems
with an L220 cache controller.

This patch makes the workaround effective only when the cache controller
is identified as a PL310 at probe time.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-l2x0.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index a53fd2a..a8d02c0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -32,6 +32,7 @@ static void __iomem *l2x0_base;
 static DEFINE_RAW_SPINLOCK(l2x0_lock);
 static u32 l2x0_way_mask;	/* Bitmask of active ways */
 static u32 l2x0_size;
+static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
 
 struct l2x0_regs l2x0_saved_regs;
 
@@ -61,12 +62,7 @@ static inline void cache_sync(void)
 {
 	void __iomem *base = l2x0_base;
 
-#ifdef CONFIG_PL310_ERRATA_753970
-	/* write to an unmmapped register */
-	writel_relaxed(0, base + L2X0_DUMMY_REG);
-#else
-	writel_relaxed(0, base + L2X0_CACHE_SYNC);
-#endif
+	writel_relaxed(0, base + sync_reg_offset);
 	cache_wait(base + L2X0_CACHE_SYNC, 1);
 }
 
@@ -331,6 +327,10 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 		else
 			ways = 8;
 		type = "L310";
+#ifdef CONFIG_PL310_ERRATA_753970
+		/* Unmapped register. */
+		sync_reg_offset = L2X0_DUMMY_REG;
+#endif
 		break;
 	case L2X0_CACHE_ID_PART_L210:
 		ways = (aux >> 13) & 0xf;
-- 
1.7.4.1
