From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 15 Apr 2015 17:34:17 +0200
Subject: [PATCH v4 06/13] arm64: implement our own
 early_init_dt_add_memory_arch()
In-Reply-To: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1429112064-19952-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Override the __weak early_init_dt_add_memory_arch() with our own
version. This allows us to relax the imposed restrictions at memory
discovery time, which is needed if we want to defer the assignment
of PHYS_OFFSET and make it independent of where the kernel Image
is placed in physical memory.

So copy the generic original, but only retain the check against
regions whose sizes become zero when clipped to page alignment.

For now, we will remove the range below PHYS_OFFSET explicitly
until we rework that logic in a subsequent patch. Any memory that
we will not be able to map due to insufficient size of the linear
region is also removed.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ae85da6307bb..1599a5c5e94a 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -158,6 +158,15 @@ early_param("mem", early_mem);
 
 void __init arm64_memblock_init(void)
 {
+	/*
+	 * Remove the memory that we will not be able to cover
+	 * with the linear mapping.
+	 */
+	const s64 linear_region_size = -(s64)PAGE_OFFSET;
+
+	memblock_remove(0, memstart_addr);
+	memblock_remove(memstart_addr + linear_region_size, ULLONG_MAX);
+
 	memblock_enforce_memory_limit(memory_limit);
 
 	/*
@@ -372,3 +381,19 @@ static int __init keepinitrd_setup(char *__unused)
 
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
1.8.3.2
