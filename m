From: tixy@linaro.org (Jon Medhurst)
Date: Thu, 16 Mar 2017 13:29:57 +0000
Subject: [PATCH 1/2] arm: Fix cache inconsistency when using fixmap
Message-ID: <20170316132958.22227-1-tixy@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To cope with the variety in ARM architectures and configurations, the
pagetable attributes for kernel memory are generated at runtime to match
the system the kernel finds itself on. This calculated value is stored
in pgprot_kernel.

However, when early fixmap support was added for arm (commit
a5f4c561b3b1) the attributes used for mappings were hard coded because
pgprot_kernel is not set up early enough. Unfortunately, the values used
didn't include the 'shareable' attribute which means that for later
non-early fixmap use, when multiple CPUs are running, any cache entries
allocated for fixmap memory aren't kept consistent between CPUs. This
can result in different CPUs seeing different memory contents.

This issue was discovered on a dual cluster system by failures with
kprobes, which uses fixmap to modify the kernel image if
CONFIG_DEBUG_RODATA is enabled. It will also affect kgdb and jump_labels
which also make use of the same code to modify the kernel, and any other
uses of fixmap after secondary CPUs are brought online.

To fix this issue, and to help avoid other potential problems where
pagetable attributes are incorrect, we change the fixmap code to use the
same generated value in pgprot_kernel that the rest of the kernel uses,
and only fall back to a hard coded value if this isn't set - which will
be early on in boot before other CPUs are brought online.

Fixes: a5f4c561b3b1 ("ARM: 8415/1: early fixmap support for earlycon")
Cc: stable at vger.kernel.org # v4.3+

Reviewed-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

Stefan and Ard reviewed the code in these 2 patches but not the commit
wording... https://www.spinics.net/lists/arm-kernel/msg565126.html

 arch/arm/include/asm/fixmap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
index 5c17d2dec777..4e6784dc5668 100644
--- a/arch/arm/include/asm/fixmap.h
+++ b/arch/arm/include/asm/fixmap.h
@@ -41,7 +41,8 @@ static const enum fixed_addresses __end_of_fixed_addresses =
 
 #define FIXMAP_PAGE_COMMON	(L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN | L_PTE_DIRTY)
 
-#define FIXMAP_PAGE_NORMAL	(FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
+#define FIXMAP_PAGE_NORMAL	(pgprot_kernel ? pgprot_kernel | L_PTE_XN : \
+					FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
 #define FIXMAP_PAGE_RO		(FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
 
 /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
-- 
2.11.0
