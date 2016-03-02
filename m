From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  2 Mar 2016 09:47:13 +0100
Subject: [PATCH] arm64: mm: check at build time that PAGE_OFFSET divides the
 VA space evenly
Message-ID: <1456908433-27149-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 8439e62a1561 ("arm64: mm: use bit ops rather than arithmetic in
pa/va translations") changed the boundary check against PAGE_OFFSET from
an arithmetic comparison to a bit test. This means we now silently assume
that PAGE_OFFSET is a power of 2 that divides the kernel virtual address
space into two equal halves. So make that assumption explicit.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9cfe94b41b54..ea136b904f56 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -171,6 +171,13 @@ void __init arm64_memblock_init(void)
 	const s64 linear_region_size = -(s64)PAGE_OFFSET;
 
 	/*
+	 * Ensure that the linear region takes up exactly half of the kernel
+	 * virtual address space. This way, we can distinguish a linear address
+	 * from a kernel/module/vmalloc address by testing a single bit.
+	 */
+	BUILD_BUG_ON(linear_region_size != BIT(VA_BITS - 1));
+
+	/*
 	 * Select a suitable value for the base of physical memory.
 	 */
 	memstart_addr = round_down(memblock_start_of_DRAM(),
-- 
2.5.0
