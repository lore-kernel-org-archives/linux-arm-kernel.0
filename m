From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 10 Apr 2014 13:54:53 +0530
Subject: [PATCH 3/6] ARM: EXYNOS: Migrate Exynos specific macros from plat to
 mach
In-Reply-To: <1397118296-6846-1-git-send-email-sachin.kamat@linaro.org>
References: <1397118296-6846-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1397118296-6846-4-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move Exynos specific macros to mach-exynos from plat-samsung to avoid
unnecessary dependency on plat based header files.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-exynos/common.h            |   72 ++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/cpu.h |   60 -------------------------
 2 files changed, 72 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 9ef3f83efaff..c1a2f2207af0 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -15,6 +15,75 @@
 #include <linux/reboot.h>
 #include <linux/of.h>
 
+#define EXYNOS4210_CPU_ID	0x43210000
+#define EXYNOS4212_CPU_ID	0x43220000
+#define EXYNOS4412_CPU_ID	0xE4412200
+#define EXYNOS4_CPU_MASK	0xFFFE0000
+
+#define EXYNOS5250_SOC_ID	0x43520000
+#define EXYNOS5420_SOC_ID	0xE5420000
+#define EXYNOS5440_SOC_ID	0xE5440000
+#define EXYNOS5_SOC_MASK	0xFFFFF000
+
+extern unsigned long samsung_cpu_id;
+
+#define IS_SAMSUNG_CPU(name, id, mask)		\
+static inline int is_samsung_##name(void)	\
+{						\
+	return ((samsung_cpu_id & mask) == (id & mask));	\
+}
+
+IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
+IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
+IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
+IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
+
+#if defined(CONFIG_CPU_EXYNOS4210)
+# define soc_is_exynos4210()	is_samsung_exynos4210()
+#else
+# define soc_is_exynos4210()	0
+#endif
+
+#if defined(CONFIG_SOC_EXYNOS4212)
+# define soc_is_exynos4212()	is_samsung_exynos4212()
+#else
+# define soc_is_exynos4212()	0
+#endif
+
+#if defined(CONFIG_SOC_EXYNOS4412)
+# define soc_is_exynos4412()	is_samsung_exynos4412()
+#else
+# define soc_is_exynos4412()	0
+#endif
+
+#define EXYNOS4210_REV_0	(0x0)
+#define EXYNOS4210_REV_1_0	(0x10)
+#define EXYNOS4210_REV_1_1	(0x11)
+
+#if defined(CONFIG_SOC_EXYNOS5250)
+# define soc_is_exynos5250()	is_samsung_exynos5250()
+#else
+# define soc_is_exynos5250()	0
+#endif
+
+#if defined(CONFIG_SOC_EXYNOS5420)
+# define soc_is_exynos5420()	is_samsung_exynos5420()
+#else
+# define soc_is_exynos5420()	0
+#endif
+
+#if defined(CONFIG_SOC_EXYNOS5440)
+# define soc_is_exynos5440()	is_samsung_exynos5440()
+#else
+# define soc_is_exynos5440()	0
+#endif
+
+#define soc_is_exynos4() (soc_is_exynos4210() || soc_is_exynos4212() || \
+			  soc_is_exynos4412())
+#define soc_is_exynos5() (soc_is_exynos5250() || soc_is_exynos5420())
+
 void mct_init(void __iomem *base, int irq_g0, int irq_l0, int irq_l1);
 
 struct map_desc;
@@ -63,4 +132,7 @@ struct exynos_pmu_conf {
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 
+extern void s5p_init_cpu(void __iomem *cpuid_addr);
+extern unsigned int samsung_rev(void);
+
 #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 930b4be832cd..5a237db9f9eb 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -43,16 +43,6 @@ extern unsigned long samsung_cpu_id;
 #define S5PV210_CPU_ID		0x43110000
 #define S5PV210_CPU_MASK	0xFFFFF000
 
-#define EXYNOS4210_CPU_ID	0x43210000
-#define EXYNOS4212_CPU_ID	0x43220000
-#define EXYNOS4412_CPU_ID	0xE4412200
-#define EXYNOS4_CPU_MASK	0xFFFE0000
-
-#define EXYNOS5250_SOC_ID	0x43520000
-#define EXYNOS5420_SOC_ID	0xE5420000
-#define EXYNOS5440_SOC_ID	0xE5440000
-#define EXYNOS5_SOC_MASK	0xFFFFF000
-
 #define IS_SAMSUNG_CPU(name, id, mask)		\
 static inline int is_samsung_##name(void)	\
 {						\
@@ -68,12 +58,6 @@ IS_SAMSUNG_CPU(s5p6440, S5P6440_CPU_ID, S5P64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5p6450, S5P6450_CPU_ID, S5P64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s5pc100, S5PC100_CPU_ID, S5PC100_CPU_MASK)
 IS_SAMSUNG_CPU(s5pv210, S5PV210_CPU_ID, S5PV210_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
-IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
-IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
     defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2440) || \
@@ -126,50 +110,6 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_s5pv210()	0
 #endif
 
-#if defined(CONFIG_CPU_EXYNOS4210)
-# define soc_is_exynos4210()	is_samsung_exynos4210()
-#else
-# define soc_is_exynos4210()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS4212)
-# define soc_is_exynos4212()	is_samsung_exynos4212()
-#else
-# define soc_is_exynos4212()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS4412)
-# define soc_is_exynos4412()	is_samsung_exynos4412()
-#else
-# define soc_is_exynos4412()	0
-#endif
-
-#define EXYNOS4210_REV_0	(0x0)
-#define EXYNOS4210_REV_1_0	(0x10)
-#define EXYNOS4210_REV_1_1	(0x11)
-
-#if defined(CONFIG_SOC_EXYNOS5250)
-# define soc_is_exynos5250()	is_samsung_exynos5250()
-#else
-# define soc_is_exynos5250()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5420)
-# define soc_is_exynos5420()	is_samsung_exynos5420()
-#else
-# define soc_is_exynos5420()	0
-#endif
-
-#if defined(CONFIG_SOC_EXYNOS5440)
-# define soc_is_exynos5440()	is_samsung_exynos5440()
-#else
-# define soc_is_exynos5440()	0
-#endif
-
-#define soc_is_exynos4() (soc_is_exynos4210() || soc_is_exynos4212() || \
-			  soc_is_exynos4412())
-#define soc_is_exynos5() (soc_is_exynos5250() || soc_is_exynos5420())
-
 #define IODESC_ENT(x) { (unsigned long)S3C24XX_VA_##x, __phys_to_pfn(S3C24XX_PA_##x), S3C24XX_SZ_##x, MT_DEVICE }
 
 #ifndef KHZ
-- 
1.7.9.5
