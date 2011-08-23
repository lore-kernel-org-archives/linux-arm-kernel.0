From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 23 Aug 2011 10:39:11 +0900
Subject: [PATCH V2 1/4] ARM: SAMSUNG: Add support for detecting CPU at runtime
Message-ID: <1314063552-27416-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The soc_is_[name]() can be used to distinguish cpu at runtime.

This patch was originally from Changhwan Youn <chaos.youn@samsung.com>

Acked-by: Changhwan Youn <chaos.youn@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- soc_is_xxx() is used instead of cpu_is_xxx()

 arch/arm/mach-s3c64xx/cpu.c              |   18 +++----
 arch/arm/plat-s3c24xx/cpu.c              |    8 +--
 arch/arm/plat-s5p/cpu.c                  |   26 ++++-----
 arch/arm/plat-samsung/include/plat/cpu.h |   87 +++++++++++++++++++++++++++++-
 arch/arm/plat-samsung/init.c             |    1 +
 5 files changed, 110 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpu.c b/arch/arm/mach-s3c64xx/cpu.c
index 374e45e..7b665f3 100644
--- a/arch/arm/mach-s3c64xx/cpu.c
+++ b/arch/arm/mach-s3c64xx/cpu.c
@@ -43,16 +43,16 @@ static const char name_s3c6410[] = "S3C6410";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
-		.idcode		= 0x36400000,
-		.idmask		= 0xfffff000,
+		.idcode		= S3C6400_CPU_ID,
+		.idmask		= S3C64XX_CPU_MASK,
 		.map_io		= s3c6400_map_io,
 		.init_clocks	= s3c6400_init_clocks,
 		.init_uarts	= s3c6400_init_uarts,
 		.init		= s3c6400_init,
 		.name		= name_s3c6400,
 	}, {
-		.idcode		= 0x36410100,
-		.idmask		= 0xffffff00,
+		.idcode		= S3C6410_CPU_ID,
+		.idmask		= S3C64XX_CPU_MASK,
 		.map_io		= s3c6410_map_io,
 		.init_clocks	= s3c6410_init_clocks,
 		.init_uarts	= s3c6410_init_uarts,
@@ -140,22 +140,20 @@ void __init s3c6400_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 
 void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
 {
-	unsigned long idcode;
-
 	/* initialise the io descriptors we need for initialisation */
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 	iotable_init(mach_desc, size);
 
-	idcode = __raw_readl(S3C_VA_SYS + 0x118);
-	if (!idcode) {
+	samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0x118);
+	if (!samsung_cpu_id) {
 		/* S3C6400 has the ID register in a different place,
 		 * and needs a write before it can be read. */
 
 		__raw_writel(0x0, S3C_VA_SYS + 0xA1C);
-		idcode = __raw_readl(S3C_VA_SYS + 0xA1C);
+		samsung_cpu_id = __raw_readl(S3C_VA_SYS + 0xA1C);
 	}
 
-	s3c_init_cpu(idcode, cpu_ids, ARRAY_SIZE(cpu_ids));
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
 }
 
 static __init int s3c64xx_sysdev_init(void)
diff --git a/arch/arm/plat-s3c24xx/cpu.c b/arch/arm/plat-s3c24xx/cpu.c
index c1fc6c6..ead21a4 100644
--- a/arch/arm/plat-s3c24xx/cpu.c
+++ b/arch/arm/plat-s3c24xx/cpu.c
@@ -215,19 +215,17 @@ static void s3c24xx_pm_restart(char mode, const char *cmd)
 
 void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 {
-	unsigned long idcode = 0x0;
-
 	/* initialise the io descriptors we need for initialisation */
 	iotable_init(mach_desc, size);
 	iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 
 	if (cpu_architecture() >= CPU_ARCH_ARMv5) {
-		idcode = s3c24xx_read_idcode_v5();
+		samsung_cpu_id = s3c24xx_read_idcode_v5();
 	} else {
-		idcode = s3c24xx_read_idcode_v4();
+		samsung_cpu_id = s3c24xx_read_idcode_v4();
 	}
 
 	arm_pm_restart = s3c24xx_pm_restart;
 
-	s3c_init_cpu(idcode, cpu_ids, ARRAY_SIZE(cpu_ids));
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
 }
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index bbc2aa7..3ef6734 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -36,40 +36,40 @@ static const char name_exynos4210[] = "EXYNOS4210";
 
 static struct cpu_table cpu_ids[] __initdata = {
 	{
-		.idcode		= 0x56440100,
-		.idmask		= 0xfffff000,
+		.idcode		= S5P6440_CPU_ID,
+		.idmask		= S5P64XX_CPU_MASK,
 		.map_io		= s5p6440_map_io,
 		.init_clocks	= s5p6440_init_clocks,
 		.init_uarts	= s5p6440_init_uarts,
 		.init		= s5p64x0_init,
 		.name		= name_s5p6440,
 	}, {
-		.idcode		= 0x36450000,
-		.idmask		= 0xfffff000,
+		.idcode		= S5P6450_CPU_ID,
+		.idmask		= S5P64XX_CPU_MASK,
 		.map_io		= s5p6450_map_io,
 		.init_clocks	= s5p6450_init_clocks,
 		.init_uarts	= s5p6450_init_uarts,
 		.init		= s5p64x0_init,
 		.name		= name_s5p6450,
 	}, {
-		.idcode		= 0x43100000,
-		.idmask		= 0xfffff000,
+		.idcode		= S5PC100_CPU_ID,
+		.idmask		= S5PC100_CPU_MASK,
 		.map_io		= s5pc100_map_io,
 		.init_clocks	= s5pc100_init_clocks,
 		.init_uarts	= s5pc100_init_uarts,
 		.init		= s5pc100_init,
 		.name		= name_s5pc100,
 	}, {
-		.idcode		= 0x43110000,
-		.idmask		= 0xfffff000,
+		.idcode		= S5PV210_CPU_ID,
+		.idmask		= S5PV210_CPU_MASK,
 		.map_io		= s5pv210_map_io,
 		.init_clocks	= s5pv210_init_clocks,
 		.init_uarts	= s5pv210_init_uarts,
 		.init		= s5pv210_init,
 		.name		= name_s5pv210,
 	}, {
-		.idcode		= 0x43210000,
-		.idmask		= 0xfffe0000,
+		.idcode		= EXYNOS4210_CPU_ID,
+		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
 		.init_clocks	= exynos4_init_clocks,
 		.init_uarts	= exynos4_init_uarts,
@@ -114,13 +114,11 @@ static struct map_desc s5p_iodesc[] __initdata = {
 void __init s5p_init_io(struct map_desc *mach_desc,
 			int size, void __iomem *cpuid_addr)
 {
-	unsigned long idcode;
-
 	/* initialize the io descriptors we need for initialization */
 	iotable_init(s5p_iodesc, ARRAY_SIZE(s5p_iodesc));
 	if (mach_desc)
 		iotable_init(mach_desc, size);
 
-	idcode = __raw_readl(cpuid_addr);
-	s3c_init_cpu(idcode, cpu_ids, ARRAY_SIZE(cpu_ids));
+	samsung_cpu_id = __raw_readl(cpuid_addr);
+	s3c_init_cpu(samsung_cpu_id, cpu_ids, ARRAY_SIZE(cpu_ids));
 }
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index c0a5741..bdf43ad 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -1,9 +1,12 @@
 /* linux/arch/arm/plat-samsung/include/plat/cpu.h
  *
+ * Copyright (c) 2011 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
  * Copyright (c) 2004-2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
- * Header file for S3C24XX CPU support
+ * Header file for Samsung CPU support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -15,6 +18,88 @@
 #ifndef __SAMSUNG_PLAT_CPU_H
 #define __SAMSUNG_PLAT_CPU_H
 
+extern unsigned long samsung_cpu_id;
+
+#define S3C24XX_CPU_ID		0x32400000
+#define S3C24XX_CPU_MASK	0xFFF00000
+
+#define S3C6400_CPU_ID		0x36400000
+#define S3C6410_CPU_ID		0x36410000
+#define S3C64XX_CPU_ID		(S3C6400_CPU_ID & S3C6410_CPU_ID)
+#define S3C64XX_CPU_MASK	0x1FF40000
+
+#define S5P6440_CPU_ID		0x56440000
+#define S5P6450_CPU_ID		0x36450000
+#define S5P64XX_CPU_MASK	0x1FF40000
+
+#define S5PC100_CPU_ID		0x43100000
+#define S5PC100_CPU_MASK	0xFFFFF000
+
+#define S5PV210_CPU_ID		0x43110000
+#define S5PV210_CPU_MASK	0xFFFFF000
+
+#define EXYNOS4210_CPU_ID	0x43210000
+#define EXYNOS4_CPU_MASK	0xFFFE0000
+
+#define IS_SAMSUNG_CPU(name, id, mask)		\
+static inline int is_samsung_##name(void)	\
+{						\
+	return ((samsung_cpu_id & mask) == (id & mask));	\
+}
+
+IS_SAMSUNG_CPU(s3c24xx, S3C24XX_CPU_ID, S3C24XX_CPU_MASK)
+IS_SAMSUNG_CPU(s3c64xx, S3C64XX_CPU_ID, S3C64XX_CPU_MASK)
+IS_SAMSUNG_CPU(s5p6440, S5P6440_CPU_ID, S5P64XX_CPU_MASK)
+IS_SAMSUNG_CPU(s5p6450, S5P6450_CPU_ID, S5P64XX_CPU_MASK)
+IS_SAMSUNG_CPU(s5pc100, S5PC100_CPU_ID, S5PC100_CPU_MASK)
+IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
+IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
+
+#if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
+    defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2440) || \
+    defined(CONFIG_CPU_S3C2442) || defined(CONFIG_CPU_S3C244X) || \
+    defined(CONFIG_CPU_S3C2443)
+# define soc_is_s3c24xx()	is_samsung_s3c24xx()
+#else
+# define soc_is_s3c24xx()	0
+#endif
+
+#if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
+# define soc_is_s3c64xx()	is_samsung_s3c64xx()
+#else
+# define soc_is_s3c64xx()	0
+#endif
+
+#if defined(CONFIG_CPU_S5P6440)
+# define soc_is_s5p6440()	is_samsung_s5p6440()
+#else
+# define soc_is_s5p6440()	0
+#endif
+
+#if defined(CONFIG_CPU_S5P6450)
+# define soc_is_s5p6450()	is_samsung_s5p6450()
+#else
+# define soc_is_s5p6450()	0
+#endif
+
+#if defined(CONFIG_CPU_S5PC100)
+# define soc_is_s5pc100()	is_samsung_s5pc100()
+#else
+# define soc_is_s5pc100()	0
+#endif
+
+#if defined(CONFIG_CPU_S5PV210)
+# define soc_is_s5pv210()	is_samsung_s5pv210()
+#else
+# define soc_is_s5pv210()	0
+#endif
+
+#if defined(CONFIG_CPU_EXYNOS4210)
+# define soc_is_exynos4210()	is_samsung_exynos4210()
+#else
+# define soc_is_exynos4210()	0
+#endif
+
 #define IODESC_ENT(x) { (unsigned long)S3C24XX_VA_##x, __phys_to_pfn(S3C24XX_PA_##x), S3C24XX_SZ_##x, MT_DEVICE }
 
 #ifndef MHZ
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index 79d10fc..40b1228 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -30,6 +30,7 @@
 #include <plat/regs-serial.h>
 
 static struct cpu_table *cpu;
+unsigned long samsung_cpu_id;
 
 static struct cpu_table * __init s3c_lookup_cpu(unsigned long idcode,
 						struct cpu_table *tab,
-- 
1.7.1
