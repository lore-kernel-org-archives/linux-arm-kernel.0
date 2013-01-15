From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Jan 2013 17:45:24 +0000
Subject: [PATCHv4 07/14] arm: arch_timer: add isbs to register accessors
In-Reply-To: <1358271931-7761-1-git-send-email-mark.rutland@arm.com>
References: <1358271931-7761-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1358271931-7761-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without the isbs in arch_timer_get_cnt{p,v}ct the cpu may speculate
reads and return stale values. This could be bad for code sensitive to
changes in expected deltas between calls (e.g. the delay loop).

Without isbs in arch_timer_reg_write the processor may reorder
instructions around enabling/disabling of the timer or writing the
compare value, which we probably don't want.

This patch adds isbs to prevent those issues.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm/include/asm/arch_timer.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index db0fdc4..75975d9 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -49,6 +49,8 @@ static inline void arch_timer_reg_write(const int access, const int reg, u32 val
 			break;
 		}
 	}
+
+	isb();
 }
 
 static inline u32 arch_timer_reg_read(const int access, const int reg)
@@ -91,6 +93,7 @@ static inline u64 arch_counter_get_cntpct(void)
 {
 	u64 cval;
 
+	isb();
 	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (cval));
 	return cval;
 }
@@ -99,6 +102,7 @@ static inline u64 arch_counter_get_cntvct(void)
 {
 	u64 cval;
 
+	isb();
 	asm volatile("mrrc p15, 1, %Q0, %R0, c14" : "=r" (cval));
 	return cval;
 }
-- 
1.7.0.4
