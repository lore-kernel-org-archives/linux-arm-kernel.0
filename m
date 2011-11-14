From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Nov 2011 16:44:56 +0000
Subject: [PATCH v2] ARM: mach-imx: convert logical CPU numbers to physical
 numbers
Message-ID: <1321289096-28679-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the new cpu_logical_map() macro for converting logical
CPU numbers into physical numbers when releasing CPUs during the SMP
boot and CPU hotplug paths.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-imx/src.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 36cacbd..a8e3368 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/smp.h>
 #include <asm/unified.h>
 
 #define SRC_SCR				0x000
@@ -23,10 +24,15 @@
 
 static void __iomem *src_base;
 
+#ifndef CONFIG_SMP
+#define cpu_logical_map(cpu)		0
+#endif
+
 void imx_enable_cpu(int cpu, bool enable)
 {
 	u32 mask, val;
 
+	cpu = cpu_logical_map(cpu);
 	mask = 1 << (BP_SRC_SCR_CORE1_ENABLE + cpu - 1);
 	val = readl_relaxed(src_base + SRC_SCR);
 	val = enable ? val | mask : val & ~mask;
@@ -35,6 +41,7 @@ void imx_enable_cpu(int cpu, bool enable)
 
 void imx_set_cpu_jump(int cpu, void *jump_addr)
 {
+	cpu = cpu_logical_map(cpu);
 	writel_relaxed(BSYM(virt_to_phys(jump_addr)),
 		       src_base + SRC_GPR1 + cpu * 8);
 }
-- 
1.7.4.1
