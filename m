From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Jan 2013 12:15:28 +0000
Subject: [PATCHv5 05/16] arm: arch_timer: split cntfrq accessor
In-Reply-To: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1359634539-9580-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CNTFRQ register is not duplicated for physical and virtual timers,
and accessing it as if it were is confusing.

Instead, use a separate accessor which doesn't take the access type
as a parameter.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/kernel/arch_timer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index eb78f43..f31c9ee 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -51,8 +51,7 @@ static bool arch_timer_use_virtual = true;
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
 
 #define ARCH_TIMER_REG_CTRL		0
-#define ARCH_TIMER_REG_FREQ		1
-#define ARCH_TIMER_REG_TVAL		2
+#define ARCH_TIMER_REG_TVAL		1
 
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
@@ -101,9 +100,6 @@ static inline u32 arch_timer_reg_read(const int access, const int reg)
 		case ARCH_TIMER_REG_TVAL:
 			asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
 			break;
-		case ARCH_TIMER_REG_FREQ:
-			asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (val));
-			break;
 		}
 	}
 
@@ -121,6 +117,13 @@ static inline u32 arch_timer_reg_read(const int access, const int reg)
 	return val;
 }
 
+static inline u32 arch_timer_get_cntfrq(void)
+{
+	u32 val;
+	asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (val));
+	return val;
+}
+
 static inline u64 arch_counter_get_cntpct(void)
 {
 	u64 cval;
@@ -253,8 +256,7 @@ static int arch_timer_available(void)
 	u32 freq;
 
 	if (arch_timer_rate == 0) {
-		freq = arch_timer_reg_read(ARCH_TIMER_PHYS_ACCESS,
-					   ARCH_TIMER_REG_FREQ);
+		freq = arch_timer_get_cntfrq();
 
 		/* Check the timer frequency. */
 		if (freq == 0) {
-- 
1.8.1.1
