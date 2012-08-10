From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Aug 2012 18:36:30 +0100
Subject: [PATCH 4/9] ARM: pmu: remove arm_pmu_type enumeration
In-Reply-To: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
Message-ID: <1344620195-22372-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>

The arm_pmu_type enumeration was initially introduced to identify
different PMU types in the system, the usual one being that on the CPU
(ARM_PMU_DEVICE_CPU). With the removal of the PMU reservation code and
the introduction of devicetree bindings for the CPU PMU, the enumeration
is no longer required.

This patch removes the enumeration and updates the various CPU PMU
platform devices so that they no longer pass an .id field referring
to identify the PMU type.

Cc: JD Zheng <jdzheng@broadcom.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
[will: cosmetic edits and actual removal of the enum type]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h               |   10 ----------
 arch/arm/mach-bcmring/arch.c             |    3 +--
 arch/arm/mach-omap2/devices.c            |    3 +--
 arch/arm/mach-pxa/devices.c              |    3 +--
 arch/arm/mach-realview/realview_eb.c     |    3 +--
 arch/arm/mach-realview/realview_pb1176.c |    3 +--
 arch/arm/mach-realview/realview_pb11mp.c |    3 +--
 arch/arm/mach-realview/realview_pba8.c   |    3 +--
 arch/arm/mach-realview/realview_pbx.c    |    3 +--
 arch/arm/mach-tegra/devices.c            |    3 +--
 arch/arm/mach-ux500/cpu-db8500.c         |    3 +--
 arch/arm/mach-vexpress/ct-ca9x4.c        |    3 +--
 arch/arm/plat-iop/pmu.c                  |    3 +--
 arch/arm/plat-samsung/devs.c             |    3 +--
 14 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 05e0401..fbec73a 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -16,15 +16,6 @@
 #include <linux/perf_event.h>
 
 /*
- * Types of PMUs that can be accessed directly and require mutual
- * exclusion between profiling tools.
- */
-enum arm_pmu_type {
-	ARM_PMU_DEVICE_CPU	= 0,
-	ARM_NUM_PMU_DEVICES,
-};
-
-/*
  * struct arm_pmu_platdata - ARM PMU platform data
  *
  * @handle_irq: an optional handler which will be called from the
@@ -73,7 +64,6 @@ struct pmu_hw_events {
 
 struct arm_pmu {
 	struct pmu	pmu;
-	enum arm_pmu_type type;
 	cpumask_t	active_irqs;
 	char		*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
index 45c97b1..76e7953 100644
--- a/arch/arm/mach-bcmring/arch.c
+++ b/arch/arm/mach-bcmring/arch.c
@@ -29,7 +29,6 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/time.h>
-#include <asm/pmu.h>
 
 #include <asm/mach/arch.h>
 #include <mach/dma.h>
@@ -116,7 +115,7 @@ static struct resource pmu_resource = {
 
 static struct platform_device pmu_device = {
 	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
+	.id		= -1,
 	.resource	= &pmu_resource,
 	.num_resources	= 1,
 };
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c00c689..02b9478 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -23,7 +23,6 @@
 #include <mach/irqs.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
-#include <asm/pmu.h>
 
 #include "iomap.h"
 #include <plat/board.h>
@@ -448,7 +447,7 @@ static struct resource omap3_pmu_resource = {
 
 static struct platform_device omap_pmu_device = {
 	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
+	.id		= -1,
 	.num_resources	= 1,
 };
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 166eee5..c1f3b12 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -6,7 +6,6 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/i2c/pxa-i2c.h>
 
-#include <asm/pmu.h>
 #include <mach/udc.h>
 #include <mach/pxa3xx-u2d.h>
 #include <mach/pxafb.h>
@@ -42,7 +41,7 @@ static struct resource pxa_resource_pmu = {
 
 struct platform_device pxa_device_pmu = {
 	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
+	.id		= -1,
 	.resource	= &pxa_resource_pmu,
 	.num_resources	= 1,
 };
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index baf382c..d7a6e9c 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -32,7 +32,6 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
-#include <asm/pmu.h>
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -297,7 +296,7 @@ static struct resource pmu_resources[] = {
 
 static struct platform_device pmu_device = {
 	.name			= "arm-pmu",
-	.id			= ARM_PMU_DEVICE_CPU,
+	.id			= -1,
 	.num_resources		= ARRAY_SIZE(pmu_resources),
 	.resource		= pmu_resources,
 };
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index b1d7caf..361f898 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -34,7 +34,6 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
-#include <asm/pmu.h>
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -280,7 +279,7 @@ static struct resource pmu_resource = {
 
 static struct platform_device pmu_device = {
 	.name			= "arm-pmu",
-	.id			= ARM_PMU_DEVICE_CPU,
+	.id			= -1,
 	.num_resources		= 1,
 	.resource		= &pmu_resource,
 };
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index a98c536..c56bc8d 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -32,7 +32,6 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
-#include <asm/pmu.h>
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -263,7 +262,7 @@ static struct resource pmu_resources[] = {
 
 static struct platform_device pmu_device = {
 	.name			= "arm-pmu",
-	.id			= ARM_PMU_DEVICE_CPU,
+	.id			= -1,
 	.num_resources		= ARRAY_SIZE(pmu_resources),
 	.resource		= pmu_resources,
 };
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 5965017..0409375 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -31,7 +31,6 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
-#include <asm/pmu.h>
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 
@@ -241,7 +240,7 @@ static struct resource pmu_resource = {
 
 static struct platform_device pmu_device = {
 	.name			= "arm-pmu",
-	.id			= ARM_PMU_DEVICE_CPU,
+	.id			= -1,
 	.num_resources		= 1,
 	.resource		= &pmu_resource,
 };
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 3f2f605..97885dc 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -30,7 +30,6 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
-#include <asm/pmu.h>
 #include <asm/smp_twd.h>
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
@@ -280,7 +279,7 @@ static struct resource pmu_resources[] = {
 
 static struct platform_device pmu_device = {
 	.name			= "arm-pmu",
-	.id			= ARM_PMU_DEVICE_CPU,
+	.id			= -1,
 	.num_resources		= ARRAY_SIZE(pmu_resources),
 	.resource		= pmu_resources,
 };
diff --git a/arch/arm/mach-tegra/devices.c b/arch/arm/mach-tegra/devices.c
index c70e65f..61e9603 100644
--- a/arch/arm/mach-tegra/devices.c
+++ b/arch/arm/mach-tegra/devices.c
@@ -23,7 +23,6 @@
 #include <linux/fsl_devices.h>
 #include <linux/serial_8250.h>
 #include <linux/i2c-tegra.h>
-#include <asm/pmu.h>
 #include <mach/irqs.h>
 #include <mach/iomap.h>
 #include <mach/dma.h>
@@ -516,7 +515,7 @@ static struct resource tegra_pmu_resources[] = {
 
 struct platform_device tegra_pmu_device = {
 	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(tegra_pmu_resources),
 	.resource	= tegra_pmu_resources,
 };
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index db3c52d..3ee761d 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -19,7 +19,6 @@
 #include <linux/mfd/abx500/ab8500.h>
 
 #include <asm/mach/map.h>
-#include <asm/pmu.h>
 #include <plat/gpio-nomadik.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
@@ -122,7 +121,7 @@ struct arm_pmu_platdata db8500_pmu_platdata = {
 
 static struct platform_device db8500_pmu_device = {
 	.name			= "arm-pmu",
-	.id			= ARM_PMU_DEVICE_CPU,
+	.id			= -1,
 	.num_resources		= ARRAY_SIZE(db8500_pmu_resources),
 	.resource		= db8500_pmu_resources,
 	.dev.platform_data	= &db8500_pmu_platdata,
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 61c4924..e4073a6 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -13,7 +13,6 @@
 #include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
-#include <asm/pmu.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 
@@ -144,7 +143,7 @@ static struct resource pmu_resources[] = {
 
 static struct platform_device pmu_device = {
 	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pmu_resources),
 	.resource	= pmu_resources,
 };
diff --git a/arch/arm/plat-iop/pmu.c b/arch/arm/plat-iop/pmu.c
index a2024b8..ad9f974 100644
--- a/arch/arm/plat-iop/pmu.c
+++ b/arch/arm/plat-iop/pmu.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/platform_device.h>
-#include <asm/pmu.h>
 #include <mach/irqs.h>
 
 static struct resource pmu_resource = {
@@ -26,7 +25,7 @@ static struct resource pmu_resource = {
 
 static struct platform_device pmu_device = {
 	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
+	.id		= -1,
 	.resource	= &pmu_resource,
 	.num_resources	= 1,
 };
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 74e31ce..8154fab 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -33,7 +33,6 @@
 #include <linux/platform_data/s3c-hsotg.h>
 
 #include <asm/irq.h>
-#include <asm/pmu.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
@@ -1105,7 +1104,7 @@ static struct resource s5p_pmu_resource[] = {
 
 static struct platform_device s5p_device_pmu = {
 	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
+	.id		= -1,
 	.num_resources	= ARRAY_SIZE(s5p_pmu_resource),
 	.resource	= s5p_pmu_resource,
 };
-- 
1.7.4.1
