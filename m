From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Sun, 22 Mar 2015 10:40:41 +0000
Subject: [PATCH] ARM: S3C64XX: Use fixed IRQ bases to avoid conflicts on
 Cragganmore
Message-ID: <1427020841-24189-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two PMICs on Cragganmore, currently one dynamically assign
its IRQ base and the other uses a fixed base. It is possible for the
statically assigned PMIC to fail if its IRQ is taken by the dynamically
assigned one. Fix this by statically assigning both the IRQ bases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/crag6410.h      |    1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/crag6410.h b/arch/arm/mach-s3c64xx/crag6410.h
index 7bc6668..dcbe17f 100644
--- a/arch/arm/mach-s3c64xx/crag6410.h
+++ b/arch/arm/mach-s3c64xx/crag6410.h
@@ -14,6 +14,7 @@
 #include <mach/gpio-samsung.h>
 
 #define GLENFARCLAS_PMIC_IRQ_BASE	IRQ_BOARD_START
+#define BANFF_PMIC_IRQ_BASE		(IRQ_BOARD_START + 64)
 
 #define PCA935X_GPIO_BASE		GPIO_BOARD_START
 #define CODEC_GPIO_BASE			(GPIO_BOARD_START + 8)
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 10b913b..65c426b 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -554,6 +554,7 @@ static struct wm831x_touch_pdata touch_pdata = {
 
 static struct wm831x_pdata crag_pmic_pdata = {
 	.wm831x_num = 1,
+	.irq_base = BANFF_PMIC_IRQ_BASE,
 	.gpio_base = BANFF_PMIC_GPIO_BASE,
 	.soft_shutdown = true,
 
-- 
1.7.2.5
