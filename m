From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Jul 2011 10:57:07 +0100
Subject: [PATCH] ARMv7: Do not clean the PTE coherent page table walk is supported
Message-ID: <mailman.2.1309515040.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a check for the ID_MMFR3[23:20] bits (coherent walk) and
only cleans the D-cache corresponding to a PTE if coherent page table
walks are not supported.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/proc-v7.S |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 8013afc..fc5b36f 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -166,7 +166,9 @@ ENTRY(cpu_v7_set_pte_ext)
  ARM(	str	r3, [r0, #2048]! )
  THUMB(	add	r0, r0, #2048 )
  THUMB(	str	r3, [r0] )
-	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
+	mrc	p15, 0, r3, c0, c1, 7		@ read ID_MMFR3
+	tst	r3, #0xf << 20			@ check the coherent walk bits
+	mcreq	p15, 0, r0, c7, c10, 1		@ flush_pte
 #endif
 	mov	pc, lr
 ENDPROC(cpu_v7_set_pte_ext)

-- 
Catalin
