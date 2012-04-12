From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Apr 2012 14:08:31 +0100
Subject: [RFC PATCH 3/3] ARM: kernel: update cpu_suspend code to use dcache
 level operations
In-Reply-To: <1334236111-28144-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1334236111-28144-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1334236111-28144-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In processors like A15/A7 L2 cache is unified and integrated within the
processor cache hierarchy, so that it is not considered an outer cache
anymore. For processors like A15/A7 flush_cache_all() ends up cleaning
all cache levels up to Level of Coherency (LoC) that includes the L2
unified cache.

When a single CPU is suspended (CPU idle) a complete L2 clean is not
required, so generic cpu_suspend code must clean the data cache using the
newly introduced dcache level function. The HW cache level is retrieved
through the hook

flush_cache_level_cpu(void)

that returns the preferred data cache level to be flushed for the respective
architecture/platform.

The context and stack pointer (context pointer) are cleaned to main memory
using cache area functions that operate on MVA and guarantee that the data
is written back to main memory (perform cache cleaning up to the Point of
Coherency - PoC) so that the processor can fetch the context when the MMU
is off in the cpu_resume code path.

outer_cache management remains unchanged.

Tested on an A15 dual-core cluster through CPU soft-reset.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Colin Cross <ccross@android.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>
---
 arch/arm/kernel/suspend.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 1794cc3..2909bc8 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -26,7 +26,18 @@ void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr)
 
 	cpu_do_suspend(ptr);
 
-	flush_cache_all();
+	flush_dcache_level(flush_cache_level_cpu());
+	/*
+	 * flush_dcache_level does not guarantee that
+	 * save_ptr and ptr are cleaned to main memory,
+	 * just up to the required cache level.
+	 * Since the context pointer and context itself
+	 * are to be retrieved with the MMU off that
+	 * data must be cleaned from all cache levels
+	 * to main memory using "area" cache primitives.
+	 */
+	__cpuc_flush_dcache_area(ptr, ptrsz);
+	__cpuc_flush_dcache_area(save_ptr, sizeof(*save_ptr));
 	outer_clean_range(*save_ptr, *save_ptr + ptrsz);
 	outer_clean_range(virt_to_phys(save_ptr),
 			  virt_to_phys(save_ptr) + sizeof(*save_ptr));
-- 
1.7.9.5
