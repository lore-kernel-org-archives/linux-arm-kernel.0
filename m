From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:20:54 +0100
Subject: [PATCH 06/23] ARM: entry: abort-macro: simplify do_ldrd_abort
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqx4-0002F4-DW@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can test bits 27:25 and 20 of the instruction at the same time;
there's no need to separate out the check of bit 20.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/abort-macro.S |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/abort-macro.S b/arch/arm/mm/abort-macro.S
index 8d3b9f9..af97a10 100644
--- a/arch/arm/mm/abort-macro.S
+++ b/arch/arm/mm/abort-macro.S
@@ -30,12 +30,10 @@ not_thumb:
  *    [20] == 0
  */
 	.macro	do_ldrd_abort, tmp, insn
-	tst	\insn, #0x0e000000		@ [27:25] == 0
+	tst	\insn, #0x0e100000		@ [27:25,20] == 0
 	bne	not_ldrd
 	and	\tmp, \insn, #0x000000f0	@ [7:4] == 1101
 	cmp	\tmp, #0x000000d0
-	bne	not_ldrd
-	tst	\insn, #1 << 20			@ [20] == 0
 	moveq	pc, lr
 not_ldrd:
 	.endm
-- 
1.7.4.4
