From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Fri, 29 Nov 2013 20:00:14 +0200
Subject: [RFC] kprobes/kprobes-test fixes, .inst updates
In-Reply-To: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5298D62E.2000208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 08:37 PM, Ben Dooks wrote:
> This is a series to fix kprobes and kprobes-test, as well as tidy
> up the <asm/opcodes.h> use of data instructions to output code and
> a missed bug in traps.
> 
> I have not had time to test these, or push to the new git server we
> are using. I will try and sort this out on monday.
> 
> This is an initial review series and I would appreicate testing.

kprobes-thumb.c fixes are missed in this series. Patch is below.

I've tested the series with all my comments addressed,
Dave's patch instead of 9/9 and with the patch below.
Kprobes-test passed for all combinations ARM/Thumb LE/BE.


From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Date: Fri, 29 Nov 2013 19:15:53 +0200
Subject: [PATCH] ARM: kprobes-thumb: fix instruction fetch order with <asm/opcodes.h>

If we are running BE8, the data and instruction endianness
do not match, so use <asm/opcodes.h> to correctly
translate memory accesses into ARM instructions.

Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 arch/arm/kernel/kprobes-thumb.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/kprobes-thumb.c b/arch/arm/kernel/kprobes-thumb.c
index 6123daf..b82e798 100644
--- a/arch/arm/kernel/kprobes-thumb.c
+++ b/arch/arm/kernel/kprobes-thumb.c
@@ -163,9 +163,9 @@ t32_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	enum kprobe_insn ret = kprobe_decode_ldmstm(insn, asi);
 
 	/* Fixup modified instruction to have halfwords in correct order...*/
-	insn = asi->insn[0];
-	((u16 *)asi->insn)[0] = insn >> 16;
-	((u16 *)asi->insn)[1] = insn & 0xffff;
+	insn = __mem_to_opcode_arm(asi->insn[0]);
+	((u16 *)asi->insn)[0] = __opcode_to_mem_thumb16(insn >> 16);
+	((u16 *)asi->insn)[1] = __opcode_to_mem_thumb16(insn & 0xffff);
 
 	return ret;
 }
@@ -1153,7 +1153,7 @@ t16_decode_hiregs(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
 	insn &= ~0x00ff;
 	insn |= 0x001; /* Set Rdn = R1 and Rm = R0 */
-	((u16 *)asi->insn)[0] = insn;
+	((u16 *)asi->insn)[0] = __opcode_to_mem_thumb16(insn);
 	asi->insn_handler = t16_emulate_hiregs;
 	return INSN_GOOD;
 }
@@ -1182,8 +1182,10 @@ t16_decode_push(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	 * and call it with R9=SP and LR in the register list represented
 	 * by R8.
 	 */
-	((u16 *)asi->insn)[0] = 0xe929;		/* 1st half STMDB R9!,{} */
-	((u16 *)asi->insn)[1] = insn & 0x1ff;	/* 2nd half (register list) */
+	/* 1st half STMDB R9!,{} */
+	((u16 *)asi->insn)[0] = __opcode_to_mem_thumb16(0xe929);
+	/* 2nd half (register list) */
+	((u16 *)asi->insn)[1] = __opcode_to_mem_thumb16(insn & 0x1ff);
 	asi->insn_handler = t16_emulate_push;
 	return INSN_GOOD;
 }
@@ -1232,8 +1234,10 @@ t16_decode_pop(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	 * and call it with R9=SP and PC in the register list represented
 	 * by R8.
 	 */
-	((u16 *)asi->insn)[0] = 0xe8b9;		/* 1st half LDMIA R9!,{} */
-	((u16 *)asi->insn)[1] = insn & 0x1ff;	/* 2nd half (register list) */
+	/* 1st half LDMIA R9!,{} */
+	((u16 *)asi->insn)[0] = __opcode_to_mem_thumb16(0xe8b9);
+	/* 2nd half (register list) */
+	((u16 *)asi->insn)[1] = __opcode_to_mem_thumb16(insn & 0x1ff);
 	asi->insn_handler = insn & 0x100 ? t16_emulate_pop_pc
 					 : t16_emulate_pop_nopc;
 	return INSN_GOOD;
-- 
1.7.9.5



-- 
Taras Kondratiuk
