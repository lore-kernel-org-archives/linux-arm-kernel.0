From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  8 Feb 2016 11:12:12 +0100
Subject: [PATCH] arm64: allow the module region to be randomized independently
In-Reply-To: <CAGXu5j+1rcScYedzQ5o0aaGZJWPCBGk-gai0D8jY8Huc-VuG7A@mail.gmail.com>
References: <CAGXu5j+1rcScYedzQ5o0aaGZJWPCBGk-gai0D8jY8Huc-VuG7A@mail.gmail.com>
Message-ID: <1454926332-25929-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch applies directly onto '[PATCH v5sub2 7/8] arm64: add support for
kernel ASLR' so it can be folded in or applied separately, as desired.

As pointed out by Kees, fully randomizing each module allocation does not add
anything in terms of security, and only hurts performance even more, since it
would cause all inter-module branches to be resolved via veneers as well.

----------8<--------------
This adds the option to randomize the module region independently from the
core kernel, and enables it by default. This makes it less likely that the
location of core kernel data structures can be determined by an adversary,
but causes all function calls from modules into the core kernel to be
resolved via entries in the module PLTs.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig              | 15 ++++++++
 arch/arm64/include/asm/module.h |  6 ++++
 arch/arm64/kernel/kaslr.c       | 36 +++++++++++++++-----
 arch/arm64/kernel/module.c      |  9 ++---
 4 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e3049d5c1246..666aacc4c763 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -787,6 +787,21 @@ config RANDOMIZE_BASE
 
 	  If unsure, say N.
 
+config RANDOMIZE_MODULE_REGION_FULL
+	bool "Randomize the module region independently from the core kernel"
+	depends on RANDOMIZE_BASE
+	default y
+	help
+	  Randomizes the location of the module region without considering the
+	  location of the core kernel. This way, it is impossible for modules
+	  to leak information about the location of core kernel data structures
+	  but it does imply that function calls between modules and the core
+	  kernel will need to be resolved via veneers in the module PLT.
+
+	  When this option is not set, the module region will be randomized over
+	  a limited range that contains the [_stext, _etext] interval of the
+	  core kernel, so branch relocations are always in range.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 8652fb613304..e12af6754634 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -31,4 +31,10 @@ struct mod_arch_specific {
 u64 module_emit_plt_entry(struct module *mod, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
+#ifdef CONFIG_RANDOMIZE_BASE
+extern u64 module_alloc_base;
+#else
+#define module_alloc_base	((u64)_etext - MODULES_VSIZE)
+#endif
+
 #endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index b0bf628ba51f..7a40aa4ba93d 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -20,7 +20,7 @@
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 
-u32 __read_mostly module_load_offset;
+u64 __read_mostly module_alloc_base;
 
 static __init u64 get_kaslr_seed(void *fdt)
 {
@@ -126,14 +126,32 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	    (((u64)_end + offset) >> SWAPPER_TABLE_SHIFT))
 		offset = (offset + (u64)(_end - _text)) & mask;
 
-	/*
-	 * Randomize the module region, by setting module_load_offset to
-	 * a PAGE_SIZE multiple in the interval [0, module_range). This
-	 * ensures that the resulting region still covers [_stext, _etext],
-	 * and that all relative branches can be resolved without veneers.
-	 */
-	module_range = MODULES_VSIZE - (u64)(_etext - _stext);
-	module_load_offset = ((module_range * (u16)seed) >> 16) & PAGE_MASK;
+	if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
+		/*
+		 * Randomize the module region independently from the core
+		 * kernel. This prevents modules from leaking any information
+		 * about the address of the kernel itself, but results in
+		 * branches between modules and the core kernel that are
+		 * resolved via PLTs. (Branches between modules will be
+		 * resolved normally.)
+		 */
+		module_range = VMALLOC_END - VMALLOC_START - MODULES_VSIZE;
+		module_alloc_base = VMALLOC_START;
+	} else {
+		/*
+		 * Randomize the module region by setting module_alloc_base to
+		 * a PAGE_SIZE multiple in the range [_etext - MODULES_VSIZE,
+		 * _stext) . This guarantees that the resulting region still
+		 * covers [_stext, _etext], and that all relative branches can
+		 * be resolved without veneers.
+		 */
+		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
+		module_alloc_base = (u64)_etext + offset - MODULES_VSIZE;
+	}
+
+	/* use the lower 21 bits to randomize the base of the module region */
+	module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
+	module_alloc_base &= PAGE_MASK;
 
 	return offset;
 }
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 54702d456680..dfa1ffaa9844 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -33,14 +33,9 @@
 void *module_alloc(unsigned long size)
 {
 	void *p;
-	u64 base = (u64)_etext - MODULES_VSIZE;
 
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
-		extern u32 module_load_offset;
-		base += module_load_offset;
-	}
-
-	p = __vmalloc_node_range(size, MODULE_ALIGN, base, base + MODULES_VSIZE,
+	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
+				module_alloc_base + MODULES_VSIZE,
 				GFP_KERNEL, PAGE_KERNEL_EXEC, 0,
 				NUMA_NO_NODE, __builtin_return_address(0));
 
-- 
2.5.0
