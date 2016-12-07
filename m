From: scott.branden@broadcom.com (Scott Branden)
Date: Wed,  7 Dec 2016 11:40:00 -0800
Subject: [PATCH 1/1] arm64: mm: add config options for page table configuration
In-Reply-To: <1481139600-24455-1-git-send-email-scott.branden@broadcom.com>
References: <1481139600-24455-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1481139600-24455-2-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make MAX_PHYSMEM_BITS and SECTIONS_SIZE_BITS configurable by adding
config options.
Default to current settings currently defined in sparesmem.h.
For systems wishing to save memory the config options can be overridden.
Example, changing MAX_PHYSMEM_BITS from 48 to 36 at the same time as
changing SECTION_SIZE_BITS from 30 to 26 frees 13MB of memory.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/Kconfig                 | 21 +++++++++++++++++++++
 arch/arm64/include/asm/sparsemem.h |  4 ++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2482fdd..d0a95de 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -121,6 +121,27 @@ config ARCH_PHYS_ADDR_T_64BIT
 config MMU
 	def_bool y
 
+config MAX_PHYSMEM_BITS
+	int "Maximum Physical Addressable Bits"
+	depends on SPARSEMEM
+	default 48
+	help
+	  Maximum number of physical addressable bits.
+	  If not all the physical bits are used this number can be reduced
+	  to save memory when creating page tables.
+
+	  If unsure, leave this at the default.
+
+config SECTION_SIZE_BITS
+	int "Section Size Bits"
+	depends on SPARSEMEM
+	default 30
+	help
+	  Size of each memory section.
+	  If you need to be able to allocate smaller
+	  sections in page table this number can be change to save memory.
+
+	  If unsure, leave this at the default.
 config DEBUG_RODATA
 	def_bool y
 
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 74a9d30..6677582 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -17,8 +17,8 @@
 #define __ASM_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
-#define MAX_PHYSMEM_BITS	48
-#define SECTION_SIZE_BITS	30
+#define MAX_PHYSMEM_BITS	CONFIG_MAX_PHYSMEM_BITS
+#define SECTION_SIZE_BITS	CONFIG_SECTION_SIZE_BITS
 #endif
 
 #endif
-- 
2.5.0
