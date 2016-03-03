From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  3 Mar 2016 14:09:41 +0100
Subject: [PATCH 3/3] arm64: simplify kernel segment mapping granularity
In-Reply-To: <1457010581-4924-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1457010581-4924-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1457010581-4924-4-git-send-email-ard.biesheuvel@linaro.org>
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
2 MB if CONFIG_DEBUG_ALIGN_RODATA=y.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 25 ++++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7a141c098bbb..2c60d19b038c 100644
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
@@ -113,12 +118,12 @@ SECTIONS
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
 
@@ -166,7 +171,7 @@ SECTIONS
 		*(.hash)
 	}
 
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(SEGMENT_ALIGN);
 	__init_end = .;
 
 	_data = .;
-- 
2.5.0
