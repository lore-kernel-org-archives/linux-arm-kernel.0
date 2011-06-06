From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 18:04:53 +0100
Subject: [PATCH 1/6] ARM: l2x0: fix disabling function to avoid livelock
In-Reply-To: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
References: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379898-14256-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The l2x0_disable function attempts to writel with the l2x0_lock held.
This results in livelock when the writel contains an outer_sync call
for the platform.

This patch replaces the writel with a call to writel_relaxed in the
disabling code, preventing livelock from occurring.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-l2x0.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index ef59099..2bce3be 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -266,7 +266,7 @@ static void l2x0_disable(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&l2x0_lock, flags);
-	writel(0, l2x0_base + L2X0_CTRL);
+	writel_relaxed(0, l2x0_base + L2X0_CTRL);
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-- 
1.7.0.4
