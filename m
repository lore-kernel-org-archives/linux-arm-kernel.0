From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 12:48:54 +0100
Subject: [PATCH 4/7] ARM: nommu: do not initialise page tables in
 secondary_data structure
In-Reply-To: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
References: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368532137-8871-5-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

nommu systems do not require any page tables, so don't try to initialise
them when bringing up secondary cores.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/smp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 47ab905..b476002 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -87,8 +87,10 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *idle)
 	 * its stack and the page tables.
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
+#ifdef CONFIG_MMU
 	secondary_data.pgdir = virt_to_phys(idmap_pgd);
 	secondary_data.swapper_pg_dir = virt_to_phys(swapper_pg_dir);
+#endif
 	__cpuc_flush_dcache_area(&secondary_data, sizeof(secondary_data));
 	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
 
-- 
1.7.9.5
