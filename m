From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  6 Feb 2017 15:02:42 +0000
Subject: [PATCH] arm64: Revert "arm64: kaslr: fix breakage with
 CONFIG_MODVERSIONS=y"
Message-ID: <1486393362-10875-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 9c0e83c371cf4696926c95f9c8c77cd6ea803426, which
is no longer needed now that the modversions code plays nice with
relocatable PIE kernels.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
This simply removes some dead code, so this patch can wait for v4.12 if
preferred. (The modversions fixes were only queued for -rc7)

 arch/arm64/include/asm/module.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 06ff7fd9e81f..e12af6754634 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -17,7 +17,6 @@
 #define __ASM_MODULE_H
 
 #include <asm-generic/module.h>
-#include <asm/memory.h>
 
 #define MODULE_ARCH_VERMAGIC	"aarch64"
 
@@ -33,10 +32,6 @@ u64 module_emit_plt_entry(struct module *mod, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
 #ifdef CONFIG_RANDOMIZE_BASE
-#ifdef CONFIG_MODVERSIONS
-#define ARCH_RELOCATES_KCRCTAB
-#define reloc_start 		(kimage_vaddr - KIMAGE_VADDR)
-#endif
 extern u64 module_alloc_base;
 #else
 #define module_alloc_base	((u64)_etext - MODULES_VSIZE)
-- 
2.7.4
