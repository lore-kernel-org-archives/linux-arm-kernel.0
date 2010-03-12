From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Mar 2010 17:29:42 +0000
Subject: [RFC PATCH 4/6] ARM: BCMRING: register PMU IRQ during board
	initialisation
In-Reply-To: <1268414985-22699-4-git-send-email-will.deacon@arm.com>
References: <1268414985-22699-1-git-send-email-will.deacon@arm.com>
	<1268414985-22699-2-git-send-email-will.deacon@arm.com>
	<1268414985-22699-3-git-send-email-will.deacon@arm.com>
	<1268414985-22699-4-git-send-email-will.deacon@arm.com>
Message-ID: <1268414985-22699-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the initialisation routine for the BCMRING platform
so that it registers its PMU IRQ with the PMU framework in the Kernel.

Cc: Leo Chen <leochen@broadcom.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-bcmring/arch.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
index 53dd2a9..e9d952a 100644
--- a/arch/arm/mach-bcmring/arch.c
+++ b/arch/arm/mach-bcmring/arch.c
@@ -26,6 +26,7 @@
 #include <linux/sysctl.h>
 
 #include <asm/irq.h>
+#include <asm/pmu.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/time.h>
@@ -89,6 +90,16 @@ static struct platform_device *devices[] __initdata = {
 	&nand_device,
 };
 
+static int pmu_irqs[] = {
+	IRQ_PMUIRQ,
+};
+
+static struct pmu_irqs cpu_pmu_device = {
+	.device_type		= ARM_PMU_DEVICE_CPU,
+	.irqs			= pmu_irqs,
+	.num_irqs		= ARRAY_SIZE(pmu_irqs),
+};
+
 /****************************************************************************
 *
 *   Called from the customize_machine function in arch/arm/kernel/setup.c
@@ -108,6 +119,8 @@ static void __init bcmring_init_machine(void)
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
+	pmu_device_register(&cpu_pmu_device);
+
 	bcmring_amba_init();
 
 	dma_init();
-- 
1.6.3.3
