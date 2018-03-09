From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu,  8 Mar 2018 22:20:57 -0500
Subject: [PATCH 4/7] ARM: linker script: factor out unwinding table sections
In-Reply-To: <20180309032100.31039-1-nicolas.pitre@linaro.org>
References: <20180309032100.31039-1-nicolas.pitre@linaro.org>
Message-ID: <20180309032100.31039-5-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 15 +--------------
 arch/arm/kernel/vmlinux.lds.S     | 15 +--------------
 arch/arm/kernel/vmlinux.lds.h     | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 4ddb547b19..65048708e4 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -66,20 +66,7 @@ SECTIONS
 	}
 
 #ifdef CONFIG_ARM_UNWIND
-	/*
-	 * Stack unwinding tables
-	 */
-	. = ALIGN(8);
-	.ARM.unwind_idx : {
-		__start_unwind_idx = .;
-		*(.ARM.exidx*)
-		__stop_unwind_idx = .;
-	}
-	.ARM.unwind_tab : {
-		__start_unwind_tab = .;
-		*(.ARM.extab*)
-		__stop_unwind_tab = .;
-	}
+	ARM_UNWIND_SECTIONS
 #endif
 
 	NOTES
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index a02a96c651..3b375d8ccb 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -74,20 +74,7 @@ SECTIONS
 	}
 
 #ifdef CONFIG_ARM_UNWIND
-	/*
-	 * Stack unwinding tables
-	 */
-	. = ALIGN(8);
-	.ARM.unwind_idx : {
-		__start_unwind_idx = .;
-		*(.ARM.exidx*)
-		__stop_unwind_idx = .;
-	}
-	.ARM.unwind_tab : {
-		__start_unwind_tab = .;
-		*(.ARM.extab*)
-		__stop_unwind_tab = .;
-	}
+	ARM_UNWIND_SECTIONS
 #endif
 
 	NOTES
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index 0ef86d75a0..566a7b42a0 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -78,3 +78,17 @@
 		. = ALIGN(4);						\
 		*(.got)			/* Global offset table */	\
 		ARM_CPU_KEEP(PROC_INFO)
+
+/* Stack unwinding tables */
+#define ARM_UNWIND_SECTIONS						\
+	. = ALIGN(8);							\
+	.ARM.unwind_idx : {						\
+		__start_unwind_idx = .;					\
+		*(.ARM.exidx*)						\
+		__stop_unwind_idx = .;					\
+	}								\
+	.ARM.unwind_tab : {						\
+		__start_unwind_tab = .;					\
+		*(.ARM.extab*)						\
+		__stop_unwind_tab = .;					\
+	}
-- 
2.14.3
