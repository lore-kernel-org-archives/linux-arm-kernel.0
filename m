From: rabin@rab.in (Rabin Vincent)
Date: Mon, 28 Nov 2011 22:29:14 +0530
Subject: [RFC PATCH] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
References: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
Message-ID: <CAH+eYFBM36VqYAqZdiZnMP7AODh_SqYQWuoFDSyS3BDZDvHU5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2011 at 16:58, Dave Martin <dave.martin@linaro.org> wrote:
> +#ifdef CONFIG_CPU_ENDIAN_BE8
> +#define __opcode_to_mem_arm(x) swab32(x)
> +#define __opcode_to_mem_thumb16(x) swab16(x)
> +#define __opcode_to_mem_thumb32(x) swahb32(x)
> +#else
> +#define __opcode_to_mem_arm(x) (x) ((u32)(x))
> +#define __opcode_to_mem_thumb16(x) ((u16)(x))
> +#define __opcode_to_mem_thumb32(x) swahw32(x)
> +#endif

The current kprobes code does:

#ifndef __ARMEB__ /* Swap halfwords for little-endian */
                bkp = (bkp >> 16) | (bkp << 16);
#endif

There seems to be a difference between your macros and that for the case
__ARMEB__ + !CONFIG_CPU_ENDIAN_BE8.  Or is that combination not
possible?

> +
> +#define __mem_to_opcode_arm(x) __opcode_to_mem_arm(x)
> +#define __mem_to_opcode_thumb16(x) __opcode_to_mem_thumb16(x)
> +#define __mem_to_opcode_thumb32(x) __opcode_to_mem_thumb32(x)
> +
> +/* Operations specific to Thumb opcodes */
> +
> +/* Instruction size checks: */
> +#define __opcode_is_thumb32(x) ((u32)(x) >= 0xE8000000UL)
> +#define __opcode_is_thumb16(x) ((u32)(x) < 0xE800UL)
> +
> +/* Operations to construct or split 32-bit Thumb instructions: */
> +#define __opcode_thumb32_first(x) ((u16)((thumb_opcode) >> 16))
> +#define __opcode_thumb32_second(x) ((u16)(thumb_opcode))
> +#define __opcode_thumb32_compose(first, second) \
> + ? ? ? (((u32)(u16)(first) << 16) | (u32)(u16)(second))

All of these could certainly find use in the files being touched by
the jump label patchset:

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index c46d18b..c437a9d 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -72,12 +72,13 @@ static int ftrace_modify_code(unsigned long pc,
unsigned long old,
 {
 	unsigned long replaced;

-#ifndef __ARMEB__
 	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
-		old = (old >> 16) | (old << 16);
-		new = (new >> 16) | (new << 16);
+		old = __opcode_to_mem_thumb32(old);
+		new = __opcode_to_mem_thumb32(new);
+	} else {
+		old = __opcode_to_mem_arm(old);
+		new = __opcode_to_mem_arm(new);
 	}
-#endif

 	if (old) {
 		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
diff --git a/arch/arm/kernel/insn.c b/arch/arm/kernel/insn.c
index f65b68c..9079997 100644
--- a/arch/arm/kernel/insn.c
+++ b/arch/arm/kernel/insn.c
@@ -27,7 +27,7 @@ __arm_gen_branch_thumb2(unsigned long pc, unsigned
long addr, bool link)
 	if (link)
 		second |= 1 << 14;

-	return (first << 16) | second;
+	return __opcode_thumb32_compose(first, second);
 }

 static unsigned long
diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 15df8a5..5398659 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -17,21 +17,21 @@ void __kprobes __patch_text(void *addr, unsigned int insn)
 	bool thumb2 = IS_ENABLED(CONFIG_THUMB2_KERNEL);
 	int size;

-	if (thumb2 && !is_wide_instruction(insn)) {
-		*(u16 *)addr = insn;
+	if (thumb2 && __opcode_is_thumb16(insn)) {
+		*(u16 *)addr = __opcode_to_mem_thumb16(insn);
 		size = sizeof(u16);
 	} else if (thumb2 && ((uintptr_t)addr & 2)) {
 		u16 *addrh = addr;

-		addrw[0] = insn >> 16;
-		addrw[1] = insn & 0xffff;
+		addrw[0] = __opcode_thumb32_first(insn);
+		addrw[1] = __opcode_thumb32_second(insn);

 		size = sizeof(u32);
 	} else {
-#ifndef __ARMEB__
 		if (thumb2)
-			insn = (insn >> 16) | (insn << 16);
-#endif
+			insn = __opcode_to_mem_thumb32(insn);
+		else
+			insn = __opcode_to_mem_arm(insn);

 		*(u32 *)addr = insn;
 		size = sizeof(u32);
@@ -61,7 +61,7 @@ void __kprobes patch_text(void *addr, unsigned int insn)
 		stop_machine(patch_text_stop_machine, &patch, cpu_online_mask);
 	} else {
 		bool straddles_word = IS_ENABLED(CONFIG_THUMB2_KERNEL)
-				      && is_wide_instruction(insn)
+				      && __opcode_is_thumb32(insn)
 				      && ((uintptr_t)addr & 2);

 		if (straddles_word)
