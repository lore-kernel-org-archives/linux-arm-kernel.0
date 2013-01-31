From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:37 +0000
Subject: [PATCHv5 14/16] ARM: arch_timers: switch to physical timers if HYP
 mode is available
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-15-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <Marc.Zyngier@arm.com>

If we're booted in HYP mode, it is possible that we'll run some
kind of virtualized environment. In this case, it is a better to
switch to the physical timers, and leave the virtual timers to
guests.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ec30a73..d7ad425 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 
 #include <asm/arch_timer.h>
+#include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
 
@@ -364,10 +365,14 @@ int __init arch_timer_init(void)
 	of_node_put(np);
 
 	/*
+	 * If HYP mode is available, we know that the physical timer
+	 * has been configured to be accessible from PL1. Use it, so
+	 * that a guest can use the virtual timer instead.
+	 *
 	 * If no interrupt provided for virtual timer, we'll have to
 	 * stick to the physical timer. It'd better be accessible...
 	 */
-	if (!arch_timer_ppi[VIRT_PPI]) {
+	if (is_hyp_mode_available() || !arch_timer_ppi[VIRT_PPI]) {
 		arch_timer_use_virtual = false;
 
 		if (!arch_timer_ppi[PHYS_SECURE_PPI] ||
-- 
1.8.1.1
