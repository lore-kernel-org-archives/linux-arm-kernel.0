From: labbott@redhat.com (Laura Abbott)
Date: Wed,  2 Nov 2016 15:00:53 -0600
Subject: [PATCHv2 5/6] arm64: Use __pa_symbol for _end
In-Reply-To: <20161102210054.16621-1-labbott@redhat.com>
References: <20161102210054.16621-1-labbott@redhat.com>
Message-ID: <20161102210054.16621-6-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


__pa_symbol is technically the marco that should be used for kernel
symbols. Switch to this as a pre-requisite for DEBUG_VIRTUAL.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 212c4d1..3236eb0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -209,8 +209,8 @@ void __init arm64_memblock_init(void)
 	 * linear mapping. Take care not to clip the kernel which may be
 	 * high in memory.
 	 */
-	memblock_remove(max_t(u64, memstart_addr + linear_region_size, __pa(_end)),
-			ULLONG_MAX);
+	memblock_remove(max_t(u64, memstart_addr + linear_region_size,
+			__pa_symbol(_end)), ULLONG_MAX);
 	if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {
 		/* ensure that memstart_addr remains sufficiently aligned */
 		memstart_addr = round_up(memblock_end_of_DRAM() - linear_region_size,
-- 
2.10.1
