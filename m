From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 20:12:47 +0100
Subject: [PATCH v2 02/12] ARM: SAMSUNG: Add soc_is_s3c2410() helper
In-Reply-To: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
References: <1391713977-22300-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391713977-22300-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the S3C2410 SoC being quite different from other S3C24xx SoCs
in some aspects, such as availability of DIVSLOT register in its UART
blocks, there is a need sometimes to check whether we are running on
this SoC, not just the S3C24xx series. This patch adds soc_is_s3c2410()
helper function for this purpose.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/cpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 335beb3..6bf86f6 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -20,6 +20,9 @@
 
 extern unsigned long samsung_cpu_id;
 
+#define S3C2410_CPU_ID		0x32410000
+#define S3C2410_CPU_MASK	0xFFFFFFFF
+
 #define S3C24XX_CPU_ID		0x32400000
 #define S3C24XX_CPU_MASK	0xFFF00000
 
@@ -56,6 +59,7 @@ static inline int is_samsung_##name(void)	\
 	return ((samsung_cpu_id & mask) == (id & mask));	\
 }
 
+IS_SAMSUNG_CPU(s3c2410, S3C2410_CPU_ID, S3C2410_CPU_MASK)
 IS_SAMSUNG_CPU(s3c24xx, S3C24XX_CPU_ID, S3C24XX_CPU_MASK)
 IS_SAMSUNG_CPU(s3c2412, S3C2412_CPU_ID, S3C2412_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6400, S3C6400_CPU_ID, S3C64XX_CPU_MASK)
@@ -76,8 +80,10 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
     defined(CONFIG_CPU_S3C2442) || defined(CONFIG_CPU_S3C244X) || \
     defined(CONFIG_CPU_S3C2443)
 # define soc_is_s3c24xx()	is_samsung_s3c24xx()
+# define soc_is_s3c2410()	is_samsung_s3c2410()
 #else
 # define soc_is_s3c24xx()	0
+# define soc_is_s3c2410()	0
 #endif
 
 #if defined(CONFIG_CPU_S3C2412)
-- 
1.8.5.2
