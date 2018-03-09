From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu,  8 Mar 2018 22:20:59 -0500
Subject: [PATCH 6/7] ARM: linker script: factor out TCM bits
In-Reply-To: <20180309032100.31039-1-nicolas.pitre@linaro.org>
References: <20180309032100.31039-1-nicolas.pitre@linaro.org>
Message-ID: <20180309032100.31039-7-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a plain move with identical results, and therefore
still broken in the XIP case.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 55 +----------------------------------
 arch/arm/kernel/vmlinux.lds.S     | 55 +----------------------------------
 arch/arm/kernel/vmlinux.lds.h     | 60 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 108 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 5a50a2a917..c727c56f3c 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -144,60 +144,7 @@ SECTIONS
 	__init_end = .;
 
 #ifdef CONFIG_HAVE_TCM
-        /*
-	 * We align everything to a page boundary so we can
-	 * free it after init has commenced and TCM contents have
-	 * been copied to its destination.
-	 */
-	.tcm_start : {
-		. = ALIGN(PAGE_SIZE);
-		__tcm_start = .;
-		__itcm_start = .;
-	}
-
-	/*
-	 * Link these to the ITCM RAM
-	 * Put VMA to the TCM address and LMA to the common RAM
-	 * and we'll upload the contents from RAM to TCM and free
-	 * the used RAM after that.
-	 */
-	.text_itcm ITCM_OFFSET : AT(__itcm_start)
-	{
-		__sitcm_text = .;
-		*(.tcm.text)
-		*(.tcm.rodata)
-		. = ALIGN(4);
-		__eitcm_text = .;
-	}
-
-	/*
-	 * Reset the dot pointer, this is needed to create the
-	 * relative __dtcm_start below (to be used as extern in code).
-	 */
-	. = ADDR(.tcm_start) + SIZEOF(.tcm_start) + SIZEOF(.text_itcm);
-
-	.dtcm_start : {
-		__dtcm_start = .;
-	}
-
-	/* TODO: add remainder of ITCM as well, that can be used for data! */
-	.data_dtcm DTCM_OFFSET : AT(__dtcm_start)
-	{
-		. = ALIGN(4);
-		__sdtcm_data = .;
-		*(.tcm.data)
-		. = ALIGN(4);
-		__edtcm_data = .;
-	}
-
-	/* Reset the dot pointer or the linker gets confused */
-	. = ADDR(.dtcm_start) + SIZEOF(.data_dtcm);
-
-	/* End marker for freeing TCM copy in linked object */
-	.tcm_end : AT(ADDR(.dtcm_start) + SIZEOF(.data_dtcm)){
-		. = ALIGN(PAGE_SIZE);
-		__tcm_end = .;
-	}
+	ARM_TCM
 #endif
 
 	BSS_SECTION(0, 0, 8)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 2b89363090..1e9f2a6b3d 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -139,60 +139,7 @@ SECTIONS
 	_edata = .;
 
 #ifdef CONFIG_HAVE_TCM
-        /*
-	 * We align everything to a page boundary so we can
-	 * free it after init has commenced and TCM contents have
-	 * been copied to its destination.
-	 */
-	.tcm_start : {
-		. = ALIGN(PAGE_SIZE);
-		__tcm_start = .;
-		__itcm_start = .;
-	}
-
-	/*
-	 * Link these to the ITCM RAM
-	 * Put VMA to the TCM address and LMA to the common RAM
-	 * and we'll upload the contents from RAM to TCM and free
-	 * the used RAM after that.
-	 */
-	.text_itcm ITCM_OFFSET : AT(__itcm_start)
-	{
-		__sitcm_text = .;
-		*(.tcm.text)
-		*(.tcm.rodata)
-		. = ALIGN(4);
-		__eitcm_text = .;
-	}
-
-	/*
-	 * Reset the dot pointer, this is needed to create the
-	 * relative __dtcm_start below (to be used as extern in code).
-	 */
-	. = ADDR(.tcm_start) + SIZEOF(.tcm_start) + SIZEOF(.text_itcm);
-
-	.dtcm_start : {
-		__dtcm_start = .;
-	}
-
-	/* TODO: add remainder of ITCM as well, that can be used for data! */
-	.data_dtcm DTCM_OFFSET : AT(__dtcm_start)
-	{
-		. = ALIGN(4);
-		__sdtcm_data = .;
-		*(.tcm.data)
-		. = ALIGN(4);
-		__edtcm_data = .;
-	}
-
-	/* Reset the dot pointer or the linker gets confused */
-	. = ADDR(.dtcm_start) + SIZEOF(.data_dtcm);
-
-	/* End marker for freeing TCM copy in linked object */
-	.tcm_end : AT(ADDR(.dtcm_start) + SIZEOF(.data_dtcm)){
-		. = ALIGN(PAGE_SIZE);
-		__tcm_end = .;
-	}
+	ARM_TCM
 #endif
 
 	BSS_SECTION(0, 0, 0)
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index 0a4682ecc4..cf9dabbdbd 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -113,3 +113,63 @@
 	__stubs_end = .;						\
 									\
 	PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
+
+#define ARM_TCM								\
+        /*								\
+	 * We align everything to a page boundary so we can		\
+	 * free it after init has commenced and TCM contents have	\
+	 * been copied to its destination.				\
+	 */								\
+	.tcm_start : {							\
+		. = ALIGN(PAGE_SIZE);					\
+		__tcm_start = .;					\
+		__itcm_start = .;					\
+	}								\
+									\
+	/*								\
+	 * Link these to the ITCM RAM					\
+	 *								\
+	 * Put VMA to the TCM address and LMA to the common RAM		\
+	 * and we'll upload the contents from RAM to TCM and free	\
+	 * the used RAM after that.					\
+	 */								\
+	.text_itcm ITCM_OFFSET : AT(__itcm_start)			\
+	{								\
+		__sitcm_text = .;					\
+		*(.tcm.text)						\
+		*(.tcm.rodata)						\
+		. = ALIGN(4);						\
+		__eitcm_text = .;					\
+	}								\
+									\
+	/*								\
+	 * Reset the dot pointer, this is needed to create the		\
+	 * relative __dtcm_start below (to be used as extern in code).	\
+	 */								\
+	. = ADDR(.tcm_start) + SIZEOF(.tcm_start) + SIZEOF(.text_itcm);	\
+									\
+	.dtcm_start : {							\
+		__dtcm_start = .;					\
+	}								\
+									\
+	/*								\
+	 * TODO: add remainder of ITCM as well,				\
+	 * that can be used for data!					\
+	 */								\
+	.data_dtcm DTCM_OFFSET : AT(__dtcm_start)			\
+	{								\
+		. = ALIGN(4);						\
+		__sdtcm_data = .;					\
+		*(.tcm.data)						\
+		. = ALIGN(4);						\
+		__edtcm_data = .;					\
+	}								\
+									\
+	/* Reset the dot pointer or the linker gets confused */		\
+	. = ADDR(.dtcm_start) + SIZEOF(.data_dtcm);			\
+									\
+	/* End marker for freeing TCM copy in linked object */		\
+	.tcm_end : AT(ADDR(.dtcm_start) + SIZEOF(.data_dtcm)){		\
+		. = ALIGN(PAGE_SIZE);					\
+		__tcm_end = .;						\
+	}
-- 
2.14.3
