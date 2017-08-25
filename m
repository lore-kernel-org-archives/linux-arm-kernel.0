From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 25 Aug 2017 12:25:59 -0400
Subject: [PATCH 2/3] ARM: vmlinux*.lds.S: some decruftification
In-Reply-To: <20170825162600.15709-1-nicolas.pitre@linaro.org>
References: <20170825162600.15709-1-nicolas.pitre@linaro.org>
Message-ID: <20170825162600.15709-3-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove stuff from vmlinux.lds.S that is relevant only to the XIP build,
and stuff from vmlinux-xip.lds.S related to self-modifying code that
makes no sense in the XIP case.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 14 --------------
 arch/arm/kernel/vmlinux.lds.S     |  4 +---
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 8265b11621..d6c08a4c30 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -77,9 +77,7 @@ SECTIONS
 		*(.text.fixup)
 		*(__ex_table)
 #endif
-#ifndef CONFIG_SMP_ON_UP
 		*(.alt.smp.init)
-#endif
 		*(.discard)
 		*(.discard.*)
 	}
@@ -181,18 +179,6 @@ SECTIONS
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
-	.init.pv_table : {
-		__pv_table_begin = .;
-		*(.pv_table)
-		__pv_table_end = .;
-	}
 	.init.data : {
 		INIT_SETUP(16)
 		INIT_CALLS
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index c83a7ba737..4f86b4b7bd 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -236,9 +236,8 @@ SECTIONS
 	. = ALIGN(THREAD_SIZE);
 #endif
 	__init_end = .;
-	__data_loc = .;
 
-	.data : AT(__data_loc) {
+	.data : {
 		_data = .;		/* address in memory */
 		_sdata = .;
 
@@ -260,7 +259,6 @@ SECTIONS
 
 		_edata = .;
 	}
-	_edata_loc = __data_loc + SIZEOF(.data);
 
 	BUG_TABLE
 
-- 
2.9.5
