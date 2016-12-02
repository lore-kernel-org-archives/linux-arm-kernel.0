From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:25 +0000
Subject: [RFC v3 PATCH 07/25] ARM: NOMMU: relax restriction on MPU existence
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-8-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MPU is must have if we run SMP configurations (since it sets Sharable
attribute), but for UP we can progress further if MPU is not presented.

This patch changes setup_mpu to return error code which we ignore for
boot cpu and only take into account for secondaries.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/head-nommu.S |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 6b4eb27..7317554 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -13,6 +13,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <linux/errno.h>
 
 #include <asm/assembler.h>
 #include <asm/ptrace.h>
@@ -112,6 +113,8 @@ ENTRY(secondary_startup)
 	/* Use MPU region info supplied by __cpu_up */
 	ldr	r6, [r7]			@ get secondary_data.mpu_szr
 	bl      __setup_mpu			@ Initialize the MPU
+	teq	r0, #0
+	bne     __error_p
 #endif
 
 	badr	lr, 1f				@ return (PIC) address
@@ -201,7 +204,8 @@ ENDPROC(__after_proc_init)
  * Region 3: Normal, shared, inaccessible from PL0 to protect the vectors page
  *
  * r6: Value to be written to DRSR (and IRSR if required) for MPU_RAM_REGION
-*/
+ * r0: non zero value indicates error
+ */
 
 ENTRY(__setup_mpu)
 
@@ -209,13 +213,13 @@ ENTRY(__setup_mpu)
 	mrc	p15, 0, r0, c0, c1, 4		@ Read ID_MMFR0
 	and	r0, r0, #(MMFR0_PMSA)		@ PMSA field
 	teq	r0, #(MMFR0_PMSAv7)		@ PMSA v7
-	bne	__error_p			@ Fail: ARM_MPU on NOT v7 PMSA
+	bne	__nompu
 
 	/* Determine whether the D/I-side memory map is unified. We set the
 	 * flags here and continue to use them for the rest of this function */
 	mrc	p15, 0, r0, c0, c0, 4		@ MPUIR
 	ands	r5, r0, #MPUIR_DREGION_SZMASK	@ 0 size d region => No MPU
-	beq	__error_p			@ Fail: ARM_MPU and no MPU
+	beq	__nompu
 	tst	r0, #MPUIR_nU			@ MPUIR_nU = 0 for unified
 
 	/* Setup second region first to free up r6 */
@@ -263,6 +267,11 @@ ENTRY(__setup_mpu)
 	orr	r0, r0, #CR_M			@ Set SCTRL.M (MPU on)
 	mcr	p15, 0, r0, c1, c0, 0		@ Enable MPU
 	isb
+
+	mov	r0, #0
+	ret	lr
+__nompu:
+	mov	r0, #-ENODEV
 	ret	lr
 ENDPROC(__setup_mpu)
 #endif
-- 
1.7.9.5
