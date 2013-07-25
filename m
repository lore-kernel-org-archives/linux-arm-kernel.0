From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 25 Jul 2013 22:08:56 +0100
Subject: [PATCH 3/4] ARM: kprobes-test: use <asm/opcodes.h>
In-Reply-To: <1374786537-10726-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1374786537-10726-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1374786537-10726-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure we read instructions in the correct endian-ness by using
the <asm/opcodes.h> helper to transform them as necessary.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/kprobes-test.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
index 0cd63d0..6cfa04d 100644
--- a/arch/arm/kernel/kprobes-test.c
+++ b/arch/arm/kernel/kprobes-test.c
@@ -1374,13 +1374,13 @@ static uintptr_t __used kprobes_test_case_start(const char *title, void *stack)
 
 	if (test_case_is_thumb) {
 		u16 *p = (u16 *)(test_code & ~1);
-		current_instruction = p[0];
+		current_instruction = __mem_to_opcode_thumb16(p[0]);
 		if (is_wide_instruction(current_instruction)) {
-			current_instruction <<= 16;
-			current_instruction |= p[1];
+			u16 instr2 = __mem_to_opcode_thumb16(p[1]);
+			current_instruction = ___asm_opcode_thumb32_compose(current_instruction, instr2);
 		}
 	} else {
-		current_instruction = *(u32 *)test_code;
+		current_instruction = __mem_to_opcode_arm(*(u32 *)test_code);
 	}
 
 	if (current_title[0] == '.')
@@ -1593,7 +1593,6 @@ static int run_test_cases(void (*tests)(void), const union decode_item *table)
 	return 0;
 }
 
-
 static int __init run_all_tests(void)
 {
 	int ret = 0;
-- 
1.7.10.4
