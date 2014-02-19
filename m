From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 19 Feb 2014 15:15:38 +0100
Subject: [PATCH] ARM: let dumping page tables depend on MMU
Message-ID: <1392819338-393-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On no-MMU there are no page tables, so ARM_PTDUMP doesn't make sense on
these platforms. Further this fixes the following compilation errors on
efm32_defconfig + CONFIG_ARM_PTDUMP=y:

	arch/arm/mm/dump.c:56:11: error: 'L_PTE_USER' undeclared here (not in a function)
	arch/arm/mm/dump.c:61:11: error: 'L_PTE_RDONLY' undeclared here (not in a function)
	arch/arm/mm/dump.c:66:11: error: 'L_PTE_XN' undeclared here (not in a function)
	arch/arm/mm/dump.c:71:11: error: 'L_PTE_SHARED' undeclared here (not in a function)
	arch/arm/mm/dump.c:76:11: error: 'L_PTE_MT_MASK' undeclared here (not in a function)
	arch/arm/mm/dump.c:77:10: error: 'L_PTE_MT_UNCACHED' undeclared here (not in a function)
	arch/arm/mm/dump.c:81:10: error: 'L_PTE_MT_BUFFERABLE' undeclared here (not in a function)
	arch/arm/mm/dump.c:85:10: error: 'L_PTE_MT_WRITETHROUGH' undeclared here (not in a function)
	arch/arm/mm/dump.c:89:10: error: 'L_PTE_MT_WRITEBACK' undeclared here (not in a function)
	arch/arm/mm/dump.c:94:10: error: 'L_PTE_MT_MINICACHE' undeclared here (not in a function)
	arch/arm/mm/dump.c:99:10: error: 'L_PTE_MT_WRITEALLOC' undeclared here (not in a function)
	arch/arm/mm/dump.c:103:10: error: 'L_PTE_MT_DEV_SHARED' undeclared here (not in a function)
	arch/arm/mm/dump.c:108:10: error: 'L_PTE_MT_DEV_NONSHARED' undeclared here (not in a function)
	arch/arm/mm/dump.c:113:10: error: 'L_PTE_MT_DEV_WC' undeclared here (not in a function)
	arch/arm/mm/dump.c:117:10: error: 'L_PTE_MT_DEV_CACHED' undeclared here (not in a function)
	arch/arm/mm/dump.c:126:11: error: 'PMD_SECT_AP_READ' undeclared here (not in a function)
	arch/arm/mm/dump.c:126:30: error: 'PMD_SECT_AP_WRITE' undeclared here (not in a function)
	arch/arm/mm/dump.c:126:28: error: invalid operands to binary | (have 'const struct prot_bits *' and 'const struct prot_bits *')
	arch/arm/mm/dump.c:126:3: error: initializer element is not constant
	arch/arm/mm/dump.c:126:3: error: (near initialization for 'section_bits[0].mask')
	arch/arm/mm/dump.c:130:28: error: invalid operands to binary | (have 'const struct prot_bits *' and 'const struct prot_bits *')
	arch/arm/mm/dump.c:130:3: error: initializer element is not constant
	arch/arm/mm/dump.c:130:3: error: (near initialization for 'section_bits[1].mask')
	arch/arm/mm/dump.c:131:3: error: initializer element is not constant
	arch/arm/mm/dump.c:131:3: error: (near initialization for 'section_bits[1].val')
	arch/arm/mm/dump.c:134:28: error: invalid operands to binary | (have 'const struct prot_bits *' and 'const struct prot_bits *')
	arch/arm/mm/dump.c:134:3: error: initializer element is not constant
	arch/arm/mm/dump.c:134:3: error: (near initialization for 'section_bits[2].mask')
	arch/arm/mm/dump.c:135:3: error: initializer element is not constant
	arch/arm/mm/dump.c:135:3: error: (near initialization for 'section_bits[2].val')
	arch/arm/mm/dump.c:138:28: error: invalid operands to binary | (have 'const struct prot_bits *' and 'const struct prot_bits *')
	arch/arm/mm/dump.c:138:3: error: initializer element is not constant
	arch/arm/mm/dump.c:138:3: error: (near initialization for 'section_bits[3].mask')
	arch/arm/mm/dump.c:139:27: error: invalid operands to binary | (have 'const struct prot_bits *' and 'const struct prot_bits *')
	arch/arm/mm/dump.c:139:3: error: initializer element is not constant
	arch/arm/mm/dump.c:139:3: error: (near initialization for 'section_bits[3].val')
	arch/arm/mm/dump.c:153:11: error: 'PMD_SECT_XN' undeclared here (not in a function)
	arch/arm/mm/dump.c:153:3: error: initializer element is not constant
	arch/arm/mm/dump.c:153:3: error: (near initialization for 'section_bits[4].mask')
	arch/arm/mm/dump.c:154:3: error: initializer element is not constant
	arch/arm/mm/dump.c:154:3: error: (near initialization for 'section_bits[4].val')
	arch/arm/mm/dump.c:158:11: error: 'PMD_SECT_S' undeclared here (not in a function)
	arch/arm/mm/dump.c:158:3: error: initializer element is not constant
	arch/arm/mm/dump.c:158:3: error: (near initialization for 'section_bits[5].mask')
	arch/arm/mm/dump.c:159:3: error: initializer element is not constant
	arch/arm/mm/dump.c:159:3: error: (near initialization for 'section_bits[5].val')
	arch/arm/mm/dump.c: In function 'note_page':
	arch/arm/mm/dump.c:206:13: error: 'USER_PGTABLES_CEILING' undeclared (first use in this function)
	arch/arm/mm/dump.c:206:13: note: each undeclared identifier is reported only once for each function it appears in
	arch/arm/mm/dump.c:206:11: warning: comparison between pointer and integer [enabled by default]
	arch/arm/mm/dump.c: In function 'walk_pte':
	arch/arm/mm/dump.c:245:2: error: implicit declaration of function 'pte_offset_kernel' [-Werror=implicit-function-declaration]
	arch/arm/mm/dump.c:245:15: warning: initialization makes pointer from integer without a cast [enabled by default]
	arch/arm/mm/dump.c:249:18: error: 'PTRS_PER_PTE' undeclared (first use in this function)
	arch/arm/mm/dump.c:249:16: warning: comparison between pointer and integer [enabled by default]
	arch/arm/mm/dump.c: In function 'walk_pmd':
	arch/arm/mm/dump.c:261:18: error: 'PTRS_PER_PMD' undeclared (first use in this function)
	arch/arm/mm/dump.c:261:16: warning: comparison between pointer and integer [enabled by default]
	arch/arm/mm/dump.c:262:22: error: 'PMD_SIZE' undeclared (first use in this function)
	arch/arm/mm/dump.c:262:20: error: invalid operands to binary * (have 'unsigned int' and 'const struct prot_bits *')
	arch/arm/mm/dump.c:262:8: warning: assignment makes integer from pointer without a cast [enabled by default]
	arch/arm/mm/dump.c:263:3: error: implicit declaration of function 'pmd_none' [-Werror=implicit-function-declaration]
	arch/arm/mm/dump.c:263:3: error: implicit declaration of function 'pmd_large' [-Werror=implicit-function-declaration]
	arch/arm/mm/dump.c:263:3: error: implicit declaration of function 'pmd_present' [-Werror=implicit-function-declaration]
	arch/arm/mm/dump.c: In function 'walk_pgd':
	arch/arm/mm/dump.c:291:23: error: 'USER_PGTABLES_CEILING' undeclared (first use in this function)
	arch/arm/mm/dump.c:291:45: error: invalid operands to binary / (have 'const struct prot_bits *' and 'long unsigned int')
	arch/arm/mm/dump.c:291:23: warning: initialization makes integer from pointer without a cast [enabled by default]
	arch/arm/mm/dump.c:299:23: error: 'PTRS_PER_PGD' undeclared (first use in this function)
	arch/arm/mm/dump.c:299:21: warning: comparison between pointer and integer [enabled by default]

Fixes: 1fd15b879d00 ("ARM: add support to dump the kernel page tables")
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0531da8e5216..a43b0cbd2e15 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -4,7 +4,7 @@ source "lib/Kconfig.debug"
 
 config ARM_PTDUMP
 	bool "Export kernel pagetable layout to userspace via debugfs"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && MMU
 	select DEBUG_FS
 	---help---
 	  Say Y here if you want to show the kernel pagetable layout in a
-- 
1.8.5.3
