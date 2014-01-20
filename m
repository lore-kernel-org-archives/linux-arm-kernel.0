From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 20 Jan 2014 14:00:21 +0900
Subject: [PATCH v2] arm64: mm: use ubfm for dcache_line_size
Message-ID: <002501cf159c$85a358b0$90ea0a10$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 'ubfm' for the bitfield move instruction; thus, single
instruction can be used instead of two instructions, when
getting the minimum D-cache line size from CTR_EL0 register.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Change since v1
- Remove unnecessary prefix '0x' from immediates, per Will Deacon
- Add '#' to immediates for consistency, per Ard Biesheuvel

 arch/arm64/mm/proc-macros.S |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
index 8957b82..005d29e 100644
--- a/arch/arm64/mm/proc-macros.S
+++ b/arch/arm64/mm/proc-macros.S
@@ -38,8 +38,7 @@
  */
 	.macro	dcache_line_size, reg, tmp
 	mrs	\tmp, ctr_el0			// read CTR
-	lsr	\tmp, \tmp, #16
-	and	\tmp, \tmp, #0xf		// cache line size encoding
+	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
 	mov	\reg, #4			// bytes per word
 	lsl	\reg, \reg, \tmp		// actual cache line size
 	.endm
-- 
1.7.10.4
