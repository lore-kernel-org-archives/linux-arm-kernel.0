From: keescook@chromium.org (Kees Cook)
Date: Thu, 13 Feb 2014 17:04:10 -0800
Subject: [PATCH 2/2] ARM: mm: keep rodata non-executable
In-Reply-To: <1392339850-18686-1-git-send-email-keescook@chromium.org>
References: <1392339850-18686-1-git-send-email-keescook@chromium.org>
Message-ID: <1392339850-18686-3-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce "CONFIG_DEBUG_RODATA" to mostly match the x86 config, though
the behavior is different: it depends on STRICT_KERNMEM_PERMS, which
sets rodata read-only (but executable), where as this option additionally
splits rodata from the kernel text (resulting in potentially more memory
lost to padding) and sets it non-executable as well. The end result is
that on builds with CONFIG_DEBUG_RODATA=y (like x86) the rodata with be
marked purely read-only.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/cacheflush.h |    5 +++++
 arch/arm/kernel/vmlinux.lds.S     |    3 +++
 arch/arm/mm/Kconfig               |   12 ++++++++++++
 arch/arm/mm/init.c                |    8 ++++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index e9a49fe0284e..2b058fc7a188 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -486,4 +486,9 @@ int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
 
+#ifdef CONFIG_DEBUG_RODATA
+/* This has already happened during free_initmem. */
+static inline void mark_rodata_ro(void) { }
+#endif
+
 #endif
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 08fa667ef2f1..ec79e7268e09 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -120,6 +120,9 @@ SECTIONS
 			ARM_CPU_KEEP(PROC_INFO)
 	}
 
+#ifdef CONFIG_DEBUG_RODATA
+	. = ALIGN(1<<SECTION_SHIFT);
+#endif
 	RO_DATA(PAGE_SIZE)
 
 	. = ALIGN(4);
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 999eb505faee..7c8bbe7e2769 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -968,3 +968,15 @@ config ARM_KERNMEM_PERMS
 	  region is padded to section-size (1MiB) boundaries (because their
 	  permissions are different and splitting the 1M pages into 4K ones
 	  causes TLB performance problems), wasting memory.
+
+config DEBUG_RODATA
+	bool "Split rodata from text and set it read-only/non-executable"
+	depends on ARM_KERNMEM_PERMS
+	default y
+	help
+	  If this is set, rodata will be split from kernel text and made
+	  non-executable. (This option already depends on the option
+	  CONFIG_STRICT_KERNMEM_PERMS which makes rodata read-only, though
+	  still executable.) This creates another section-size padded
+	  region, so it can waste more memory space while gaining a pure
+	  read-only rodata region.
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index f0b1df53f436..5b1b049501b9 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -656,6 +656,14 @@ struct section_perm __initdata section_perms[] = {
 		.prot	= PMD_SECT_APX | PMD_SECT_AP_WRITE,
 #endif
 	},
+#ifdef CONFIG_DEBUG_RODATA
+	/* Make rodata RO (set NX). */
+	{
+		.start	= (unsigned long)__start_rodata,
+		.end	= (unsigned long)__init_begin,
+		.prot	= PMD_SECT_XN,
+	}
+#endif
 };
 
 static inline void section_update(unsigned long addr, pmdval_t prot)
-- 
1.7.9.5
