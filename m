From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Mar 2010 15:16:34 +0000
Subject: [PATCH 2/6] ARM: Realview: register PMU IRQs during board
	initialisation
In-Reply-To: <1269530198-19572-2-git-send-email-will.deacon@arm.com>
References: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
	<1269530198-19572-2-git-send-email-will.deacon@arm.com>
Message-ID: <1269530198-19572-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the initialisation routines for the Realview boards so that
they register their PMU IRQs with the PMU framework in the Kernel.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-realview/realview_eb.c     |   32 ++++++++++++++++++++++++++++++
 arch/arm/mach-realview/realview_pb1176.c |   15 ++++++++++++++
 arch/arm/mach-realview/realview_pb11mp.c |   32 ++++++++++++++++++++++++++++++
 arch/arm/mach-realview/realview_pba8.c   |   15 ++++++++++++++
 arch/arm/mach-realview/realview_pbx.c    |   32 ++++++++++++++++++++++++++++++
 5 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 7d857d3..a4a101a 100644
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
@@ -294,6 +295,36 @@ static struct resource realview_eb_isp1761_resources[] = {
 	},
 };
 
+static struct resource pmu_resources[] = {
+	[0] = {
+		.start		= IRQ_EB11MP_PMU_CPU0,
+		.end		= IRQ_EB11MP_PMU_CPU0,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start		= IRQ_EB11MP_PMU_CPU1,
+		.end		= IRQ_EB11MP_PMU_CPU1,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= IRQ_EB11MP_PMU_CPU2,
+		.end		= IRQ_EB11MP_PMU_CPU2,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start		= IRQ_EB11MP_PMU_CPU3,
+		.end		= IRQ_EB11MP_PMU_CPU3,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pmu_device = {
+	.name			= "arm-pmu",
+	.id			= ARM_PMU_DEVICE_CPU,
+	.num_resources		= ARRAY_SIZE(pmu_resources),
+	.resource		= pmu_resources,
+};
+
 static void __init gic_init_irq(void)
 {
 	if (core_tile_eb11mp() || core_tile_a9mp()) {
@@ -407,6 +438,7 @@ static void __init realview_eb_init(void)
 		 * Bits:  .... ...0 0111 1001 0000 .... .... .... */
 		l2x0_init(__io_address(REALVIEW_EB11MP_L220_BASE), 0x00790000, 0xfe000fff);
 #endif
+		platform_device_register(&pmu_device);
 	}
 
 	realview_flash_register(&realview_eb_flash_resource, 1);
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 44392e5..85429cb 100644
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
@@ -263,6 +264,19 @@ static struct resource realview_pb1176_isp1761_resources[] = {
 	},
 };
 
+static struct resource pmu_resource = {
+	.start		= IRQ_DC1176_PMU_CPU0,
+	.end		= IRQ_DC1176_PMU_CPU0,
+	.flags		= IORESOURCE_IRQ,
+};
+
+static struct platform_device pmu_device = {
+	.name			= "arm-pmu",
+	.id			= ARM_PMU_DEVICE_CPU,
+	.num_resources		= 1,
+	.resource		= &pmu_resource,
+};
+
 static void __init gic_init_irq(void)
 {
 	/* ARM1176 DevChip GIC, primary */
@@ -324,6 +338,7 @@ static void __init realview_pb1176_init(void)
 	realview_eth_register(NULL, realview_pb1176_smsc911x_resources);
 	platform_device_register(&realview_i2c_device);
 	realview_usb_register(realview_pb1176_isp1761_resources);
+	platform_device_register(&pmu_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 3e02731..3ab4447 100644
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
@@ -260,6 +261,36 @@ static struct resource realview_pb11mp_isp1761_resources[] = {
 	},
 };
 
+static struct resource pmu_resources[] = {
+	[0] = {
+		.start		= IRQ_TC11MP_PMU_CPU0,
+		.end		= IRQ_TC11MP_PMU_CPU0,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start		= IRQ_TC11MP_PMU_CPU1,
+		.end		= IRQ_TC11MP_PMU_CPU1,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= IRQ_TC11MP_PMU_CPU2,
+		.end		= IRQ_TC11MP_PMU_CPU2,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start		= IRQ_TC11MP_PMU_CPU3,
+		.end		= IRQ_TC11MP_PMU_CPU3,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pmu_device = {
+	.name			= "arm-pmu",
+	.id			= ARM_PMU_DEVICE_CPU,
+	.num_resources		= ARRAY_SIZE(pmu_resources),
+	.resource		= pmu_resources,
+};
+
 static void __init gic_init_irq(void)
 {
 	unsigned int pldctrl;
@@ -329,6 +360,7 @@ static void __init realview_pb11mp_init(void)
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&realview_cf_device);
 	realview_usb_register(realview_pb11mp_isp1761_resources);
+	platform_device_register(&pmu_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index fe4e25c..7b36ea9 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -30,6 +30,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/mach-types.h>
+#include <asm/pmu.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/icst307.h>
 
@@ -250,6 +251,19 @@ static struct resource realview_pba8_isp1761_resources[] = {
 	},
 };
 
+static struct resource pmu_resource = {
+	.start		= IRQ_PBA8_PMU,
+	.end		= IRQ_PBA8_PMU,
+	.flags		= IORESOURCE_IRQ,
+};
+
+static struct platform_device pmu_device = {
+	.name			= "arm-pmu",
+	.id			= ARM_PMU_DEVICE_CPU,
+	.num_resources		= 1,
+	.resource		= &pmu_resource,
+};
+
 static void __init gic_init_irq(void)
 {
 	/* ARM PB-A8 on-board GIC */
@@ -296,6 +310,7 @@ static void __init realview_pba8_init(void)
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&realview_cf_device);
 	realview_usb_register(realview_pba8_isp1761_resources);
+	platform_device_register(&pmu_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index d94857e..a235ba3 100644
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
@@ -270,6 +271,36 @@ static struct resource realview_pbx_isp1761_resources[] = {
 	},
 };
 
+static struct resource pmu_resources[] = {
+	[0] = {
+		.start		= IRQ_PBX_PMU_CPU0,
+		.end		= IRQ_PBX_PMU_CPU0,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start		= IRQ_PBX_PMU_CPU1,
+		.end		= IRQ_PBX_PMU_CPU1,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start		= IRQ_PBX_PMU_CPU2,
+		.end		= IRQ_PBX_PMU_CPU2,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.start		= IRQ_PBX_PMU_CPU3,
+		.end		= IRQ_PBX_PMU_CPU3,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pmu_device = {
+	.name			= "arm-pmu",
+	.id			= ARM_PMU_DEVICE_CPU,
+	.num_resources		= ARRAY_SIZE(pmu_resources),
+	.resource		= pmu_resources,
+};
+
 static void __init gic_init_irq(void)
 {
 	/* ARM PBX on-board GIC */
@@ -354,6 +385,7 @@ static void __init realview_pbx_init(void)
 		/* 16KB way size, 8-way associativity, parity disabled
 		 * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... .... */
 		l2x0_init(l2x0_base, 0x02520000, 0xc0000fff);
+		platform_device_register(&pmu_device);
 	}
 #endif
 
-- 
1.6.3.3
