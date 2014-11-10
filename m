From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 10 Nov 2014 19:47:02 +0100
Subject: [PATCH v2 2/2] arm64: fdt: call preserve_fdt() before unflattening it
In-Reply-To: <1415645222-14909-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1415645222-14909-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1415645222-14909-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support the new /sys/firmware/fdt entry that gives access to
the FDT blob as passed by the bootloader, call preserve_fdt()
in the early arch code to make a copy of it before the
unflattening code gets its hands on it.

Also, make the early mapping of the FDT read only so we are certain
it will not get clobbered by anything called by setup_machine_fdt(),
which handles the FDT blob even earlier.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/head.S  | 3 +++
 arch/arm64/kernel/setup.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0a6e4f924df8..df25dffcda9f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -79,8 +79,10 @@
 
 #ifdef CONFIG_ARM64_64K_PAGES
 #define MM_MMUFLAGS	PTE_ATTRINDX(MT_NORMAL) | PTE_FLAGS
+#define MM_MMUFLAGS_RO	PTE_ATTRINDX(MT_NORMAL) | PTE_FLAGS | PTE_RDONLY
 #else
 #define MM_MMUFLAGS	PMD_ATTRINDX(MT_NORMAL) | PMD_FLAGS
+#define MM_MMUFLAGS_RO	PMD_ATTRINDX(MT_NORMAL) | PMD_FLAGS | PMD_SECT_RDONLY
 #endif
 
 /*
@@ -607,6 +609,7 @@ __create_page_tables:
 	 * Map the FDT blob (maximum 2MB; must be within 512MB of
 	 * PHYS_OFFSET).
 	 */
+	ldr	x7, =MM_MMUFLAGS_RO
 	mov	x3, x21				// FDT phys address
 	and	x3, x3, #~((1 << 21) - 1)	// 2MB aligned
 	mov	x6, #PAGE_OFFSET
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 2437196cc5d4..1b535cc42981 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -394,6 +394,7 @@ void __init setup_arch(char **cmdline_p)
 
 	efi_idmap_init();
 
+	preserve_fdt();
 	unflatten_device_tree();
 
 	psci_init();
-- 
1.8.3.2
