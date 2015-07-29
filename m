From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Jul 2015 18:14:55 +0200
Subject: [PATCH] arm64: override early_init_dt_add_memory_arch()
Message-ID: <1438186495-18126-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Override the __weak early_init_dt_add_memory_arch() with our own
version. This allows us to relax the imposed restrictions at memory
discovery time, and clip the memory we will not able to address in
a single go at mapping time.

So copy the generic original, but only retain the check against
regions whose sizes become zero when clipped to page alignment.

The clipping against the maximum size of the linear region has been
moved to arm64_memblock_init().

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ad87ce826cce..76a624611939 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -158,6 +158,25 @@ early_param("mem", early_mem);
 
 void __init arm64_memblock_init(void)
 {
+	/*
+	 * Remove the memory that we will not be able to cover
+	 * with the linear mapping.
+	 */
+	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+
+	if (memblock_start_of_DRAM() < memstart_addr) {
+		pr_warn("Ignoring memory below PHYS_OFFSET (0x%012llx - 0x%012llx)\n",
+			(u64)memblock_start_of_DRAM(), memstart_addr - 1);
+		memblock_remove(0, memstart_addr);
+	}
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
@@ -374,3 +393,19 @@ static int __init keepinitrd_setup(char *__unused)
 
 __setup("keepinitrd", keepinitrd_setup);
 #endif
+
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+	if (!PAGE_ALIGNED(base)) {
+		if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
+			pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
+				base, base + size);
+			return;
+		}
+		size -= PAGE_SIZE - (base & ~PAGE_MASK);
+		base = PAGE_ALIGN(base);
+	}
+	size &= PAGE_MASK;
+
+	memblock_add(base, size);
+}
-- 
1.9.1
