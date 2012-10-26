From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Oct 2012 11:30:08 +0100
Subject: [PATCH v2 1/8] ARM: hw_breakpoint: only clear OS lock when
 implemented on v7
Message-ID: <1351247415-25090-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OS save and restore register are optional in debug architecture v7,
so check the status register before attempting to clear the OS lock.

Tested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 281bf33..76a650a 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -906,7 +906,7 @@ static struct undef_hook debug_reg_hook = {
 static void reset_ctrl_regs(void *unused)
 {
 	int i, raw_num_brps, err = 0, cpu = smp_processor_id();
-	u32 dbg_power;
+	u32 val;
 
 	/*
 	 * v7 debug contains save and restore registers so that debug state
@@ -926,16 +926,23 @@ static void reset_ctrl_regs(void *unused)
 		 * Ensure sticky power-down is clear (i.e. debug logic is
 		 * powered up).
 		 */
-		asm volatile("mrc p14, 0, %0, c1, c5, 4" : "=r" (dbg_power));
-		if ((dbg_power & 0x1) == 0)
+		asm volatile("mrc p14, 0, %0, c1, c5, 4" : "=r" (val));
+		if ((val & 0x1) == 0)
 			err = -EPERM;
+
+		/*
+		 * Check whether we implement OS save and restore.
+		 */
+		asm volatile("mrc p14, 0, %0, c1, c1, 4" : "=r" (val));
+		if ((val & 0x9) == 0)
+			goto clear_vcr;
 		break;
 	case ARM_DEBUG_ARCH_V7_1:
 		/*
 		 * Ensure the OS double lock is clear.
 		 */
-		asm volatile("mrc p14, 0, %0, c1, c3, 4" : "=r" (dbg_power));
-		if ((dbg_power & 0x1) == 1)
+		asm volatile("mrc p14, 0, %0, c1, c3, 4" : "=r" (val));
+		if ((val & 0x1) == 1)
 			err = -EPERM;
 		break;
 	}
@@ -947,7 +954,7 @@ static void reset_ctrl_regs(void *unused)
 	}
 
 	/*
-	 * Unconditionally clear the lock by writing a value
+	 * Unconditionally clear the OS lock by writing a value
 	 * other than 0xC5ACCE55 to the access register.
 	 */
 	asm volatile("mcr p14, 0, %0, c1, c0, 4" : : "r" (0));
@@ -957,6 +964,7 @@ static void reset_ctrl_regs(void *unused)
 	 * Clear any configured vector-catch events before
 	 * enabling monitor mode.
 	 */
+clear_vcr:
 	asm volatile("mcr p14, 0, %0, c0, c7, 0" : : "r" (0));
 	isb();
 
-- 
1.7.4.1
