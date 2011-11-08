From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Nov 2011 14:34:54 +0000
Subject: [PATCH 2/2] ARM: highbank: convert logical CPU numbers to physical
 numbers
In-Reply-To: <1320762894-11824-1-git-send-email-will.deacon@arm.com>
References: <1320762894-11824-1-git-send-email-will.deacon@arm.com>
Message-ID: <1320762894-11824-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the new cpu_logical_map() macro for converting logical
CPU numbers into physical numbers when releasing CPUs during the SMP
boot and CPU hotplug paths.

Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-highbank/highbank.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index b82dcf0..a6cdc27 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -22,6 +22,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
+#include <linux/smp.h>
 
 #include <asm/cacheflush.h>
 #include <asm/unified.h>
@@ -72,6 +73,7 @@ static void __init highbank_map_io(void)
 
 void highbank_set_cpu_jump(int cpu, void *jump_addr)
 {
+	cpu = cpu_logical_map(cpu);
 	writel(BSYM(virt_to_phys(jump_addr)), HB_JUMP_TABLE_VIRT(cpu));
 	__cpuc_flush_dcache_area(HB_JUMP_TABLE_VIRT(cpu), 16);
 	outer_clean_range(HB_JUMP_TABLE_PHYS(cpu),
-- 
1.7.4.1
