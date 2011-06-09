From: will.deacon@arm.com (Will Deacon)
Date: Thu,  9 Jun 2011 16:58:55 +0100
Subject: [PATCH v2 03/10] ARM: proc: add definition of cpu_reset for ARMv6 and
	ARMv7 cores
In-Reply-To: <1307635142-11312-1-git-send-email-will.deacon@arm.com>
References: <1307635142-11312-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307635142-11312-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds simple definitions of cpu_reset for ARMv6 and ARMv7
cores, which disable the MMU via the SCTLR.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v6.S |    5 +++++
 arch/arm/mm/proc-v7.S |    7 +++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 1d2b845..f3b5232 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -56,6 +56,11 @@ ENTRY(cpu_v6_proc_fin)
  */
 	.align	5
 ENTRY(cpu_v6_reset)
+	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
+	bic	r1, r1, #0x1			@ ...............m
+	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
+	mov	r1, #0
+	mcr	p15, 0, r1, c7, c5, 4		@ ISB
 	mov	pc, r0
 
 /*
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b3b566e..776443a 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -58,9 +58,16 @@ ENDPROC(cpu_v7_proc_fin)
  *	to what would be the reset vector.
  *
  *	- loc   - location to jump to for soft reset
+ *
+ *	This code must be executed using a flat identity mapping with
+ *      caches disabled.
  */
 	.align	5
 ENTRY(cpu_v7_reset)
+	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
+	bic	r1, r1, #0x1			@ ...............m
+	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
+	isb
 	mov	pc, r0
 ENDPROC(cpu_v7_reset)
 
-- 
1.7.0.4
