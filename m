From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Nov 2013 18:37:12 +0000
Subject: [PATCH 9/9] ARM: asm/opcodes.h: use ARM_HAVE_INST to use .inst to
 build instructions
In-Reply-To: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1383935832-20865-10-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the <asm/opcodes.h> header uses .work and .short to build
instructions. This means the output data does not get marked as an
instruction which can cause issues such as BE8 code failures.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/include/asm/opcodes.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index e796c59..4c7cac1 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -103,9 +103,15 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define __opcode_to_mem_arm(x) ___opcode_swab32(x)
 #define __opcode_to_mem_thumb16(x) ___opcode_swab16(x)
 #define __opcode_to_mem_thumb32(x) ___opcode_swahb32(x)
+#ifdef ARM_HAVE_INST
 #define ___asm_opcode_to_mem_arm(x) ___asm_opcode_swab32(x)
 #define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_swab16(x)
 #define ___asm_opcode_to_mem_thumb32(x) ___asm_opcode_swahb32(x)
+#else
+#define ___asm_opcode_to_mem_arm(x) ___asm_opcode_identity32(x)
+#define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_identity16(x)
+#define ___asm_opcode_to_mem_thumb32(x) ___asm_opcode_identity32(x)
+#endif /* !ARM_HAVE_INST */
 
 #else /* ! CONFIG_CPU_ENDIAN_BE8 */
 
@@ -218,14 +224,27 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 
 /* Helpers for the helpers.  Don't use these directly. */
 #ifdef __ASSEMBLY__
+#ifdef ARM_HAVE_INST
+#define ___inst_arm(x) .inst x
+#define ___inst_thumb16(x) .inst.w x
+#define ___inst_thumb32(first, second) .inst.w first, second
+#else
 #define ___inst_arm(x) .long x
 #define ___inst_thumb16(x) .short x
 #define ___inst_thumb32(first, second) .short first, second
+#endif /* !ARM_HAVE_INST */
+#else
+#ifdef ARM_HAVE_INST
+#define ___inst_arm(x) ".inst " __stringify(x) "\n\t"
+#define ___inst_thumb16(x) ".inst.w " __stringify(x) "\n\t"
+#define ___inst_thumb32(first, second) \
+	".inst.w " __stringify(first) ", " __stringify(second) "\n\t"
 #else
 #define ___inst_arm(x) ".long " __stringify(x) "\n\t"
 #define ___inst_thumb16(x) ".short " __stringify(x) "\n\t"
 #define ___inst_thumb32(first, second) \
 	".short " __stringify(first) ", " __stringify(second) "\n\t"
+#endif /* !ARM_HAVE_INST */
 #endif
 
 #endif /* __ASM_ARM_OPCODES_H */
-- 
1.8.4.rc3
