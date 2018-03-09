From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu,  8 Mar 2018 22:20:58 -0500
Subject: [PATCH 5/7] ARM: linker script: factor out vectors and stubs
In-Reply-To: <20180309032100.31039-1-nicolas.pitre@linaro.org>
References: <20180309032100.31039-1-nicolas.pitre@linaro.org>
Message-ID: <20180309032100.31039-6-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 21 +--------------------
 arch/arm/kernel/vmlinux.lds.S     | 21 +--------------------
 arch/arm/kernel/vmlinux.lds.h     | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 40 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 65048708e4..5a50a2a917 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -73,26 +73,7 @@ SECTIONS
 
 	_etext = .;			/* End of text and rodata section */
 
-	/*
-	 * The vectors and stubs are relocatable code, and the
-	 * only thing that matters is their relative offsets
-	 */
-	__vectors_start = .;
-	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
-	}
-	. = __vectors_start + SIZEOF(.vectors);
-	__vectors_end = .;
-
-	__stubs_start = .;
-	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
-		*(.stubs)
-	}
-	. = __stubs_start + SIZEOF(.stubs);
-	__stubs_end = .;
-
-	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
-
+	ARM_VECTORS
 	INIT_TEXT_SECTION(8)
 	.exit.text : {
 		ARM_EXIT_KEEP(EXIT_TEXT)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 3b375d8ccb..2b89363090 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -86,26 +86,7 @@ SECTIONS
 #endif
 	__init_begin = .;
 
-	/*
-	 * The vectors and stubs are relocatable code, and the
-	 * only thing that matters is their relative offsets
-	 */
-	__vectors_start = .;
-	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
-	}
-	. = __vectors_start + SIZEOF(.vectors);
-	__vectors_end = .;
-
-	__stubs_start = .;
-	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {
-		*(.stubs)
-	}
-	. = __stubs_start + SIZEOF(.stubs);
-	__stubs_end = .;
-
-	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
-
+	ARM_VECTORS
 	INIT_TEXT_SECTION(8)
 	.exit.text : {
 		ARM_EXIT_KEEP(EXIT_TEXT)
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index 566a7b42a0..0a4682ecc4 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -92,3 +92,24 @@
 		*(.ARM.extab*)						\
 		__stop_unwind_tab = .;					\
 	}
+
+/*
+ * The vectors and stubs are relocatable code, and the
+ * only thing that matters is their relative offsets
+ */
+#define ARM_VECTORS							\
+	__vectors_start = .;						\
+	.vectors 0xffff0000 : AT(__vectors_start) {			\
+		*(.vectors)						\
+	}								\
+	. = __vectors_start + SIZEOF(.vectors);				\
+	__vectors_end = .;						\
+									\
+	__stubs_start = .;						\
+	.stubs ADDR(.vectors) + 0x1000 : AT(__stubs_start) {		\
+		*(.stubs)						\
+	}								\
+	. = __stubs_start + SIZEOF(.stubs);				\
+	__stubs_end = .;						\
+									\
+	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
-- 
2.14.3
