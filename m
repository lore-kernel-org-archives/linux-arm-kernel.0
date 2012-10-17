From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:31:41 +0100
Subject: [PATCH 7/7] ARM: hw_breakpoint: use CRn as argument for debug reg
 accessor macros
In-Reply-To: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350487901-3108-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The coprocessor register CRn for accesses to the debug register can be a
different one than C0. Take this into account for the ARM_DBG_READ and
the ARM_DBG_WRITE macro.

The inline assembler calls which used a coprocessor register CRn other
than C0 are replaced by the ARM_DBG_READ or ARM_DBG_WRITE macro.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hw_breakpoint.h |    8 +++---
 arch/arm/kernel/hw_breakpoint.c      |   40 +++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index c190bc9..01169dd 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -98,12 +98,12 @@ static inline void decode_ctrl_reg(u32 reg,
 #define ARM_BASE_WCR		112
 
 /* Accessor macros for the debug registers. */
-#define ARM_DBG_READ(M, OP2, VAL) do {\
-	asm volatile("mrc p14, 0, %0, c0," #M ", " #OP2 : "=r" (VAL));\
+#define ARM_DBG_READ(N, M, OP2, VAL) do {\
+	asm volatile("mrc p14, 0, %0, " #N "," #M ", " #OP2 : "=r" (VAL));\
 } while (0)
 
-#define ARM_DBG_WRITE(M, OP2, VAL) do {\
-	asm volatile("mcr p14, 0, %0, c0," #M ", " #OP2 : : "r" (VAL));\
+#define ARM_DBG_WRITE(N, M, OP2, VAL) do {\
+	asm volatile("mcr p14, 0, %0, " #N "," #M ", " #OP2 : : "r" (VAL));\
 } while (0)
 
 struct notifier_block;
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 3127ae4..05fdd68 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -52,14 +52,14 @@ static u8 debug_arch;
 /* Maximum supported watchpoint length. */
 static u8 max_watchpoint_len;
 
-#define READ_WB_REG_CASE(OP2, M, VAL)		\
-	case ((OP2 << 4) + M):			\
-		ARM_DBG_READ(c ## M, OP2, VAL); \
+#define READ_WB_REG_CASE(OP2, M, VAL)			\
+	case ((OP2 << 4) + M):				\
+		ARM_DBG_READ(c0, c ## M, OP2, VAL);	\
 		break
 
-#define WRITE_WB_REG_CASE(OP2, M, VAL)		\
-	case ((OP2 << 4) + M):			\
-		ARM_DBG_WRITE(c ## M, OP2, VAL);\
+#define WRITE_WB_REG_CASE(OP2, M, VAL)			\
+	case ((OP2 << 4) + M):				\
+		ARM_DBG_WRITE(c0, c ## M, OP2, VAL);	\
 		break
 
 #define GEN_READ_WB_REG_CASES(OP2, VAL)		\
@@ -140,7 +140,7 @@ static u8 get_debug_arch(void)
 		"Assuming v6 debug is present.\n"))
 		return ARM_DEBUG_ARCH_V6;
 
-	ARM_DBG_READ(c0, 0, didr);
+	ARM_DBG_READ(c0, c0, 0, didr);
 	return (didr >> 16) & 0xf;
 }
 
@@ -168,7 +168,7 @@ static int debug_exception_updates_fsr(void)
 static int get_num_wrp_resources(void)
 {
 	u32 didr;
-	ARM_DBG_READ(c0, 0, didr);
+	ARM_DBG_READ(c0, c0, 0, didr);
 	return ((didr >> 28) & 0xf) + 1;
 }
 
@@ -176,7 +176,7 @@ static int get_num_wrp_resources(void)
 static int get_num_brp_resources(void)
 {
 	u32 didr;
-	ARM_DBG_READ(c0, 0, didr);
+	ARM_DBG_READ(c0, c0, 0, didr);
 	return ((didr >> 24) & 0xf) + 1;
 }
 
@@ -230,14 +230,14 @@ static int get_num_brps(void)
 static int monitor_mode_enabled(void)
 {
 	u32 dscr;
-	ARM_DBG_READ(c1, 0, dscr);
+	ARM_DBG_READ(c0, c1, 0, dscr);
 	return !!(dscr & ARM_DSCR_MDBGEN);
 }
 
 static int enable_monitor_mode(void)
 {
 	u32 dscr;
-	ARM_DBG_READ(c1, 0, dscr);
+	ARM_DBG_READ(c0, c1, 0, dscr);
 
 	/* If monitor mode is already enabled, just return. */
 	if (dscr & ARM_DSCR_MDBGEN)
@@ -247,11 +247,11 @@ static int enable_monitor_mode(void)
 	switch (get_debug_arch()) {
 	case ARM_DEBUG_ARCH_V6:
 	case ARM_DEBUG_ARCH_V6_1:
-		ARM_DBG_WRITE(c1, 0, (dscr | ARM_DSCR_MDBGEN));
+		ARM_DBG_WRITE(c0, c1, 0, (dscr | ARM_DSCR_MDBGEN));
 		break;
 	case ARM_DEBUG_ARCH_V7_ECP14:
 	case ARM_DEBUG_ARCH_V7_1:
-		ARM_DBG_WRITE(c2, 2, (dscr | ARM_DSCR_MDBGEN));
+		ARM_DBG_WRITE(c0, c2, 2, (dscr | ARM_DSCR_MDBGEN));
 		isb();
 		break;
 	default:
@@ -259,7 +259,7 @@ static int enable_monitor_mode(void)
 	}
 
 	/* Check that the write made it through. */
-	ARM_DBG_READ(c1, 0, dscr);
+	ARM_DBG_READ(c0, c1, 0, dscr);
 	if (WARN_ONCE(!(dscr & ARM_DSCR_MDBGEN),
 		"Failed to enable monitor mode on CPU %d.\n",
 		smp_processor_id()))
@@ -852,7 +852,7 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
 		local_irq_enable();
 
 	/* We only handle watchpoints and hardware breakpoints. */
-	ARM_DBG_READ(c1, 0, dscr);
+	ARM_DBG_READ(c0, c1, 0, dscr);
 
 	/* Perform perf callbacks. */
 	switch (ARM_DSCR_MOE(dscr)) {
@@ -920,14 +920,14 @@ static void reset_ctrl_regs(void *unused)
 		 * Ensure sticky power-down is clear (i.e. debug logic is
 		 * powered up).
 		 */
-		asm volatile("mrc p14, 0, %0, c1, c5, 4" : "=r" (dbg_power));
+		ARM_DBG_READ(c1, c5, 4, dbg_power);
 		if ((dbg_power & 0x1) == 0)
 			err = -EPERM;
 
 		/*
 		 * Check whether we implement OS save and restore.
 		 */
-		asm volatile("mrc p14, 0, %0, c1, c1, 4" : "=r" (dbg_power));
+		ARM_DBG_READ(c1, c1, 4, dbg_power);
 		if ((dbg_power & 0x9) == 0)
 			goto clear_vcr;
 		break;
@@ -935,7 +935,7 @@ static void reset_ctrl_regs(void *unused)
 		/*
 		 * Ensure the OS double lock is clear.
 		 */
-		asm volatile("mrc p14, 0, %0, c1, c3, 4" : "=r" (dbg_power));
+		ARM_DBG_READ(c1, c3, 4, dbg_power);
 		if ((dbg_power & 0x1) == 1)
 			err = -EPERM;
 		break;
@@ -951,7 +951,7 @@ static void reset_ctrl_regs(void *unused)
 	 * Unconditionally clear the OS lock by writing a value
 	 * other than 0xC5ACCE55 to the access register.
 	 */
-	asm volatile("mcr p14, 0, %0, c1, c0, 4" : : "r" (0));
+	ARM_DBG_WRITE(c1, c0, 4, 0);
 	isb();
 
 	/*
@@ -959,7 +959,7 @@ static void reset_ctrl_regs(void *unused)
 	 * enabling monitor mode.
 	 */
 clear_vcr:
-	asm volatile("mcr p14, 0, %0, c0, c7, 0" : : "r" (0));
+	ARM_DBG_WRITE(c0, c7, 0, 0);
 	isb();
 
 	if (cpumask_intersects(&debug_err_mask, cpumask_of(cpu))) {
-- 
1.7.4.1
