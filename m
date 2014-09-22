From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 22 Sep 2014 14:48:42 +0100
Subject: [PATCH RESEND] arm: don't break misaligned NEON load/store
Message-ID: <15fc86b0d2b4984377d7116113b0f2f9498bd088.1411392970.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The alignment fixup incorrectly decodes faulting ARM VLDn/VSTn
instructions (where the optional alignment hint is given but incorrect)
as LDR/STR, leading to register corruption. Detect these and correctly
treat them as unhandled, so that userspace gets the fault it expects.

Reported-by: Simon Hosie <simon.hosie@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Cc: <stable@vger.kernel.org>
---

Hi all,

This was met with a resounding silence a while back[1], but the bug is
still causing annoyance - apparently Clang intrinsics can be a little
over-eager with alignment hints. Regardless of whose fault that is,
the kernel shouldn't be silently mangling registers unexpectedly.

Any objections to me dropping this into the patch system?

Robin.

[1]:http://www.spinics.net/lists/arm-kernel/msg328889.html


 arch/arm/mm/alignment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 0c1ab49..83792f4 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -41,6 +41,7 @@
  * This code is not portable to processors with late data abort handling.
  */
 #define CODING_BITS(i)	(i & 0x0e000000)
+#define COND_BITS(i)	(i & 0xf0000000)
 
 #define LDST_I_BIT(i)	(i & (1 << 26))		/* Immediate constant	*/
 #define LDST_P_BIT(i)	(i & (1 << 24))		/* Preindex		*/
@@ -821,6 +822,8 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		break;
 
 	case 0x04000000:	/* ldr or str immediate */
+		if (COND_BITS(instr) == 0xf0000000) /* NEON VLDn, VSTn */
+			goto bad;
 		offset.un = OFFSET_BITS(instr);
 		handler = do_alignment_ldrstr;
 		break;
-- 
1.9.1
