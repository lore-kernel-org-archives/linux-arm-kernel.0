From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 11 Nov 2013 18:40:58 +0000
Subject: [PATCH 9/9] ARM: asm/opcodes.h: use ARM_HAVE_INST to use .inst
 to build instructions
In-Reply-To: <20131111161829.GC3166@localhost.localdomain>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
 <1383935832-20865-10-git-send-email-ben.dooks@codethink.co.uk>
 <20131111161829.GC3166@localhost.localdomain>
Message-ID: <20131111184058.GE3166@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 04:18:30PM +0000, Dave Martin wrote:
> On Fri, Nov 08, 2013 at 06:37:12PM +0000, Ben Dooks wrote:
> > Currently the <asm/opcodes.h> header uses .work and .short to build
> 
> .work?  :)
> 
> > instructions. This means the output data does not get marked as an
> > instruction which can cause issues such as BE8 code failures.
> 
> Are you aware of any actual failures caused by this?
> 
> Use of .short/.long instead of .inst confuses tools like objdump, but
> there should be no runtime issue because vmlinux doesn't have the
> mapping symbols anyway.  If there's an actual bug here, we need to fix
> it, though.
> 
> 

[...]

> 
> Can you have a go with the following patch?
> 
> Beware -- I've not tested it yet...
> 
> From 1978c354e3871bfeecce12d2db66fa4032b1f183 Mon Sep 17 00:00:00 2001
> From: Dave Martin <Dave.Martin@arm.com>
> Date: Mon, 11 Nov 2013 16:13:33 +0000
> Subject: [PATCH] ARM: opcodes: Use .inst to emit instructions if available
> 
> Use of assembler data directives such as .long and .short to emit
> instruction opcodes can confuse tools that try to interpret the
> linker output, such as disassemblers or debuggers.
> 

[...]

>  
> +#ifdef HAVE_ARM_INST

Whoops, that should be ARM_HAVE_INST everywhere...

Try this instead:


>From 8827c8146312e4fd65330767c3d683b3cc48c10d Mon Sep 17 00:00:00 2001
From: Dave Martin <Dave.Martin@arm.com>
Date: Mon, 11 Nov 2013 18:13:47 +0000
Subject: [PATCH v2] ARM: opcodes: Use .inst to emit instructions if available

Use of assembler data directives such as .long and .short to emit
instruction opcodes can confuse tools that try to interpret the
linker output, such as disassemblers or debuggers.

Newer versions of the GNU assembler support an .inst directive,
which can be used instead to mark the emitted bytes correctly as
instructions.

This patch makes use of the .inst directive instead of data
directives, if available.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/include/asm/opcodes.h |   32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index e796c59..96c2c21 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -199,12 +199,18 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
  */
 #include <linux/stringify.h>
 
+#ifdef ARM_HAVE_INST
+#define __inst_arm(x) ___inst_arm(x)
+#define __inst_thumb32(x) ___inst_thumb32(x)
+#define __inst_thumb16(x) ___inst_thumb16(x)
+#else /* ! ARM_HAVE_INST */
 #define __inst_arm(x) ___inst_arm(___asm_opcode_to_mem_arm(x))
 #define __inst_thumb32(x) ___inst_thumb32(				\
 	___asm_opcode_to_mem_thumb16(___asm_opcode_thumb32_first(x)),	\
 	___asm_opcode_to_mem_thumb16(___asm_opcode_thumb32_second(x))	\
 )
 #define __inst_thumb16(x) ___inst_thumb16(___asm_opcode_to_mem_thumb16(x))
+#endif /* ! ARM_HAVE_INST */
 
 #ifdef CONFIG_THUMB2_KERNEL
 #define __inst_arm_thumb16(arm_opcode, thumb_opcode) \
@@ -216,16 +222,36 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define __inst_arm_thumb32(arm_opcode, thumb_opcode) __inst_arm(arm_opcode)
 #endif
 
-/* Helpers for the helpers.  Don't use these directly. */
+/*
+ * Helpers for the helpers.  Don't use these directly.
+ * Note that the interface for these depends on whether or not ARM_HAVE_INST
+ * is defined.
+ */
 #ifdef __ASSEMBLY__
+
+#ifdef ARM_HAVE_INST
+#define ___inst_arm(x) .inst x
+#define ___inst_thumb16(x) .inst.n x
+#define ___inst_thumb32(x) .inst.w x
+#else /* ! ARM_HAVE_INST */
 #define ___inst_arm(x) .long x
 #define ___inst_thumb16(x) .short x
 #define ___inst_thumb32(first, second) .short first, second
-#else
+#endif /* ! ARM_HAVE_INST */
+
+#else /* ! __ASSEMBLY__ */
+
+#ifdef ARM_HAVE_INST
+#define ___inst_arm(x) ".inst " __stringify(x) "\n\t"
+#define ___inst_thumb16(x) ".inst.n " __stringify(x) "\n\t"
+#define ___inst_thumb32(x) ".inst.w " __stringify(x) "\n\t"
+#else /* ! ARM_HAVE_INST */
 #define ___inst_arm(x) ".long " __stringify(x) "\n\t"
 #define ___inst_thumb16(x) ".short " __stringify(x) "\n\t"
 #define ___inst_thumb32(first, second) \
 	".short " __stringify(first) ", " __stringify(second) "\n\t"
-#endif
+#endif /* ! ARM_HAVE_INST */
+
+#endif /* ! __ASSEMBLY__ */
 
 #endif /* __ASM_ARM_OPCODES_H */
-- 
1.7.9.5
