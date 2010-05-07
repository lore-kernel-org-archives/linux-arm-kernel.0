From: will.deacon@arm.com (Will Deacon)
Date: Fri,  7 May 2010 18:49:20 +0100
Subject: [PATCH] ARM: MSM: register ARM11 PMU IRQ using platform device
Message-ID: <1273254560-15645-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the MSM trout and halibut families to register
the ARM11 PMU IRQ as a platform device rather than hardcoding it
in the PMU framework.

Taken against -next-20100507.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-msm/board-halibut.c |    1 +
 arch/arm/mach-msm/board-trout.c   |    1 +
 arch/arm/mach-msm/devices.c       |   16 ++++++++++++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/board-halibut.c b/arch/arm/mach-msm/board-halibut.c
index acc2288..84d0626 100644
--- a/arch/arm/mach-msm/board-halibut.c
+++ b/arch/arm/mach-msm/board-halibut.c
@@ -63,6 +63,7 @@ static struct platform_device *devices[] __initdata = {
 	&msm_device_nand,
 	&msm_device_hsusb,
 	&msm_device_i2c,
+	&msm_device_pmu,
 	&smc91x_device,
 };
 
diff --git a/arch/arm/mach-msm/board-trout.c b/arch/arm/mach-msm/board-trout.c
index b88aec2..3987a01 100644
--- a/arch/arm/mach-msm/board-trout.c
+++ b/arch/arm/mach-msm/board-trout.c
@@ -36,6 +36,7 @@ static struct platform_device *devices[] __initdata = {
 	&msm_device_nand,
 	&msm_device_hsusb,
 	&msm_device_i2c,
+	&msm_device_pmu,
 };
 
 extern struct sys_timer msm_timer;
diff --git a/arch/arm/mach-msm/devices.c b/arch/arm/mach-msm/devices.c
index 982f1da..18952b6 100644
--- a/arch/arm/mach-msm/devices.c
+++ b/arch/arm/mach-msm/devices.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <asm/pmu.h>
 
 #include <mach/irqs.h>
 #include <mach/msm_iomap.h>
@@ -157,6 +158,21 @@ struct platform_device msm_device_smd = {
 	.id	= -1,
 };
 
+static struct resource resouces_pmu[] = {
+	[0] = {
+		.start	= INT_ARM11_PMU,
+		.end	= INT_ARM11_PMU,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device msm_device_pmu = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.num_resources	= 1,
+	.resource	= resources_pmu,
+};
+
 static struct resource resources_sdc1[] = {
 	{
 		.start	= MSM_SDC1_PHYS,
-- 
1.6.3.3
