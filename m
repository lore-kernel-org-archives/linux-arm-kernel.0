From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Mar 2010 14:58:19 +0000
Subject: [RFC PATCH 2/2] ARM: Realview-PBX: register PMU IRQs during board
	initialisation
In-Reply-To: <1268233099-28965-2-git-send-email-will.deacon@arm.com>
References: <1268233099-28965-1-git-send-email-will.deacon@arm.com>
	<1268233099-28965-2-git-send-email-will.deacon@arm.com>
Message-ID: <1268233099-28965-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the Realview-PBX initialisation routine to register
the PMU IRQs with the PMU framework in the Kernel.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-realview/realview_pbx.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index d94857e..0d31486 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -29,6 +29,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
+#include <asm/pmu.h>
 #include <asm/smp_twd.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -270,6 +271,19 @@ static struct resource realview_pbx_isp1761_resources[] = {
 	},
 };
 
+static const int pmu_irqs[] = {
+	IRQ_PBX_PMU_CPU0,
+	IRQ_PBX_PMU_CPU1,
+	IRQ_PBX_PMU_CPU2,
+	IRQ_PBX_PMU_CPU3,
+};
+
+static struct pmu_irqs cpu_pmu_device = {
+	.device_type		= ARM_PMU_DEVICE_CPU,
+	.irqs			= pmu_irqs,
+	.num_irqs		= ARRAY_SIZE(pmu_irqs),
+};
+
 static void __init gic_init_irq(void)
 {
 	/* ARM PBX on-board GIC */
@@ -363,6 +377,7 @@ static void __init realview_pbx_init(void)
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&realview_cf_device);
 	realview_usb_register(realview_pbx_isp1761_resources);
+	pmu_device_register(&cpu_pmu_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
-- 
1.6.3.3
