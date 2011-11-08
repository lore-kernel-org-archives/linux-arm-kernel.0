From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Nov 2011 14:34:53 +0000
Subject: [PATCH 1/2] ARM: mach-imx: convert logical CPU numbers to physical
 numbers
In-Reply-To: <1320762894-11824-1-git-send-email-will.deacon@arm.com>
References: <1320762894-11824-1-git-send-email-will.deacon@arm.com>
Message-ID: <1320762894-11824-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the new cpu_logical_map() macro for converting logical
CPU numbers into physical numbers when releasing CPUs during the SMP
boot and CPU hotplug paths.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-imx/src.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
index 36cacbd..63ba593 100644
--- a/arch/arm/mach-imx/src.c
+++ b/arch/arm/mach-imx/src.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/smp.h>
 #include <asm/unified.h>
 
 #define SRC_SCR				0x000
@@ -27,6 +28,7 @@ void imx_enable_cpu(int cpu, bool enable)
 {
 	u32 mask, val;
 
+	cpu = cpu_logical_map(cpu);
 	mask = 1 << (BP_SRC_SCR_CORE1_ENABLE + cpu - 1);
 	val = readl_relaxed(src_base + SRC_SCR);
 	val = enable ? val | mask : val & ~mask;
@@ -35,6 +37,7 @@ void imx_enable_cpu(int cpu, bool enable)
 
 void imx_set_cpu_jump(int cpu, void *jump_addr)
 {
+	cpu = cpu_logical_map(cpu);
 	writel_relaxed(BSYM(virt_to_phys(jump_addr)),
 		       src_base + SRC_GPR1 + cpu * 8);
 }
-- 
1.7.4.1
