From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  4 Jul 2018 10:36:47 +0200
Subject: [PATCH v10 2/6] module: allow symbol exports to be disabled
In-Reply-To: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
References: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
Message-ID: <20180704083651.24360-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow existing C code to be incorporated into the decompressor or
the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
declarations into nops, and #define it in places where such exports
are undesirable. Note that this gets rid of a rather dodgy redefine
of linux/export.h's header guard.

Acked-by: Nicolas Pitre <nico@linaro.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/boot/compressed/kaslr.c      |  5 +----
 drivers/firmware/efi/libstub/Makefile |  3 ++-
 include/linux/export.h                | 11 ++++++++++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b87a7582853d..ed7a123bba42 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -23,11 +23,8 @@
  * _ctype[] in lib/ctype.c is needed by isspace() of linux/ctype.h.
  * While both lib/ctype.c and lib/cmdline.c will bring EXPORT_SYMBOL
  * which is meaningless and will cause compiling error in some cases.
- * So do not include linux/export.h and define EXPORT_SYMBOL(sym)
- * as empty.
  */
-#define _LINUX_EXPORT_H
-#define EXPORT_SYMBOL(sym)
+#define __DISABLE_EXPORTS
 
 #include "misc.h"
 #include "error.h"
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a34e9290a699..0d0d3483241c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -20,7 +20,8 @@ cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -D__NO_FORTIFY \
 				   $(call cc-option,-ffreestanding) \
-				   $(call cc-option,-fno-stack-protector)
+				   $(call cc-option,-fno-stack-protector) \
+				   -D__DISABLE_EXPORTS
 
 GCOV_PROFILE			:= n
 KASAN_SANITIZE			:= n
diff --git a/include/linux/export.h b/include/linux/export.h
index b768d6dd3c90..ea7df303d68d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -66,7 +66,16 @@ extern struct module __this_module;
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
-#if defined(__KSYM_DEPS__)
+#if defined(__DISABLE_EXPORTS)
+
+/*
+ * Allow symbol exports to be disabled completely so that C code may
+ * be reused in other execution contexts such as the UEFI stub or the
+ * decompressor.
+ */
+#define __EXPORT_SYMBOL(sym, sec)
+
+#elif defined(__KSYM_DEPS__)
 
 /*
  * For fine grained build dependencies, we want to tell the build system
-- 
2.17.1
