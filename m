From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Mar 2010 17:29:40 +0000
Subject: [RFC PATCH 2/6] ARM: Realview: register PMU IRQs during board
	initialisation
In-Reply-To: <1268414985-22699-2-git-send-email-will.deacon@arm.com>
References: <1268414985-22699-1-git-send-email-will.deacon@arm.com>
	<1268414985-22699-2-git-send-email-will.deacon@arm.com>
Message-ID: <1268414985-22699-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the initialisation routines for the Realview boards so that
they register their PMU IRQs with the PMU framework in the Kernel.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-realview/realview_eb.c     |   15 +++++++++++++++
 arch/arm/mach-realview/realview_pb1176.c |   12 ++++++++++++
 arch/arm/mach-realview/realview_pb11mp.c |   15 +++++++++++++++
 arch/arm/mach-realview/realview_pba8.c   |   12 ++++++++++++
 arch/arm/mach-realview/realview_pbx.c    |   15 +++++++++++++++
 5 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 7d857d3..603a747 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -31,6 +31,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
+#include <asm/pmu.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/icst307.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -294,6 +295,19 @@ static struct resource realview_eb_isp1761_resources[] = {
 	},
 };
 
+static int pmu_irqs[] = {
+	IRQ_EB11MP_PMU_CPU0,
+	IRQ_EB11MP_PMU_CPU1,
+	IRQ_EB11MP_PMU_CPU2,
+	IRQ_EB11MP_PMU_CPU3,
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
 	if (core_tile_eb11mp() || core_tile_a9mp()) {
@@ -413,6 +427,7 @@ static void __init realview_eb_init(void)
 	platform_device_register(&realview_i2c_device);
 	eth_device_register();
 	realview_usb_register(realview_eb_isp1761_resources);
+	pmu_device_register(&cpu_pmu_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 44392e5..e43fd53 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -31,6 +31,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
+#include <asm/pmu.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/icst307.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -263,6 +264,16 @@ static struct resource realview_pb1176_isp1761_resources[] = {
 	},
 };
 
+static int pmu_irqs[] = {
+	IRQ_DC1176_CORE_PMU,
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
 	/* ARM1176 DevChip GIC, primary */
@@ -324,6 +335,7 @@ static void __init realview_pb1176_init(void)
 	realview_eth_register(NULL, realview_pb1176_smsc911x_resources);
 	platform_device_register(&realview_i2c_device);
 	realview_usb_register(realview_pb1176_isp1761_resources);
+	pmu_device_register(&cpu_pmu_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 3e02731..00db50e 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -31,6 +31,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
+#include <asm/pmu.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/icst307.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -260,6 +261,19 @@ static struct resource realview_pb11mp_isp1761_resources[] = {
 	},
 };
 
+static int pmu_irqs[] = {
+	IRQ_TC11MP_PMU_CPU0,
+	IRQ_TC11MP_PMU_CPU1,
+	IRQ_TC11MP_PMU_CPU2,
+	IRQ_TC11MP_PMU_CPU3,
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
 	unsigned int pldctrl;
@@ -329,6 +343,7 @@ static void __init realview_pb11mp_init(void)
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&realview_cf_device);
 	realview_usb_register(realview_pb11mp_isp1761_resources);
+	pmu_device_register(&cpu_pmu_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index fe4e25c..9c787ac 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -30,6 +30,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
+#include <asm/pmu.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/icst307.h>
 
@@ -250,6 +251,16 @@ static struct resource realview_pba8_isp1761_resources[] = {
 	},
 };
 
+static int pmu_irqs[] = {
+	IRQ_PBA8_PMU,
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
 	/* ARM PB-A8 on-board GIC */
@@ -296,6 +307,7 @@ static void __init realview_pba8_init(void)
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&realview_cf_device);
 	realview_usb_register(realview_pba8_isp1761_resources);
+	pmu_device_register(&cpu_pmu_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index d94857e..95b0a12 100644
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
 
+static int pmu_irqs[] = {
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
