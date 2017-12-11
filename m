From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Mon, 11 Dec 2017 11:03:32 +0530
Subject: [PATCH] arch/arm64: elfcorehdr should be the first allocation
Message-ID: <1512970412-5472-1-git-send-email-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhimanyu Saini <abhimanyu.saini@nxp.com>

elfcorehdr_addr is assigned by kexec-utils and device tree of
dump kernel is fixed in chosen node with parameter "linux,elfcorehdr".
So, memory should be first reserved for elfcorehdr,
otherwise overlaps may happen with other memory allocations
which were done before the allocation of elcorehdr in the crash kernel

Signed-off-by: Guanhua <guanhua.gao@nxp.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
---
 arch/arm64/mm/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5960bef0170d..551048cfcfff 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -453,6 +453,10 @@ void __init arm64_memblock_init(void)
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
 	 */
+
+	/* make this the first reservation so that there are no chances of
+	 * overlap */
+	reserve_elfcorehdr();
 	memblock_reserve(__pa_symbol(_text), _end - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start) {
@@ -474,8 +478,6 @@ void __init arm64_memblock_init(void)
 
 	reserve_crashkernel();
 
-	reserve_elfcorehdr();
-
 	dma_contiguous_reserve(arm64_dma_phys_limit);
 
 	memblock_allow_resize();
-- 
2.14.1
