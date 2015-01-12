From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Jan 2015 19:36:47 +0000
Subject: [PATCH 1/2] arm64: Fix overlapping VA allocations
In-Reply-To: <1421091408-10660-1-git-send-email-mark.rutland@arm.com>
References: <1421091408-10660-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1421091408-10660-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

32MiB of space immediately below MODULES_VADDR is allocated as PCI I/O
space, yet the final 8KiB of this space is also allocated for the
fixmap, allowing for potential clashes between the two.

Additionally, the size of the PCI I/O space is assumed to be 16MiB by
mem_init and the page table dumping code, resulting the I/O space being
erroneously reported as 16MiB long.

This patch changes the definition of the PCI I/O space allocation to
live in asm/memory.h, along with the other VA space allocations. As the
fixmap allocation depends on the number of fixmap entries, this is moved
below the PCI I/O space allocation. Both the fixmap and PCI I/O space
are guarded with a following 2MB of padding. Sites assuming the I/O
space was 16MiB are moved over use new PCI_IO_{START,END} definitions.

As a useful side effect, the use of the new PCI_IO_{START,END}
definitions prevents a build issue in the dumping code due to a (now
redundant) missing include of io.h for PCI_IOBASE, reported by Mark
Brown.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/io.h     | 5 +++--
 arch/arm64/include/asm/memory.h | 4 +++-
 arch/arm64/mm/dump.c            | 4 ++--
 arch/arm64/mm/init.c            | 3 ++-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 949c406..c180c9d 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -26,6 +26,7 @@
 
 #include <asm/byteorder.h>
 #include <asm/barrier.h>
+#include <asm/memory.h>
 #include <asm/pgtable.h>
 #include <asm/early_ioremap.h>
 #include <asm/alternative.h>
@@ -145,8 +146,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  *  I/O port access primitives.
  */
 #define arch_has_dev_port()	(1)
-#define IO_SPACE_LIMIT		(SZ_32M - 1)
-#define PCI_IOBASE		((void __iomem *)(MODULES_VADDR - SZ_32M))
+#define IO_SPACE_LIMIT		(PCI_IO_END - PCI_IO_START - 1)
+#define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 
 /*
  * String version of I/O memory access operations.
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6486b2b..a183577 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -45,7 +45,9 @@
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
 #define MODULES_END		(PAGE_OFFSET)
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
-#define FIXADDR_TOP		(MODULES_VADDR - SZ_2M - PAGE_SIZE)
+#define PCI_IO_END		(MODULES_VADDR - SZ_2M)
+#define PCI_IO_START		(PCI_IO_END - SZ_32M)
+#define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
 #define TASK_SIZE_64		(UL(1) << VA_BITS)
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index cf33f33..203a6cf 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -52,8 +52,8 @@ static struct addr_marker address_markers[] = {
 	{ 0,			"vmemmap start" },
 	{ 0,			"vmemmap end" },
 #endif
-	{ (unsigned long) PCI_IOBASE,		"PCI I/O start" },
-	{ (unsigned long) PCI_IOBASE + SZ_16M,	"PCI I/O end" },
+	{ PCI_IO_START,		"PCI I/O start" },
+	{ PCI_IO_END,		"PCI I/O end" },
 	{ FIXADDR_START,	"Fixmap start" },
 	{ FIXADDR_TOP,		"Fixmap end" },
 	{ MODULES_VADDR,	"Modules start" },
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index bac492c..9f2406d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -35,6 +35,7 @@
 #include <linux/efi.h>
 
 #include <asm/fixmap.h>
+#include <asm/memory.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/sizes.h>
@@ -291,7 +292,7 @@ void __init mem_init(void)
 		  MLM((unsigned long)virt_to_page(PAGE_OFFSET),
 		      (unsigned long)virt_to_page(high_memory)),
 #endif
-		  MLM((unsigned long)PCI_IOBASE, (unsigned long)PCI_IOBASE + SZ_16M),
+		  MLM(PCI_IO_START, PCI_IO_END),
 		  MLK(FIXADDR_START, FIXADDR_TOP),
 		  MLM(MODULES_VADDR, MODULES_END),
 		  MLM(PAGE_OFFSET, (unsigned long)high_memory),
-- 
1.9.1
