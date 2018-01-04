From: poonam.aggrwal@codeaurora.org (Poonam Aggrwal)
Date: Thu, 4 Jan 2018 16:08:20 +0530
Subject: [PATCH] arm64: Allocate elfcorehdr & crashkernel mem before any
 reservation
Message-ID: <1515062300-8246-1-git-send-email-poonam.aggrwal@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Poonam Aggrwal <poonam.aggrwal@nxp.com>

Address for both crashkernel memory and elfcorehdr can be assigned
statically. For crashkernel memory it is via crashkernel=SIZE at ADDRESS
and elfcorehdr_addr via by kexec-utils in dump kernel device tree.

So memory should be reserved for both the above areas before any
other memory reservations are done. Otherwise overlaps may happen and
memory allocations will fail leading to failure in booting the 
dump capture kernel.

Signed-off-by: Guanhua <guanhua.gao@nxp.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
---
reworked based on the discussions:(with Will Deacon and Takahiro)
https://patchwork.kernel.org/patch/10104249/
 arch/arm64/mm/init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 00e7b90..24ce15d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -453,6 +453,14 @@ void __init arm64_memblock_init(void)
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
 	 */
+
+	/* make these the first reservations to avoid chances of
+	 * overlap
+	 */
+	reserve_elfcorehdr();
+
+	reserve_crashkernel();
+
 	memblock_reserve(__pa_symbol(_text), _end - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start) {
@@ -472,10 +480,6 @@ void __init arm64_memblock_init(void)
 	else
 		arm64_dma_phys_limit = PHYS_MASK + 1;
 
-	reserve_crashkernel();
-
-	reserve_elfcorehdr();
-
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 
 	dma_contiguous_reserve(arm64_dma_phys_limit);
-- 
2.7.4
