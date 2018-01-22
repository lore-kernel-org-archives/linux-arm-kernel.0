From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Jan 2018 16:28:30 +0000
Subject: per-task stack canaries for arm64
In-Reply-To: <CAKv+Gu_qERYZu5-cWbo3DuuqrS5d1JhRHhpNAL0kurg93m=MNQ@mail.gmail.com>
References: <CAKv+Gu_rdDEQeBYabZCOywws96mTWF4F=JEpVNXEW76tAwo1Rw@mail.gmail.com>
 <CAGXu5j+cJoc6o8d-hmLFj08r18GhEbKhVNA94LDKM5yqo9CbSQ@mail.gmail.com>
 <CAKv+Gu9vViZUBYJWnGdnewL9h-ahP0Hs8gU+3_QH76ROdQh1yQ@mail.gmail.com>
 <CAGXu5j+PO=Ben0J-xnOztrAdsku2SUKFiz6w7cqTEfHTveFFSg@mail.gmail.com>
 <f80404f3-985f-9e3b-2ad3-f2b0fc2a8b28@arm.com>
 <CAKv+Gu-TtJ7Pxa7+qOX7MiQwPFwsNOup2Q=0TvjCO4xHxf3QQA@mail.gmail.com>
 <CAKv+Gu8P6OZDSMw7oA+5_RgGLkeOwoaEPb_5c510uoBAJY7MeA@mail.gmail.com>
 <CAGXu5j+erd-=LqZdxEDUQnHhtsEbZ1YNch4sToKk+MWzybvQWA@mail.gmail.com>
 <CAKv+Gu_qERYZu5-cWbo3DuuqrS5d1JhRHhpNAL0kurg93m=MNQ@mail.gmail.com>
Message-ID: <CAKv+Gu-N0r4CRookMzySeWvgo5W3Y41csHV+AwvTju7Wy5iP2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2018 at 12:42, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 22 January 2018 at 12:26, Kees Cook <keescook@chromium.org> wrote:
>> On Mon, Jan 22, 2018 at 9:59 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> OK, so I have done a bit of homework, and I think this shouldn't be
>>> too difficult after all.
>>>
>>> I realized that we don't really need per-CPU references to
>>> __stack_chk_guard, given that we already keep the task struct pointer
>>> in sp_el0. This means we should be able to do
>>>
>>> mrs   x0, sp_el0
>>> movz  x1, :abs_g0:__stack_chk_guard_tsk_offset
>>> add   x0, x0, x1
>>> ldr   x2, [x0]
>>>
>>> where __stack_chk_guard_tsk_offset is exposed via an ELF symbol.
>>> (Analogous to x86, this could be implemented at the GCC level using
>>> arbitrary sysreg and symbol names to remain flexible)
>>>
>>> So my next question (mainly to Ramana): would it be possible to emit
>>> the mrs/movz/add sequence above from targetm.stack_protect_guard() in
>>> a way that will allow expand_normal() to expand it in a useful manner
>>> (e.g., as an INDIRECT_REF that can be matched by the memory_operand in
>>> Aarch64's stack_protect_set)? If that is the case, we could implement
>>> this in a GCC plugin in the kernel rather than relying on upstream GCC
>>> changes (and having to commit to this ABI long term)
>>
>> Though this would ultimately be implemented in core GCC, yes? (I don't
>> want to have GCC plugins be a dependency for stack protector...)
>>
>
> Oh absolutely. But being able to expose this more widely early on,
> while GCC 9 is still under development, would help prevent cockups
> where we end up with a flawed ABI and it's too late to do something
> about it.

OK, so it appears the only feasible way to implement this is via a
backend function, which is what i386 and rs6000 do as well.

Taking that code as an example, I managed to piece together a GCC
patch that uses what is basically the above sequence, and
interestingly, I could just compile the mainline kernel with virtually
no changes (see below), and it just works, using different values for
the stack canary for each task. This would mean we would not need any
build time compiler feature test to enable the functionality, which is
an advantage.

So all we need is agree on how to parameterize this so that we don't
paint ourselves into a corner. Using a system register name and offset
symbol name like x86 does sounds flexible enough, although an absolute
offset value such as __stack_chk_guard_tsk_offset is rather different
from an ordinary symbol reference, given that we cannot use an
adrp/add pair to load it. Also, the range of the offset decides which
sequence to emit: I am using add with a :lo12: relocation in my patch,
but I think we probably want to avoid limiting ourselves to 4 KB here.

Comments?


Kernel patch
---------------------8<--------------------------
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 1303e04110cd..4b639a3c15bb 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -164,5 +164,6 @@ int main(void)
   DEFINE(SDEI_EVENT_INTREGS,   offsetof(struct sdei_registered_event,
interrupted_regs));
   DEFINE(SDEI_EVENT_PRIORITY,  offsetof(struct sdei_registered_event,
priority));
 #endif
+  DEFINE(TSK_STACK_CANARY,     offsetof(struct task_struct, stack_canary));
   return 0;
 }
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index c7fcb232fe47..a4dd7350111a 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -18,6 +18,8 @@
 #ifndef __ASM_IMAGE_H
 #define __ASM_IMAGE_H

