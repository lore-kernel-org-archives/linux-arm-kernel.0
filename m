From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:12:48 +0100
Subject: [PATCH 1/5] ARM: hw_breakpoint: add initial Cortex-A15 (debug v7.1)
	support
In-Reply-To: <1312823572-9807-1-git-send-email-will.deacon@arm.com>
References: <1312823572-9807-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823572-9807-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds initial support for Cortex-A15 (debug architecture v7.1)
to the hw_breakpoint ARM backend.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hw_breakpoint.h |    1 +
 arch/arm/kernel/hw_breakpoint.c      |   52 +++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index f389b27..0ac141a 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -50,6 +50,7 @@ static inline void decode_ctrl_reg(u32 reg,
 #define ARM_DEBUG_ARCH_V6_1	2
 #define ARM_DEBUG_ARCH_V7_ECP14	3
 #define ARM_DEBUG_ARCH_V7_MM	4
+#define ARM_DEBUG_ARCH_V7_1	5
 
 /* Breakpoint */
 #define ARM_BREAKPOINT_EXECUTE	0
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index a927ca1..9848157 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -154,7 +154,7 @@ u8 arch_get_debug_arch(void)
 static int debug_arch_supported(void)
 {
 	u8 arch = get_debug_arch();
-	return arch >= ARM_DEBUG_ARCH_V6 && arch <= ARM_DEBUG_ARCH_V7_ECP14;
+	return arch >= ARM_DEBUG_ARCH_V6 && arch <= ARM_DEBUG_ARCH_V7_1;
 }
 
 /* Determine number of BRP register available. */
@@ -255,6 +255,7 @@ static int enable_monitor_mode(void)
 		ARM_DBG_WRITE(c1, 0, (dscr | ARM_DSCR_MDBGEN));
 		break;
 	case ARM_DEBUG_ARCH_V7_ECP14:
+	case ARM_DEBUG_ARCH_V7_1:
 		ARM_DBG_WRITE(c2, 2, (dscr | ARM_DSCR_MDBGEN));
 		break;
 	default:
@@ -836,7 +837,7 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
  */
 static void reset_ctrl_regs(void *info)
 {
-	int i, cpu = smp_processor_id();
+	int i, err = 0, cpu = smp_processor_id();
 	u32 dbg_power;
 	cpumask_t *cpumask = info;
 
@@ -848,33 +849,46 @@ static void reset_ctrl_regs(void *info)
 	 * Access Register to avoid taking undefined instruction exceptions
 	 * later on.
 	 */
-	if (debug_arch >= ARM_DEBUG_ARCH_V7_ECP14) {
+	switch (debug_arch) {
+	case ARM_DEBUG_ARCH_V7_ECP14:
 		/*
 		 * Ensure sticky power-down is clear (i.e. debug logic is
 		 * powered up).
 		 */
 		asm volatile("mrc p14, 0, %0, c1, c5, 4" : "=r" (dbg_power));
-		if ((dbg_power & 0x1) == 0) {
-			pr_warning("CPU %d debug is powered down!\n", cpu);
-			cpumask_or(cpumask, cpumask, cpumask_of(cpu));
-			return;
-		}
-
+		if ((dbg_power & 0x1) == 0)
+			err = -EPERM;
+		break;
+	case ARM_DEBUG_ARCH_V7_1:
 		/*
-		 * Unconditionally clear the lock by writing a value
-		 * other than 0xC5ACCE55 to the access register.
+		 * Ensure the OS double lock is clear.
 		 */
-		asm volatile("mcr p14, 0, %0, c1, c0, 4" : : "r" (0));
-		isb();
+		asm volatile("mrc p14, 0, %0, c1, c3, 4" : "=r" (dbg_power));
+		if ((dbg_power & 0x1) == 1)
+			err = -EPERM;
+		break;
+	}
 
-		/*
-		 * Clear any configured vector-catch events before
-		 * enabling monitor mode.
-		 */
-		asm volatile("mcr p14, 0, %0, c0, c7, 0" : : "r" (0));
-		isb();
+	if (err) {
+		pr_warning("CPU %d debug is powered down!\n", cpu);
+		cpumask_or(cpumask, cpumask, cpumask_of(cpu));
+		return;
 	}
 
+	/*
+	 * Unconditionally clear the lock by writing a value
+	 * other than 0xC5ACCE55 to the access register.
+	 */
+	asm volatile("mcr p14, 0, %0, c1, c0, 4" : : "r" (0));
+	isb();
+
+	/*
+	 * Clear any configured vector-catch events before
+	 * enabling monitor mode.
+	 */
+	asm volatile("mcr p14, 0, %0, c0, c7, 0" : : "r" (0));
+	isb();
+
 	if (enable_monitor_mode())
 		return;
 
-- 
1.7.0.4
