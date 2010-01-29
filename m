From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Jan 2010 17:03:08 +0530
Subject: [PATCH] OMAP4: Clean the secondary_data from L2
In-Reply-To: <1264764789-16025-1-git-send-email-santosh.shilimkar@ti.com>
References: <1264764789-16025-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1264764789-16025-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The boot_secondary() needs to call outer_clean_range() because the
L2 cache is already enabled in the kernel boot with
early_initcall

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-smp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 38153e5..2d0733a 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -73,6 +73,8 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the AuxCoreBoot1 register is updated with cpu state
 	 * A barrier is added to ensure that write buffer is drained
 	 */
+	flush_cache_all();
+	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
 	omap_modify_auxcoreboot0(0x200, 0x0);
 	flush_cache_all();
 	smp_wmb();
-- 
1.6.0.4
