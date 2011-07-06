From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 06 Jul 2011 11:24:10 +0100
Subject: [PATCH 4/7] ARM: vmlinux.lds: rearrange .init output section
In-Reply-To: <20110706102245.GO8286@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
Message-ID: <E1QePH8-0004zl-Gf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep the various linker tables as separate output sections rather
than combining them together into one big .init section.  This
makes the 'vmlinux' easier to see what is placed where.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/vmlinux.lds.S |   47 +++++++++++++++++++++++++---------------
 1 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index cb46a9b..c8bb9b7 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -65,48 +65,59 @@ SECTIONS
 #else
 	. = PAGE_OFFSET + TEXT_OFFSET;
 #endif
-
-	.init : {			/* Init code and data		*/
+	.head.text : {
 		_stext = .;
-		_sinittext = .;
-			HEAD_TEXT
-			INIT_TEXT
-			ARM_EXIT_KEEP(EXIT_TEXT)
-		_einittext = .;
+		HEAD_TEXT
+	}
+	INIT_TEXT_SECTION(8)
+	.exit.text : {
+		ARM_EXIT_KEEP(EXIT_TEXT)
+	}
+	.init.proc.info : {
 		ARM_CPU_DISCARD(PROC_INFO)
+	}
+	.init.arch.info : {
 		__arch_info_begin = .;
-			*(.arch.info.init)
+		*(.arch.info.init)
 		__arch_info_end = .;
+	}
+	.init.tagtable : {
 		__tagtable_begin = .;
-			*(.taglist.init)
+		*(.taglist.init)
 		__tagtable_end = .;
+	}
 #ifdef CONFIG_SMP_ON_UP
+	.init.smpalt : {
 		__smpalt_begin = .;
-			*(.alt.smp.init)
+		*(.alt.smp.init)
 		__smpalt_end = .;
+	}
 #endif
-
+	.init.pv_table : {
 		__pv_table_begin = .;
-			*(.pv_table)
+		*(.pv_table)
 		__pv_table_end = .;
-
+	}
+	.init.data : {
+#ifndef CONFIG_XIP_KERNEL
+		INIT_DATA
+#endif
 		INIT_SETUP(16)
-
 		INIT_CALLS
 		CON_INITCALL
 		SECURITY_INITCALL
 		INIT_RAM_FS
-
+	}
 #ifndef CONFIG_XIP_KERNEL
-		__init_begin = _stext;
-		INIT_DATA
+	.exit.data : {
 		ARM_EXIT_KEEP(EXIT_DATA)
-#endif
 	}
+#endif
 
 	PERCPU_SECTION(32)
 
 #ifndef CONFIG_XIP_KERNEL
+	__init_begin = _stext;
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
 #endif
-- 
1.7.4.4
