From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Mar 2016 14:25:46 +0200
Subject: [PATCH v2 1/3] arm64/mm: ensure memstart_addr remains sufficiently
 aligned
In-Reply-To: <1459340748-14975-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1459340748-14975-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1459340748-14975-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After choosing memstart_addr to be the highest multiple of
ARM64_MEMSTART_ALIGN less than or equal to the first usable physical memory
address, we clip the memblocks to the maximum size of the linear region.
Since the kernel may be high up in memory, we take care not to clip the
kernel itself, which means we have to clip some memory from the bottom if
this occurs, to ensure that the distance between the first and the last
usable physical memory address can be covered by the linear region.

However, we fail to update memstart_addr if this clipping from the bottom
occurs, which means that we may still end up with virtual addresses that
wrap into the userland range. So increment memstart_addr as appropriate to
prevent this from happening.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ec4db8dfbe3a..82ced5fa1e66 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -190,8 +190,12 @@ void __init arm64_memblock_init(void)
 	 */
 	memblock_remove(max_t(u64, memstart_addr + linear_region_size, __pa(_end)),
 			ULLONG_MAX);
-	if (memblock_end_of_DRAM() > linear_region_size)
-		memblock_remove(0, memblock_end_of_DRAM() - linear_region_size);
+	if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {
+		/* ensure that memstart_addr remains sufficiently aligned */
+		memstart_addr = round_up(memblock_end_of_DRAM() - linear_region_size,
+					 ARM64_MEMSTART_ALIGN);
+		memblock_remove(0, memstart_addr);
+	}
 
 	/*
 	 * Apply the memory limit if it was set. Since the kernel may be loaded
-- 
2.5.0
