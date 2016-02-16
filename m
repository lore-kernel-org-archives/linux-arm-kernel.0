From: keescook@chromium.org (Kees Cook)
Date: Tue, 16 Feb 2016 10:38:09 -0800
Subject: [PATCH] ARM: fix __start_rodata_section_aligned on XIP
Message-ID: <20160216183809.GA26069@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the build for both allnoconfig (!CONFIG_MMU) and with
XIP_KERNEL (due to missing pieces in the linker script), as seen after
both "ARM: 8502/1: mm: mark section-aligned portion of rodata NX" and
"ARM: 8513/1: xip: Move XIP linking to a separate file".

Reported-by: Russell King <linux@arm.linux.org.uk>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 18 +++++++++++++++---
 arch/arm/kernel/vmlinux.lds.S     |  4 ++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 40bc4cadb959..2da60cd1b295 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -8,9 +8,7 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/page.h>
-#ifdef CONFIG_DEBUG_RODATA
 #include <asm/pgtable.h>
-#endif
 
 #define PROC_INFO							\
 	. = ALIGN(4);							\
@@ -115,7 +113,7 @@ SECTIONS
 			ARM_CPU_KEEP(PROC_INFO)
 	}
 
-#ifdef CONFIG_DEBUG_RODATA
+#ifdef CONFIG_DEBUG_ALIGN_RODATA
 	. = ALIGN(1<<SECTION_SHIFT);
 #endif
 	RO_DATA(PAGE_SIZE)
@@ -148,6 +146,9 @@ SECTIONS
 
 	NOTES
 
+#ifdef CONFIG_DEBUG_RODATA
+	. = ALIGN(1<<SECTION_SHIFT);
+#endif
 	_etext = .;			/* End of text and rodata section */
 
 	/*
@@ -310,6 +311,17 @@ SECTIONS
 }
 
 /*
+ * Without CONFIG_DEBUG_ALIGN_RODATA, __start_rodata_section_aligned will
+ * be the first section-aligned location after __start_rodata. Otherwise,
+ * it will be equal to __start_rodata.
+ */
+#ifdef CONFIG_MMU
+__start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
+#else
+__start_rodata_section_aligned = __start_rodata;
+#endif
+
+/*
  * These must never be empty
  * If you have to comment these two assert statements out, your
  * binutils is too old (for other reasons as well)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1707b9431761..f13960e44955 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -328,7 +328,11 @@ SECTIONS
  * be the first section-aligned location after __start_rodata. Otherwise,
  * it will be equal to __start_rodata.
  */
+#ifdef CONFIG_MMU
 __start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
+#else
+__start_rodata_section_aligned = __start_rodata;
+#endif
 
 /*
  * These must never be empty
-- 
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
