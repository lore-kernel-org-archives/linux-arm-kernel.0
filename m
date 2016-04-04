From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  4 Apr 2016 10:31:23 +0200
Subject: [PATCH v5 3/4] memremap: add arch specific hook for MEMREMAP_WB
 mappings
In-Reply-To: <1459758684-16191-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459758684-16191-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459758684-16191-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the memremap code serves MEMREMAP_WB mappings directly from
the kernel direct mapping, unless the region is in high memory, in which
case it falls back to using ioremap_cache(). However, the semantics of
ioremap_cache() are not unambiguously defined, and on ARM, it will
actually result in a mapping type that differs from the attributes used
for the linear mapping, and for this reason, the ioremap_cache() call
fails if the region is part of the memory managed by the kernel.

So instead, implement an optional hook 'arch_memremap_wb' whose default
implementation calls ioremap_cache() as before, but which can be
overridden by the architecture to do what is appropriate for it.

Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 kernel/memremap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index a6d382312e6f..017532193fb1 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -27,6 +27,13 @@ __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
 }
 #endif
 
+#ifndef arch_memremap_wb
+static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
+{
+	return (__force void *)ioremap_cache(offset, size);
+}
+#endif
+
 static void *try_ram_remap(resource_size_t offset, size_t size)
 {
 	unsigned long pfn = PHYS_PFN(offset);
@@ -34,7 +41,7 @@ static void *try_ram_remap(resource_size_t offset, size_t size)
 	/* In the simple case just return the existing linear address */
 	if (pfn_valid(pfn) && !PageHighMem(pfn_to_page(pfn)))
 		return __va(offset);
-	return NULL; /* fallback to ioremap_cache */
+	return NULL; /* fallback to arch_memremap_wb */
 }
 
 /**
@@ -90,7 +97,7 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 		if (is_ram == REGION_INTERSECTS)
 			addr = try_ram_remap(offset, size);
 		if (!addr)
-			addr = ioremap_cache(offset, size);
+			addr = arch_memremap_wb(offset, size);
 	}
 
 	/*
-- 
2.5.0
