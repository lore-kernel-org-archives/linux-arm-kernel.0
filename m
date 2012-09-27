From: fwu@marvell.com (Fan Wu)
Date: Thu, 27 Sep 2012 14:36:01 +0800
Subject: [PATCH] ARM:CPUIDLE: Fix wrongly used idle control counter
Message-ID: <1348727761-16485-1-git-send-email-fwu@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: fwu <fwu@marvell.com>

1. On ARM platform, "nohlt" can be used to prevent core from idle
   process, returning immediately.
2. There are two interface, exported for other modules, named
   disable_hlt and enable_hlt and used to enable/disable the
   cpuidle mechanism by increasing/decreasing "hlt_counter".
   So, the more "hlt_counter" is, the more user want to disable
   cpuidle. Disable_hlt and enable_hlt are paired operation,
   when you first call disable_hlt and then enable_hlt, the
   semantics are right, but if you call enable_hlt and
   then disable_hlt, it is wrong.
3. Change "hlt_counter > 0" can fix the problem.
   The judgement whethere the cpuidle is disabled need to check
   whether the "hlt_counter > 0" rather than "hlt_counter != 0".

Change-Id: Ibd5ea805b0c01fe326833d333ce5d72e0447430a
Signed-off-by: fwu <fwu@marvell.com>
Signed-off-by: YiLu Mao <ylmao@marvell.com>
Signed-off-by: Ning Jiang <ning.jiang@marvell.com>
---
 arch/arm/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 693b744..4dc2fee 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -204,7 +204,7 @@ void cpu_idle(void)
 #ifdef CONFIG_PL310_ERRATA_769419
 			wmb();
 #endif
-			if (hlt_counter) {
+			if (hlt_counter > 0) {
 				local_irq_enable();
 				cpu_relax();
 			} else if (!need_resched()) {
-- 
1.7.0.4
