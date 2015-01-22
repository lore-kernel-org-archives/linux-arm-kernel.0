From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Jan 2015 18:20:35 +0000
Subject: [PATCHv2 1/2] arm64: Fix overlapping VA allocations
In-Reply-To: <1421950836-19869-1-git-send-email-mark.rutland@arm.com>
References: <1421950836-19869-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1421950836-19869-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI IO space was intended to be 16MiB, at 32MiB below MODULES_VADDR, but
commit d1e6dc91b532d3d3 ("arm64: Add architectural support for PCI")
extended this to cover the full 32MiB. The final 8KiB of this 32MiB is
also allocated for the fixmap, allowing for potential clashes between
the two.

This change was masked by assumptions in mem_init and the page table
dumping code, which assumed the I/O space to be 16MiB long through
seaparte hard-coded definitions.

This patch changes the definition of the PCI I/O space allocation to
live in asm/memory.h, along with the other VA space allocations. As the
fixmap allocation depends on the number of fixmap entries, this is moved
below the PCI I/O space allocation. Both the fixmap and PCI I/O space
are guarded with 2MB of padding. Sites assuming the I/O space was 16MiB
are moved over use new PCI_IO_{START,END} definitions, which will keep
in sync with the size of the IO space (now restored to 16MiB).

As a useful side effect, the use of the new PCI_IO_{START,END}
definitions prevents a build issue in the dumping code due to a (now
redundant) missing include of io.h for PCI_IOBASE.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/io.h     |  5 +++--
 arch/arm64/include/asm/memory.h | 10 +++++++++-
 arch/arm64/mm/dump.c            |  4 ++--
 arch/arm64/mm/init.c            |  5 +++--
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 949c406..540f7c0 100644
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
+#define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
+#define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 
 /*
  * String version of I/O memory access operations.
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6486b2b..f800d45 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -33,6 +33,12 @@
 #define UL(x) _AC(x, UL)
 
 /*
+ * Size of the PCI I/O space. This must remain a power of two so that
+ * IO_SPACE_LIMIT acts as a mask for the low bits of I/O addresses.
+ */
+#define PCI_IO_SIZE		SZ_16M
+
+/*
  * PAGE_OFFSET - the virtual address of the start of the kernel image (top
  *		 (VA_BITS - 1))
  * VA_BITS - the maximum number of bits for virtual addresses.
@@ -45,7 +51,9 @@
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
 #define MODULES_END		(PAGE_OFFSET)
 #define MODULES_VADDR		(MODULES_END - SZ_64M)
-#define FIXADDR_TOP		(MODULES_VADDR - SZ_2M - PAGE_SIZE)
+#define PCI_IO_END		(MODULES_VADDR - SZ_2M)
+#define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
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
index bac492c..7e9f12e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -35,6 +35,7 @@
 #include <linux/efi.h>
 
 #include <asm/fixmap.h>
+#include <asm/memory.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/sizes.h>
@@ -277,8 +278,8 @@ void __init mem_init(void)
 		  "    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n"
 		  "              0x%16lx - 0x%16lx   (%6ld MB actual)\n"
 #endif
-		  "    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n"
 		  "    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n"
+		  "    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n"
 		  "    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n"
 		  "    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n"
 		  "      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n"
@@ -291,8 +292,8 @@ void __init mem_init(void)
 		  MLM((unsigned long)virt_to_page(PAGE_OFFSET),
 		      (unsigned long)virt_to_page(high_memory)),
 #endif
-		  MLM((unsigned long)PCI_IOBASE, (unsigned long)PCI_IOBASE + SZ_16M),
 		  MLK(FIXADDR_START, FIXADDR_TOP),
+		  MLM(PCI_IO_START, PCI_IO_END),
 		  MLM(MODULES_VADDR, MODULES_END),
 		  MLM(PAGE_OFFSET, (unsigned long)high_memory),
 		  MLK_ROUNDUP(__init_begin, __init_end),
-- 
1.9.1
