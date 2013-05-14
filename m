From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 14:04:44 +0100
Subject: [PATCH 8/8] ARM: mpu: protect the vectors page with an MPU region
In-Reply-To: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
References: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368536684-13608-9-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without an MMU it is possible for userspace programs to start executing code
in places that they have no business executing. The MPU allows some level of
protection against this.

This patch protects the vectors page from access by userspace processes.
Userspace tasks that dereference a null pointer are already protected by an
svc at 0x0 that kills them. However when tasks use an offset from a null
pointer (eg a function in a null struct) they miss this carefully placed svc
and enter the exception vectors in user mode, ending up in the kernel.

This patch causes programs that do this to receive a SEGV instead of happily
entering the kernel in user-mode, and hence avoid a 'Bad Mode' panic.

As part of this change it is necessary to make sigreturn happen via the
stack when there is not an sa_restorer function. This change is invisible to
userspace, and irrelevant to code compiled using a uClibc toolchain, which
always uses an sa_restorer function.

Because we don't get to remap the vectors in !MMU kuser_helpers are not
in a defined location, and hence aren't usable. This means we don't need to
worry about keeping them accessible from PL0

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
CC: Nicolas Pitre <nico@linaro.org>
CC: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/mpu.h   |    1 +
 arch/arm/kernel/head-nommu.S |   16 ++++++++++++++++
 arch/arm/kernel/signal.c     |    9 +++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index 0014834..c3247cc 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -46,6 +46,7 @@
 #define MPU_PROBE_REGION	0
 #define MPU_BG_REGION		1
 #define MPU_RAM_REGION		2
+#define MPU_VECTORS_REGION	3
 
 /* Maximum number of regions Linux is interested in */
 #define MPU_MAX_REGIONS		16
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 3d3071b..0640704 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -21,6 +21,7 @@
 #include <asm/cp15.h>
 #include <asm/thread_info.h>
 #include <asm/mpu.h>
+#include <asm/page.h>
 
 /*
  * Kernel startup entry point.
@@ -184,6 +185,7 @@ ENDPROC(__after_proc_init)
  * Region 0: Use this for probing the MPU details, so leave disabled.
  * Region 1: Background region - covers the whole of RAM as strongly ordered
  * Region 2: Normal, Shared, cacheable for RAM. From PHYS_OFFSET, size from r6
+ * Region 3: Normal, shared, inaccessible from PL0 to protect the vectors page
  *
  * r6: Value to be written to DRSR (and IRSR if required) for MPU_RAM_REGION
 */
@@ -228,6 +230,20 @@ ENTRY(__setup_mpu)
 	setup_region r0, r5, r6, MPU_INSTR_SIDE @ 0x0, BG region, enabled
 2:	isb
 
+	/* Vectors region */
+	set_region_nr r0, #MPU_VECTORS_REGION
+	isb
+	/* Shared, inaccessible to PL0, rw PL1 */
+	mov	r0, #CONFIG_VECTORS_BASE	@ Cover from VECTORS_BASE
+	ldr	r5,=(MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL)
+	/* Writing N to bits 5:1 (RSR_SZ) --> region size 2^N+1 */
+	mov	r6, #(((PAGE_SHIFT - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN)
+
+	setup_region r0, r5, r6, MPU_DATA_SIDE	@ VECTORS_BASE, PL0 NA, enabled
+	beq	3f				@ Memory-map not unified
+	setup_region r0, r5, r6, MPU_INSTR_SIDE	@ VECTORS_BASE, PL0 NA, enabled
+3:	isb
+
 	/* Enable the MPU */
 	mrc	p15, 0, r0, c1, c0, 0		@ Read SCTLR
 	bic     r0, r0, #CR_BR			@ Disable the 'default mem-map'
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 296786b..1c16c35 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -392,14 +392,19 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 			idx += 3;
 
+		/*
+		 * Put the sigreturn code on the stack no matter which return
+		 * mechanism we use in order to remain ABI compliant
+		 */
 		if (__put_user(sigreturn_codes[idx],   rc) ||
 		    __put_user(sigreturn_codes[idx+1], rc+1))
 			return 1;
 
-		if (cpsr & MODE32_BIT) {
+		if ((cpsr & MODE32_BIT) && !IS_ENABLED(CONFIG_ARM_MPU)) {
 			/*
 			 * 32-bit code can use the new high-page
-			 * signal return code support.
+			 * signal return code support except when the MPU has
+			 * protected the vectors page from PL0
 			 */
 			retcode = KERN_SIGRETURN_CODE + (idx << 2) + thumb;
 		} else {
-- 
1.7.9.5
