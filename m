From: b32955@freescale.com (Huang Shijie)
Date: Thu, 13 Jun 2013 16:57:06 +0800
Subject: [PATCH 2/2] ARM: mm: dump the memblock info in the later place
In-Reply-To: <1371113826-1231-1-git-send-email-b32955@freescale.com>
References: <1371113826-1231-1-git-send-email-b32955@freescale.com>
Message-ID: <1371113826-1231-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code calls the memblock_dump_all() in the arm_memblock_init(),
but it will dump out uncorrect memblock information.

So we move it to paging_init() where we will not allocate memory from
the memblock any more.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mm/init.c |    1 -
 arch/arm/mm/mmu.c  |    2 ++
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 59c18b8..c99b543 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -384,7 +384,6 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 
 	arm_memblock_steal_permitted = false;
 	memblock_allow_resize();
-	memblock_dump_all();
 }
 
 void __init bootmem_init(void)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 56d1a22..70ad181 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1332,6 +1332,8 @@ void __init paging_init(struct machine_desc *mdesc)
 
 	bootmem_init();
 
+	memblock_dump_all();
+
 	empty_zero_page = virt_to_page(zero_page);
 	__flush_dcache_page(NULL, empty_zero_page);
 }
-- 
1.7.1
