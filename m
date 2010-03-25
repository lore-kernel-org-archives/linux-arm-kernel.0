From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Mar 2010 15:16:35 +0000
Subject: [PATCH 3/6] ARM: OMAP: register PMU IRQs during board initialisation
In-Reply-To: <1269530198-19572-3-git-send-email-will.deacon@arm.com>
References: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
	<1269530198-19572-2-git-send-email-will.deacon@arm.com>
	<1269530198-19572-3-git-send-email-will.deacon@arm.com>
Message-ID: <1269530198-19572-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the initialisation routines for the OMAP2 and OMAP3 boards
so that they register their PMU IRQs with the PMU framework in the Kernel.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-omap2/devices.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 23e4d77..4a1c232 100644
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
@@ -453,6 +455,37 @@ static void omap_init_mcspi(void)
 static inline void omap_init_mcspi(void) {}
 #endif
 
+static struct resource omap2_pmu_resource = {
+	.start	= 3,
+	.end	= 3,
+	.flags	= IORESOURCE_IRQ,
+};
+
+static struct resource omap3_pmu_resource = {
+	.start	= INT_34XX_BENCH_MPU_EMUL,
+	.end	= INT_34XX_BENCH_MPU_EMUL,
+	.flags	= IORESOURCE_IRQ,
+};
+
+static struct platform_device omap_pmu_device = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.num_resources	= 1,
+};
+
+static void omap_init_pmu(void)
+{
+	if (cpu_is_omap24xx())
+		omap_pmu_device.resource = &omap2_pmu_resource;
+	else if (cpu_is_omap34xx())
+		omap_pmu_device.resource = &omap3_pmu_resource;
+	else
+		return;
+
+	platform_device_register(&omap_pmu_device);
+}
+
+
 #ifdef CONFIG_OMAP_SHA1_MD5
 static struct resource sha1_md5_resources[] = {
 	{
@@ -797,6 +830,7 @@ static int __init omap2_init_devices(void)
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
+	omap_init_pmu();
 	omap_hdq_init();
 	omap_init_sti();
 	omap_init_sha1_md5();
-- 
1.6.3.3
