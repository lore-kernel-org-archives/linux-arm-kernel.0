From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 17:43:09 +0200
Subject: [PATCH v2 4/4] arm64: simplify kernel segment mapping granularity
In-Reply-To: <1459352589-28721-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459352589-28721-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459352589-28721-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mapping of the kernel consist of four segments, each of which is mapped
with different permission attributes and/or lifetimes. To optimize the TLB
and translation table footprint, we define various opaque constants in the
linker script that resolve to different aligment values depending on the
page size and whether CONFIG_DEBUG_ALIGN_RODATA is set.

Considering that
- a 4 KB granule kernel benefits from a 64 KB segment alignment (due to
  the fact that it allows the use of the contiguous bit),
- the minimum alignment of the .data segment is THREAD_SIZE already, not
  PAGE_SIZE (i.e., we already have padding between _data and the start of
  the .data payload in many cases),
- 2 MB is a suitable alignment value on all granule sizes, either for
  mapping directly (level 2 on 4 KB), or via the contiguous bit (level 3 on
  16 KB and 64 KB),
- anything beyond 2 MB exceeds the minimum alignment mandated by the boot
  protocol, and can only be mapped efficiently if the physical alignment
  happens to be the same,

we can simplify this by standardizing on 64 KB (or 2 MB) explicitly, i.e.,
regardless of granule size, all segments are aligned either to 64 KB, or to
2 MB if CONFIG_DEBUG_ALIGN_RODATA=y. This also means we can drop the Kconfig
dependency of CONFIG_DEBUG_ALIGN_RODATA on CONFIG_ARM64_4K_PAGES.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig.debug        |  2 +-
 arch/arm64/kernel/vmlinux.lds.S | 25 ++++++++++++--------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 7e76845a0434..710fde4ad0f0 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -59,7 +59,7 @@ config DEBUG_RODATA
 	  If in doubt, say Y
 
 config DEBUG_ALIGN_RODATA
-	depends on DEBUG_RODATA && ARM64_4K_PAGES
+	depends on DEBUG_RODATA
 	bool "Align linker sections up to SECTION_SIZE"
 	help
 	  If this option is enabled, sections that may potentially be marked as
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 61a1075b9c30..77d86c976abd 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -63,14 +63,19 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 #endif
 
 #if defined(CONFIG_DEBUG_ALIGN_RODATA)
-#define ALIGN_DEBUG_RO			. = ALIGN(1<<SECTION_SHIFT);
-#define ALIGN_DEBUG_RO_MIN(min)		ALIGN_DEBUG_RO
-#elif defined(CONFIG_DEBUG_RODATA)
-#define ALIGN_DEBUG_RO			. = ALIGN(1<<PAGE_SHIFT);
-#define ALIGN_DEBUG_RO_MIN(min)		ALIGN_DEBUG_RO
+/*
+ *  4 KB granule:   1 level 2 entry
+ * 16 KB granule: 128 level 3 entries, with contiguous bit
+ * 64 KB granule:  32 level 3 entries, with contiguous bit
+ */
+#define SEGMENT_ALIGN			SZ_2M
 #else
-#define ALIGN_DEBUG_RO
-#define ALIGN_DEBUG_RO_MIN(min)		. = ALIGN(min);
+/*
+ *  4 KB granule:  16 level 3 entries, with contiguous bit
+ * 16 KB granule:   4 level 3 entries, without contiguous bit
+ * 64 KB granule:   1 level 3 entry
+ */
+#define SEGMENT_ALIGN			SZ_64K
 #endif
 
 SECTIONS
@@ -114,12 +119,12 @@ SECTIONS
 		*(.got)			/* Global offset table		*/
 	}
 
-	ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
+	. = ALIGN(SEGMENT_ALIGN);
 	RO_DATA(PAGE_SIZE)		/* everything from this point to */
 	EXCEPTION_TABLE(8)		/* _etext will be marked RO NX   */
 	NOTES
 
-	ALIGN_DEBUG_RO_MIN(PAGE_SIZE)
+	. = ALIGN(SEGMENT_ALIGN);
 	_etext = .;			/* End of text and rodata section */
 	__init_begin = .;
 
@@ -168,7 +173,7 @@ SECTIONS
 		*(.hash)
 	}
 
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(SEGMENT_ALIGN);
 	__init_end = .;
 
 	_data = .;
-- 
2.5.0
