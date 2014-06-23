From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Sun, 22 Jun 2014 22:11:52 -0500
Subject: [PATCH v7 3/9] ARM: arch_timer: remove unused functions
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1403493118-7597-4-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The counter access and evtstream configuration are now done in common
code, so remove the now-unused arch_counter_set_user_access and
arch_timer_evtstrm_enable.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/include/asm/arch_timer.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 0704e0cf5571..92793ba69c40 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -99,31 +99,6 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	asm volatile("mcr p15, 0, %0, c14, c1, 0" : : "r" (cntkctl));
 }
 
-static inline void arch_counter_set_user_access(void)
-{
-	u32 cntkctl = arch_timer_get_cntkctl();
-
-	/* Disable user access to both physical/virtual counters/timers */
-	/* Also disable virtual event stream */
-	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
-			| ARCH_TIMER_USR_VT_ACCESS_EN
-			| ARCH_TIMER_VIRT_EVT_EN
-			| ARCH_TIMER_USR_VCT_ACCESS_EN
-			| ARCH_TIMER_USR_PCT_ACCESS_EN);
-	arch_timer_set_cntkctl(cntkctl);
-}
-
-static inline void arch_timer_evtstrm_enable(int divider)
-{
-	u32 cntkctl = arch_timer_get_cntkctl();
-	cntkctl &= ~ARCH_TIMER_EVT_TRIGGER_MASK;
-	/* Set the divider and enable virtual event stream */
-	cntkctl |= (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
-			| ARCH_TIMER_VIRT_EVT_EN;
-	arch_timer_set_cntkctl(cntkctl);
-	elf_hwcap |= HWCAP_EVTSTRM;
-}
-
 #endif
 
 #endif
-- 
1.9.3
