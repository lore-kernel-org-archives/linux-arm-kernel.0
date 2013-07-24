From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 24 Jul 2013 11:28:00 +0100
Subject: [PATCH 12/14] ARM: traps: use <asm/opcodes.h> to get correct
 instruction order
In-Reply-To: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1374661682-9349-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1374661682-9349-13-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The trap handler needs to take into account the endian configuration of
the system when loading instructions. Use <asm/opcodes.h> to provide the
necessary conversion functions.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/traps.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 18b32e8..c300e51 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -34,6 +34,7 @@
 #include <asm/unwind.h>
 #include <asm/tls.h>
 #include <asm/system_misc.h>
+#include <asm/opcodes.h>
 
 #include "signal.h"
 
@@ -404,23 +405,24 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	if (processor_mode(regs) == SVC_MODE) {
 #ifdef CONFIG_THUMB2_KERNEL
 		if (thumb_mode(regs)) {
-			instr = ((u16 *)pc)[0];
+			instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
 			if (is_wide_instruction(instr)) {
 				instr <<= 16;
-				instr |= ((u16 *)pc)[1];
+				instr |= __mem_to_opcode_thumb16(((u16 *)pc)[1]);
 			}
 		} else
 #endif
-			instr = *(u32 *) pc;
+			instr = __mem_to_opcode_arm(*(u32 *) pc);
 	} else if (thumb_mode(regs)) {
 		if (get_user(instr, (u16 __user *)pc))
 			goto die_sig;
+		instr = __mem_to_opcode_thumb16(instr);
 		if (is_wide_instruction(instr)) {
 			unsigned int instr2;
 			if (get_user(instr2, (u16 __user *)pc+1))
 				goto die_sig;
 			instr <<= 16;
-			instr |= instr2;
+			instr |= __mem_to_opcode_thumb16(instr2);
 		}
 	} else if (get_user(instr, (u32 __user *)pc)) {
 		goto die_sig;
-- 
1.7.10.4
