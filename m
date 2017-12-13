From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 13 Dec 2017 17:02:04 +0000
Subject: [RFC PATCH 2/5] ARM: NOMMU: Reorganise __setup_mpu
In-Reply-To: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
References: <1513184527-44120-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1513184527-44120-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we have mixed code placement between .head.text and .text
depends on configuration we are building:

_text                           M       R(UP)   R(SMP)
======================================================
 __setup_mpu                    __HEAD  __HEAD  text
 __after_proc_init              __HEAD  __HEAD  text
 __mmap_switched                text    text    text

We are going to support another variant of MPU which is different to
PMSAv7 in sense overlapping MPU regions are not allowed, so this patch
makes boundaries between these sections precise and consistent:

_text                           M       R(UP)   R(SMP)
======================================================
 __setup_mpu                    __HEAD  __HEAD  __HEAD
 __after_proc_init              text    text    text
 __mmap_switched                text    text    text

Additionally, it paves a path to postpone MPU activation till
__after_proc_init where we do set SCTLR anyway and can return
directly to __mmap_switched.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/head-nommu.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 0d17187..aaa25a6 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -75,8 +75,8 @@ ENTRY(stext)
 	ldr	r12, [r10, #PROCINFO_INITFUNC]
 	add	r12, r12, r10
 	ret	r12
-1:	bl	__after_proc_init
-	b	__mmap_switched
+1:	ldr	lr, =__mmap_switched
+	b	__after_proc_init
 ENDPROC(stext)
 
 #ifdef CONFIG_SMP
@@ -123,6 +123,7 @@ __secondary_data:
 /*
  * Set the Control Register and Read the process ID.
  */
+	.text
 __after_proc_init:
 #ifdef CONFIG_CPU_CP15
 	/*
@@ -202,6 +203,7 @@ ENDPROC(__after_proc_init)
  *
  * r6: Value to be written to DRSR (and IRSR if required) for PMSAv7_RAM_REGION
 */
+	__HEAD
 
 ENTRY(__setup_mpu)
 
@@ -301,6 +303,7 @@ ENDPROC(__setup_pmsa_v7)
  * r6: pointer at mpu_rgn_info
  */
 
+	.text
 ENTRY(__secondary_setup_mpu)
 	/* Use MPU region info supplied by __cpu_up */
 	ldr	r6, [r7]			@ get secondary_data.mpu_rgn_info
-- 
2.0.0
