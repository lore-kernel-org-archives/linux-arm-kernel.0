From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Tue, 22 Apr 2014 19:48:53 -0500
Subject: [PATCH v6 2/6] ARM: allow user access to arch timer virtual counter
In-Reply-To: <cover.1398213562.git.nathan_lynch@mentor.com>
References: <cover.1398213562.git.nathan_lynch@mentor.com>
Message-ID: <10ed3f4cfce13a80a9a3070934fc0e31619a1242.1398213562.git.nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As ARM64 does.  This is a necessary prerequisite for implementing
gettimeofday and clock_gettime in a vdso.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/include/asm/arch_timer.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 0704e0cf5571..047c800b57f0 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -103,13 +103,16 @@ static inline void arch_counter_set_user_access(void)
 {
 	u32 cntkctl = arch_timer_get_cntkctl();
 
-	/* Disable user access to both physical/virtual counters/timers */
+	/* Disable user access to the timers and the physical counter */
 	/* Also disable virtual event stream */
 	cntkctl &= ~(ARCH_TIMER_USR_PT_ACCESS_EN
 			| ARCH_TIMER_USR_VT_ACCESS_EN
 			| ARCH_TIMER_VIRT_EVT_EN
-			| ARCH_TIMER_USR_VCT_ACCESS_EN
 			| ARCH_TIMER_USR_PCT_ACCESS_EN);
+
+	/* Enable user access to the virtual counter */
+	cntkctl |= ARCH_TIMER_USR_VCT_ACCESS_EN;
+
 	arch_timer_set_cntkctl(cntkctl);
 }
 
-- 
1.8.3.1
