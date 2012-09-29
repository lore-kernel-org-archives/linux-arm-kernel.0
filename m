From: fwu@marvell.com (Fan Wu)
Date: Sat, 29 Sep 2012 08:48:07 +0800
Subject: [PATCH] ARM: Add BUG_ON when hlt counter is wrongly used
Message-ID: <1348879687-18887-1-git-send-email-fwu@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: fwu <fwu@marvell.com>

1. On ARM platform, "nohlt" can be used to prevent core from idle
   process, returning immediately.
2. There are two interfaces, exported for other modules, named
   "disable_hlt" and "enable_hlt" are used to enable/disable the
   cpuidle mechanism by increasing/decreasing "hlt_counter".
   Disable_hlt and enable_hlt are paired operation,
   when you first call disable_hlt and then enable_hlt, the
   semantics are right.
3. There is no obvious constraint to prevent user(driver/module)
   code to prevent the case that enable_hlt is ahead of disable_hlt,
   which is a fatal operation on kernel state change from user,
   and there is no any WARNING or notification if the case happens
   in current kernel code.
   This patch aims to report BUG when the case happens, just like
   what the kernel do when enable_irq is ahead of disable_irq.

Signed-off-by: fwu <fwu@marvell.com>
Signed-off-by: YiLu Mao <ylmao@marvell.com>
Signed-off-by: Ning Jiang <ning.jiang@marvell.com>

---
 arch/arm/kernel/process.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 693b744..d3f2972 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -70,6 +70,7 @@ EXPORT_SYMBOL(disable_hlt);
 void enable_hlt(void)
 {
 	hlt_counter--;
+	BUG_ON(hlt_counter < 0);
 }
 
 EXPORT_SYMBOL(enable_hlt);
-- 
1.7.0.4
