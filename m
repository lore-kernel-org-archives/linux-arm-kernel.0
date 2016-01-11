From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 Jan 2016 14:50:21 +0100
Subject: [PATCH] arm64: kasan: ensure that the KASAN zero page is mapped
 read-only
Message-ID: <1452520221-6219-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When switching from the early KASAN shadow region, which maps the
entire shadow space read-write, to the permanent KASAN shadow region,
which uses a zero page to shadow regions that are not subject to
instrumentation, the lowest level table kasan_zero_pte[] may be
reused unmodified, which means that the mappings of the zero page
that it contains will still be read-write.

So update it explicitly to map the zero page read only when we
activate the permanent mapping.

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/kasan_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index cf038c7d9fa9..cab7a5be40aa 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -120,6 +120,7 @@ static void __init cpu_set_ttbr1(unsigned long ttbr1)
 void __init kasan_init(void)
 {
 	struct memblock_region *reg;
+	int i;
 
 	/*
 	 * We are going to perform proper setup of shadow memory.
@@ -155,6 +156,14 @@ void __init kasan_init(void)
 				pfn_to_nid(virt_to_pfn(start)));
 	}
 
+	/*
+	 * KAsan may reuse the contents of kasan_zero_pte directly, so we
+	 * should make sure that it maps the zero page read-only.
+	 */
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		set_pte(&kasan_zero_pte[i],
+			pfn_pte(virt_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
+
 	memset(kasan_zero_page, 0, PAGE_SIZE);
 	cpu_set_ttbr1(__pa(swapper_pg_dir));
 	flush_tlb_all();
-- 
2.5.0
