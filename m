From: mpe@ellerman.id.au (Michael Ellerman)
Date: Fri, 12 Jun 2015 10:30:14 +1000
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <1434069014.28544.1.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (arm_multi_v7_defconfig)
failed like this:

  scripts/Makefile.build:258: recipe for target 'arch/arm/mach-socfpga/platsmp.o' failed
  arch/arm/mach-socfpga/platsmp.c:66:23: error: 'socfpga_secondary_startup' undeclared (first use in this function)
     writel(virt_to_phys(socfpga_secondary_startup),
                       ^

Caused by the interaction of commits 45be0cdb5323 "ARM: socfpga: add
CPU_METHOD_OF_DECLARE for Arria 10" and 02b4e2756e01 "ARM: v7 setup function
should invalidate L1 cache".

I applied the following fix for today.

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 4d2ad3d31f7b..c6f1df89f9af 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -63,7 +63,7 @@ static int socfpga_a10_boot_secondary(unsigned int cpu, struct task_struct *idle
 		       SOCFPGA_A10_RSTMGR_MODMPURST);
 		memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);
 
-		writel(virt_to_phys(socfpga_secondary_startup),
+		writel(virt_to_phys(secondary_startup),
 		       sys_manager_base_addr + (socfpga_cpu1start_addr & 0x00000fff));
 
 		flush_cache_all();

cheers
