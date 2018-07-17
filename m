From: yaojun8558363@gmail.com (Jun Yao)
Date: Tue, 17 Jul 2018 17:56:08 +0800
Subject: [PATCH v4 6/6] arm64/mm: Move {idmap_pg_dir,
 swapper_pg_dir} to .rodata section
In-Reply-To: <20180717095608.11008-1-yaojun8558363@gmail.com>
References: <20180717095608.11008-1-yaojun8558363@gmail.com>
Message-ID: <20180717095608.11008-7-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move {idmap_pg_dir, tramp_pg_dir, reserved_ttbr0, swapper_pg_dir}
to .rodata section.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 39 ++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 2446911f4262..142528a23b44 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -64,8 +64,13 @@ jiffies = jiffies_64;
 	*(.entry.tramp.text)				\
 	. = ALIGN(PAGE_SIZE);				\
 	__entry_tramp_text_end = .;
+
+#define TRAMP_PG_TABLE					\
+	tramp_pg_dir = .;				\
+	. += PAGE_SIZE;
 #else
 #define TRAMP_TEXT
+#define TRAMP_PG_TABLE
 #endif
 
 #define INIT_PG_TABLES					\
@@ -74,6 +79,24 @@ jiffies = jiffies_64;
 	. += SWAPPER_DIR_SIZE;                          \
 	init_pg_end = .;
 
+#ifdef CONFIG_ARM64_SW_TTBR0_PAN
+#define RESERVED_PG_TABLE				\
+	reserved_ttbr0 = .;				\
+	. += RESERVED_TTBR0_SIZE;
+#else
+#define RESERVED_PG_TABLE
+#endif
+
+#define KERNEL_PG_TABLES				\
+	. = ALIGN(PAGE_SIZE);                           \
+	idmap_pg_dir = .;				\
+	. += IDMAP_DIR_SIZE;				\
+	TRAMP_PG_TABLE					\
+	RESERVED_PG_TABLE				\
+	swapper_pg_dir = .;				\
+	. += PAGE_SIZE;					\
+	swapper_pg_end = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -143,6 +166,7 @@ SECTIONS
 	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
 	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
 	NOTES
+	KERNEL_PG_TABLES
 
 	. = ALIGN(SEGMENT_ALIGN);
 	__init_begin = .;
@@ -224,21 +248,6 @@ SECTIONS
 	BSS_SECTION(0, 0, 0)
 
 	. = ALIGN(PAGE_SIZE);
-	idmap_pg_dir = .;
-	. += IDMAP_DIR_SIZE;
-
-#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	tramp_pg_dir = .;
-	. += PAGE_SIZE;
-#endif
-
-#ifdef CONFIG_ARM64_SW_TTBR0_PAN
-	reserved_ttbr0 = .;
-	. += RESERVED_TTBR0_SIZE;
-#endif
-	swapper_pg_dir = .;
-	. += PAGE_SIZE;
-	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
-- 
2.17.1
