From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2012 13:39:12 +0900
Subject: [PATCH 01/10] ARM: shmobile: r8a7740: Enable PMU
In-Reply-To: <1350448761-27346-1-git-send-email-horms@verge.net.au>
References: <1350448761-27346-1-git-send-email-horms@verge.net.au>
Message-ID: <1350448761-27346-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

This patch enables PMU for r8a7740.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig |    1 +
 arch/arm/mach-shmobile/setup-r8a7740.c     |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index f78d259..3d76407 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -7,6 +7,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 11bb1d9..1e032cb 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -590,6 +590,21 @@ static struct platform_device i2c1_device = {
 	.num_resources	= ARRAY_SIZE(i2c1_resources),
 };
 
+static struct resource pmu_resources[] = {
+	[0] = {
+		.start	= evt2irq(0x19a0),
+		.end	= evt2irq(0x19a0),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pmu_device = {
+	.name	= "arm-pmu",
+	.id		= -1,
+	.num_resources = ARRAY_SIZE(pmu_resources),
+	.resource = pmu_resources,
+};
+
 static struct platform_device *r8a7740_late_devices[] __initdata = {
 	&i2c0_device,
 	&i2c1_device,
@@ -597,6 +612,7 @@ static struct platform_device *r8a7740_late_devices[] __initdata = {
 	&dma1_device,
 	&dma2_device,
 	&usb_dma_device,
+	&pmu_device,
 };
 
 /*
-- 
1.7.10.4