+#include <asm/asm-offsets.h>
+
 #ifndef LINKER_SCRIPT
 #error This file should only be included in vmlinux.lds.S
 #endif
@@ -118,4 +120,6 @@ __efistub_screen_info               =
KALLSYMS_HIDE(screen_info);

 #endif

+PROVIDE(__stack_chk_guard_tsk_offset = ABSOLUTE(TSK_STACK_CANARY));
+
 #endif /* __ASM_IMAGE_H */
---------------------8<--------------------------


GCC patch
---------------------8<--------------------------
diff --git a/gcc/config/aarch64/aarch64.c b/gcc/config/aarch64/aarch64.c
index 174310c9f1bc..dc4928f1f14c 100644
--- a/gcc/config/aarch64/aarch64.c
+++ b/gcc/config/aarch64/aarch64.c
@@ -17208,6 +17208,12 @@ aarch64_select_early_remat_modes (sbitmap modes)
     }
 }

+static tree
+aarch64_init_stack_protect_guard (void)
+{
+  return NULL_TREE;
+}
+
 /* Target-specific selftests.  */

 #if CHECKING_P
@@ -17682,6 +17688,9 @@ aarch64_libgcc_floating_mode_supported_p
 #define TARGET_RUN_TARGET_SELFTESTS selftest::aarch64_run_selftests
 #endif /* #if CHECKING_P */

+#undef TARGET_STACK_PROTECT_GUARD
+#define TARGET_STACK_PROTECT_GUARD aarch64_init_stack_protect_guard
+
 struct gcc_target targetm = TARGET_INITIALIZER;

 #include "gt-aarch64.h"
diff --git a/gcc/config/aarch64/aarch64.md b/gcc/config/aarch64/aarch64.md
index a6ecb3913094..cd591b65d8e6 100644
--- a/gcc/config/aarch64/aarch64.md
+++ b/gcc/config/aarch64/aarch64.md
@@ -168,6 +168,7 @@
     UNSPEC_INSR
     UNSPEC_CLASTB
     UNSPEC_FADDA
+    UNSPEC_TSK_STACK_CANARY
 ])

 (define_c_enum "unspecv" [
@@ -5834,6 +5835,15 @@
   DONE;
 })

+(define_insn "aarch64_load_current_stack_canary"
+  [(set (match_operand:DI 0 "register_operand" "=r")
+       (unspec:DI [(const_int 0)] UNSPEC_TSK_STACK_CANARY))]
+  ""
+  "mrs\\t%0, sp_el0\;add\\t%0, %0, :lo12:__stack_chk_guard_tsk_offset"
+  [(set_attr "type" "multiple")
+   (set_attr "length" "8")]
+)
+
 ;; Named patterns for stack smashing protection.
 (define_expand "stack_protect_set"
   [(match_operand 0 "memory_operand")
@@ -5842,6 +5852,11 @@
 {
   machine_mode mode = GET_MODE (operands[0]);

+  rtx reg = gen_reg_rtx (Pmode);
+
+  operands[1] = gen_rtx_MEM (Pmode, reg);
+  emit_insn (gen_aarch64_load_current_stack_canary (reg));
+
   emit_insn ((mode == DImode
              ? gen_stack_protect_set_di
              : gen_stack_protect_set_si) (operands[0], operands[1]));
@@ -5867,6 +5882,11 @@
   rtx result;
   machine_mode mode = GET_MODE (operands[0]);

+  rtx reg = gen_reg_rtx (Pmode);
+
+  operands[1] = gen_rtx_MEM (Pmode, reg);
+  emit_insn (gen_aarch64_load_current_stack_canary (reg));
+
   result = gen_reg_rtx(mode);

   emit_insn ((mode == DImode
