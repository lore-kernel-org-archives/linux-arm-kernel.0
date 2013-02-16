From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 16 Feb 2013 17:43:58 +0100
Subject: [PATCH v2 06/12] clocksource: samsung-time: Remove use of static
 register mapping
In-Reply-To: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
References: <1361033044-27629-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1361033044-27629-7-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch brings the samsung-time driver one step closer to
multiplatform by replacing references to statically mapped registers
with dynamic mapping using ioremap.

The helper struct samsung_timer_variant is extended with reg_base field,
which is used to pass platform-specific base address to the driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/mach-universal_c210.c | 1 +
 arch/arm/mach-s3c24xx/common.c             | 1 +
 arch/arm/mach-s3c64xx/common.c             | 1 +
 arch/arm/mach-s5p64x0/common.c             | 1 +
 arch/arm/mach-s5pc100/common.c             | 1 +
 arch/arm/mach-s5pv210/common.c             | 1 +
 drivers/clocksource/samsung-time.c         | 9 +++++++--
 include/clocksource/samsung-time.h         | 2 ++
 8 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index ba059a4..74f6e7f 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1091,6 +1091,7 @@ static struct platform_device *universal_devices[] __initdata = {
 };
 
 static const struct samsung_timer_variant universal_timer_variant = {
+	.reg_base = EXYNOS4_PA_TIMER,
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 1017ebb..44ba280 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -221,6 +221,7 @@ static void s3c24xx_default_idle(void)
 }
 
 static const struct samsung_timer_variant s3c24xx_timer_variant = {
+	.reg_base = S3C24XX_PA_TIMER,
 	.bits = 16,
 	.prescale = 25,
 	.divisor = 50,
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index c316efa..9883a91 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -150,6 +150,7 @@ static struct device s3c64xx_dev = {
 };
 
 static const struct samsung_timer_variant s3c64xx_timer_variant = {
+	.reg_base = S3C_PA_TIMER,
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/arch/arm/mach-s5p64x0/common.c b/arch/arm/mach-s5p64x0/common.c
index fc2d6c6..d715b19 100644
--- a/arch/arm/mach-s5p64x0/common.c
+++ b/arch/arm/mach-s5p64x0/common.c
@@ -158,6 +158,7 @@ static void s5p64x0_idle(void)
 }
 
 static const struct samsung_timer_variant s5p64x0_timer_variant = {
+	.reg_base = S5P_PA_TIMER,
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/arch/arm/mach-s5pc100/common.c b/arch/arm/mach-s5pc100/common.c
index d1e9241..d93e26e 100644
--- a/arch/arm/mach-s5pc100/common.c
+++ b/arch/arm/mach-s5pc100/common.c
@@ -133,6 +133,7 @@ static struct map_desc s5pc100_iodesc[] __initdata = {
 };
 
 static const struct samsung_timer_variant s5pc100_timer_variant = {
+	.reg_base = S5P_PA_TIMER,
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/arch/arm/mach-s5pv210/common.c b/arch/arm/mach-s5pv210/common.c
index d0a446d..29317ee 100644
--- a/arch/arm/mach-s5pv210/common.c
+++ b/arch/arm/mach-s5pv210/common.c
@@ -150,6 +150,7 @@ void s5pv210_restart(char mode, const char *cmd)
 }
 
 static const struct samsung_timer_variant s5pv210_timer_variant = {
+	.reg_base = S5P_PA_TIMER,
 	.bits = 32,
 	.prescale = 2,
 	.divisor = 2,
diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index 670f3c6..f1e54f9 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -24,10 +24,11 @@
 #include <asm/mach/map.h>
 #include <asm/sched_clock.h>
 
-#include <mach/map.h>
 #include <plat/devs.h>
 
-#define S3C_TIMERREG(x) (S3C_VA_TIMER + (x))
+static void __iomem *timer_base;
+
+#define S3C_TIMERREG(x) (timer_base + (x))
 #define S3C_TIMERREG2(tmr,reg) S3C_TIMERREG((reg)+0x0c+((tmr)*0x0c))
 
 #define S3C2410_TCFG0	      S3C_TIMERREG(0x00)
@@ -474,6 +475,10 @@ static void __init samsung_timer_resources(void)
 	unsigned long source_id = timer_source.source_id;
 	char devname[15];
 
+	timer_base = ioremap_nocache(timer_variant.reg_base, SZ_4K);
+	if (!timer_base)
+		panic("failed to map timer registers");
+
 	timerclk = clk_get(NULL, "timers");
 	if (IS_ERR(timerclk))
 		panic("failed to get timers clock for timer");
diff --git a/include/clocksource/samsung-time.h b/include/clocksource/samsung-time.h
index e352600..6d25b0b 100644
--- a/include/clocksource/samsung-time.h
+++ b/include/clocksource/samsung-time.h
@@ -29,11 +29,13 @@ struct samsung_timer_source {
 
 /**
  * struct samsung_timer_variant - SoC-specific parameters of Samsung PWM timers
+ * @reg_base:	physical base address of timer registers
  * @bits:	bit width of time counters
  * @prescale:	prescaler divisor
  * @divisor:	resulting divisor after prescaler and main divisor
  */
 struct samsung_timer_variant {
+	unsigned long reg_base;
 	int bits;
 	u16 prescale;
 	u16 divisor;
-- 
1.8.1.2
