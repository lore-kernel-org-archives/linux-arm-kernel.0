From: jonas.rabenstein@studium.uni-erlangen.de (Jonas Rabenstein)
Date: Thu, 24 Mar 2016 19:58:40 +0100
Subject: [PATCH] arm: remove dead blocks in XIP_KERNEL link script
Message-ID: <1458845920-14922-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 538bf4694898 ("ARM: 8513/1: xip: Move XIP linking to a separate
file") separated all CONFIG_XIP_KERNEL related portions of the linker
script into a separate file. The copied parts depending on CONFIG_SMP
may be removed, as CONFIG_SMP (and related options) can never be
selected together with CONFIG_XIP_KERNEL. CONFIG_SMP_ON_UP has a direct
dependency on !CONFIG_XIP_KERNEL. CONFIG_XIP_KERNEL itself depends on
!ARCH_MULTIPLATFORM, but all devices specifying HAVE_SMP are also some
kind of multiplatform devices. Finally, HAVE_TCM is also only selected
by multiplatform devices and may not selected for the same reasons.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 I detected the issue with chimaera, a tool I currently develop for my bachelor
 thesis extending the undertaker tool suite (https://undertaker.cs.fau.de).

 arch/arm/kernel/vmlinux-xip.lds.S | 75 ---------------------------------------
 1 file changed, 75 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index cba1ec8..7da95f8 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -25,13 +25,8 @@
 	*(.hyp.idmap.text)						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
 
-#ifdef CONFIG_HOTPLUG_CPU
-#define ARM_CPU_DISCARD(x)
-#define ARM_CPU_KEEP(x)		x
-#else
 #define ARM_CPU_DISCARD(x)	x
 #define ARM_CPU_KEEP(x)
-#endif
 
 #if (defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)) || \
 	defined(CONFIG_GENERIC_BUG)
@@ -74,9 +69,7 @@ SECTIONS
 		*(.text.fixup)
 		*(__ex_table)
 #endif
-#ifndef CONFIG_SMP_ON_UP
 		*(.alt.smp.init)
-#endif
 		*(.discard)
 		*(.discard.*)
 	}
@@ -177,13 +170,6 @@ SECTIONS
 		*(.taglist.init)
 		__tagtable_end = .;
 	}
-#ifdef CONFIG_SMP_ON_UP
-	.init.smpalt : {
-		__smpalt_begin = .;
-		*(.alt.smp.init)
-		__smpalt_end = .;
-	}
-#endif
 	.init.pv_table : {
 		__pv_table_begin = .;
 		*(.pv_table)
@@ -197,10 +183,6 @@ SECTIONS
 		INIT_RAM_FS
 	}
 
-#ifdef CONFIG_SMP
-	PERCPU_SECTION(L1_CACHE_BYTES)
-#endif
-
 	_exiprom = .;			/* End of XIP ROM area */
 	__data_loc = ALIGN(4);		/* location in binary */
 	. = PAGE_OFFSET + TEXT_OFFSET;
@@ -236,63 +218,6 @@ SECTIONS
 	}
 	_edata_loc = __data_loc + SIZEOF(.data);
 
-#ifdef CONFIG_HAVE_TCM
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
-#endif
-
 	BSS_SECTION(0, 0, 0)
 	_end = .;
 
-- 
2.7.3
