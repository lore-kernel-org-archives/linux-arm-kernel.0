From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 25 Jul 2013 15:42:37 +0100
Subject: [PATCH 2/2] ARM: fix BUG() detection
In-Reply-To: <1374763357-4893-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1374763357-4893-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1374763357-4893-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The detection of the instruction used by BUG() did not take into account
the differences in endian-ness between instruction and data. Change the
code to use the relevant helpers in <asm/opcodes.h> to translate the
endian-ness of the instructions.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/traps.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index cb67b04..ae2d828 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -344,15 +344,17 @@ void arm_notify_die(const char *str, struct pt_regs *regs,
 int is_valid_bugaddr(unsigned long pc)
 {
 #ifdef CONFIG_THUMB2_KERNEL
-	unsigned short bkpt;
+	u16 bkpt;
+	u16 insn = __opcode_to_mem_thumb16(BUG_INSTR_VALUE);
 #else
-	unsigned long bkpt;
+	u32 bkpt;
+	u32 insn = __opcode_to_mem_arm(BUG_INSTR_VALUE);
 #endif
 
 	if (probe_kernel_address((unsigned *)pc, bkpt))
 		return 0;
 
-	return bkpt == BUG_INSTR_VALUE;
+	return bkpt == insn;
 }
 
 #endif
-- 
1.7.10.4
