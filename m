From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 13 Oct 2016 17:42:09 +0100
Subject: [PATCH] arm64: kaslr: fix breakage with CONFIG_MODVERSIONS=y
Message-ID: <1476376929-29688-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it turns out, the KASLR code breaks CONFIG_MODVERSIONS, since the
kcrctab has an absolute address field that is relocated at runtime
when the kernel offset is randomized.

This has been fixed already for PowerPC in the past, so simply wire up
the existing code dealing with this issue.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

Given that I spotted this when trying to boot a distro kernel, this probably
deserves a cc stable.

Timur, could you please test this and report back? Thanks.

 arch/arm64/include/asm/module.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index e12af6754634..06ff7fd9e81f 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -17,6 +17,7 @@
 #define __ASM_MODULE_H
 
 #include <asm-generic/module.h>
+#include <asm/memory.h>
 
 #define MODULE_ARCH_VERMAGIC	"aarch64"
 
@@ -32,6 +33,10 @@ u64 module_emit_plt_entry(struct module *mod, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
 #ifdef CONFIG_RANDOMIZE_BASE
+#ifdef CONFIG_MODVERSIONS
+#define ARCH_RELOCATES_KCRCTAB
+#define reloc_start 		(kimage_vaddr - KIMAGE_VADDR)
+#endif
 extern u64 module_alloc_base;
 #else
 #define module_alloc_base	((u64)_etext - MODULES_VSIZE)
-- 
2.7.4
