From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Mar 2016 18:38:43 +0100
Subject: [PATCH 1/2] arm64/mm: ensure memstart_addr remains sufficiently
 aligned
Message-ID: <1458581924-14462-1-git-send-email-ard.biesheuvel@linaro.org>
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
index 61a38eaf0895..ef1f70f860b0 100644
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
1.9.1
