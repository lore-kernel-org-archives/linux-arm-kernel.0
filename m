From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Wed, 04 Dec 2013 19:51:04 +0200
Subject: [PATCH v3 00/15] uprobes: Add uprobes support for ARM
In-Reply-To: <1385520814-10663-1-git-send-email-dave.long@linaro.org>
References: <1385520814-10663-1-git-send-email-dave.long@linaro.org>
Message-ID: <529F6B88.2050005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2013 04:53 AM, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> This patch series adds basic uprobes support to ARM. It is based on patches
> developed earlier by Rabin Vincent. That approach of adding hooks into
> the kprobes instruction parsing code was not well received. This approach
> separates the ARM instruction parsing code in kprobes out into a separate set
> of functions which can be used by both kprobes and uprobes. Both kprobes and
> uprobes then provide their own semantic action tables to process the results of
> the parsing.
> 
> The following are noteworthy changes made for v3:
> 
> 1) The ARM uprobes functionality no longer depends on kprobes. As
> a side effect of this there are no longer any changes to the common
> kprobes include file (or any other common kprobes files).
> 2) A couple large patches have been broken down into more smaller
> patches.
> 3) A problem with uretprobes has been fixed.
> 4) The kprobes-test module has been made more useable for thumb tests.
> 5) The argument list to the "action" functions has been shrunk.
> 6) Alignment with a few recent patches that were made to common
> uprobes code specifically to support this patchset.
> 
> This patchset is based on v3.13-rc1

Hi Dave

I've tested this series in big-endian mode.
There is an issue within __create_xol_area() function.
It writes UPROBE_SWBP_INSN directly to memory, but UPROBE_SWBP_INSN
stores canonical opcode, which leads to a wrong instruction endianness
if CPU runs in BE.

I think the easies way to fix it without touching generic uprobes code
is to store opcode in native endianness in UPROBE_SWBP_INSN, and use
another macro for canonical form in ARM specific code.
Please check a diff below. With this diff plus addressed comment for
patch 14/15 plus fixed Ben's BE kprobes series I have uprobes working
on LE and BE.

diff --git a/arch/arm/include/asm/uprobes.h b/arch/arm/include/asm/uprobes.h
index e5acaa3..5313418 100644
--- a/arch/arm/include/asm/uprobes.h
+++ b/arch/arm/include/asm/uprobes.h
@@ -2,14 +2,16 @@
 #define _ASM_UPROBES_H
 
 #include <asm/probes.h>
+#include <asm/opcodes.h>
 
 typedef u32 uprobe_opcode_t;
 
 #define MAX_UINSN_BYTES		4
 #define UPROBE_XOL_SLOT_BYTES	64
 
-#define UPROBE_SWBP_INSN	0xe7f001f9
-#define UPROBE_SS_INSN		0xe7f001fa
+#define UPROBE_SWBP_ARM_INSN	0xe7f001f9
+#define UPROBE_SS_ARM_INSN	0xe7f001fa
+#define UPROBE_SWBP_INSN	__opcode_to_mem_arm(UPROBE_SWBP_ARM_INSN)
 #define UPROBE_SWBP_INSN_SIZE	4
 
 struct arch_uprobe_task {
diff --git a/arch/arm/kernel/uprobes.c b/arch/arm/kernel/uprobes.c
index d9873ef..ae18549 100644
--- a/arch/arm/kernel/uprobes.c
+++ b/arch/arm/kernel/uprobes.c
@@ -22,7 +22,7 @@
 bool is_swbp_insn(uprobe_opcode_t *insn)
 {
 	return (__mem_to_opcode_arm(*insn) & 0x0fffffff) ==
-		(UPROBE_SWBP_INSN & 0x0fffffff);
+		(UPROBE_SWBP_ARM_INSN & 0x0fffffff);
 }
 
 int set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm,
@@ -83,7 +83,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	insn = __mem_to_opcode_arm(*(unsigned int *)auprobe->insn);
 	auprobe->ixol[0] = __opcode_to_mem_arm(insn);
-	auprobe->ixol[1] = __opcode_to_mem_arm(UPROBE_SS_INSN);
+	auprobe->ixol[1] = __opcode_to_mem_arm(UPROBE_SS_ARM_INSN);
 
 	ret = arm_probes_decode_insn(insn, &auprobe->asi, false,
 				     uprobes_probes_actions);
@@ -100,7 +100,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		break;
 	}
 
-	bpinsn = UPROBE_SWBP_INSN & 0x0fffffff;
+	bpinsn = UPROBE_SWBP_ARM_INSN & 0x0fffffff;
 	if (insn >= 0xe0000000)
 		bpinsn |= 0xe0000000;  /* Unconditional instruction */
 	else
@@ -158,9 +158,9 @@ static int uprobe_trap_handler(struct pt_regs *regs, unsigned int instr)
 
 	local_irq_save(flags);
 	instr &= 0x0fffffff;
-	if (instr == (UPROBE_SWBP_INSN & 0x0fffffff))
+	if (instr == (UPROBE_SWBP_ARM_INSN & 0x0fffffff))
 		uprobe_pre_sstep_notifier(regs);
-	else if (instr == (UPROBE_SS_INSN & 0x0fffffff))
+	else if (instr == (UPROBE_SS_ARM_INSN & 0x0fffffff))
 		uprobe_post_sstep_notifier(regs);
 	local_irq_restore(flags);
 
@@ -174,7 +174,7 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 
 static struct undef_hook uprobes_arm_break_hook = {
 	.instr_mask	= 0x0fffffff,
-	.instr_val	= (UPROBE_SWBP_INSN & 0x0fffffff),
+	.instr_val	= (UPROBE_SWBP_ARM_INSN & 0x0fffffff),
 	.cpsr_mask	= MODE_MASK,
 	.cpsr_val	= USR_MODE,
 	.fn		= uprobe_trap_handler,
@@ -182,7 +182,7 @@ static struct undef_hook uprobes_arm_break_hook = {
 
 static struct undef_hook uprobes_arm_ss_hook = {
 	.instr_mask	= 0x0fffffff,
-	.instr_val	= (UPROBE_SS_INSN & 0x0fffffff),
+	.instr_val	= (UPROBE_SS_ARM_INSN & 0x0fffffff),
 	.cpsr_mask	= MODE_MASK,
 	.cpsr_val	= USR_MODE,
 	.fn		= uprobe_trap_handler,



-- 
Taras Kondratiuk
