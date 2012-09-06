From: koba@kmckk.co.jp (Tetsuyuki Kobayshi)
Date: Thu,  6 Sep 2012 20:14:07 +0900
Subject: [PATCH v3 2/2] ARM: shmobile: emev2: enable PMU(Performance
 Monitoring Unit)
In-Reply-To: <1346930047-9541-1-git-send-email-koba@kmckk.co.jp>
References: <50487370.6000409@kmckk.co.jp>
 <1346930047-9541-1-git-send-email-koba@kmckk.co.jp>
Message-ID: <1346930047-9541-3-git-send-email-koba@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

This patch enables PMU(Performance Monitoring Unit) for emev2.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
Changes for v2:
- Removed #ifdef CONFIG_HW_PERF_EVENTS
- Added kzm9d_defconfig

Changes for v3:
- Rebased to pmu/clean on arm-soc.

 arch/arm/configs/kzm9d_defconfig     |    1 +
 arch/arm/mach-shmobile/setup-emev2.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
index 26146ff..8c49df6 100644
--- a/arch/arm/configs/kzm9d_defconfig
+++ b/arch/arm/configs/kzm9d_defconfig
@@ -8,6 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index dae9aa6..61446f3 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -356,6 +356,26 @@ static struct platform_device gio4_device = {
 	},
 };
 
+static struct resource pmu_resources[] = {
+	[0] = {
+		.start	= 152,
+		.end	= 152,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start	= 153,
+		.end	= 153,
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
 static struct platform_device *emev2_early_devices[] __initdata = {
 	&uart0_device,
 	&uart1_device,
@@ -370,6 +390,7 @@ static struct platform_device *emev2_late_devices[] __initdata = {
 	&gio2_device,
 	&gio3_device,
 	&gio4_device,
+	&pmu_device,
 };
 
 void __init emev2_add_standard_devices(void)
-- 
1.7.9.5
