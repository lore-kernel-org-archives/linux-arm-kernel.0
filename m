From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Thu, 18 Jan 2018 19:13:11 +0000
Subject: [PATCH] arm64: mm: ignore memory above supported physical address size
Message-ID: <1516302791-7692-1-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting a kernel without 52-bit PA support (e.g. a kernel with 4k
pages) on a system with 52-bit memory, the kernel will currently try to
use the 52-bit memory and crash. Fix this by ignoring any memory higher
than what the kernel supports.

Fixes: f77d281713d4 ("arm64: enable 52-bit physical address support")
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/mm/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 672094ed7e07..285745b2ca38 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -366,6 +366,9 @@ void __init arm64_memblock_init(void)
 	/* Handle linux,usable-memory-range property */
 	fdt_enforce_memory_region();
 
+	/* Remove memory above our supported physical address size */
+	memblock_remove(1ULL << PHYS_MASK_SHIFT, ULLONG_MAX);
+
 	/*
 	 * Ensure that the linear region takes up exactly half of the kernel
 	 * virtual address space. This way, we can distinguish a linear address
-- 
2.1.4
