From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Mar 2010 15:16:36 +0000
Subject: [PATCH 4/6] ARM: BCMRING: register PMU IRQ during board initialisation
In-Reply-To: <1269530198-19572-4-git-send-email-will.deacon@arm.com>
References: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
	<1269530198-19572-2-git-send-email-will.deacon@arm.com>
	<1269530198-19572-3-git-send-email-will.deacon@arm.com>
	<1269530198-19572-4-git-send-email-will.deacon@arm.com>
Message-ID: <1269530198-19572-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the initialisation routine for the BCMRING platform
so that it registers its PMU IRQ with the PMU framework in the Kernel.

Cc: Leo Chen <leochen@broadcom.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-bcmring/arch.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-bcmring/arch.c b/arch/arm/mach-bcmring/arch.c
index 53dd2a9..2f13919 100644
--- a/arch/arm/mach-bcmring/arch.c
+++ b/arch/arm/mach-bcmring/arch.c
@@ -29,6 +29,7 @@
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/mach/time.h>
+#include <asm/pmu.h>
 
 #include <asm/mach/arch.h>
 #include <mach/dma.h>
@@ -85,8 +86,23 @@ static struct platform_device nand_device = {
 	.num_resources	= ARRAY_SIZE(nand_resource),
 };
 
+static struct resource pmu_resource = {
+	.start	= IRQ_PMUIRQ,
+	.end	= IRQ_PMUIRQ,
+	.flags	= IORESOURCE_IRQ,
+};
+
+static struct platform_device pmu_device = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.resource	= &pmu_resource,
+	.num_resources	= 1,
+};
+
+
 static struct platform_device *devices[] __initdata = {
 	&nand_device,
+	&pmu_device,
 };
 
 /****************************************************************************
-- 
1.6.3.3
