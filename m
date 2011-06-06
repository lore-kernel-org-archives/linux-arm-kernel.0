From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 18:04:55 +0100
Subject: [PATCH 3/6] ARM: proc-v7: add definition of cpu_reset for ARMv7 cores
In-Reply-To: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
References: <1307379898-14256-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379898-14256-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a simple definition of cpu_reset for ARMv7 cores, which
disables the MMU via the SCTLR.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v7.S |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

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
