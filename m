From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 25 Jul 2013 16:57:00 +0100
Subject: [PATCH 1/2] ARM: Correct BUG() assembly to ensure it is
 endian-agnostic
In-Reply-To: <1374763357-4893-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1374763357-4893-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374763357-4893-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130725155700.GD2546@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 03:42:36PM +0100, Ben Dooks wrote:
> Currently BUG() uses .word or .hword to create the necessary illegal
> instructions. However if we are building BE8 then these get swapped
> by the linker into different illegal instructions in the text.

In the case of Thumb, the resulting instruction is actually not illegal,
which is even worse...

> Change to using .inst and .inst.w to create the instructions and mark
> them as instructions so that the linker acts correctly.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/include/asm/bug.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
> index 7af5c6c..b95da52 100644
> --- a/arch/arm/include/asm/bug.h
> +++ b/arch/arm/include/asm/bug.h
> @@ -12,10 +12,10 @@
>   */
>  #ifdef CONFIG_THUMB2_KERNEL
>  #define BUG_INSTR_VALUE 0xde02
> -#define BUG_INSTR_TYPE ".hword "
> +#define BUG_INSTR_TYPE ".inst.w "
>  #else
>  #define BUG_INSTR_VALUE 0xe7f001f2
> -#define BUG_INSTR_TYPE ".word "
> +#define BUG_INSTR_TYPE ".inst "
>  #endif

There was some uncertainty a while ago about precisely which versions of
gas support .inst.

<asm/opcodes.h> implements an abstracted workaround for this issue,
whereby you can emit instructions using the __inst*() macros, and
the swabbing and assembler directives should be generated for you.

The patch below ought to do this for BUG(), but I've only briefly
build-tested it.


Note that the disassembly of the injected instructions in .o files
can be a bit confusing, because they are marked as data, do ld --be8
doesn't swab them (unlike the instructions, which do get swabbed).
objdump may also do extra swabbing during disassembly.

You can sanity-check what is really in the image by dumping the text
section of vmlinux with objdump -s.


The change to <asm/opcodes.h> is due to a missing include which is
really required for correctness, but which didn't show up without
the <asm/bug.h> change (this causes opcodes.h to get included way
more often than is otherwise the case).

Cheers
---Dave


diff --git a/arch/arm/include/asm/bug.h b/arch/arm/include/asm/bug.h
index 7af5c6c..e36fe85 100644
--- a/arch/arm/include/asm/bug.h
+++ b/arch/arm/include/asm/bug.h
@@ -2,6 +2,7 @@
 #define _ASMARM_BUG_H
 
 #include <linux/linkage.h>
+#include <asm/opcodes.h>
 
 #ifdef CONFIG_BUG
 
@@ -12,15 +13,15 @@
  */
 #ifdef CONFIG_THUMB2_KERNEL
 #define BUG_INSTR_VALUE 0xde02
-#define BUG_INSTR_TYPE ".hword "
+#define __BUG_INSTR __inst_thumb16(BUG_INSTR_VALUE)
 #else
 #define BUG_INSTR_VALUE 0xe7f001f2
-#define BUG_INSTR_TYPE ".word "
+#define __BUG_INSTR __inst_arm(BUG_INSTR_VALUE)
 #endif
 
 
-#define BUG() _BUG(__FILE__, __LINE__, BUG_INSTR_VALUE)
-#define _BUG(file, line, value) __BUG(file, line, value)
+#define BUG() _BUG(__FILE__, __LINE__)
+#define _BUG(file, line) __BUG(file, line)
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 
@@ -31,9 +32,9 @@
  * avoid multiple copies of the string appearing in the kernel image.
  */
 
-#define __BUG(__file, __line, __value)				\
+#define __BUG(__file, __line)					\
 do {								\
-	asm volatile("1:\t" BUG_INSTR_TYPE #__value "\n"	\
+	asm volatile("1:\t" __BUG_INSTR "\n"			\
 		".pushsection .rodata.str, \"aMS\", %progbits, 1\n" \
 		"2:\t.asciz " #__file "\n" 			\
 		".popsection\n" 				\
@@ -46,9 +47,9 @@ do {								\
 
 #else  /* not CONFIG_DEBUG_BUGVERBOSE */
 
-#define __BUG(__file, __line, __value)				\
+#define __BUG(__file, __line)					\
 do {								\
-	asm volatile(BUG_INSTR_TYPE #__value);			\
+	asm volatile(__BUG_INSTR)				\
 	unreachable();						\
 } while (0)
 #endif  /* CONFIG_DEBUG_BUGVERBOSE */
diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index e796c59..e94ebfd 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -11,6 +11,8 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/linkage.h>
+#include <linux/types.h>
+
 extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #endif
 
