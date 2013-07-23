From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Jul 2013 12:09:23 +0100
Subject: [PATCH v3 11/12] ARM: l2x0: use -st dsb option for ordering
 writel_relaxed with unlock
In-Reply-To: <1374577764-32480-1-git-send-email-will.deacon@arm.com>
References: <1374577764-32480-1-git-send-email-will.deacon@arm.com>
Message-ID: <1374577764-32480-12-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

writel_relaxed and spin_unlock are both store operations, so we only
need to enforce store ordering in the dsb.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-l2x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index d70e0ab..0c3fc27 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -290,7 +290,7 @@ static void l2x0_disable(void)
 	raw_spin_lock_irqsave(&l2x0_lock, flags);
 	__l2x0_flush_all();
 	writel_relaxed(0, l2x0_base + L2X0_CTRL);
-	dsb();
+	dsb(st);
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-- 
1.8.2.2
