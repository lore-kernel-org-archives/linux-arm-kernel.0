From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 01 Oct 2012 05:15:45 -0400
Subject: [PATCH v2 1/5] ARM: arch_timers: switch to physical timers if HYP
 mode is available
In-Reply-To: <20121001091528.49694.69990.stgit@ubuntu>
References: <20121001091528.49694.69990.stgit@ubuntu>
Message-ID: <20121001091545.49694.51281.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

If we're booted in HYP mode, it is possible that we'll run some
kind of virtualized environment. In this case, it is a better to
switch to the physical timers, and leave the virtual timers to
guests.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/arch_timer.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index c04c2a6..8a30186 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -25,6 +25,7 @@
 #include <asm/arch_timer.h>
 #include <asm/system_info.h>
 #include <asm/sched_clock.h>
+#include <asm/virt.h>
 
 static unsigned long arch_timer_rate;
 
@@ -490,10 +491,14 @@ int __init arch_timer_of_register(void)
 		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
 
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
