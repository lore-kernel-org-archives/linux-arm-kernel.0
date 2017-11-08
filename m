From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 8 Nov 2017 12:25:55 +0300
Subject: [PATCH 13/15] arm64: fix mrs_s/msr_s macros for clang LTO
In-Reply-To: <20171103171203.107569-18-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-18-samitolvanen@google.com>
Message-ID: <20171108092555.ta4mkqolunyw6mdr@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sami,

(CC Andi Kleen, Alex Matveev, Maxim Kuvyrkov)

On Fri, Nov 03, 2017 at 10:12:01AM -0700, Sami Tolvanen wrote:
> Clang's integrated assembler does not allow assembly macros defined
> in one inline asm block using the .macro directive to be used across
> separate asm blocks. LLVM developers consider this a feature and not a
> bug, recommending code refactoring:
> 
>   https://bugs.llvm.org/show_bug.cgi?id=19749
> 
> As binutils doesn't allow macros to be redefined, this change adds C
> preprocessor macros that define the assembly macros globally for binutils
> and locally for clang's integrated assembler.

This macros are also the problem for gcc and ld.bfd if we try to
enable LTO.

The patch below uses trick with undefining mrs_s/msr_s immediately
after use to solve the problem. It works for both gcc and clang.

There's the series from Andi Kleen that enables LTO for Linux on x86:
https://lwn.net/Articles/512548/
https://github.com/andikleen/linux-misc/tree/lto-411-1

It has solved many problems you also try to solve, and some patches
are looking very similar. 

At now we have different patchsets for gcc and clang, and it would be
better to have them together. One thing I'm worried is that you introduce
CONFIG_CLANG_LTO and use it for all cases, including that where more
generic CONFIG_LTO should be used.

I think we'd also discuss it here.
________

>From c939344c726e8ae6b28012ad2807c63b54175e40 Mon Sep 17 00:00:00 2001
From: Alex Matveev <alxmtvv@gmail.com>
Date: Tue, 7 Nov 2017 01:06:33 +0000
Subject: [PATCH] arm64: make mrs_s and msr_s macros work with LTO

Use UNDEFINE_MRS_S and UNDEFINE_MSR_S to define corresponding macros
in-place and workaround gcc and clang limitations on redefining macros
across different assembler blocks.

Signed-off-by: Alex Matveev <alxmtvv@gmail.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/kvm_hyp.h |  8 ++++--
 arch/arm64/include/asm/sysreg.h  | 55 +++++++++++++++++++++++++++-------------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 4572a9b560fa..20bfb8e676e0 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -29,7 +29,9 @@
 	({								\
 		u64 reg;						\
 		asm volatile(ALTERNATIVE("mrs %0, " __stringify(r##nvh),\
-					 "mrs_s %0, " __stringify(r##vh),\
+					 DEFINE_MRS_S			\
+					 "mrs_s %0, " __stringify(r##vh) "\n"\
+					 UNDEFINE_MRS_S,		\
 					 ARM64_HAS_VIRT_HOST_EXTN)	\
 			     : "=r" (reg));				\
 		reg;							\
@@ -39,7 +41,9 @@
 	do {								\
 		u64 __val = (u64)(v);					\
 		asm volatile(ALTERNATIVE("msr " __stringify(r##nvh) ", %x0",\
-					 "msr_s " __stringify(r##vh) ", %x0",\
+					 DEFINE_MSR_S			\
+					 "msr_s " __stringify(r##vh) ", %x0\n"\
+					 UNDEFINE_MSR_S,		\
 					 ARM64_HAS_VIRT_HOST_EXTN)	\
 					 : : "rZ" (__val));		\
 	} while (0)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index f707fed5886f..a69b0ca9a3b4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -463,20 +463,39 @@
 
 #include <linux/types.h>
 
-asm(
-"	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
-"	.equ	.L__reg_num_x\\num, \\num\n"
-"	.endr\n"
+#define __DEFINE_MRS_MSR_S_REGNUM				\
+"	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n" \
+"	.equ	.L__reg_num_x\\num, \\num\n"			\
+"	.endr\n"						\
 "	.equ	.L__reg_num_xzr, 31\n"
-"\n"
-"	.macro	mrs_s, rt, sreg\n"
-	__emit_inst(0xd5200000|(\\sreg)|(.L__reg_num_\\rt))
+
+#define DEFINE_MRS_S						\
+	__DEFINE_MRS_MSR_S_REGNUM				\
+"	.macro	mrs_s, rt, sreg\n"				\
+	__emit_inst(0xd5200000|(\\sreg)|(.L__reg_num_\\rt))	\
 "	.endm\n"
-"\n"
-"	.macro	msr_s, sreg, rt\n"
-	__emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))
+
+#define DEFINE_MSR_S						\
+	__DEFINE_MRS_MSR_S_REGNUM				\
+"	.macro	msr_s, sreg, rt\n"				\
+	__emit_inst(0xd5000000|(\\sreg)|(.L__reg_num_\\rt))	\
 "	.endm\n"
-);
+
+#define UNDEFINE_MRS_S						\
+"	.purgem	mrs_s\n"
+
+#define UNDEFINE_MSR_S						\
+"	.purgem	msr_s\n"
+
+#define __mrs_s(r, v)						\
+	DEFINE_MRS_S						\
+"	mrs_s %0, " __stringify(r) "\n"				\
+	UNDEFINE_MRS_S : "=r" (v)
+
+#define __msr_s(r, v)						\
+	DEFINE_MSR_S						\
+"	msr_s " __stringify(r) ", %x0\n"			\
+	UNDEFINE_MSR_S : : "rZ" (v)
 
 /*
  * Unlike read_cpuid, calls to read_sysreg are never expected to be
@@ -502,15 +521,15 @@ asm(
  * For registers without architectural names, or simply unsupported by
  * GAS.
  */
-#define read_sysreg_s(r) ({						\
-	u64 __val;							\
-	asm volatile("mrs_s %0, " __stringify(r) : "=r" (__val));	\
-	__val;								\
+#define read_sysreg_s(r) ({					\
+	u64 __val;						\
+	asm volatile(__mrs_s(r, __val));			\
+	__val;							\
 })
 
-#define write_sysreg_s(v, r) do {					\
-	u64 __val = (u64)(v);						\
-	asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val));	\
+#define write_sysreg_s(v, r) do {				\
+	u64 __val = (u64)(v);					\
+	asm volatile(__msr_s(r, __val));			\
 } while (0)
 
 static inline void config_sctlr_el1(u32 clear, u32 set)
-- 
2.11.0
