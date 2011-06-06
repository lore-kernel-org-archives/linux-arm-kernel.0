From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:51 +0100
Subject: [PATCH 07/11] ARM: proc: add proc info for Cortex-A15MP using classic
	page tables
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multicore implementations of the Cortex-A15 require bit 6 of the
auxiliary control register to be set in order for cache and TLB
maintenance operations to be broadcast between CPUs.

This patch adds a new proc_info structure for Cortex-A15, which enables
the SMP bit during setup and includes the new HWCAPs for integer
division and VFPv4.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v7.S |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 8eba506..1e74e16 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -275,12 +275,18 @@ cpu_resume_l1_flags:
  */
 __v7_ca5mp_setup:
 __v7_ca9mp_setup:
+	mov	r10, #(1 << 0)			@ TLB ops broadcasting
+	b	1f
+__v7_ca15mp_setup:
+	mov	r10, #0
+1:
 #ifdef CONFIG_SMP
 	ALT_SMP(mrc	p15, 0, r0, c1, c0, 1)
 	ALT_UP(mov	r0, #(1 << 6))		@ fake it for UP
 	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
-	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
-	mcreq	p15, 0, r0, c1, c0, 1		@ TLB ops broadcasting
+	orreq	r0, r0, #(1 << 6)		@ Enable SMP/nAMP mode
+	orreq	r0, r0, r10			@ Enable CPU-specific SMP bits
+	mcreq	p15, 0, r0, c1, c0, 1
 #endif
 __v7_setup:
 	adr	r12, __v7_setup_stack		@ the local stack
@@ -480,6 +486,16 @@ __v7_ca9mp_proc_info:
 	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
 
 	/*
+	 * ARM Ltd. Cortex A15 processor.
+	 */
+	.type	__v7_ca15mp_proc_info, #object
+__v7_ca15mp_proc_info:
+	.long	0x410fc0f0
+	.long	0xff0ffff0
+	__v7_proc __v7_ca15mp_setup, HWCAP_VFPv4 | HWCAP_IDIV
+	.size	__v7_ca15mp_proc_info, . - __v7_ca15mp_proc_info
+
+	/*
 	 * Match any ARMv7 processor core.
 	 */
 	.type	__v7_proc_info, #object
-- 
1.7.0.4
