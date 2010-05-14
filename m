From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 May 2010 16:25:23 +0900
Subject: [PATCH v2 10/11] ARM: SAMSUNG: Remove the TYPE and replace it with a
	Feature
Message-ID: <1273821923-17552-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna <ch.naveen@samsung.com>

This patch makes changes in the core files to remove the TYPE
and replace it with a Feature bit field instead.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---

This 2 new patches which require the previous 9 patches to be applied. (0010 & 0011)
This patch set of 9 patches contains core changes & driver changes into seperate patches.
The 2 new patches would remove the TYPE from the core and driver file and replace it with 
Feature field as suggested by Ben Dooks.

 arch/arm/mach-s3c64xx/mach-smdk6410.c   |    1 +
 arch/arm/mach-s3c64xx/s3c6410.c         |    1 -
 arch/arm/mach-s5p6440/cpu.c             |    1 -
 arch/arm/mach-s5p6440/mach-smdk6440.c   |    1 +
 arch/arm/mach-s5pv210/cpu.c             |    1 -
 arch/arm/mach-s5pv210/mach-smdkv210.c   |    1 +
 arch/arm/plat-samsung/dev-ts.c          |    1 +
 arch/arm/plat-samsung/include/plat/ts.h |    1 +
 8 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index fb186c9..a8ead39 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -604,6 +604,7 @@ static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
 	.delay			= 10000,
 	.presc			= 49,
 	.oversampling_shift	= 2,
+	.feature		= 1 << 0,	/* HAS ADCCLRINTPNDNUP */
 };
 
 static void __init smdk6410_map_io(void)
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 4390ecb..31e53fa 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -55,7 +55,6 @@ void __init s3c6410_map_io(void)
 
 	s3c_device_adc.name      = "s3c64xx-adc";
 	s3c_device_nand.name = "s3c6400-nand";
-	s3c_device_ts.name	= "s3c64xx-ts";
 }
 
 void __init s3c6410_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5p6440/cpu.c b/arch/arm/mach-s5p6440/cpu.c
index e461955..78c0e47 100644
--- a/arch/arm/mach-s5p6440/cpu.c
+++ b/arch/arm/mach-s5p6440/cpu.c
@@ -61,7 +61,6 @@ static void s5p6440_idle(void)
 void __init s5p6440_map_io(void)
 {
 	/* initialize any device information early */
-	s3c_device_ts.name      = "s3c64xx-ts";
 	s3c_device_adc.name	= "s3c64xx-adc";
 }
 
diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
index 177701b..afb53b1 100644
--- a/arch/arm/mach-s5p6440/mach-smdk6440.c
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -94,6 +94,7 @@ static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
 	.delay			= 10000,
 	.presc			= 49,
 	.oversampling_shift	= 2,
+	.feature		= 1 << 0,	/* HAS ADCCLRINTPNDNUP */
 };
 
 static void __init smdk6440_map_io(void)
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index dd3dcca..8391342 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -74,7 +74,6 @@ static void s5pv210_idle(void)
 
 void __init s5pv210_map_io(void)
 {
-	s3c_device_ts.name      = "s5pv210-ts";
 	s3c_device_adc.name	= "s3c64xx-adc";
 
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 1440cb2..a0b0a67 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -82,6 +82,7 @@ static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
 	.delay			= 10000,
 	.presc			= 49,
 	.oversampling_shift	= 2,
+	.feature		= 1 << 0,	/* HAS ADCCLRINTPNDNUP */
 };
 
 static void __init smdkv210_map_io(void)
diff --git a/arch/arm/plat-samsung/dev-ts.c b/arch/arm/plat-samsung/dev-ts.c
index 8d7cefb..7571691 100644
--- a/arch/arm/plat-samsung/dev-ts.c
+++ b/arch/arm/plat-samsung/dev-ts.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include <mach/map.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/plat-samsung/include/plat/ts.h b/arch/arm/plat-samsung/include/plat/ts.h
index 26fdb22..82c0eaf 100644
--- a/arch/arm/plat-samsung/include/plat/ts.h
+++ b/arch/arm/plat-samsung/include/plat/ts.h
@@ -14,6 +14,7 @@ struct s3c2410_ts_mach_info {
        int             delay;
        int             presc;
        int             oversampling_shift;
+	int	feature;
 	void    (*cfg_gpio)(struct platform_device *dev);
 };
 
-- 
1.6.2.5
