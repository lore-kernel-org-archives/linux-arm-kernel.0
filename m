From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Jan 2013 17:45:28 +0000
Subject: [PATCHv4 11/14] arm64: arm_generic: prevent reading stale time
In-Reply-To: <1358271931-7761-1-git-send-email-mark.rutland@arm.com>
References: <1358271931-7761-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1358271931-7761-12-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently arch_counter_get_cnt{p,v}ct can be speculated, allowing for
stale time values to be read. This could be problematic for the delay
loop and other sensitive functions, as the time delta could jump around
unexpectedly.

This patch adds isbs to arch_counter_get_cnt{p,v}ct, preventing this
possibility.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/arm_generic.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/arm_generic.h b/arch/arm64/include/asm/arm_generic.h
index df2aeb8..6ece2f1 100644
--- a/arch/arm64/include/asm/arm_generic.h
+++ b/arch/arm64/include/asm/arm_generic.h
@@ -83,6 +83,7 @@ static inline cycle_t arch_counter_get_cntpct(void)
 {
 	cycle_t cval;
 
+	isb();
 	asm volatile("mrs %0, cntpct_el0" : "=r" (cval));
 
 	return cval;
@@ -92,6 +93,7 @@ static inline cycle_t arch_counter_get_cntvct(void)
 {
 	cycle_t cval;
 
+	isb();
 	asm volatile("mrs %0, cntvct_el0" : "=r" (cval));
 
 	return cval;
-- 
1.7.0.4
