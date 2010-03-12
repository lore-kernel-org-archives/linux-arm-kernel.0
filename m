From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Mar 2010 17:29:41 +0000
Subject: [RFC PATCH 3/6] ARM: OMAP: register PMU IRQs during board
	initialisation
In-Reply-To: <1268414985-22699-3-git-send-email-will.deacon@arm.com>
References: <1268414985-22699-1-git-send-email-will.deacon@arm.com>
	<1268414985-22699-2-git-send-email-will.deacon@arm.com>
	<1268414985-22699-3-git-send-email-will.deacon@arm.com>
Message-ID: <1268414985-22699-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the initialisation routines for the OMAP2 and OMAP3 boards
so that they register their PMU IRQs with the PMU framework in the Kernel.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-omap2/devices.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 18ad931..83d06d8 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -17,8 +17,10 @@
 #include <linux/clk.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
+#include <asm/pmu.h>
 
 #include <plat/control.h>
 #include <plat/tc.h>
@@ -435,6 +437,33 @@ static void omap_init_mcspi(void)
 static inline void omap_init_mcspi(void) {}
 #endif
 
+static int omap2_pmu_irqs[] = {
+	3,
+};
+
+static int omap3_pmu_irqs[] = {
+	INT_34XX_BENCH_MPU_EMUL,
+};
+
+static struct pmu_irqs cpu_pmu_device = {
+	.device_type = ARM_PMU_DEVICE_CPU,
+};
+
+static void omap_init_pmu(void)
+{
+	if (cpu_is_omap24xx()) {
+		cpu_pmu_device.irqs = omap2_pmu_irqs;;
+		cpu_pmu_device.num_irqs = ARRAY_SIZE(omap2_pmu_irqs);
+	} else if (cpu_is_omap34xx()) {
+		cpu_pmu_device.irqs = omap3_pmu_irqs;
+		cpu_pmu_device.num_irqs = ARRAY_SIZE(omap3_pmu_irqs);
+	} else {
+		return;
+	}
+
+	pmu_device_register(&cpu_pmu_device);
+}
+
 #ifdef CONFIG_OMAP_SHA1_MD5
 static struct resource sha1_md5_resources[] = {
 	{
@@ -774,6 +803,7 @@ static int __init omap2_init_devices(void)
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
+	omap_init_pmu();
 	omap_hdq_init();
 	omap_init_sti();
 	omap_init_sha1_md5();
-- 
1.6.3.3
