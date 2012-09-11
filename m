From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Sep 2012 17:05:26 +0900
Subject: [PATCH 1/2] ARM: shmobile: sh73a0: enable PMU(Performance Monitoring
 Unit)
In-Reply-To: <1347350727-11962-1-git-send-email-horms@verge.net.au>
References: <1347350727-11962-1-git-send-email-horms@verge.net.au>
Message-ID: <1347350727-11962-2-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

This patch enables PMU(Performance Monitoring Unit) for sh73a0.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig      |    1 +
 arch/arm/mach-shmobile/setup-sh73a0.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 2388c86..5d0c667 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -14,6 +14,7 @@ CONFIG_NAMESPACES=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index d230af6..38ed2dd 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -734,6 +734,26 @@ static struct platform_device mpdma0_device = {
 	},
 };
 
+static struct resource pmu_resources[] = {
+	[0] = {
+		.start	= gic_spi(55),
+		.end	= gic_spi(55),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start	= gic_spi(56),
+		.end	= gic_spi(56),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pmu_device = {
+	.name		= "arm-pmu",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pmu_resources),
+	.resource	= pmu_resources,
+};
+
 static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -757,6 +777,7 @@ static struct platform_device *sh73a0_late_devices[] __initdata = {
 	&i2c4_device,
 	&dma0_device,
 	&mpdma0_device,
+	&pmu_device,
 };
 
 #define SRCR2          0xe61580b0
-- 
1.7.10.4
