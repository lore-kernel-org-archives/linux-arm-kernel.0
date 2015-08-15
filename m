From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 15 Aug 2015 14:13:44 +0200
Subject: [PATCH] arm64: ignore memory outside of the linear range
Message-ID: <1439640824-30498-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to ensure that we don't try to map system RAM ranges whose
offset relative to the start of the kernel image exceeds the size of
the linear range. This may happen even on systems that don't have
huge amounts of RAM if it is laid out very sparsely.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This is the minimal fix for addressing the issue we discussed. I dropped
the other changes for now, let's revisit those when (if) my patches for
decoupling the kernel mapping from the linear mapping are back under
discussion.

I will leave it up to the maintainers whether this constitutes a bugfix or
not, but since this has never worked from the beginning afaict, I don't
think it belongs in stable per se.

 arch/arm64/mm/init.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ad87ce826cce..c65e57d4c3e7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -158,6 +158,19 @@ early_param("mem", early_mem);
 
 void __init arm64_memblock_init(void)
 {
+	/*
+	 * Remove the memory that we will not be able to cover
+	 * with the linear mapping.
+	 */
+	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+
+	if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {
+		pr_warn("Ignoring memory outside of linear range (0x%012llx - 0x%012llx)\n",
+			memstart_addr + linear_region_size,
+			(u64)memblock_end_of_DRAM() - 1);
+		memblock_remove(memstart_addr + linear_region_size, ULLONG_MAX);
+	}
+
 	memblock_enforce_memory_limit(memory_limit);
 
 	/*
-- 
1.9.1
