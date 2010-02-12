From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Feb 2010 18:25:52 +0000
Subject: [PATCH] Help fix SMP boot issues with L2 cache
Message-ID: <20100212182552.GF18595@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    ARM: Add L2 cache handling to smp boot support
    
    The page table and secondary data which we're asking the secondary CPU
    to make use of has to hit RAM to ensure that the secondary CPU can see
    it since it may not be taking part in coherency or cache searches at
    this point.
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

 arch/arm/kernel/smp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 57162af..577543f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -99,6 +99,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	*pmd = __pmd((PHYS_OFFSET & PGDIR_MASK) |
 		     PMD_TYPE_SECT | PMD_SECT_AP_WRITE);
 	flush_pmd_entry(pmd);
+	outer_clean_range(__pa(pmd), __pa(pmd + 1));
 
 	/*
 	 * We need to tell the secondary core where to find
@@ -106,7 +107,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	 */
 	secondary_data.stack = task_stack_page(idle) + THREAD_START_SP;
 	secondary_data.pgdir = virt_to_phys(pgd);
-	wmb();
+	__cpuc_flush_dcache_area(&secondary_data, sizeof(secondary_data));
+	outer_clean_range(__pa(&secondary_data), __pa(&secondary_data + 1));
 
 	/*
 	 * Now bring the CPU into our world.
