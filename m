From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Nov 2013 18:37:05 +0000
Subject: [PATCH 2/9] ARM: kprobes: fix instruction fetch order with
 <asm/opcodes.h>
In-Reply-To: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1383935832-20865-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are running BE8, the data and instruction endian-ness do not
match, so use <asm/opcodes.h> to correctly translate memory accesses
into ARM instructions.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>y
---
 arch/arm/kernel/kprobes-common.c | 14 ++++++++------
 arch/arm/kernel/kprobes.c        |  9 +++++----
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
index 18a7628..4954e0f 100644
--- a/arch/arm/kernel/kprobes-common.c
+++ b/arch/arm/kernel/kprobes-common.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 #include <asm/system_info.h>
+#include <asm/opcodes.h>
 
 #include "kprobes.h"
 
@@ -305,7 +306,8 @@ kprobe_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	if (handler) {
 		/* We can emulate the instruction in (possibly) modified form */
-		asi->insn[0] = (insn & 0xfff00000) | (rn << 16) | reglist;
+		asi->insn[0] = __opcode_to_mem_arm((insn & 0xfff00000) |
+						   (rn << 16) | reglist);
 		asi->insn_handler = handler;
 		return INSN_GOOD;
 	}
@@ -338,9 +340,9 @@ prepare_emulated_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
 		thumb_insn[2] = 0x4770; /* Thumb bx lr */
 		return insn;
 	}
-	asi->insn[1] = 0xe12fff1e; /* ARM bx lr */
+	asi->insn[1] = __opcode_to_mem_arm(0xe12fff1e); /* ARM bx lr */
 #else
-	asi->insn[1] = 0xe1a0f00e; /* mov pc, lr */
+	asi->insn[1] = __opcode_to_mem_arm(0xe1a0f00e); /* mov pc, lr */
 #endif
 	/* Make an ARM instruction unconditional */
 	if (insn < 0xe0000000)
@@ -360,12 +362,12 @@ set_emulated_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
 	if (thumb) {
 		u16 *ip = (u16 *)asi->insn;
 		if (is_wide_instruction(insn))
-			*ip++ = insn >> 16;
-		*ip++ = insn;
+			*ip++ = __opcode_to_mem_thumb16(insn >> 16);
+		*ip++ = __opcode_to_mem_thumb16(insn);
 		return;
 	}
 #endif
-	asi->insn[0] = insn;
+	asi->insn[0] = __opcode_to_mem_arm(insn);
 }
 
 /*
diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 170e9f3..1c6ece5 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -26,6 +26,7 @@
 #include <linux/stop_machine.h>
 #include <linux/stringify.h>
 #include <asm/traps.h>
+#include <asm/opcodes.h>
 #include <asm/cacheflush.h>
 
 #include "kprobes.h"
@@ -62,10 +63,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 #ifdef CONFIG_THUMB2_KERNEL
 	thumb = true;
 	addr &= ~1; /* Bit 0 would normally be set to indicate Thumb code */
-	insn = ((u16 *)addr)[0];
+	insn = __mem_to_opcode_thumb16(((u16 *)addr)[0]);
 	if (is_wide_instruction(insn)) {
-		insn <<= 16;
-		insn |= ((u16 *)addr)[1];
+		u16 inst2 = __mem_to_opcode_thumb16(((u16 *)addr)[1]);
+		insn = __opcode_thumb32_compose(insn, inst2);
 		decode_insn = thumb32_kprobe_decode_insn;
 	} else
 		decode_insn = thumb16_kprobe_decode_insn;
@@ -73,7 +74,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	thumb = false;
 	if (addr & 0x3)
 		return -EINVAL;
-	insn = *p->addr;
+	insn = __mem_to_opcode_arm(*p->addr);
 	decode_insn = arm_kprobe_decode_insn;
 #endif
 
-- 
1.8.4.rc3
