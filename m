From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  7 May 2014 10:51:57 +0100
Subject: [PATCH 2/2] arm: don't break misaligned NEON load/store
In-Reply-To: <cover.1399028497.git.robin.murphy@arm.com>
References: <cover.1399028497.git.robin.murphy@arm.com>
Message-ID: <68eafcc6692acd552dd3b490d7c2a45e32604142.1399028497.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The alignment fixup incorrectly decodes faulting ARM VLDn/VSTn
instructions as LDR/STR, leading to register corruption. Detect these
and correctly treat them as unhandled.

Reported-by: Simon Hosie <simon.hosie@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/mm/alignment.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 9a93315..5812e0c 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -40,6 +40,7 @@
  * This code is not portable to processors with late data abort handling.
  */
 #define CODING_BITS(i)	(i & 0x0e000000)
+#define COND_BITS(i)	(i & 0xf0000000)

 #define LDST_I_BIT(i)	(i & (1 << 26))		/* Immediate constant	*/
 #define LDST_P_BIT(i)	(i & (1 << 24))		/* Preindex		*/
@@ -817,6 +818,8 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		break;

 	case 0x04000000:	/* ldr or str immediate */
+		if (COND_BITS(instr) == 0xf0000000) /* NEON VLDn, VSTn */
+			goto bad;
 		offset.un = OFFSET_BITS(instr);
 		handler = do_alignment_ldrstr;
 		break;
--
1.7.9.5
