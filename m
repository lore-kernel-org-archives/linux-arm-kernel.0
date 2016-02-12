From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 12 Feb 2016 10:06:47 -0600
Subject: [PATCH 1/2] arm64: mm: Enable CONT_SIZE aligned sections for 64k page
 kernels.
In-Reply-To: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
References: <1455293208-6763-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1455293208-6763-2-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change allows ALIGN_RODATA for 16k and 64k kernels.
In the case of 64k kernels it actually aligns to the CONT_SIZE
rather than the SECTION_SIZE (which is 512M). This makes it generally
more useful, especially for CONT enabled kernels.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig.debug        | 12 ++++++------
 arch/arm64/kernel/vmlinux.lds.S | 11 ++++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index e13c4bf..65705ee 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -59,15 +59,15 @@ config DEBUG_RODATA
           If in doubt, say Y
 
 config DEBUG_ALIGN_RODATA
-	depends on DEBUG_RODATA && ARM64_4K_PAGES
+	depends on DEBUG_RODATA
 	bool "Align linker sections up to SECTION_SIZE"
 	help
 	  If this option is enabled, sections that may potentially be marked as
-	  read only or non-executable will be aligned up to the section size of
-	  the kernel. This prevents sections from being split into pages and
-	  avoids a potential TLB penalty. The downside is an increase in
-	  alignment and potentially wasted space. Turn on this option if
-	  performance is more important than memory pressure.
+	  read only or non-executable will be aligned up to the section size
+	  or contiguous hint size of the kernel. This prevents sections from
+	  being split into pages and avoids a potential TLB penalty. The downside
+	  is an increase in alignment and potentially wasted space. Turn on
+	  this option if performance is more important than memory pressure.
 
 	  If in doubt, say N
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b78a3c7..ab4e436 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -63,13 +63,14 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 #endif
 
 #if defined(CONFIG_DEBUG_ALIGN_RODATA)
-#define ALIGN_DEBUG_RO			. = ALIGN(1<<SECTION_SHIFT);
-#define ALIGN_DEBUG_RO_MIN(min)		ALIGN_DEBUG_RO
+#if defined(CONFIG_ARM64_64K_PAGES)
+#define ALIGN_DEBUG_RO_MIN(min)		. = ALIGN(CONT_SIZE);
+#else
+#define ALIGN_DEBUG_RO_MIN(min)		. = ALIGN(SECTION_SIZE);
+#endif
 #elif defined(CONFIG_DEBUG_RODATA)
-#define ALIGN_DEBUG_RO			. = ALIGN(1<<PAGE_SHIFT);
-#define ALIGN_DEBUG_RO_MIN(min)		ALIGN_DEBUG_RO
+#define ALIGN_DEBUG_RO_MIN(min)		. = ALIGN(PAGE_SIZE);
 #else
-#define ALIGN_DEBUG_RO
 #define ALIGN_DEBUG_RO_MIN(min)		. = ALIGN(min);
 #endif
 
-- 
2.4.3
