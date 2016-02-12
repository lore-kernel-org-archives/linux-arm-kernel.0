From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 12 Feb 2016 10:13:19 -0600
Subject: [PATCH] arm64: mm: Mark .rodata as RO
Message-ID: <1455293599-6974-1-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the .rodata section is actually still executable when DEBUG_RODATA
is enabled. This changes that so the .rodata is actually read only, no execute.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/vmlinux.lds.S |  5 +++--
 arch/arm64/mm/mmu.c             | 14 +++++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index ab4e436..2e2c053 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -114,8 +114,9 @@ SECTIONS
 		*(.got)			/* Global offset table		*/
 	}
 
-	RO_DATA(PAGE_SIZE)
-	EXCEPTION_TABLE(8)
+	ALIGN_DEBUG_RO_MIN(0)
+	RO_DATA(PAGE_SIZE)		/* everything from this point to */
+	EXCEPTION_TABLE(8)		/* _etext will be marked RO NX   */
 	NOTES
 
 	ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ab69a99..a3f4112 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -453,10 +453,18 @@ static void __init map_mem(pgd_t *pgd)
 #ifdef CONFIG_DEBUG_RODATA
 void mark_rodata_ro(void)
 {
-	create_mapping_late(__pa(_stext), (unsigned long)_stext,
-				(unsigned long)_etext - (unsigned long)_stext,
-				PAGE_KERNEL_ROX);
+	unsigned long section_size;
 
+	section_size = (unsigned long)__start_rodata - (unsigned long)_stext;
+	create_mapping_late(__pa(_stext), (unsigned long)_stext,
+			    section_size, PAGE_KERNEL_ROX);
+	/*
+	 * mark .rodata as read only. Use _etext rather than __end_rodata to
+	 * cover NOTES and EXCEPTION_TABLE.
+	 */
+	section_size = (unsigned long)_etext - (unsigned long)__start_rodata;
+	create_mapping_late(__pa(__start_rodata), (unsigned long)__start_rodata,
+			    section_size, PAGE_KERNEL_RO);
 }
 #endif
 
-- 
2.4.3
