From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:20 +0800
Subject: [PATCH 05/13] [ARM] Introduce machine specific adjust_zones()
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-6-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add machine specific 'adjust_zones' to 'struct machine_desc', and
fall back to arch_adjust_zones() if it's defined.

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/include/asm/mach/arch.h |    2 ++
 arch/arm/mm/init.c               |   12 ++++++++----
 arch/arm/mm/mmu.c                |    2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 8562ed6..0422d84 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -66,6 +66,8 @@ struct machine_desc {
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
 	void			(*init_machine)(void);
+	void			(*adjust_zones)(unsigned long *,
+						unsigned long *);
 };
 
 /*
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 2dd5a51..bfa4556 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -191,7 +191,8 @@ static void __init arm_bootmem_init(struct meminfo *mi,
 }
 
 static void __init arm_bootmem_free(struct meminfo *mi, unsigned long min,
-	unsigned long max_low, unsigned long max_high)
+	unsigned long max_low, unsigned long max_high,
+	struct machine_desc *mdesc)
 {
 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
 	int i;
@@ -229,7 +230,10 @@ static void __init arm_bootmem_free(struct meminfo *mi, unsigned long min,
 	 * Adjust the sizes according to any special requirements for
 	 * this machine type.
 	 */
-	arch_adjust_zones(zone_size, zhole_size);
+	if (mdesc->adjust_zones)
+		mdesc->adjust_zones(zone_size, zhole_size);
+	else
+		arch_adjust_zones(zone_size, zhole_size);
 
 	free_area_init_node(0, zone_size, min, zhole_size);
 }
@@ -301,7 +305,7 @@ void __init arm_lmb_init(struct meminfo *mi, struct machine_desc *mdesc)
 	lmb_dump_all();
 }
 
-void __init bootmem_init(void)
+void __init bootmem_init(struct machine_desc *mdesc)
 {
 	struct meminfo *mi = &meminfo;
 	unsigned long min, max_low, max_high;
@@ -328,7 +332,7 @@ void __init bootmem_init(void)
 	 * the sparse mem_map arrays initialized by sparse_init()
 	 * for memmap_init_zone(), otherwise all PFNs are invalid.
 	 */
-	arm_bootmem_free(mi, min, max_low, max_high);
+	arm_bootmem_free(mi, min, max_low, max_high, mdesc);
 
 	high_memory = __va((max_low << PAGE_SHIFT) - 1) + 1;
 
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 2b7c474..b0a4587 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1011,7 +1011,7 @@ void __init paging_init(struct machine_desc *mdesc)
 	/* allocate the zero page. */
 	zero_page = early_alloc(PAGE_SIZE);
 
-	bootmem_init();
+	bootmem_init(mdesc);
 
 	empty_zero_page = virt_to_page(zero_page);
 	__flush_dcache_page(NULL, empty_zero_page);
-- 
1.7.1
