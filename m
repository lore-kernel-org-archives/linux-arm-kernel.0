From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 20 Jan 2011 14:33:57 +0800
Subject: [PATCH] ARM: TWD: fix the clock calculation for TWD
Message-ID: <1295505237-5735-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original code will do count * (HZ /5). It will make the twd
timer rate decreased if HZ can not be excatly divided. For
example HZ=128.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/kernel/smp_twd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 35882fb..ca6405b 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -111,7 +111,8 @@ static void __cpuinit twd_calibrate_rate(void)
 
 		count = __raw_readl(twd_base + TWD_TIMER_COUNTER);
 
-		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
+		twd_timer_rate = ((unsigned long)(0xFFFFFFFFU - count))
+			* HZ / 5;
 
 		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
 			(twd_timer_rate / 100000) % 100);
-- 
1.6.3.3
