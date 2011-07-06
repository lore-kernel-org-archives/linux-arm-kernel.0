From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 06 Jul 2011 11:23:50 +0100
Subject: [PATCH 3/7] ARM: vmlinux.lds: move discarded sections to beginning
In-Reply-To: <20110706102245.GO8286@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
Message-ID: <E1QePGo-0004zh-D2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than scattering the discarded sections throughout the linker
file, move them to the start.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/vmlinux.lds.S |   47 +++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index e5287f2..cb46a9b 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -38,6 +38,28 @@ jiffies = jiffies_64 + 4;
 
 SECTIONS
 {
+	/*
+	 * unwind exit sections must be discarded before the rest of the
+	 * unwind sections get included.
+	 */
+	/DISCARD/ : {
+		*(.ARM.exidx.exit.text)
+		*(.ARM.extab.exit.text)
+		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
+		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
+#ifndef CONFIG_HOTPLUG
+		*(.ARM.exidx.devexit.text)
+		*(.ARM.extab.devexit.text)
+#endif
+#ifndef CONFIG_MMU
+		*(.fixup)
+		*(__ex_table)
+#endif
+#ifndef CONFIG_SMP_ON_UP
+		*(.alt.smp.init)
+#endif
+	}
+
 #ifdef CONFIG_XIP_KERNEL
 	. = XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR);
 #else
@@ -89,25 +111,6 @@ SECTIONS
 	__init_end = .;
 #endif
 
-	/*
-	 * unwind exit sections must be discarded before the rest of the
-	 * unwind sections get included.
-	 */
-	/DISCARD/ : {
-		*(.ARM.exidx.exit.text)
-		*(.ARM.extab.exit.text)
-		ARM_CPU_DISCARD(*(.ARM.exidx.cpuexit.text))
-		ARM_CPU_DISCARD(*(.ARM.extab.cpuexit.text))
-#ifndef CONFIG_HOTPLUG
-		*(.ARM.exidx.devexit.text)
-		*(.ARM.extab.devexit.text)
-#endif
-#ifndef CONFIG_MMU
-		*(.fixup)
-		*(__ex_table)
-#endif
-	}
-
 	.text : {			/* Real text segment		*/
 		_text = .;		/* Text and read-only data	*/
 			__exception_text_start = .;
@@ -270,12 +273,6 @@ SECTIONS
 
 	/* Default discards */
 	DISCARDS
-
-#ifndef CONFIG_SMP_ON_UP
-	/DISCARD/ : {
-		*(.alt.smp.init)
-	}
-#endif
 }
 
 /*
-- 
1.7.4.4
